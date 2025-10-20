Return-Path: <stable+bounces-188240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B92BCBF34DC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7024FD35F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683332F770;
	Mon, 20 Oct 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4XpTU5H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C552D0636
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990329; cv=none; b=bSPY7PXOXiL+85PnisLDfwUVSEUV1QUmN1c8vAvdafPrxV/O9Ih3TwYeKkvmqh/4MlUb5KhN04/pCujLPHxmYaTI6drknOr336sh39bomhudaxjNpm/dtoWBMjy9HTGqyNj01FIr2vk2IGVy8CDimGOAx+OK04H9jbXPy9TIBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990329; c=relaxed/simple;
	bh=2OZDX6HUYA3fwFJL0UHxKhN7J9bkrE3VPNYY8WBvgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNOR9W3rCybz742dda1NXrBEvlHxWrVbHH0/uHpRz/dIyLldIOGNUEARtrBsEt+thnfRvM/Hn0XoDTrJvhOpBXq+Lu51hntFJr8gH9mPjnsj8i8y6m+h3Lut/wl7JggxjDlfHAb8h4EtfKwfSZFhX7A9MgDzUXLXEELSnldBnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4XpTU5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA378C113D0;
	Mon, 20 Oct 2025 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990329;
	bh=2OZDX6HUYA3fwFJL0UHxKhN7J9bkrE3VPNYY8WBvgHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4XpTU5HUSjBEf2ufkOpnmkLtwk+FJmTrlUGm2EPT5T6Q7l/1kJeLOql4GplH1eL2
	 qIhp8XQj6sJ9a3tww6MFZ9Pl2LVjhLi50ZG6eR8/3PjBbw66VeffA5+kfK2ZQdx7GR
	 crK/NBAuo0rnkaUJPHSRjktOnqaSMKsPNkZ5FUVojEhi0IoGBOGHxHIspEJacXrHt9
	 qhY86/u4ILCVFIUdgMXvYJPPFbtPt6qomMHVYDX/KQxJmoNj1kEln+W0fC9w/zmBsL
	 T7NBBdatBohuahfjwrF6DnzPAN6NpVc3UhCQSDgmZyzfX2E/Cqepl4W1LfShBBPWWc
	 /g9UOsDiVSRXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] NFSD: Rework encoding and decoding of nfsd4_deviceid
Date: Mon, 20 Oct 2025 15:58:44 -0400
Message-ID: <20251020195846.1896208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102049-comic-carpentry-952e@gregkh>
References: <2025102049-comic-carpentry-952e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit 832738e4b325b742940761e10487403f9aad13e8 ]

Compilers may optimize the layout of C structures, so we should not rely
on sizeof struct and memcpy to encode and decode XDR structures. The byte
order of the fields should also be taken into account.

This patch adds the correct functions to handle the deviceid4 structure
and removes the pad field, which is currently not used by NFSD, from the
runtime state. The server's byte order is preserved because the deviceid4
blob on the wire is only used as a cookie by the client.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 4b47a8601b71 ("NFSD: Define a proc_layoutcommit for the FlexFiles layout type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayoutxdr.c    |  7 ++-----
 fs/nfsd/flexfilelayoutxdr.c |  3 +--
 fs/nfsd/nfs4layouts.c       |  1 -
 fs/nfsd/nfs4xdr.c           | 14 +-------------
 fs/nfsd/xdr4.h              | 36 +++++++++++++++++++++++++++++++++++-
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index bcf21fde91207..18de37ff28916 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -156,9 +155,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
-
+		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
 			goto fail;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index aeb71c10ff1b9..f9f7e38cba13f 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &fl->deviceid);
 
 	*p++ = cpu_to_be32(1);			/* efficiency */
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index aea905fcaf87a..683bd1130afe2 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a00300b287754..7df4d5aed6647 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -588,18 +588,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static __be32
-nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_deviceid *devid)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
-	if (!p)
-		return nfserr_bad_xdr;
-	memcpy(devid, p, sizeof(*devid));
-	return nfs_ok;
-}
 
 static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
@@ -1784,7 +1772,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a23bc56051caf..e65b552bf5f5a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -595,9 +595,43 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	*q = (__force __be64)devid->fsid_idx;
+	p += 2;
+	*p++ = (__force __be32)devid->generation;
+	*p++ = xdr_zero;
+	return p;
+}
+
+static inline __be32 *
+svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	devid->fsid_idx = (__force u64)(*q);
+	p += 2;
+	devid->generation = (__force u32)(*p++);
+	p++; /* NFSD does not use the remaining octets */
+	return p;
+}
+
+static inline __be32
+nfsd4_decode_deviceid4(struct xdr_stream *xdr, struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	svcxdr_decode_deviceid4(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
-- 
2.51.0


