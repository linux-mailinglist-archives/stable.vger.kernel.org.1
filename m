Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04167E24A2
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjKFNXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjKFNXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210BD61
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:23:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48624C433C9;
        Mon,  6 Nov 2023 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277019;
        bh=h3KaH+3U6sUjgoXqmSrvw9mXfXTNA9qUAZJwaO3wUz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7j5FrbGTEK3A4l/fdzBaSaA4u25HE6OYOfWAaGO1m8ZBvJSwVEJv9xq3+LKh45r+
         uwmEpWmNP2VjwOkALHHOE8fwPRU6q3YuoYGofq6/1w5m1bR/o3vJcqlE5lcDI6n+cA
         wVuCVvj8v1cOneRH22Qn1/vqV6X6PQlCF5zPe7rM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Auger <eric.auger@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.15 011/128] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Date:   Mon,  6 Nov 2023 14:02:51 +0100
Message-ID: <20231106130309.640427592@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Auger <eric.auger@redhat.com>

commit ca50ec377c2e94b0a9f8735de2856cd0f13beab4 upstream.

Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
entries") Forbade vhost iotlb msg with null size to prevent entries
with size = start = 0 and last = ULONG_MAX to end up in the iotlb.

Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
message types to fix a regression observed with batching hit.

Still, the introduction of that check introduced a regression for
some users attempting to invalidate the whole ULONG_MAX range by
setting the size to 0. This is the case with qemu/smmuv3/vhost
integration which does not work anymore. It Looks safe to partially
revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
with null size. vhost_iotlb_del_range() will compute a correct end
iova. Same for vhost_vdpa_iotlb_unmap().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
Cc: stable@vger.kernel.org # v5.17+
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230927140544.205088-1-eric.auger@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1171,9 +1171,7 @@ ssize_t vhost_chr_write_iter(struct vhos
 		goto done;
 	}
 
-	if ((msg.type == VHOST_IOTLB_UPDATE ||
-	     msg.type == VHOST_IOTLB_INVALIDATE) &&
-	     msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}


