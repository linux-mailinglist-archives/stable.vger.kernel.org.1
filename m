Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756D79C02A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjIKVuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjIKONR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D5DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D6C433C7;
        Mon, 11 Sep 2023 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441593;
        bh=+qXSSpOOumZtkXaZhJ4YGBEMrnSYWdm56ylT+DhWSYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD5GiE3vNqXdWtjJj1BZQExMVlAEP4pKqh10Yliqv8Qe0wpMviVUy0DT0uB8SEJGX
         bA4XsopUW/eFcnYDXXAgKNhGiq29LK/yrSIKhhWhUNcpUebYLnYEII+vEWqOcD9dcA
         7LJ9T88KruVh6wPaETqZ2tpmXCMQSyC0OP055STA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 436/739] nfs/blocklayout: Use the passed in gfp flags
Date:   Mon, 11 Sep 2023 15:43:55 +0200
Message-ID: <20230911134703.350283105@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 70f5563a8e81c..65cbb5607a5fc 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -404,7 +404,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->concat.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
@@ -433,7 +433,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->stripe.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
-- 
2.40.1



