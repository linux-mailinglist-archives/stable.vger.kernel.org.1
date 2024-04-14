Return-Path: <stable+bounces-37507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01589C528
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E1F1C2223C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDB74BF5;
	Mon,  8 Apr 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZB6fsjk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55406EB72;
	Mon,  8 Apr 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584436; cv=none; b=NVd635P8nKid+QDWAg/ym7+2iBy6VfB3a8dN0HYkMVUhLZB2EJNH0t1cLGrJrF3i6Uvn6nQH18uFly/F53ycFoiGlisvVAJsnUwg7DUIfqmnDKTQmrVOvZV+EGh0ocgYXZEJk5tc7g68V9bYePCuTkCTGmodjxjXig8R97DlTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584436; c=relaxed/simple;
	bh=yTGFgD/f/Wq3JfelQTdq0btGxi0NYerh0vz0Wausuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts1GcMz1lCRIfolVaeXnqef09KKlieCzd0sH46VU993mDD66qB6ug+ke6I0Dg+eXf1vejFNYdRKfjcfZzATeo0nCaFDKeIvuMI72aD+2ZuDiS67wIEE7e/Xo/DxywKP/Dn3QOZerHtzibeMvWk3qgLyXSsT7G2gwFv6ZvgBw09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZB6fsjk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7FAC43394;
	Mon,  8 Apr 2024 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584436;
	bh=yTGFgD/f/Wq3JfelQTdq0btGxi0NYerh0vz0Wausuk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZB6fsjk/qZ8b9rkXLLBYtLttn5rpk0TPeVdzeYoHVvRBLs6nWJU8tfNo8FtOPO+1q
	 hopljeVJUnxythSnSVbn4M/wgcKBG3gHOpoOAhWvvxRgJDneMlq6eGWR+7NJT3Wqvs
	 YANR0B51EiF1bdXjVogPWZeJvBiIe68HuP/61K/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 437/690] NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing
Date: Mon,  8 Apr 2024 14:55:03 +0200
Message-ID: <20240408125415.464302745@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 3fdc546462348b8a497c72bc894e0cde9f10fc40 ]

Have SunRPC clear everything except for the iops array. Then have
each NFSv4 XDR decoder clear it's own argument before decoding.

Now individual operations may have a large argument struct while not
penalizing the vast majority of operations with a small struct.

And, clearing the argument structure occurs as the argument fields
are initialized, enabling the CPU to do write combining on that
memory. In some cases, clearing is not even necessary because all
of the fields in the argument structure are initialized by the
decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  | 61 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8aae0fb4846bc..7fdede420e65b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3590,7 +3590,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfs4svc_decode_compoundargs,
 		.pc_encode = nfs4svc_encode_compoundres,
 		.pc_argsize = sizeof(struct nfsd4_compoundargs),
-		.pc_argzero = sizeof(struct nfsd4_compoundargs),
+		.pc_argzero = offsetof(struct nfsd4_compoundargs, iops),
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3ad9b41c51730..6c43cf52a885f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -793,6 +793,7 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
 		return nfserr_bad_xdr;
+	memset(&commit->co_verf, 0, sizeof(commit->co_verf));
 	return nfs_ok;
 }
 
@@ -801,6 +802,7 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 {
 	__be32 *p, status;
 
+	memset(create, 0, sizeof(*create));
 	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
 		return nfserr_bad_xdr;
 	switch (create->cr_type) {
@@ -850,6 +852,7 @@ nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegretu
 static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
+	memset(getattr, 0, sizeof(*getattr));
 	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
 				    ARRAY_SIZE(getattr->ga_bmval));
 }
@@ -857,6 +860,7 @@ nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *geta
 static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
+	memset(link, 0, sizeof(*link));
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
@@ -905,6 +909,7 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
+	memset(lock, 0, sizeof(*lock));
 	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
@@ -921,6 +926,7 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
+	memset(lockt, 0, sizeof(*lockt));
 	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
 		return nfserr_bad_xdr;
 	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
@@ -1142,11 +1148,8 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	__be32 status;
 	u32 dummy;
 
-	memset(open->op_bmval, 0, sizeof(open->op_bmval));
-	open->op_iattr.ia_valid = 0;
-	open->op_openowner = NULL;
+	memset(open, 0, sizeof(*open));
 
-	open->op_xdr_error = 0;
 	if (xdr_stream_decode_u32(argp->xdr, &open->op_seqid) < 0)
 		return nfserr_bad_xdr;
 	/* deleg_want is ignored */
@@ -1181,6 +1184,8 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 	if (xdr_stream_decode_u32(argp->xdr, &open_conf->oc_seqid) < 0)
 		return nfserr_bad_xdr;
 
+	memset(&open_conf->oc_resp_stateid, 0,
+	       sizeof(open_conf->oc_resp_stateid));
 	return nfs_ok;
 }
 
@@ -1189,6 +1194,7 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 {
 	__be32 status;
 
+	memset(open_down, 0, sizeof(*open_down));
 	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
@@ -1218,6 +1224,7 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 	if (!putfh->pf_fhval)
 		return nfserr_jukebox;
 
+	putfh->no_verify = false;
 	return nfs_ok;
 }
 
@@ -1234,6 +1241,7 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	__be32 status;
 
+	memset(read, 0, sizeof(*read));
 	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
