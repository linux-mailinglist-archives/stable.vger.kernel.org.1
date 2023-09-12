Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2979B0AB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358459AbjIKWLF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjIKPSa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35376FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2A7C433C7;
        Mon, 11 Sep 2023 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445505;
        bh=11zuF0wd4CH28OMKOgZh7RioE56lzVa1ptOIiyhOVfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3khoVPzkP564+EP8o+2mXXCvW7tjDtJTEfklYOQSXvpq175fGFWuQMjNYsNTwzse
         c82x8KjOiA1IJKOM33dyrer+OViN/tp56RmnLCVh4pBI6aRyQIRvWfA97cLsCTwpXH
         Cz75LPltrCZcMS3ETCXlG7N49oCVu0qf3ELMuYls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 372/600] NFSv4.2: Rework scratch handling for READ_PLUS
Date:   Mon, 11 Sep 2023 15:46:45 +0200
Message-ID: <20230911134644.661125798@linuxfoundation.org>
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit fbd2a05f29a95d5b42b294bf47e55a711424965b ]

Instead of using a tiny, static scratch buffer, we should use a kmalloc()-ed
buffer that is allocated when checking for read plus usage. This lets us
use the buffer before decoding any part of the READ_PLUS operation
instead of setting it right before segment decoding, meaning it should
be a little more robust.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: bb05a617f06b ("NFSv4.2: Fix READ_PLUS smatch warnings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42xdr.c       |  4 ++--
 fs/nfs/nfs4proc.c       | 17 ++++++++++++-----
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 2fd465cab631d..08c1dd094f010 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1121,7 +1121,6 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	uint32_t segments;
 	struct read_plus_segment *segs;
 	int status, i;
-	char scratch_buf[16];
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1142,7 +1141,6 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (!segs)
 		return -ENOMEM;
 
-	xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
 	status = -EIO;
 	for (i = 0; i < segments; i++) {
 		status = decode_read_plus_segment(xdr, &segs[i]);
@@ -1347,6 +1345,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
+	xdr_set_scratch_buffer(xdr, res->scratch, sizeof(res->scratch));
+
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1044305e77996..3f96ccc386c34 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5446,6 +5446,8 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
+	if (hdr->res.scratch)
+		kfree(hdr->res.scratch);
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -5459,17 +5461,22 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 }
 
 #if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
-static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
 	/* Note: We don't use READ_PLUS with pNFS yet */
-	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp)
+	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp) {
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
+		hdr->res.scratch = kmalloc(32, GFP_KERNEL);
+		return hdr->res.scratch != NULL;
+	}
+	return false;
 }
 #else
-static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
+	return false;
 }
 #endif /* CONFIG_NFS_V4_2 */
 
@@ -5479,8 +5486,8 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 	hdr->timestamp   = jiffies;
 	if (!hdr->pgio_done_cb)
 		hdr->pgio_done_cb = nfs4_read_done_cb;
-	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
-	nfs42_read_plus_support(hdr, msg);
+	if (!nfs42_read_plus_support(hdr, msg))
+		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d212..2fd973d188c47 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -670,6 +670,7 @@ struct nfs_pgio_res {
 		struct {
 			unsigned int		replen;		/* used by read */
 			int			eof;		/* used by read */
+			void *			scratch;	/* used by read */
 		};
 		struct {
 			struct nfs_writeverf *	verf;		/* used by write */
-- 
2.40.1



