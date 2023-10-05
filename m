Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE15A7B9EAA
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJEOJJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjJEOHH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 10:07:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA01F760
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 03:00:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3226b8de467so791915f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696500001; x=1697104801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlSZgEfFpGtGkHga/JbRqci7TTiLVFu+ACcdlspJxk4=;
        b=OxRpdcnZAiOiHCSqLf2C5kgf+M1899Miogh3znKtaYmaMTsiJsMcrT9uy4TIBpqKGM
         NWhVPR/w7iXWrQixymJPdiQALtdwPnwFJ5QYdkonEW+ba8e2lDq7CBxP+1UYuOEkOKOw
         WsZuv7vQri8ih7oaUTruY0n4pqXw3yFXUQzdotD0Q6e6qaEbr4/x7CTKxTVAmJxxBXbM
         dlcuNcJ+xR9TtXX3lQEO4E+tGYgWNPapW+jphqN7XwIHLw0W6oM2lK/GrlOSzpnUNA0d
         B4ctQJRvsuEbRidmfqM5FCPnqgy0nDxNf8lsrh6jsCb2BiiPBAHFZbeQDXgBl2O/8GWT
         48IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500001; x=1697104801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlSZgEfFpGtGkHga/JbRqci7TTiLVFu+ACcdlspJxk4=;
        b=vKoal+B7EYH0moVBROjUzUrmTkdxDPRbyyk9g39LENbxHAMLR/SJjg37eCxcktX6OW
         urGyhtOJ+jDLFLCYt0/NhRS9f8Uy3Od/3nCuCTmWi/enBoB+eZ1Qo8Ykmo1gnwETQhK/
         CS3gWp2z/AfZPCkqLKJiZv+J/XO+F6zbcx04nnvUZcefr1CWHRs3A/569iboHIc0n3sI
         i60fMencbPCUgUir2UaH97rCeNbDfFVcmUBeghJ3uyXWdyg0TF1St1920+rAiludIFlO
         gFUImzCPj5w6pQkkKd6fLKGPPgTT4FY4szgar+gV9Rjd9d3FqIfFOlAujZOT7iLPXLvD
         4KrA==
X-Gm-Message-State: AOJu0Yzo6/z5oE/er8rKpd2t0YiHGhqtsSebdrxl2VzmCR6brMuAol5T
        QfM7PR8CIZxauJSKyOUHNcQKfz5tNds=
X-Google-Smtp-Source: AGHT+IHaGN7UGT4QqWiB3qsxv2ahRBrAaTWa2zDZlzRU4FE+ZZ1y8goDBYd5XEJ1K/VRSbuIuAdMuQ==
X-Received: by 2002:adf:e68a:0:b0:323:cc8:83a2 with SMTP id r10-20020adfe68a000000b003230cc883a2mr4131985wrm.49.1696500000914;
        Thu, 05 Oct 2023 03:00:00 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d4d4b000000b003231ca246b6sm1389897wru.95.2023.10.05.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:00:00 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.10-6.1 3/4] rbd: decouple parent info read-in from updating rbd_dev
Date:   Thu,  5 Oct 2023 11:59:34 +0200
Message-ID: <20231005095937.317188-4-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005095937.317188-1-idryomov@gmail.com>
References: <20231005095937.317188-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit c10311776f0a8ddea2276df96e255625b07045a8 upstream.

Unlike header read-in, parent info read-in is already decoupled in
get_parent_info(), but it's buried in rbd_dev_v2_parent_info() along
with the processing logic.

Separate the initial read-in and update read-in logic into
rbd_dev_setup_parent() and rbd_dev_update_parent() respectively and
have rbd_dev_v2_parent_info() just populate struct parent_image_info
(i.e. what get_parent_info() did).  Some existing QoI issues, like
flatten of a standalone clone being disregarded on refresh, remain.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drivers/block/rbd.c | 142 +++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b1c44c633857..38c92b1b0346 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5595,6 +5595,14 @@ struct parent_image_info {
 	u64		overlap;
 };
 
+static void rbd_parent_info_cleanup(struct parent_image_info *pii)
+{
+	kfree(pii->pool_ns);
+	kfree(pii->image_id);
+
+	memset(pii, 0, sizeof(*pii));
+}
+
 /*
  * The caller is responsible for @pii.
  */
@@ -5664,6 +5672,9 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 	if (pii->has_overlap)
 		ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
@@ -5702,14 +5713,17 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
 	return -EINVAL;
 }
 
-static int get_parent_info(struct rbd_device *rbd_dev,
-			   struct parent_image_info *pii)
+static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
 {
 	struct page *req_page, *reply_page;
 	void *p;
@@ -5737,7 +5751,7 @@ static int get_parent_info(struct rbd_device *rbd_dev,
 	return ret;
 }
 
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
+static int rbd_dev_setup_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
 	struct parent_image_info pii = { 0 };
@@ -5747,37 +5761,12 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (!parent_spec)
 		return -ENOMEM;
 
-	ret = get_parent_info(rbd_dev, &pii);
+	ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 	if (ret)
 		goto out_err;
 
-	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
-	     __func__, pii.pool_id, pii.pool_ns, pii.image_id, pii.snap_id,
-	     pii.has_overlap, pii.overlap);
-
-	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap) {
-		/*
-		 * Either the parent never existed, or we have
-		 * record of it but the image got flattened so it no
-		 * longer has a parent.  When the parent of a
-		 * layered image disappears we immediately set the
-		 * overlap to 0.  The effect of this is that all new
-		 * requests will be treated as if the image had no
-		 * parent.
-		 *
-		 * If !pii.has_overlap, the parent image spec is not
-		 * applicable.  It's there to avoid duplication in each
-		 * snapshot record.
-		 */
-		if (rbd_dev->parent_overlap) {
-			rbd_dev->parent_overlap = 0;
-			rbd_dev_parent_put(rbd_dev);
-			pr_info("%s: clone image has been flattened\n",
-				rbd_dev->disk->disk_name);
-		}
-
+	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap)
 		goto out;	/* No parent?  No problem. */
