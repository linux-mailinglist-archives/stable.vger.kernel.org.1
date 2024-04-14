Return-Path: <stable+bounces-37506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5489C527
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C227F2844BF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A88762E5;
	Mon,  8 Apr 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lupg9TAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DF74BF5;
	Mon,  8 Apr 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584433; cv=none; b=DfNEQ+hmFzVW1bZpQgfcMpqZ6WG+xmzIyPepYgRinj2JloM43Kd+Cch0f9J72gXrUzhHi07aSevo5MaO/plK/lEKYz1SsiWWG089KhEicEOlXkRDjWo4NWHdHujCbP/s8ljca9GKzLqUZ8sHD+V81L6fEoD13tjuEUERd4K2EIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584433; c=relaxed/simple;
	bh=trzPue1PjB6le4bKUafeypVZSsGpRthwnuQYSt1njwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWqR3L3kdOanuq2zVQUxnx4Kkqtl54FD+NaCVgJaZ4hHkvoHBfVYDutWEUWHAuMyQIuNJCQlG6FbTEQJSLvjXFuT34SxTuyInMU3j5E/y3K9td2OMIHoHNLv7gZN1jQ1hQELNUBccF2A0DVc3iq5z7sq3RAoAv0+E+bE47ufLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lupg9TAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC2DC41679;
	Mon,  8 Apr 2024 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584433;
	bh=trzPue1PjB6le4bKUafeypVZSsGpRthwnuQYSt1njwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lupg9TAakEp+lsIkTxZ1kJw3z+aZcql/IsBXdfBAcaN1TEzfzDSZoeZ3C+bPOz9eg
	 Fj3UbiUymtVpYpaI5LBadqORlzawGq8ef2HBRz0wIwSWEJ+WpCglu6X0dBWZDP8iAc
	 XBcW335lYbzm1LdLHdkXyOtLEsHebABcZnuq0/dI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 436/690] SUNRPC: Parametrize how much of argsize should be zeroed
Date: Mon,  8 Apr 2024 14:55:02 +0200
Message-ID: <20240408125415.423512101@linuxfoundation.org>
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
index 930e90f21b151..742b8d31d2fad 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -523,6 +523,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "NULL",
@@ -532,6 +533,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_testres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
@@ -541,6 +543,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
@@ -550,6 +553,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_cancargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
@@ -559,6 +563,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_unlockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
@@ -568,6 +573,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
@@ -577,6 +583,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_MSG",
@@ -586,6 +593,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_MSG",
@@ -595,6 +603,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_cancargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_MSG",
@@ -604,6 +613,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_unlockargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_MSG",
@@ -613,6 +623,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_testargs,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_MSG",
@@ -622,6 +633,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_RES",
@@ -631,6 +643,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_RES",
@@ -640,6 +653,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_RES",
@@ -649,6 +663,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_RES",
@@ -658,6 +673,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_res,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_RES",
@@ -667,6 +683,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_reboot,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_argzero = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "SM_NOTIFY",
@@ -676,6 +693,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -685,6 +703,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -694,6 +713,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "UNUSED",
@@ -703,6 +723,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_shareargs,
 		.pc_encode = nlm4svc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
@@ -712,6 +733,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_shareargs,
 		.pc_encode = nlm4svc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
@@ -721,6 +743,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_lockargs,
 		.pc_encode = nlm4svc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
@@ -730,6 +753,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_decode = nlm4svc_decode_notify,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "FREE_ALL",
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index c215a4599d5c8..7e25d5583c7d0 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -557,6 +557,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "NULL",
@@ -566,6 +567,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_testres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
@@ -575,6 +577,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
@@ -584,6 +587,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
@@ -593,6 +597,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
@@ -602,6 +607,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
@@ -611,6 +617,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_MSG",
@@ -620,6 +627,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_MSG",
@@ -629,6 +637,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_MSG",
@@ -638,6 +647,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_MSG",
@@ -647,6 +657,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_MSG",
@@ -656,6 +667,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_RES",
@@ -665,6 +677,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_RES",
@@ -674,6 +687,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_RES",
@@ -683,6 +697,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_RES",
@@ -692,6 +707,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_res,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
+		.pc_argzero = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_RES",
@@ -701,6 +717,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_reboot,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_argzero = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "SM_NOTIFY",
@@ -710,6 +727,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -719,6 +737,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -728,6 +747,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
+		.pc_argzero = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNUSED",
@@ -737,6 +757,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
@@ -746,6 +767,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
@@ -755,6 +777,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
@@ -764,6 +787,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_decode = nlmsvc_decode_notify,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_args),
+		.pc_argzero = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "FREE_ALL",
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 8dcb08e1a885d..d0cccddb7d088 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1065,6 +1065,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_func = nfs4_callback_compound,
 		.pc_encode = nfs4_encode_void,
 		.pc_argsize = 256,
+		.pc_argzero = 256,
 		.pc_ressize = 256,
 		.pc_xdrressize = NFS4_CALLBACK_BUFSIZE,
 		.pc_name = "COMPOUND",
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 87f224cd30a85..65d4511b7af08 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -321,6 +321,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
@@ -332,6 +333,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfsaclsvc_encode_getaclres,
 		.pc_release = nfsaclsvc_release_getacl,
 		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_argzero = sizeof(struct nfsd3_getaclargs),
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
@@ -343,6 +345,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -354,6 +357,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfssvc_encode_attrstatres,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_argzero = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
@@ -365,6 +369,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_encode = nfsaclsvc_encode_accessres,
 		.pc_release = nfsaclsvc_release_access,
 		.pc_argsize = sizeof(struct nfsd3_accessargs),
+		.pc_argzero = sizeof(struct nfsd3_accessargs),
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1,
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9446c67436649..2fb9ee3564558 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -252,6 +252,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
@@ -263,6 +264,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_encode = nfs3svc_encode_getaclres,
 		.pc_release = nfs3svc_release_getacl,
 		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_argzero = sizeof(struct nfsd3_getaclargs),
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
@@ -274,6 +276,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_encode = nfs3svc_encode_setaclres,
 		.pc_release = nfs3svc_release_fhandle,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd3_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT,
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 5b1e771238b35..58695e4e18b46 100644
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
index ce8062c959315..8aae0fb4846bc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3579,6 +3579,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfssvc_decode_voidarg,
 		.pc_encode = nfssvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_argzero = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
@@ -3589,6 +3590,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_decode = nfs4svc_decode_compoundargs,
 		.pc_encode = nfs4svc_encode_compoundres,
 		.pc_argsize = sizeof(struct nfsd4_compoundargs),
+		.pc_argzero = sizeof(struct nfsd4_compoundargs),
 		.pc_ressize = sizeof(struct nfsd4_compoundres),
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index ee02ede74bf53..49778ff410e32 100644
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
index 1d9a81bab3fa2..53405c282209f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -475,6 +475,7 @@ struct svc_procedure {
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);
 	unsigned int		pc_argsize;	/* argument struct size */
+	unsigned int		pc_argzero;	/* how much of argument to clear */
 	unsigned int		pc_ressize;	/* result struct size */
 	unsigned int		pc_cachetype;	/* cache info (NFS) */
 	unsigned int		pc_xdrressize;	/* maximum size of XDR reply */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f2a8c1ee8530e..86f00019d0ebb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1242,7 +1242,7 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
-	memset(rqstp->rq_argp, 0, procp->pc_argsize);
+	memset(rqstp->rq_argp, 0, procp->pc_argzero);
 	memset(rqstp->rq_resp, 0, procp->pc_ressize);
 
 	/* Bump per-procedure stats counter */
-- 
2.43.0




