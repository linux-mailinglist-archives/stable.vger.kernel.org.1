Return-Path: <stable+bounces-52962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87690D0D2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07104B2543F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2714B07A;
	Tue, 18 Jun 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTEG10p3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4C13DB8D;
	Tue, 18 Jun 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714923; cv=none; b=cN1arPA1ETeRJJCfoHj3KKQ12QwF6lk7CX7RtKLPQG1Z/9m9Ef0+Yea5rDb+hEDNcH0dtLAsV9kbqMtFLkmMffYPv0jQRSGmzOo0zpQlGV0kzSLMtdLG0Nz2Rjb/NPSUWsm7P6A7cPfFZMhbYMiJqnvHzHbyZK2JHI8bqrCYroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714923; c=relaxed/simple;
	bh=w7gAbqDz0FNHXWAc5YODVUAUYK8nWSYbu9ImHpzkbL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5S2GEojJ/yv0eaAmmy71vKhkQE+ykI5tBT8dhOmLLKVof8EJr+SReHH0snL9qT8R7R8xsYtTB3ykJqm7DFSwcHh2csBawa6MU0/P9y906OvZzMh/8+UckpgfV8K005xb8pUr13FcJZxCekNTqU+DJx8t6PryLz8yk8h7ifQS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTEG10p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A6C3277B;
	Tue, 18 Jun 2024 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714923;
	bh=w7gAbqDz0FNHXWAc5YODVUAUYK8nWSYbu9ImHpzkbL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTEG10p3jicxxToMJXy4mVPy8VtNjaIfxx4BAiqO77Ph98n6PRKmc5m0GuWupT+Dt
	 cYMsglXk+09CKKeKXFy/BRDBUa7DBjCz2KeKkexAUlxzFaIl+R4qsdhHl8EE9Z2l+x
	 sftG8vBugKcLjdnGuu5AkMHl0+zSqEioaniBDUzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/770] SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
Date: Tue, 18 Jun 2024 14:29:46 +0200
Message-ID: <20240618123412.410656794@linuxfoundation.org>
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

[ Upstream commit 2289e87b5951f97783f07fc895e6c5e804b53668 ]

The next few patches will employ these strings to help make server-
side trace logs more human-readable. A similar technique is already
in use in kernel RPC client code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc4proc.c        | 24 ++++++++++++++++++++++++
 fs/lockd/svcproc.c         | 24 ++++++++++++++++++++++++
 fs/nfs/callback_xdr.c      |  2 ++
 fs/nfsd/nfs2acl.c          |  5 +++++
 fs/nfsd/nfs3acl.c          |  3 +++
 fs/nfsd/nfs3proc.c         | 22 ++++++++++++++++++++++
 fs/nfsd/nfs4proc.c         |  2 ++
 fs/nfsd/nfsproc.c          | 18 ++++++++++++++++++
 include/linux/sunrpc/svc.h |  1 +
 9 files changed, 101 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fa41dda399259..4c10fb5138f10 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -512,6 +512,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlm4svc_proc_test,
@@ -520,6 +521,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlm4svc_proc_lock,
@@ -528,6 +530,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlm4svc_proc_cancel,
@@ -536,6 +539,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlm4svc_proc_unlock,
@@ -544,6 +548,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlm4svc_proc_granted,
@@ -552,6 +557,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlm4svc_proc_test_msg,
@@ -560,6 +566,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlm4svc_proc_lock_msg,
@@ -568,6 +575,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
@@ -576,6 +584,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlm4svc_proc_unlock_msg,
@@ -584,6 +593,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlm4svc_proc_granted_msg,
@@ -592,6 +602,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -600,6 +611,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -608,6 +620,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -616,6 +629,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -624,6 +638,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlm4svc_proc_granted_res,
@@ -632,6 +647,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
@@ -640,6 +656,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -648,6 +665,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[18] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -656,6 +674,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[19] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -664,6 +683,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlm4svc_proc_share,
@@ -672,6 +692,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlm4svc_proc_unshare,
@@ -680,6 +701,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlm4svc_proc_nm_lock,
@@ -688,6 +710,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlm4svc_proc_free_all,
@@ -696,5 +719,6 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "FREE_ALL",
 	},
 };
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 50855f2c1f4b8..4ae4b63b53925 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -554,6 +554,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlmsvc_proc_test,
@@ -562,6 +563,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlmsvc_proc_lock,
@@ -570,6 +572,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlmsvc_proc_cancel,
@@ -578,6 +581,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlmsvc_proc_unlock,
@@ -586,6 +590,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlmsvc_proc_granted,
@@ -594,6 +599,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlmsvc_proc_test_msg,
@@ -602,6 +608,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlmsvc_proc_lock_msg,
@@ -610,6 +617,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlmsvc_proc_cancel_msg,
@@ -618,6 +626,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlmsvc_proc_unlock_msg,
@@ -626,6 +635,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlmsvc_proc_granted_msg,
@@ -634,6 +644,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -642,6 +653,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -650,6 +662,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -658,6 +671,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -666,6 +680,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlmsvc_proc_granted_res,
@@ -674,6 +689,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlmsvc_proc_sm_notify,
@@ -682,6 +698,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -690,6 +707,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[18] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -698,6 +716,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[19] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -706,6 +725,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlmsvc_proc_share,
@@ -714,6 +734,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlmsvc_proc_unshare,
@@ -722,6 +743,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlmsvc_proc_nm_lock,
@@ -730,6 +752,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlmsvc_proc_free_all,
@@ -738,5 +761,6 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "FREE_ALL",
 	},
 };
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index ca8a4aa351dc9..f9dfd4e712a30 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1056,6 +1056,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_decode = nfs4_decode_void,
 		.pc_encode = nfs4_encode_void,
 		.pc_xdrressize = 1,
