Return-Path: <stable+bounces-147159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA32AC5673
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBB84A4F4C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B5279782;
	Tue, 27 May 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V43jZnhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDB1E89C;
	Tue, 27 May 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366472; cv=none; b=sWVwDNsAI6FUgLwcheAO6bjsPs527hcGCNLuXMOUgE9BHCh77ogDE8dQ4Cw/l23Gq6K4OhXIg4lhgXWciLdAM+fqn9soLuoJ4ykAIVi376JgSQxZq0ZqoWBZyMD8u8EY8tWXSanYZ8PS/q2dcLChbrONERlEFpaB6eawbMfCMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366472; c=relaxed/simple;
	bh=gKEz9reLQ6nJrB6r82xawXw0mgoKEevxsNS402kGGMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYSJ1U3FxpRijsuk96aNREodXzSQClrFWt/zehk8vIrcIbAR5f4Hm2e6vWSI8gSD7TNXHq45Eqp6f0Q33wourCuhwqfhTRZ+N2ATcJoKdzOM5Oc81Zj3m5TRvtqGvbQv1ffmS3DMJdOHCntZJruyuDVTjoFfuP06U1s8XwnZSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V43jZnhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1227C4CEE9;
	Tue, 27 May 2025 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366472;
	bh=gKEz9reLQ6nJrB6r82xawXw0mgoKEevxsNS402kGGMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V43jZnhAxCuFfg4JswC7604mHT/VgnIRs8jtPoUqG3pQNg1oaBMhW9a7pipm9kdp4
	 ywA0vBSu9DONKMBQ7PhEeCXk3L32qweyxut4ambLRBaMFF+H2um09z0D9Q1ahvEDgy
	 /Mnt8YR7dJDMpnG5BWwIDAT99KldLCVRjtB3Ql0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Zhaolong <wangzhaolong1@huawei.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 051/783] smb: client: Store original IO parameters and prevent zero IO sizes
Date: Tue, 27 May 2025 18:17:28 +0200
Message-ID: <20250527162515.209142768@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Zhaolong <wangzhaolong1@huawei.com>

[ Upstream commit 287906b20035a04a234d1a3c64f760a5678387be ]

During mount option processing and negotiation with the server, the
original user-specified rsize/wsize values were being modified directly.
This makes it impossible to recover these values after a connection
reset, leading to potential degraded performance after reconnection.

The other problem is that When negotiating read and write sizes, there are
cases where the negotiated values might calculate to zero, especially
during reconnection when server->max_read or server->max_write might be
reset. In general, these values come from the negotiation response.
According to MS-SMB2 specification, these values should be at least 65536
bytes.

This patch improves IO parameter handling:

1. Adds vol_rsize and vol_wsize fields to store the original user-specified
   values separately from the negotiated values
2. Uses got_rsize/got_wsize flags to determine if values were
   user-specified rather than checking for non-zero values, which is more
   reliable
3. Adds a prevent_zero_iosize() helper function to ensure IO sizes are
   never negotiated down to zero, which could happen in edge cases like
   when server->max_read/write is zero

The changes make the CIFS client more resilient to unusual server
responses and reconnection scenarios, preventing potential failures
when IO sizes are calculated to be zero.

Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c |  2 ++
 fs/smb/client/fs_context.h |  3 +++
 fs/smb/client/smb1ops.c    |  6 +++---
 fs/smb/client/smb2ops.c    | 27 +++++++++++++++++++--------
 fs/smb/common/smb2pdu.h    |  3 +++
 5 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index e38521a713a6b..00af8dd5aa689 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1327,6 +1327,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	case Opt_rsize:
 		ctx->rsize = result.uint_32;
 		ctx->got_rsize = true;
+		ctx->vol_rsize = ctx->rsize;
 		break;
 	case Opt_wsize:
 		ctx->wsize = result.uint_32;
@@ -1342,6 +1343,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 					 ctx->wsize, PAGE_SIZE);
 			}
 		}
