Return-Path: <stable+bounces-188067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA6BF15AF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2A5A34D2D9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51C1917ED;
	Mon, 20 Oct 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK8GO3Mu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0174312804
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964790; cv=none; b=qcDv8AFB1f5xK5JQpMs4WLf4rKq5psmYe+05DNIUo27K1TjdapIrwm4qNOK8KjFlA9DhioyID+c4/1G4cQCwhxAsFy1IWhnSJlqbySVr9YMEpld8IzOUzM3338nzQaWPvYgTGOpESjYYw/dzD8ENyHvk6sCKkIenEfvOEbHLUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964790; c=relaxed/simple;
	bh=oX6qPTghOW4FObUSkaJUvFnIitzNWJMmPtPemU6wpCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9oUCRgOV7ia027l8qKkwwkwQ3Hh/b63LhsrQuNpq02hd7LLJEnhjQXqOw+R3UmSXTUGZnqNLnUzgOB7DayVUmev/O4GJ+Ca4kvd3rEXaBmvyaRGJy45ie/kYFfbpKPOMGtpKdWthfbvpKTFSDpCx22o0FpzLmm0BG1tam5qKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK8GO3Mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC366C4CEF9;
	Mon, 20 Oct 2025 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964790;
	bh=oX6qPTghOW4FObUSkaJUvFnIitzNWJMmPtPemU6wpCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK8GO3MuHt4HEffayvEK7WsgTfcoGcxC/oLzO3gZp2tc+WCZd3LsBO1HwsHY9XHe3
	 n2UtYixYDzVTSEm2tWQ1ZkCxFHdtaCvvZTdBHrIq6Hwq3MCEww9hiGsNuUlm4vq8rn
	 Dc7YUk9jcaMiGtIg9KVog19dNLHwH1WV9vTwg4OGbwkW6XlCq/0fIyvZXjnS7lclk5
	 0zyd7iEFzjDZOvLMUNm70mOHDOrEyeJhAsLC60mc3Cp43MyAgBF2/Daeanf09UNTL6
	 h2OELEbVraXDtGTssIBs4oj/b0r9krj6zsjvYRfH/Qm4l1d/qdCdjra9aWfVDpLspc
	 sjHECuamTomFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] NFSD: Rework encoding and decoding of nfsd4_deviceid
Date: Mon, 20 Oct 2025 08:53:01 -0400
Message-ID: <20251020125305.1760219-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125305.1760219-1-sashal@kernel.org>
References: <2025101657-preseason-garnish-c1e0@gregkh>
 <20251020125305.1760219-1-sashal@kernel.org>
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
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
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
index fbfddd3c4c943..fc5e82eddaa1a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 90db900b346ce..bd5c8720ea7e3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -566,18 +566,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
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
@@ -1762,7 +1750,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2a21a7662e030..83263bff27dc6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -596,9 +596,43 @@ struct nfsd4_reclaim_complete {
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


