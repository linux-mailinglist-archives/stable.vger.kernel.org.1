Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F547DD3C7
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjJaRDA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjJaRC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0A110
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:02:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D4C433C9;
        Tue, 31 Oct 2023 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771776;
        bh=u/DVd2WC9piEJeBOWao07KYzQV/zX+1uDfBUvZHq3iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6jUl+Um/1Vv0TTWl8phPr+QKP3EdHuZnl17Copw3dJgLx4vUe1DpvsRAiax/btye
         PO+401doTTus0QYCnwTtaPm3LkKmszX3+yNCgizwa7wouwYY0rkTbdtHak616cIUJc
         E51dzBF6vWP0Z91U92Xqq31DTW8wXd+dJwDUL4As=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Auger <eric.auger@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.1 17/86] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Date:   Tue, 31 Oct 2023 18:00:42 +0100
Message-ID: <20231031165919.148117473@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1176,9 +1176,7 @@ ssize_t vhost_chr_write_iter(struct vhos
 		goto done;
 	}
 
-	if ((msg.type == VHOST_IOTLB_UPDATE ||
-	     msg.type == VHOST_IOTLB_INVALIDATE) &&
-	     msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}