+		ctx->vol_wsize = ctx->wsize;
 		break;
 	case Opt_acregmax:
 		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index 881bfc08667e7..7516ccdc69c71 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -279,6 +279,9 @@ struct smb3_fs_context {
 	bool use_client_guid:1;
 	/* reuse existing guid for multichannel */
 	u8 client_guid[SMB2_CLIENT_GUID_SIZE];
+	/* User-specified original r/wsize value */
+	unsigned int vol_rsize;
+	unsigned int vol_wsize;
 	unsigned int bsize;
 	unsigned int rasize;
 	unsigned int rsize;
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index e28cdaca47e12..73a689b4ccdff 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -437,8 +437,8 @@ cifs_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	unsigned int wsize;
 
 	/* start with specified wsize, or default */
-	if (ctx->wsize)
-		wsize = ctx->wsize;
+	if (ctx->got_wsize)
+		wsize = ctx->vol_wsize;
 	else if (tcon->unix_ext && (unix_cap & CIFS_UNIX_LARGE_WRITE_CAP))
 		wsize = CIFS_DEFAULT_IOSIZE;
 	else
@@ -490,7 +490,7 @@ cifs_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	else
 		defsize = server->maxBuf - sizeof(READ_RSP);
 
-	rsize = ctx->rsize ? ctx->rsize : defsize;
+	rsize = ctx->got_rsize ? ctx->vol_rsize : defsize;
 
 	/*
 	 * no CAP_LARGE_READ_X? Then MS-CIFS states that we must limit this to
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6f89e087629fe..6795970d4de6e 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -467,6 +467,17 @@ smb2_negotiate(const unsigned int xid,
 	return rc;
 }
 
+static inline unsigned int
+prevent_zero_iosize(unsigned int size, const char *type)
+{
+	if (size == 0) {
+		cifs_dbg(VFS, "SMB: Zero %ssize calculated, using minimum value %u\n",
+			 type, CIFS_MIN_DEFAULT_IOSIZE);
+		return CIFS_MIN_DEFAULT_IOSIZE;
+	}
+	return size;
+}
+
 static unsigned int
 smb2_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 {
@@ -474,12 +485,12 @@ smb2_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	unsigned int wsize;
 
 	/* start with specified wsize, or default */
-	wsize = ctx->wsize ? ctx->wsize : CIFS_DEFAULT_IOSIZE;
+	wsize = ctx->got_wsize ? ctx->vol_wsize : CIFS_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		wsize = min_t(unsigned int, wsize, SMB2_MAX_BUFFER_SIZE);
 
-	return wsize;
+	return prevent_zero_iosize(wsize, "w");
 }
 
 static unsigned int
@@ -489,7 +500,7 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	unsigned int wsize;
 
 	/* start with specified wsize, or default */
-	wsize = ctx->wsize ? ctx->wsize : SMB3_DEFAULT_IOSIZE;
+	wsize = ctx->got_wsize ? ctx->vol_wsize : SMB3_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
@@ -511,7 +522,7 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		wsize = min_t(unsigned int, wsize, SMB2_MAX_BUFFER_SIZE);
 
-	return wsize;
+	return prevent_zero_iosize(wsize, "w");
 }
 
 static unsigned int
@@ -521,13 +532,13 @@ smb2_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	unsigned int rsize;
 
 	/* start with specified rsize, or default */
-	rsize = ctx->rsize ? ctx->rsize : CIFS_DEFAULT_IOSIZE;
+	rsize = ctx->got_rsize ? ctx->vol_rsize : CIFS_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
 
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		rsize = min_t(unsigned int, rsize, SMB2_MAX_BUFFER_SIZE);
 
-	return rsize;
+	return prevent_zero_iosize(rsize, "r");
 }
 
 static unsigned int
@@ -537,7 +548,7 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	unsigned int rsize;
 
 	/* start with specified rsize, or default */
-	rsize = ctx->rsize ? ctx->rsize : SMB3_DEFAULT_IOSIZE;
+	rsize = ctx->got_rsize ? ctx->vol_rsize : SMB3_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
@@ -560,7 +571,7 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		rsize = min_t(unsigned int, rsize, SMB2_MAX_BUFFER_SIZE);
 
-	return rsize;
+	return prevent_zero_iosize(rsize, "r");
 }
 
 /*
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 12f0013334057..f79a5165a7cc6 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -95,6 +95,9 @@
  */
 #define SMB3_DEFAULT_IOSIZE (4 * 1024 * 1024)
 
+/* According to MS-SMB2 specification The minimum recommended value is 65536.*/
+#define CIFS_MIN_DEFAULT_IOSIZE (65536)
+
 /*
  * SMB2 Header Definition
  *
-- 
2.39.5