+		.pc_name = "NULL",
 	},
 	[CB_COMPOUND] = {
 		.pc_func = nfs4_callback_compound,
@@ -1063,6 +1064,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_argsize = 256,
 		.pc_ressize = 256,
 		.pc_xdrressize = NFS4_CALLBACK_BUFSIZE,
+		.pc_name = "COMPOUND",
 	}
 };
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b0f66604532a5..899762da23c92 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -371,6 +371,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC2_GETACL] = {
 		.pc_func = nfsacld_proc_getacl,
@@ -381,6 +382,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC2_SETACL] = {
 		.pc_func = nfsacld_proc_setacl,
@@ -391,6 +393,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETACL",
 	},
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
@@ -401,6 +404,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[ACLPROC2_ACCESS] = {
 		.pc_func = nfsacld_proc_access,
@@ -411,6 +415,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1,
+		.pc_name = "SETATTR",
 	},
 };
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7c30876a31a1b..9e1a92fb97712 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -251,6 +251,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC3_GETACL] = {
 		.pc_func = nfsd3_proc_getacl,
@@ -261,6 +262,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC3_SETACL] = {
 		.pc_func = nfsd3_proc_setacl,
@@ -271,6 +273,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT,
+		.pc_name = "SETACL",
 	},
 };
 
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 3257233d1a655..0f79e007c620f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -713,6 +713,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[NFS3PROC_GETATTR] = {
 		.pc_func = nfsd3_proc_getattr,
@@ -723,6 +724,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFS3PROC_SETATTR] = {
 		.pc_func = nfsd3_proc_setattr,
@@ -733,6 +735,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "SETATTR",
 	},
 	[NFS3PROC_LOOKUP] = {
 		.pc_func = nfsd3_proc_lookup,
@@ -743,6 +746,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+pAT+pAT,
+		.pc_name = "LOOKUP",
 	},
 	[NFS3PROC_ACCESS] = {
 		.pc_func = nfsd3_proc_access,
@@ -753,6 +757,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1,
+		.pc_name = "ACCESS",
 	},
 	[NFS3PROC_READLINK] = {
 		.pc_func = nfsd3_proc_readlink,
@@ -763,6 +768,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1+NFS3_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFS3PROC_READ] = {
 		.pc_func = nfsd3_proc_read,
@@ -773,6 +779,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
+		.pc_name = "READ",
 	},
 	[NFS3PROC_WRITE] = {
 		.pc_func = nfsd3_proc_write,
@@ -783,6 +790,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_writeres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+4,
+		.pc_name = "WRITE",
 	},
 	[NFS3PROC_CREATE] = {
 		.pc_func = nfsd3_proc_create,
@@ -793,6 +801,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "CREATE",
 	},
 	[NFS3PROC_MKDIR] = {
 		.pc_func = nfsd3_proc_mkdir,
@@ -803,6 +812,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKDIR",
 	},
 	[NFS3PROC_SYMLINK] = {
 		.pc_func = nfsd3_proc_symlink,
@@ -813,6 +823,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "SYMLINK",
 	},
 	[NFS3PROC_MKNOD] = {
 		.pc_func = nfsd3_proc_mknod,
@@ -823,6 +834,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKNOD",
 	},
 	[NFS3PROC_REMOVE] = {
 		.pc_func = nfsd3_proc_remove,
@@ -833,6 +845,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "REMOVE",
 	},
 	[NFS3PROC_RMDIR] = {
 		.pc_func = nfsd3_proc_rmdir,
@@ -843,6 +856,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "RMDIR",
 	},
 	[NFS3PROC_RENAME] = {
 		.pc_func = nfsd3_proc_rename,
@@ -853,6 +867,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_renameres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+WC,
+		.pc_name = "RENAME",
 	},
 	[NFS3PROC_LINK] = {
 		.pc_func = nfsd3_proc_link,
@@ -863,6 +878,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_linkres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+pAT+WC,
+		.pc_name = "LINK",
 	},
 	[NFS3PROC_READDIR] = {
 		.pc_func = nfsd3_proc_readdir,
@@ -872,6 +888,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFS3PROC_READDIRPLUS] = {
 		.pc_func = nfsd3_proc_readdirplus,
@@ -881,6 +898,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirplusargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIRPLUS",
 	},
 	[NFS3PROC_FSSTAT] = {
 		.pc_func = nfsd3_proc_fsstat,
@@ -890,6 +908,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+2*6+1,
+		.pc_name = "FSSTAT",
 	},
 	[NFS3PROC_FSINFO] = {
 		.pc_func = nfsd3_proc_fsinfo,
@@ -899,6 +918,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsinfores),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+12,
+		.pc_name = "FSINFO",
 	},
 	[NFS3PROC_PATHCONF] = {
 		.pc_func = nfsd3_proc_pathconf,
@@ -908,6 +928,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_pathconfres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+6,
+		.pc_name = "PATHCONF",
 	},
 	[NFS3PROC_COMMIT] = {
 		.pc_func = nfsd3_proc_commit,
@@ -918,6 +939,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_commitres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+WC+2,
+		.pc_name = "COMMIT",
 	},
 };
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1ef98398362a5..a5e1f5c1a4d64 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3299,6 +3299,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
+		.pc_name = "NULL",
 	},
 	[NFSPROC4_COMPOUND] = {
 		.pc_func = nfsd4_proc_compound,
@@ -3309,6 +3310,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = NFSD_BUFSIZE/4,
+		.pc_name = "COMPOUND",
 	},
 };
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index dbd8d36046539..f22f70f63b53e 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -623,6 +623,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "NULL",
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
@@ -633,6 +634,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFSPROC_SETATTR] = {
 		.pc_func = nfsd_proc_setattr,
@@ -643,6 +645,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETATTR",
 	},
 	[NFSPROC_ROOT] = {
 		.pc_func = nfsd_proc_root,
@@ -652,6 +655,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "ROOT",
 	},
 	[NFSPROC_LOOKUP] = {
 		.pc_func = nfsd_proc_lookup,
@@ -662,6 +666,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "LOOKUP",
 	},
 	[NFSPROC_READLINK] = {
 		.pc_func = nfsd_proc_readlink,
@@ -671,6 +676,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+NFS_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFSPROC_READ] = {
 		.pc_func = nfsd_proc_read,
@@ -681,6 +687,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
+		.pc_name = "READ",
 	},
 	[NFSPROC_WRITECACHE] = {
 		.pc_func = nfsd_proc_writecache,
@@ -690,6 +697,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "WRITECACHE",
 	},
 	[NFSPROC_WRITE] = {
 		.pc_func = nfsd_proc_write,
@@ -700,6 +708,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "WRITE",
 	},
 	[NFSPROC_CREATE] = {
 		.pc_func = nfsd_proc_create,
@@ -710,6 +719,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "CREATE",
 	},
 	[NFSPROC_REMOVE] = {
 		.pc_func = nfsd_proc_remove,
@@ -719,6 +729,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "REMOVE",
 	},
 	[NFSPROC_RENAME] = {
 		.pc_func = nfsd_proc_rename,
@@ -728,6 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RENAME",
 	},
 	[NFSPROC_LINK] = {
 		.pc_func = nfsd_proc_link,
@@ -737,6 +749,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "LINK",
 	},
 	[NFSPROC_SYMLINK] = {
 		.pc_func = nfsd_proc_symlink,
@@ -746,6 +759,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "SYMLINK",
 	},
 	[NFSPROC_MKDIR] = {
 		.pc_func = nfsd_proc_mkdir,
@@ -756,6 +770,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "MKDIR",
 	},
 	[NFSPROC_RMDIR] = {
 		.pc_func = nfsd_proc_rmdir,
@@ -765,6 +780,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RMDIR",
 	},
 	[NFSPROC_READDIR] = {
 		.pc_func = nfsd_proc_readdir,
@@ -773,6 +789,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_readdirargs),
 		.pc_ressize = sizeof(struct nfsd_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFSPROC_STATFS] = {
 		.pc_func = nfsd_proc_statfs,
@@ -782,6 +799,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_statfsres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+5,
+		.pc_name = "STATFS",
 	},
 };
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 34c2a69820e93..31ee3b6047c30 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -463,6 +463,7 @@ struct svc_procedure {
 	unsigned int		pc_ressize;	/* result struct size */
 	unsigned int		pc_cachetype;	/* cache info (NFS) */
 	unsigned int		pc_xdrressize;	/* maximum size of XDR reply */
+	const char *		pc_name;	/* for display */
 };
 
 /*
-- 
2.43.0




