Return-Path: <stable+bounces-872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB017F7CF0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23308282031
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CA3A8D6;
	Fri, 24 Nov 2023 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSfHIiul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0C39FC3;
	Fri, 24 Nov 2023 18:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98405C433C8;
	Fri, 24 Nov 2023 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849988;
	bh=JpSDuDEBnigjDV3dUbftSalXXkRb/MXyVWyUBgAM9f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSfHIiuljfcYZOiEdhPjdojyRKV9FMWZGWbcv57AFky5sGvPOQaFZG5FEoWFsTFC6
	 sUo8CgVptdEFLFXRRLj7AqLrZBbwBeexferZAgx8y2sLz3SQ88udduzQPstzmARL0A
	 MvowKf4peLVlbCtug7eQAUEFy1HjcbolaMOfqdP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 400/530] apparmor: rename audit_data->label to audit_data->subj_label
Date: Fri, 24 Nov 2023 17:49:26 +0000
Message-ID: <20231124172040.201997338@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit d20f5a1a6e792d22199c9989ec7ab9e95c48d60c ]

rename audit_data's label field to subj_label to better reflect its
use. Also at the same time drop unneeded assignments to ->subj_label
as the later call to aa_check_perms will do the assignment if needed.

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Stable-dep-of: 157a3537d6bc ("apparmor: Fix regression in mount mediation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/audit.c         | 6 +++---
 security/apparmor/file.c          | 2 +-
 security/apparmor/include/audit.h | 2 +-
 security/apparmor/ipc.c           | 2 +-
 security/apparmor/lib.c           | 5 ++---
 security/apparmor/lsm.c           | 4 ++--
 security/apparmor/net.c           | 2 +-
 security/apparmor/policy.c        | 6 +++---
 security/apparmor/resource.c      | 2 +-
 security/apparmor/task.c          | 4 ++--
 10 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 06ad6a8fcce18..6933cb2f679b0 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -113,8 +113,8 @@ static void audit_pre(struct audit_buffer *ab, void *va)
 			audit_log_format(ab, " error=%d", ad->error);
 	}
 
-	if (ad->label) {
-		struct aa_label *label = ad->label;
+	if (ad->subj_label) {
+		struct aa_label *label = ad->subj_label;
 
 		if (label_isprofile(label)) {
 			struct aa_profile *profile = labels_profile(label);
@@ -187,7 +187,7 @@ int aa_audit(int type, struct aa_profile *profile,
 	if (KILL_MODE(profile) && type == AUDIT_APPARMOR_DENIED)
 		type = AUDIT_APPARMOR_KILL;
 
-	ad->label = &profile->label;
+	ad->subj_label = &profile->label;
 
 	aa_audit_msg(type, ad, cb);
 
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 9ea95fa18e7d5..5bfa70a972071 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -67,7 +67,7 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
 
 	if (ad->peer) {
 		audit_log_format(ab, " target=");
-		aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+		aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 				FLAG_VIEW_SUBNS, GFP_KERNEL);
 	} else if (ad->fs.target) {
 		audit_log_format(ab, " target=");
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 85931ec94e916..096f0a04af87f 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -109,7 +109,7 @@ struct apparmor_audit_data {
 	int type;
 	u16 class;
 	const char *op;
-	struct aa_label *label;
+	struct aa_label *subj_label;
 	const char *name;
 	const char *info;
 	u32 request;
diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index f198b8d620a4f..fd8306399b820 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -71,7 +71,7 @@ static void audit_signal_cb(struct audit_buffer *ab, void *va)
 		audit_log_format(ab, " signal=rtmin+%d",
 				 ad->signal - SIGRT_BASE);
 	audit_log_format(ab, " peer=");
-	aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+	aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 			FLAGS_NONE, GFP_ATOMIC);
 }
 
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index d6b2750fd72e4..c87bccafff446 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -297,7 +297,7 @@ static void aa_audit_perms_cb(struct audit_buffer *ab, void *va)
 				   PERMS_NAMES_MASK);
 	}
 	audit_log_format(ab, " peer=");
-	aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+	aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 				      FLAGS_NONE, GFP_ATOMIC);
 }
 
@@ -357,7 +357,6 @@ int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
 						    typeof(*rules), list);
 	struct aa_perms perms;
 
-	ad->label = &profile->label;
 	ad->peer = &target->label;
 	ad->request = request;
 
@@ -419,7 +418,7 @@ int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
 	}
 
 	if (ad) {
-		ad->label = &profile->label;
+		ad->subj_label = &profile->label;
 		ad->request = request;
 		ad->denied = denied;
 		ad->error = error;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index fd7852a4737c7..359fbfbb4a66e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -722,11 +722,11 @@ static int apparmor_setprocattr(const char *name, void *value,
 	return error;
 
 fail:
-	ad.label = begin_current_label_crit_section();
+	ad.subj_label = begin_current_label_crit_section();
 	ad.info = name;
 	ad.error = error = -EINVAL;
 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &ad, NULL);
-	end_current_label_crit_section(ad.label);
+	end_current_label_crit_section(ad.subj_label);
 	goto out;
 }
 
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 0c7304cd479c5..5e50f80e35db0 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -100,7 +100,7 @@ void audit_net_cb(struct audit_buffer *ab, void *va)
 	}
 	if (ad->peer) {
 		audit_log_format(ab, " peer=");
-		aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+		aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 				FLAGS_NONE, GFP_ATOMIC);
 	}
 }
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 9a7dbe64f102b..e5f1ef83b0fda 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -733,7 +733,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
 
 /**
  * audit_policy - Do auditing of policy changes
- * @label: label to check if it can manage policy
+ * @subj_label: label to check if it can manage policy
  * @op: policy operation being performed
  * @ns_name: name of namespace being manipulated
  * @name: name of profile being manipulated (NOT NULL)
@@ -742,7 +742,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
  *
  * Returns: the error to be returned after audit is done
  */
-static int audit_policy(struct aa_label *label, const char *op,
+static int audit_policy(struct aa_label *subj_label, const char *op,
 			const char *ns_name, const char *name,
 			const char *info, int error)
 {
@@ -752,7 +752,7 @@ static int audit_policy(struct aa_label *label, const char *op,
 	ad.name = name;
 	ad.info = info;
 	ad.error = error;
-	ad.label = label;
+	ad.subj_label = subj_label;
 
 	aa_audit_msg(AUDIT_APPARMOR_STATUS, &ad, audit_cb);
 
diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index b6b5e1bfe9a26..73ba26c646a5e 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -36,7 +36,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
 			 rlim_names[ad->rlim.rlim], ad->rlim.max);
 	if (ad->peer) {
 		audit_log_format(ab, " peer=");
-		aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+		aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 				FLAGS_NONE, GFP_ATOMIC);
 	}
 }
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index 8bd1f212215c4..79850e8321420 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -220,7 +220,7 @@ static void audit_ptrace_cb(struct audit_buffer *ab, void *va)
 		}
 	}
 	audit_log_format(ab, " peer=");
-	aa_label_xaudit(ab, labels_ns(ad->label), ad->peer,
+	aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
 			FLAGS_NONE, GFP_ATOMIC);
 }
 
@@ -266,7 +266,7 @@ static int profile_tracer_perm(struct aa_profile *tracer,
 	if (&tracer->label == tracee)
 		return 0;
 
-	ad->label = &tracer->label;
+	ad->subj_label = &tracer->label;
 	ad->peer = tracee;
 	ad->request = 0;
 	ad->error = aa_capable(&tracer->label, CAP_SYS_PTRACE,
-- 
2.42.0