-	}
 
 	/* The ceph file layout needs to fit pool id in 32 bits */
 
@@ -5789,46 +5778,34 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	}
 
 	/*
-	 * The parent won't change (except when the clone is
-	 * flattened, already handled that).  So we only need to
-	 * record the parent spec we have not already done so.
+	 * The parent won't change except when the clone is flattened,
+	 * so we only need to record the parent image spec once.
 	 */
-	if (!rbd_dev->parent_spec) {
-		parent_spec->pool_id = pii.pool_id;
-		if (pii.pool_ns && *pii.pool_ns) {
-			parent_spec->pool_ns = pii.pool_ns;
-			pii.pool_ns = NULL;
-		}
-		parent_spec->image_id = pii.image_id;
-		pii.image_id = NULL;
-		parent_spec->snap_id = pii.snap_id;
-
-		rbd_dev->parent_spec = parent_spec;
-		parent_spec = NULL;	/* rbd_dev now owns this */
+	parent_spec->pool_id = pii.pool_id;
+	if (pii.pool_ns && *pii.pool_ns) {
+		parent_spec->pool_ns = pii.pool_ns;
+		pii.pool_ns = NULL;
 	}
+	parent_spec->image_id = pii.image_id;
+	pii.image_id = NULL;
+	parent_spec->snap_id = pii.snap_id;
+
+	rbd_assert(!rbd_dev->parent_spec);
+	rbd_dev->parent_spec = parent_spec;
+	parent_spec = NULL;	/* rbd_dev now owns this */
 
 	/*
-	 * We always update the parent overlap.  If it's zero we issue
-	 * a warning, as we will proceed as if there was no parent.
+	 * Record the parent overlap.  If it's zero, issue a warning as
+	 * we will proceed as if there is no parent.
 	 */
-	if (!pii.overlap) {
-		if (parent_spec) {
-			/* refresh, careful to warn just once */
-			if (rbd_dev->parent_overlap)
-				rbd_warn(rbd_dev,
-				    "clone now standalone (overlap became 0)");
-		} else {
-			/* initial probe */
-			rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
-		}
-	}
+	if (!pii.overlap)
+		rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
 	rbd_dev->parent_overlap = pii.overlap;
 
 out:
 	ret = 0;
 out_err:
-	kfree(pii.pool_ns);
-	kfree(pii.image_id);
+	rbd_parent_info_cleanup(&pii);
 	rbd_spec_put(parent_spec);
 	return ret;
 }
@@ -6978,7 +6955,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	}
 
 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_setup_parent(rbd_dev);
 		if (ret)
 			goto err_out_probe;
 	}
@@ -7027,9 +7004,47 @@ static void rbd_dev_update_header(struct rbd_device *rbd_dev,
 	}
 }
 
+static void rbd_dev_update_parent(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
+{
+	if (pii->pool_id == CEPH_NOPOOL || !pii->has_overlap) {
+		/*
+		 * Either the parent never existed, or we have
+		 * record of it but the image got flattened so it no
+		 * longer has a parent.  When the parent of a
+		 * layered image disappears we immediately set the
+		 * overlap to 0.  The effect of this is that all new
+		 * requests will be treated as if the image had no
+		 * parent.
+		 *
+		 * If !pii.has_overlap, the parent image spec is not
+		 * applicable.  It's there to avoid duplication in each
+		 * snapshot record.
+		 */
+		if (rbd_dev->parent_overlap) {
+			rbd_dev->parent_overlap = 0;
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone has been flattened\n",
+				rbd_dev->disk->disk_name);
+		}
+	} else {
+		rbd_assert(rbd_dev->parent_spec);
+
+		/*
+		 * Update the parent overlap.  If it became zero, issue
+		 * a warning as we will proceed as if there is no parent.
+		 */
+		if (!pii->overlap && rbd_dev->parent_overlap)
+			rbd_warn(rbd_dev,
+				 "clone has become standalone (overlap 0)");
+		rbd_dev->parent_overlap = pii->overlap;
+	}
+}
+
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header	header = { 0 };
+	struct parent_image_info pii = { 0 };
 	u64 mapping_size;
 	int ret;
 
@@ -7045,12 +7060,14 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	 * mapped image getting flattened.
 	 */
 	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 		if (ret)
 			goto out;
 	}
 
 	rbd_dev_update_header(rbd_dev, &header);
+	if (rbd_dev->parent)
+		rbd_dev_update_parent(rbd_dev, &pii);
 
 	rbd_assert(!rbd_is_snap(rbd_dev));
 	rbd_dev->mapping.size = rbd_dev->header.image_size;
@@ -7060,6 +7077,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	if (!ret && mapping_size != rbd_dev->mapping.size)
 		rbd_dev_update_size(rbd_dev);
 
+	rbd_parent_info_cleanup(&pii);
 	rbd_image_header_cleanup(&header);
 	return ret;
 }
-- 
2.41.0

