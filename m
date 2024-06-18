Return-Path: <stable+bounces-53486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E657990D1EA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480D91F27B0E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10291A4F37;
	Tue, 18 Jun 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2hRJxlG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2F1A00CB;
	Tue, 18 Jun 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716467; cv=none; b=IVd8cjF4xY/UCckU2+T+4qvXNVJPzMiu6vY2Q39jTA96p9qPLEWPi2nvdH1ywzaLFlKum4G5D+8OUxsoi82X87wdAaLlyJHreuDSETIJIP07Ahpf+GKNCXctlsfXgeeNoB0yc4V9jNtFsieM+m75Ijl/SE3FqWuDx6a0oGIFrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716467; c=relaxed/simple;
	bh=Ks+O/N0NxL+uXK9/+5SJwE5Sg0UO9u/PcCOe/Nn/Wfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaaFyoUagwYLj+9zRarPi/fcxbtMHa0ZSFzgyYa7+/Tged326SkpXDjZKLoz7euwkHYOvNgj1fAGaIY3EyhNXF10FFftckcLafrsiN1tkcYLfMsihsuQcZoH2S9SQswA7n2gTeWdT6HwDqWLnLvgi4RMlz1YEklWzUPvOCXUKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2hRJxlG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C4C3277B;
	Tue, 18 Jun 2024 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716467;
	bh=Ks+O/N0NxL+uXK9/+5SJwE5Sg0UO9u/PcCOe/Nn/Wfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2hRJxlG3hTgh+kAqikmYGDjIHgfuNbvYVKyhb2fNZQw1S1OAxMA/YNAuxnpETaMwT
	 qWs7eF2NNGBkHqRZbhhy7k+6zXy5e0qiV59A2coi7mFN6HBK2lSEZt069udlVHIq+x
	 j62pnuzyACN88eMgeSuc76tj9rWLzlW7PqUzJFJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 649/770] SUNRPC: Parametrize how much of argsize should be zeroed
Date: Tue, 18 Jun 2024 14:38:22 +0200
Message-ID: <20240618123432.340021256@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 103cc1fafee48adb91fca0e19deb869fd23e46ab ]

Currently, SUNRPC clears the whole of .pc_argsize before processing
each incoming RPC transaction. Add an extra parameter to struct
svc_procedure to enable upper layers to reduce the amount of each
operation's argument structure that is zeroed by SUNRPC.

The size of struct nfsd4_compoundargs, in particular, is a lot to
clear on each incoming RPC Call. A subsequent patch will cut this
down to something closer to what NFSv2 and NFSv3 uses.

This patch should cause no behavior changes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc4proc.c        | 24 ++++++++++++++++++++++++
 fs/lockd/svcproc.c         | 24 ++++++++++++++++++++++++
 fs/nfs/callback_xdr.c      |  1 +
 fs/nfsd/nfs2acl.c          |  5 +++++
 fs/nfsd/nfs3acl.c          |  3 +++
 fs/nfsd/nfs3proc.c         | 22 ++++++++++++++++++++++
 fs/nfsd/nfs4proc.c         |  2 ++
 fs/nfsd/nfsproc.c          | 18 ++++++++++++++++++
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           |  2 +-
 10 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index bf274f23969b3..284b019cb6529 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -521,6 +521,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "NULL",
@@ -530,6 +531,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_testres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
@@ -539,6 +541,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
@@ -548,6 +551,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_cancargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
@@ -557,6 +561,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_unlockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
@@ -566,6 +571,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
@@ -575,6 +581,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_MSG",
@@ -584,6 +591,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_MSG",
@@ -593,6 +601,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_cancargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_MSG",
@@ -602,6 +611,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_unlockargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_MSG",
@@ -611,6 +621,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_MSG",
@@ -620,6 +631,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_RES",
@@ -629,6 +641,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_RES",
@@ -638,6 +651,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_RES",
@@ -647,6 +661,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_RES",
@@ -656,6 +671,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_res,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_RES",
@@ -665,6 +681,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_reboot,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_argzero = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "SM_NOTIFY",
@@ -674,6 +691,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -683,6 +701,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -692,6 +711,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -701,6 +721,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_shareargs,
 		.pc_encode = nlm4svc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
@@ -710,6 +731,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_shareargs,
 		.pc_encode = nlm4svc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
