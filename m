Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A848B79B5C4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359803AbjIKWSs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbjIKPSu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DADFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D6C433C7;
        Mon, 11 Sep 2023 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445525;
        bh=95vNOmkZ88PVpNBRMgrMDa/VPtiBFDnlQcfr+8rWhPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVwsTtdQ/fh8wNOYL6iWZ4/zbdWetUeyyLLLldHqdeg+TWRSYkz5gjUGh4FIbRSIx
         KHpAqcAp8pyAT21dhJIgG7yALJUs0K15p6Qq7tVSr2OrtNKcObVr+w7VnCBx5+Arlz
         aPH3x40eLh4C18yriU4f8I3NbrlgFO2AIWbcI+1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 378/600] nfs/blocklayout: Use the passed in gfp flags
Date:   Mon, 11 Sep 2023 15:46:51 +0200
Message-ID: <20230911134644.831507311@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 08b45fcb2d4675f6182fe0edc0d8b1fe604051fa ]

This allocation should use the passed in GFP_ flags instead of
GFP_KERNEL.  One places where this matters is in filelayout_pg_init_write()
which uses GFP_NOFS as the allocation flags.

Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index fea5f8821da5e..ce2ea62397972 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -402,7 +402,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->concat.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
@@ -431,7 +431,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->stripe.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
-- 
2.40.1



