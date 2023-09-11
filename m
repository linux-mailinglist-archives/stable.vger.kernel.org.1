Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEC79C092
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjIKVkt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbjIKO3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058EF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B0C433C7;
        Mon, 11 Sep 2023 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442568;
        bh=Tq3iQO4P9Mvl7fP6y9CkZo32FRDj4GbjSPQzJHYow7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfqya+E4suIiy+Eey7fOVe1MP5tRQ4L9nYMTgrPsJYr1RmD/6sqZGB++O8irJl2+M
         SIYJK9D8eP5XV4Q0NpMuTb3raAxufbEjlm40BGxQ6UHCyNqYg6STJzcW7AypPr6DC4
         bQeQUrriQbupVWID0ReQi9iQIBokyuY5EAFQK6fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 071/737] virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
Date:   Mon, 11 Sep 2023 15:38:50 +0200
Message-ID: <20230911134652.498190812@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

[ Upstream commit ddf409851461f515cc32974714b73efe2e012bde ]

Just like we do with alloc_contig_range(), let's convert all unknown
errors to -EBUSY, but WARN so we can look into the issue. For example,
offline_pages() could fail with -EINTR, which would be unexpected in our
case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-3-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ed15d2a4bd96b..1a76ba2bc118c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -741,11 +741,15 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
-	} else {
-		dev_dbg(&vm->vdev->dev,
-			"offlining and removing memory failed: %d\n", rc);
+		return 0;
 	}
-	return rc;
+	dev_dbg(&vm->vdev->dev, "offlining and removing memory failed: %d\n", rc);
+	/*
+	 * We don't really expect this to fail, because we fake-offlined all
+	 * memory already. But it could fail in corner cases.
+	 */
+	WARN_ON_ONCE(rc != -ENOMEM && rc != -EBUSY);
+	return rc == -ENOMEM ? -ENOMEM : -EBUSY;
 }
 
 /*
-- 
2.40.1