@@ -719,6 +741,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
@@ -728,6 +751,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_notify,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "FREE_ALL",
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index b09ca35b527cc..e35c05e278061 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -555,6 +555,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "NULL",
@@ -564,6 +565,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_testres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
@@ -573,6 +575,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
@@ -582,6 +585,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
@@ -591,6 +595,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
@@ -600,6 +605,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
@@ -609,6 +615,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_MSG",
@@ -618,6 +625,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_MSG",
@@ -627,6 +635,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_MSG",
@@ -636,6 +645,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_MSG",
@@ -645,6 +655,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_MSG",
@@ -654,6 +665,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_RES",
@@ -663,6 +675,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_RES",
@@ -672,6 +685,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_RES",
@@ -681,6 +695,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_RES",
@@ -690,6 +705,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_res,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_RES",
@@ -699,6 +715,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_reboot,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_argzero = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "SM_NOTIFY",
@@ -708,6 +725,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -717,6 +735,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -726,6 +745,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -735,6 +755,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
@@ -744,6 +765,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
@@ -753,6 +775,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
@@ -762,6 +785,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_notify,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "FREE_ALL",
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 1b21f88a9808c..db69fc267c9a0 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1070,6 +1070,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_func = nfs4_callback_compound,
 		.pc_encode = nfs4_encode_void,
 		.pc_argsize = 256,
+		.pc_argzero = 256,
 		.pc_ressize = 256,
 		.pc_xdrressize = NFS4_CALLBACK_BUFSIZE,
 		.pc_name = "COMPOUND",
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index f7d166f056afa..f8179fc8c9bdf 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -329,6 +329,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
@@ -340,6 +341,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfsaclsvc_encode_getaclres,
 		.pc_release = nfsaclsvc_release_getacl,
 		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_argzero = sizeof(struct nfsd3_getaclargs),
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
@@ -351,6 +353,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -362,6 +365,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -373,6 +377,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfsaclsvc_encode_accessres,
 		.pc_release = nfsaclsvc_release_access,
 		.pc_argsize = sizeof(struct nfsd3_accessargs),
