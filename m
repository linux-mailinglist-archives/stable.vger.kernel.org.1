Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6E79AFF5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjIKUuu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbjIKONG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B5CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A5BC433C9;
        Mon, 11 Sep 2023 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441581;
        bh=dk0ohXQ38NLjX++5LfUY0r7tbeRWNmczMJ+gNXDofwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ML59z01o+IURhZEen+8x6sjXM2feb9as972uN154q3wIecPkdsdaYc7WG9u1FFbru
         056NWx6hQ23CG8HP9izElIf2/R2EkquNbcPdhoAh12fZDWXNc1ZHVo9PqTUZ3UUd/Q
         CmwS87ZWEcZgOEiL8y7dKXVu2deNgDHtG+T9BuPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 432/739] NFSv4.2: Rework scratch handling for READ_PLUS (again)
Date:   Mon, 11 Sep 2023 15:43:51 +0200
Message-ID: <20230911134703.241410639@linuxfoundation.org>
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit 303a78052091c81e9003915c521fdca1c7e117af ]

I found that the read code might send multiple requests using the same
nfs_pgio_header, but nfs4_proc_read_setup() is only called once. This is
how we ended up occasionally double-freeing the scratch buffer, but also
means we set a NULL pointer but non-zero length to the xdr scratch
buffer. This results in an oops the first time decoding needs to copy
something to scratch, which frequently happens when decoding READ_PLUS
hole segments.

I fix this by moving scratch handling into the pageio read code. I
provide a function to allocate scratch space for decoding read replies,
and free the scratch buffer when the nfs_pgio_header is freed.

Fixes: fbd2a05f29a9 (NFSv4.2: Rework scratch handling for READ_PLUS)
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h |  1 +
 fs/nfs/nfs42.h    |  1 +
 fs/nfs/nfs42xdr.c |  2 +-
 fs/nfs/nfs4proc.c | 13 +------------
 fs/nfs/read.c     | 10 ++++++++++
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 913c09806c7f5..41abea340ad84 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -493,6 +493,7 @@ extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+extern bool nfs_read_alloc_scratch(struct nfs_pgio_header *hdr, size_t size);
 extern int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 			       struct nfs_open_context *ctx,
 			       struct folio *folio);
diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf1..b59876b01a1e3 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -13,6 +13,7 @@
  * more? Need to consider not to pre-alloc too much for a compound.
  */
 #define PNFS_LAYOUTSTATS_MAXDEV (4)
+#define READ_PLUS_SCRATCH_SIZE (16)
 
 /* nfs4.2proc.c */
 #ifdef CONFIG_NFS_V4_2
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 78193f04d8928..9e3ae53e22058 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1433,7 +1433,7 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
-	xdr_set_scratch_buffer(xdr, res->scratch, sizeof(res->scratch));
+	xdr_set_scratch_buffer(xdr, res->scratch, READ_PLUS_SCRATCH_SIZE);
 
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 832fa226b8f26..3c24c3c99e8ac 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5438,18 +5438,8 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	return false;
 }
 
-static inline void nfs4_read_plus_scratch_free(struct nfs_pgio_header *hdr)
-{
-	if (hdr->res.scratch) {
-		kfree(hdr->res.scratch);
-		hdr->res.scratch = NULL;
-	}
-}
-
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
-	nfs4_read_plus_scratch_free(hdr);
-
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -5469,8 +5459,7 @@ static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 	/* Note: We don't use READ_PLUS with pNFS yet */
 	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp) {
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
-		hdr->res.scratch = kmalloc(32, GFP_KERNEL);
-		return hdr->res.scratch != NULL;
+		return nfs_read_alloc_scratch(hdr, READ_PLUS_SCRATCH_SIZE);
 	}
 	return false;
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index f71eeee67e201..7dc21a48e3e7b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -47,6 +47,8 @@ static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
+	if (rhdr->res.scratch != NULL)
+		kfree(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
@@ -108,6 +110,14 @@ void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio)
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
 
+bool nfs_read_alloc_scratch(struct nfs_pgio_header *hdr, size_t size)
+{
+	WARN_ON(hdr->res.scratch != NULL);
+	hdr->res.scratch = kmalloc(size, GFP_KERNEL);
+	return hdr->res.scratch != NULL;
+}
+EXPORT_SYMBOL_GPL(nfs_read_alloc_scratch);
+
 static void nfs_readpage_release(struct nfs_page *req, int error)
 {
 	struct folio *folio = nfs_page_to_folio(req);
-- 
2.40.1



