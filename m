Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D975D3A0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGUTMo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjGUTMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C730EF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451F461D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B62DC433C8;
        Fri, 21 Jul 2023 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966761;
        bh=rEq52FdVj26jXDrlhS267sxTKsdTWH8TO2Wj1cOQZns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eV6vykKG0yJOWt/agYQp7dBvtPCwlE+00gX+GxytGhB/zD7dWPRo4XTbxO/P0eEWP
         BHS2x5bdYuuzN2d4+5rTnwk4wr9T/HPxLfcEhwZWcM2eoHb+u6RpzXZh5LgOw+je7f
         CpZ7zZ+VmBXkTKAk6zs8SICAKdOE3V+P3Ka4EcPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5.15 458/532] erofs: fix compact 4B support for 16k block size
Date:   Fri, 21 Jul 2023 18:06:02 +0200
Message-ID: <20230721160639.376412441@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 001b8ccd0650727e54ec16ef72bf1b8eeab7168e upstream.

In compact 4B, two adjacent lclusters are packed together as a unit to
form on-disk indexes for effective random access, as below:

(amortized = 4, vcnt = 2)
       _____________________________________________
      |___@_____ encoded bits __________|_ blkaddr _|
      0        .                                    amortized * vcnt = 8
      .             .
      .                  .              amortized * vcnt - 4 = 4
      .                        .
      .____________________________.
      |_type (2 bits)_|_clusterofs_|

Therefore, encoded bits for each pack are 32 bits (4 bytes). IOWs,
since each lcluster can get 16 bits for its type and clusterofs, the
maximum supported lclustersize for compact 4B format is 16k (14 bits).

Fix this to enable compact 4B format for 16k lclusters (blocks), which
is tested on an arm64 server with 16k page size.

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230601112341.56960-1-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zmap.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -253,7 +253,7 @@ static int unpack_compacted_index(struct
 	u8 *in, type;
 	bool big_pcluster;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -351,7 +351,6 @@ static int compacted_load_cluster_from_d
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
 					vi->inode_isize + vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
@@ -361,9 +360,6 @@ static int compacted_load_cluster_from_d
 	erofs_off_t pos;
 	int err;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 


