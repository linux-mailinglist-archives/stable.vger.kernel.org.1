Return-Path: <stable+bounces-81353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF9993182
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446AD1F2398A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C831D86DC;
	Mon,  7 Oct 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycMY8k+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC318BBB2
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315555; cv=none; b=cHzvO2soPK6Ib+3BrklJ4TzD8GHyixGHwxE2wSFcFeWpEH2oIpifCldCRvnfl9ThlRDxsapjkSjL5RbezWYz52D45yQmjSzVK9ubhM8/ZqvzDqHt807EXPsjqSi5O+htWOOBM/4nHi1CegZNFvm5W+VdMBYeFdLvv/nPqKbgFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315555; c=relaxed/simple;
	bh=rHfJXd5kkX4cbhojIjh73nq2ugmcxGiyURwDRaA6UeQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PoPUF8Ch3X9AlVCsD7tfmLSsD+XEvxroxHdbQxBvoNXz1bcHGtrsDEAZqkylugheQdcdK0UMr/p6RKEibu+DINDt9egJ9Bxlizhm2EZ8mk7Pj2eQPoSdFTvQPhDU4OIS9XaLYYOpZ2J2h826d6bNcatp7t+bYrafGq3WdydGpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycMY8k+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00B0C4CEC6;
	Mon,  7 Oct 2024 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315555;
	bh=rHfJXd5kkX4cbhojIjh73nq2ugmcxGiyURwDRaA6UeQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ycMY8k+wYIzIjIlj+BKnxhtuNsHCCQR7jzDONNJ0OuK3wO2txnp9s6lSEmtdoXi+L
	 Q47Yv54yU3SI3SP2CqcasfOzhOYmk+MUbSBnD3ZpCUiwkbQhAxNkAJG2qngkHubJQe
	 LPLYFVq4e7tE59BLb+wmqJOwz7eZJYbV5SZtywZI=
Subject: FAILED: patch "[PATCH] NFSD: Fix NFSv4's PUTPUBFH operation" failed to apply to 4.19-stable tree
To: chuck.lever@oracle.com,cedric.blancher@gmail.com,dan.f.shelton@gmail.com,roland.mainz@nrubsig.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:39:04 +0200
Message-ID: <2024100703-daunting-sternness-a39e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 202f39039a11402dcbcd5fece8d9fa6be83f49ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100703-daunting-sternness-a39e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

202f39039a11 ("NFSD: Fix NFSv4's PUTPUBFH operation")
e78e274eb22d ("NFSD: Avoid clashing function prototypes")
eeadcb757945 ("NFSD: Simplify READ_PLUS")
3fdc54646234 ("NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing")
103cc1fafee4 ("SUNRPC: Parametrize how much of argsize should be zeroed")
1913cdf56cb5 ("NFSD: Replace boolean fields in struct nfsd4_copy")
87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
09426ef2a64e ("NFSD: Shrink size of struct nfsd4_copy_notify")
99b002a1fa00 ("NFSD: Clean up nfsd4_encode_readlink()")
c738b218a2e5 ("NFSD: Clean up SPLICE_OK in nfsd4_encode_read()")
0cb4d23ae08c ("NFSD: Fix the behavior of READ near OFFSET_MAX")
555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
f11ad7aa6531 ("NFSD: Fix verifier returned in stable WRITEs")
1e37d0e5bda4 ("NFSD: Fix inconsistent indenting")
474bc334698d ("nfsd: Reduce contention for the nfsd_file nf_rwsem")
eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
bddfdbcddbe2 ("NFSD: Extract the svcxdr_init_encode() helper")
1fcbd1c9456b ("NFSD: Update the NFSv2 READLINK argument decoder to use struct xdr_stream")
224c1c894e48 ("NFSD: Update READLINK3arg decoder to use struct xdr_stream")
be63bd2ac6bb ("NFSD: Update READ3arg decoder to use struct xdr_stream")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 202f39039a11402dcbcd5fece8d9fa6be83f49ae Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Sun, 11 Aug 2024 13:11:07 -0400
Subject: [PATCH] NFSD: Fix NFSv4's PUTPUBFH operation

According to RFC 8881, all minor versions of NFSv4 support PUTPUBFH.

Replace the XDR decoder for PUTPUBFH with a "noop" since we no
longer want the minorversion check, and PUTPUBFH has no arguments to
decode. (Ideally nfsd4_decode_noop should really be called
nfsd4_decode_void).

PUTPUBFH should now behave just like PUTROOTFH.

Reported-by: Cedric Blancher <cedric.blancher@gmail.com>
Fixes: e1a90ebd8b23 ("NFSD: Combine decode operations for v4 and v4.1")
Cc: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Roland Mainz <roland.mainz@nrubsig.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4643fcfb7187..f118921250c3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1245,14 +1245,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
@@ -2374,7 +2366,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_OPEN_CONFIRM]	= nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= nfsd4_decode_noop,
 	[OP_READ]		= nfsd4_decode_read,
 	[OP_READDIR]		= nfsd4_decode_readdir,