@@ -1250,6 +1258,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 {
 	__be32 status;
 
+	memset(readdir, 0, sizeof(*readdir));
 	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
 		return nfserr_bad_xdr;
 	status = nfsd4_decode_verifier4(argp, &readdir->rd_verf);
@@ -1269,6 +1278,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 static __be32
 nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
 {
+	memset(&remove->rm_cinfo, 0, sizeof(remove->rm_cinfo));
 	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
@@ -1277,6 +1287,7 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 {
 	__be32 status;
 
+	memset(rename, 0, sizeof(*rename));
 	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
 	if (status)
 		return status;
@@ -1293,6 +1304,7 @@ static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 		     struct nfsd4_secinfo *secinfo)
 {
+	secinfo->si_exp = NULL;
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
@@ -1301,6 +1313,7 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 {
 	__be32 status;
 
+	memset(setattr, 0, sizeof(*setattr));
 	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
@@ -1315,6 +1328,8 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 {
 	__be32 *p, status;
 
+	memset(setclientid, 0, sizeof(*setclientid));
+
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
@@ -1371,6 +1386,8 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 {
 	__be32 *p, status;
 
+	memset(verify, 0, sizeof(*verify));
+
 	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
 				      ARRAY_SIZE(verify->ve_bmval));
 	if (status)
@@ -1410,6 +1427,9 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
 		return nfserr_bad_xdr;
 
+	write->wr_bytes_written = 0;
+	write->wr_how_written = 0;
+	memset(&write->wr_verifier, 0, sizeof(write->wr_verifier));
 	return nfs_ok;
 }
 
@@ -1434,6 +1454,7 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 
 static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
 {
+	memset(bc, 0, sizeof(*bc));
 	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
 		return nfserr_bad_xdr;
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
@@ -1444,6 +1465,7 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 	u32 use_conn_in_rdma_mode;
 	__be32 status;
 
+	memset(bcts, 0, sizeof(*bcts));
 	status = nfsd4_decode_sessionid4(argp, &bcts->sessionid);
 	if (status)
 		return status;
@@ -1585,6 +1607,7 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(exid, 0, sizeof(*exid));
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
 	if (status)
 		return status;
@@ -1637,6 +1660,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(sess, 0, sizeof(*sess));
 	status = nfsd4_decode_clientid4(argp, &sess->clientid);
 	if (status)
 		return status;
@@ -1652,11 +1676,7 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &sess->callback_prog) < 0)
 		return nfserr_bad_xdr;
-	status = nfsd4_decode_cb_sec(argp, &sess->cb_sec);
-	if (status)
-		return status;
-
-	return nfs_ok;
+	return nfsd4_decode_cb_sec(argp, &sess->cb_sec);
 }
 
 static __be32
@@ -1680,6 +1700,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(gdev, 0, sizeof(*gdev));
 	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
 	if (status)
 		return status;
@@ -1700,6 +1721,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 {
 	__be32 *p, status;
 
+	memset(lcp, 0, sizeof(*lcp));
 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.length) < 0)
@@ -1735,6 +1757,7 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(lgp, 0, sizeof(*lgp));
 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_layout_type) < 0)
@@ -1760,6 +1783,7 @@ static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)
 {
+	memset(lrp, 0, sizeof(*lrp));
 	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
@@ -1775,6 +1799,8 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 {
 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
 		return nfserr_bad_xdr;
+
+	sin->sin_exp = NULL;
 	return nfs_ok;
 }
 
@@ -1795,6 +1821,7 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 	seq->maxslots = be32_to_cpup(p++);
 	seq->cachethis = be32_to_cpup(p);
 
+	seq->status_flags = 0;
 	return nfs_ok;
 }
 
@@ -1805,6 +1832,7 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 	__be32 status;
 	u32 i;
 
+	memset(test_stateid, 0, sizeof(*test_stateid));
 	if (xdr_stream_decode_u32(argp->xdr, &test_stateid->ts_num_ids) < 0)
 		return nfserr_bad_xdr;
 
@@ -1902,6 +1930,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	struct nl4_server *ns_dummy;
 	__be32 status;
 
+	memset(copy, 0, sizeof(*copy));
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
 	if (status)
 		return status;
@@ -1957,6 +1986,7 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	memset(cn, 0, sizeof(*cn));
 	cn->cpn_src = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
 	if (cn->cpn_src == NULL)
 		return nfserr_jukebox;
@@ -1974,6 +2004,8 @@ static __be32
 nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_offload_status *os)
 {
+	os->count = 0;
+	os->status = 0;
 	return nfsd4_decode_stateid4(argp, &os->stateid);
 }
 
@@ -1990,6 +2022,8 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 	if (xdr_stream_decode_u32(argp->xdr, &seek->seek_whence) < 0)
 		return nfserr_bad_xdr;
 
+	seek->seek_eof = 0;
+	seek->seek_pos = 0;
 	return nfs_ok;
 }
 
@@ -2125,6 +2159,7 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 	__be32 status;
 	u32 maxcount;
 
+	memset(getxattr, 0, sizeof(*getxattr));
 	status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
 	if (status)
 		return status;
@@ -2133,8 +2168,7 @@ nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
 	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
 
 	getxattr->getxa_len = maxcount;
-
-	return status;
+	return nfs_ok;
 }
 
 static __be32
@@ -2144,6 +2178,8 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 	u32 flags, maxcount, size;
 	__be32 status;
 
+	memset(setxattr, 0, sizeof(*setxattr));
+
 	if (xdr_stream_decode_u32(argp->xdr, &flags) < 0)
 		return nfserr_bad_xdr;
 
@@ -2182,6 +2218,8 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 {
 	u32 maxcount;
 
+	memset(listxattrs, 0, sizeof(*listxattrs));
+
 	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
 		return nfserr_bad_xdr;
 
@@ -2209,6 +2247,7 @@ static __be32
 nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_removexattr *removexattr)
 {
+	memset(removexattr, 0, sizeof(*removexattr));
 	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
 }
 
-- 
2.43.0




