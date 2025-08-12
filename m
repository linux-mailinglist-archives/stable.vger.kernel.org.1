Return-Path: <stable+bounces-167798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74605B23203
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8011769A7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7191A9F89;
	Tue, 12 Aug 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODsp6KtM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94717993;
	Tue, 12 Aug 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022025; cv=none; b=ohmFwJ0JvxZ3Ol4g5oyspoyhxu55iRZLqlnneRBl8N4IdY4zuBHSLiTHxzccXMsjqd+zfSBhnSdXA0cLql6Lul1FZPtlv0Bb3wWTKVsKGtT8c4b0lVpT8AGl9wpw32W5R/oJk01Iu9+MY03ksxR1xYtRoRJAWEZUEIFwsk8XnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022025; c=relaxed/simple;
	bh=WSTEyjIqd9I0dOA5NftKwMLAJibAfc1lstLX5mBllW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DONm0B0V/80ri705YBPpksWileD6iN8SIAxi1aL1lO9qfElhya5T9zUr/bnhyBUArIhAM+dadrFbfbjxg73+PJ1DGTvO5R4r7M5PJlgEMe56E1x5ObQH8NM5azsddtlcgzKFshZorV786xE2eufX4zUPqktxyxHw0oY/jm+S/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODsp6KtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE36C4CEF0;
	Tue, 12 Aug 2025 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022025;
	bh=WSTEyjIqd9I0dOA5NftKwMLAJibAfc1lstLX5mBllW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODsp6KtMW27TRXz/ZlC1Wm7e5bVDaX2RaYLorMKCXqLmhEVWcmWpBGsL+lgcMvoBP
	 Agtynp91tMJzxv4YdGSOx4mmzE/MuM9Gx5DZgHE/5AHWbYAiVpVvTdAJkcXjNtrNhs
	 5D4ODhIzQo75QglXpbW9s1USyzPExh9cTclaA/hM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Guy Briggs <rgb@redhat.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 007/369] audit,module: restore audit logging in load failure case
Date: Tue, 12 Aug 2025 19:25:04 +0200
Message-ID: <20250812173015.020742336@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Guy Briggs <rgb@redhat.com>

[ Upstream commit ae1ae11fb277f1335d6bcd4935ba0ea985af3c32 ]

The move of the module sanity check to earlier skipped the audit logging
call in the case of failure and to a place where the previously used
context is unavailable.

Add an audit logging call for the module loading failure case and get
the module name when possible.

Link: https://issues.redhat.com/browse/RHEL-52839
Fixes: 02da2cbab452 ("module: move check_modinfo() early to early_mod_check()")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/audit.h | 9 ++++-----
 kernel/audit.h        | 2 +-
 kernel/auditsc.c      | 2 +-
 kernel/module/main.c  | 6 ++++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..a394614ccd0b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -417,7 +417,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
-extern void __audit_log_kern_module(char *name);
+extern void __audit_log_kern_module(const char *name);
 extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
@@ -519,7 +519,7 @@ static inline void audit_openat2_how(struct open_how *how)
 		__audit_openat2_how(how);
 }
 
-static inline void audit_log_kern_module(char *name)
+static inline void audit_log_kern_module(const char *name)
 {
 	if (!audit_dummy_context())
 		__audit_log_kern_module(name);
@@ -677,9 +677,8 @@ static inline void audit_mmap_fd(int fd, int flags)
 static inline void audit_openat2_how(struct open_how *how)
 { }
 
-static inline void audit_log_kern_module(char *name)
-{
-}
+static inline void audit_log_kern_module(const char *name)
+{ }
 
 static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 { }
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..5156ecd35457 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -199,7 +199,7 @@ struct audit_context {
 			int			argc;
 		} execve;
 		struct {
-			char			*name;
+			const char		*name;
 		} module;
 		struct {
 			struct audit_ntp_data	ntp_data;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..dae80e4dfcce 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2870,7 +2870,7 @@ void __audit_openat2_how(struct open_how *how)
 	context->type = AUDIT_OPENAT2;
 }
 
-void __audit_log_kern_module(char *name)
+void __audit_log_kern_module(const char *name)
 {
 	struct audit_context *context = audit_context();
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 93a07387af3b..6908062f4560 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2898,7 +2898,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_allocated = true;
 
-	audit_log_kern_module(mod->name);
+	audit_log_kern_module(info->name);
 
 	/* Reserve our place in the list. */
 	err = add_unformed_module(mod);
@@ -3058,8 +3058,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 * failures once the proper module was allocated and
 	 * before that.
 	 */
-	if (!module_allocated)
+	if (!module_allocated) {
+		audit_log_kern_module(info->name ? info->name : "?");
 		mod_stat_bump_becoming(info, flags);
+	}
 	free_copy(info, flags);
 	return err;
 }
-- 
2.39.5