+		.pc_argzero = sizeof(struct nfsd3_accessargs),
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1,
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 15bee0339c764..2c451fcd5a3cc 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -250,6 +250,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
@@ -261,6 +262,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_encode = nfs3svc_encode_getaclres,
 		.pc_release = nfs3svc_release_getacl,
 		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_argzero = sizeof(struct nfsd3_getaclargs),
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
@@ -272,6 +274,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_encode = nfs3svc_encode_setaclres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd3_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT,
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8679c41746027..5c2e2b5e5945f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -809,6 +809,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
@@ -820,6 +821,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_getattrres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -831,6 +833,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_wccstatres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_sattrargs),
+		.pc_argzero = sizeof(struct nfsd3_sattrargs),
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
@@ -842,6 +845,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_lookupres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_diropargs),
+		.pc_argzero = sizeof(struct nfsd3_diropargs),
 		.pc_ressize = sizeof(struct nfsd3_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+pAT+pAT,
@@ -853,6 +857,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_accessres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_accessargs),
+		.pc_argzero = sizeof(struct nfsd3_accessargs),
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1,
@@ -864,6 +869,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_readlinkres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1+NFS3_MAXPATHLEN/4,
@@ -875,6 +881,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_readres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_readargs),
+		.pc_argzero = sizeof(struct nfsd3_readargs),
 		.pc_ressize = sizeof(struct nfsd3_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
@@ -886,6 +893,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_writeres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_writeargs),
+		.pc_argzero = sizeof(struct nfsd3_writeargs),
 		.pc_ressize = sizeof(struct nfsd3_writeres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+4,
@@ -897,6 +905,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_createres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_createargs),
+		.pc_argzero = sizeof(struct nfsd3_createargs),
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
@@ -908,6 +917,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_createres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_mkdirargs),
+		.pc_argzero = sizeof(struct nfsd3_mkdirargs),
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
@@ -919,6 +929,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_createres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_symlinkargs),
+		.pc_argzero = sizeof(struct nfsd3_symlinkargs),
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
@@ -930,6 +941,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_createres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_mknodargs),
+		.pc_argzero = sizeof(struct nfsd3_mknodargs),
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
@@ -941,6 +953,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_wccstatres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_diropargs),
+		.pc_argzero = sizeof(struct nfsd3_diropargs),
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
@@ -952,6 +965,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_wccstatres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_diropargs),
+		.pc_argzero = sizeof(struct nfsd3_diropargs),
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
@@ -963,6 +977,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_renameres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_renameargs),
+		.pc_argzero = sizeof(struct nfsd3_renameargs),
 		.pc_ressize = sizeof(struct nfsd3_renameres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+WC,
@@ -974,6 +989,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_linkres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_linkargs),
+		.pc_argzero = sizeof(struct nfsd3_linkargs),
 		.pc_ressize = sizeof(struct nfsd3_linkres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+pAT+WC,
@@ -985,6 +1001,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_readdirres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_readdirargs),
+		.pc_argzero = sizeof(struct nfsd3_readdirargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_name = "READDIR",
@@ -995,6 +1012,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_readdirres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_readdirplusargs),
+		.pc_argzero = sizeof(struct nfsd3_readdirplusargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_name = "READDIRPLUS",
@@ -1004,6 +1022,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_fsstatres,
 		.pc_argsize = sizeof(struct nfsd3_fhandleargs),
+		.pc_argzero = sizeof(struct nfsd3_fhandleargs),
 		.pc_ressize = sizeof(struct nfsd3_fsstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+2*6+1,
@@ -1014,6 +1033,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_fsinfores,
 		.pc_argsize = sizeof(struct nfsd3_fhandleargs),
+		.pc_argzero = sizeof(struct nfsd3_fhandleargs),
 		.pc_ressize = sizeof(struct nfsd3_fsinfores),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+12,
@@ -1024,6 +1044,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_pathconfres,
 		.pc_argsize = sizeof(struct nfsd3_fhandleargs),
+		.pc_argzero = sizeof(struct nfsd3_fhandleargs),
 		.pc_ressize = sizeof(struct nfsd3_pathconfres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+6,
@@ -1035,6 +1056,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_encode = nfs3svc_encode_commitres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_commitargs),
+		.pc_argzero = sizeof(struct nfsd3_commitargs),
 		.pc_ressize = sizeof(struct nfsd3_commitres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+WC+2,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 38d60964d8b2d..f6ea7445073fe 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3577,6 +3577,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
@@ -3587,6 +3588,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfs4svc_decode_compoundargs,
 		.pc_encode = nfs4svc_encode_compoundres,
 		.pc_argsize = sizeof(struct nfsd4_compoundargs),
+		.pc_argzero = sizeof(struct nfsd4_compoundargs),
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7ed03ac6bdab3..3509331a66504 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -645,6 +645,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
@@ -656,6 +657,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -667,6 +669,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_sattrargs),
+		.pc_argzero = sizeof(struct nfsd_sattrargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
@@ -677,6 +680,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
@@ -688,6 +692,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_diropres,
 		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
+		.pc_argzero = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+AT,
@@ -698,6 +703,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_readlinkres,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+NFS_MAXPATHLEN/4,
@@ -709,6 +715,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_readres,
 		.pc_release = nfssvc_release_readres,
 		.pc_argsize = sizeof(struct nfsd_readargs),
+		.pc_argzero = sizeof(struct nfsd_readargs),
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
@@ -719,6 +726,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
@@ -730,6 +738,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_writeargs),
+		.pc_argzero = sizeof(struct nfsd_writeargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
@@ -741,6 +750,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_diropres,
 		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_createargs),
+		.pc_argzero = sizeof(struct nfsd_createargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
@@ -751,6 +761,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_diropargs,
 		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
+		.pc_argzero = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
@@ -761,6 +772,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_renameargs,
 		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_renameargs),
+		.pc_argzero = sizeof(struct nfsd_renameargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
@@ -771,6 +783,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_linkargs,
 		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_linkargs),
+		.pc_argzero = sizeof(struct nfsd_linkargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
@@ -781,6 +794,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_symlinkargs,
 		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_symlinkargs),
+		.pc_argzero = sizeof(struct nfsd_symlinkargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
@@ -792,6 +806,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_encode = nfssvc_encode_diropres,
 		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_createargs),
+		.pc_argzero = sizeof(struct nfsd_createargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
@@ -802,6 +817,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_diropargs,
 		.pc_encode = nfssvc_encode_statres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
+		.pc_argzero = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
@@ -812,6 +828,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_readdirargs,
 		.pc_encode = nfssvc_encode_readdirres,
 		.pc_argsize = sizeof(struct nfsd_readdirargs),
+		.pc_argzero = sizeof(struct nfsd_readdirargs),
 		.pc_ressize = sizeof(struct nfsd_readdirres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_name = "READDIR",
@@ -821,6 +838,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_statfsres,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_statfsres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+5,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3c908ffbbf45f..5cf6543d3c8e5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -476,6 +476,7 @@ struct svc_procedure {
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);
 	unsigned int		pc_argsize;	/* argument struct size */
+	unsigned int		pc_argzero;	/* how much of argument to clear */
 	unsigned int		pc_ressize;	/* result struct size */
 	unsigned int		pc_cachetype;	/* cache info (NFS) */
 	unsigned int		pc_xdrressize;	/* maximum size of XDR reply */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9caaed1c143e6..8c29181796492 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1237,7 +1237,7 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
 
 	/* Initialize storage for argp and resp */
-	memset(rqstp->rq_argp, 0, procp->pc_argsize);
+	memset(rqstp->rq_argp, 0, procp->pc_argzero);
 	memset(rqstp->rq_resp, 0, procp->pc_ressize);
 
 	/* Bump per-procedure stats counter */
-- 
2.43.0




