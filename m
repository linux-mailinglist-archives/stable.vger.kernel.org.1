Return-Path: <stable+bounces-235917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /TEYH4mQ3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C73E7DC0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA3FA30058DF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CE392C25;
	Mon, 13 Apr 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Jg39fXPL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF3220F49
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062595; cv=none; b=LD+lfW3jABCIanGbaArV3v8Pbpk7IWzPPp4kwGjl18fDFHRWD0juXGdN9DkJug8lKmg/UZ/02Lbu8652PwDEI9lyQ3I64LLeSt+tQR0/1pHMutzUqJH2EfUXiY8l7PCE8sukB77Ml9oq+n3BsxA3CKGx2cKSZnAwzThlXGOsYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062595; c=relaxed/simple;
	bh=21RpBESlkq7oB+L5VbckIcaBh9RdQP10u4EAgWbidPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T84xRyEDeBMhiSx0ly9/A8+HjEn09wVQsXzqNb/geJ3yoprkMv4yzvg5jhwu6U04RGsSAZti0KMmTIjIUcflc4klwcimx3DeSQ11e018QexSsGS4wq5wPJlZLdWZG7Lfpc2LDfQ7Ne2i+N/tPZXmeJY95Qr/2iQdi9NJ3WQ4qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Jg39fXPL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE3933F1DA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062591;
	bh=2RYVFV9V+TJwvoJK1XLNrMPBUqPwiFvO4jvkgTGR+8M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Jg39fXPLOP5SIUHHzo8XWtz9hF1kkxOd9OuFehAS18FStUVnm6MmjtxdsKmrRlUCU
	 bemexOFyDz2faG4zpte0cU0aBm6r6A2QA+eLLqb635YmpQekCPiozbUr5t7kf0OWqR
	 NOg/xI6VbnGQ+jh5gMlK9bPNleFJ7L7WyzGc4rjCb0alJdapDjVzlIuXRVlSaTPVmi
	 iLK6T60ihrASCJH1nS2DHH+qPBdo10VS7qtSpmA6yXFgaIZR2/yg6l/obL1NxyqBqs
	 gIaI/JAdg0pnKT21dRSmE7twYYA7WvTs7EbrXf2haiSUg1wBT8nMZ4po2sKZGZS9cU
	 sKY7u3H3a7bHO+U2R5siStc0zRujSG6ZAex+ep0XgD8b+bvwm9R7yaRnBtJnCMEDsM
	 VM9G1OKCGn8QYJv6AW8StpL6OO1c3rUvG6OJa88QkKiBHYVky/bcLksd869TR5ECp4
	 83n//BmQMYuLU60OgFCg6V1vRl47BLgV5Dk54dvHKcEwuOlLo+ZHgCSv25Bxlu5JeO
	 C+U4bbTM4Xvy54MDcyBqra/Jemo1CBdbbVcZBmQjyyeAfF801xUFaIZmywZiovgMAX
	 Q/EPtEJCzgXZZrT2Xjvn1eP8/L6BnevuW84ItGbGA+KuHzvNHNdA73mw6HOKBTNFId
	 Grag37juaMlIzkDjw8QU8yNs=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242062308so73017495ad.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062590; x=1776667390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2RYVFV9V+TJwvoJK1XLNrMPBUqPwiFvO4jvkgTGR+8M=;
        b=UJQfuwPPI10TWpJ7xZBEXeupLS36DN98AOQR/YdgS7kjeViT5qtSgR3gxIDFRkduFv
         ZROaR5Y8Wi9NyLlVQ5yjhiKNTYKKI///m1MFJRSuGMzCBNEAoqQEZz9vqhc3AsdIXcXa
         c87ZlQsa7PJYXmebFTgKgUAJLgdHzUbnCiY8a37GPblab2XBJk6NsYc6n5d0pwRA32cZ
         Da4vyV+/QkH3qjD549Wmm3MZBRAlmn43xyWZvrUFo2l141d2Xbs6A9eGcMWicKb+lysG
         1Rzu53k+2i1VaMRbclwAFU53sggWQE+/iljubAoi8F0aTscBgKECJwsainyjCIRdBvyn
         v7UA==
X-Gm-Message-State: AOJu0YwPzWQ49KzxB2Ax0zFCfp+dcsdJRy7uFlo2oBx8VJw8kp3L7Wj6
	utdChDc6RQepm4iCIWF4MFLikCkdmrWTNx0hE6F0YE0+pGPkPCOW/9UbWdaa2lsPBFonmOnr/er
	D9Dy1cYv9fyUDRKv8TpjviOxv5nXTgR0OnwhOmbgp9EiPCVKWDdoxyxQdrnx8l1uN0wtp2zgFNp
	ns2AFHoQ==
X-Gm-Gg: AeBDiet10YGC7/GzjYCmCNL+oQQ2VxXSei02Arj9T2jnnslJTr1yJHUO1VUdgG+JPfk
	2bpQdS3tw6cgMV4azObJzpVi1vjwQ/bRp8FcbwnV85sVlyyDGghadegAOIzHNRxNInX4KqhJiCm
	2YBNRgRDD/qgcZcPuRvtbd9qpNcV56Dz/x2sJnynlA/2ooEqzMgzalz2AVy+jOIKJIgPet1didU
	9Tt3IKEnIKG5vY2i4XzftOzsE7ikkGdtWssc9jks60gW6FUunWPMpGsFOeilWWjYrIHIm3jp3D4
	UrHSa7v67ZL99bbUppjc/QcSoop7Rh7inHd3+L85A823pZRm+PFiETn6uVcdkKLmpfgGAJRAOCL
	Bd3qp8PDW7ZUu1kiAAtzVCMxjlFE=
X-Received: by 2002:a17:903:22c3:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b2d5a6e6f2mr119754435ad.37.1776062590487;
        Sun, 12 Apr 2026 23:43:10 -0700 (PDT)
X-Received: by 2002:a17:903:22c3:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b2d5a6e6f2mr119754275ad.37.1776062589972;
        Sun, 12 Apr 2026 23:43:09 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4e0accbsm100864975ad.33.2026.04.12.23.43.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:09 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 08/11] apparmor: fix unprivileged local user can do privileged policy management
Date: Sun, 12 Apr 2026 23:39:17 -0700
Message-ID: <20260413064256.1578919-9-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235917-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 035C73E7DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 6601e13e82841879406bf9f369032656f441a425 upstream.

Backport for api changes introduced in
90c436a64a6e ("apparmor: pass cred through to audit info.")

An unprivileged local user can load, replace, and remove profiles by
opening the apparmorfs interfaces, via a confused deputy attack, by
passing the opened fd to a privileged process, and getting the
privileged process to write to the interface.

This does require a privileged target that can be manipulated to do
the write for the unprivileged process, but once such access is
achieved full policy management is possible and all the possible
implications that implies: removing confinement, DoS of system or
target applications by denying all execution, by-passing the
unprivileged user namespace restriction, to exploiting kernel bugs for
a local privilege escalation.

The policy management interface can not have its permissions simply
changed from 0666 to 0600 because non-root processes need to be able
to load policy to different policy namespaces.

Instead ensure the task writing the interface has privileges that
are a subset of the task that opened the interface. This is already
done via policy for confined processes, but unconfined can delegate
access to the opened fd, by-passing the usual policy check.

Fixes: b7fd2c0340eac ("apparmor: add per policy ns .load, .replace, .remove interface files")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/apparmorfs.c     | 19 +++++++++------
 security/apparmor/include/policy.h |  5 ++--
 security/apparmor/policy.c         | 39 ++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index fa518cd82366..122066bb8bda 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -412,7 +412,8 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
 }
 
 static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
-			     loff_t *pos, struct aa_ns *ns)
+			     loff_t *pos, struct aa_ns *ns,
+			     const struct cred *ocred)
 {
 	struct aa_loaddata *data;
 	struct aa_label *label;
@@ -423,7 +424,7 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, mask);
+	error = aa_may_manage_policy(current_cred(), label, ns, ocred, mask);
 	if (error)
 		goto end_section;
 
@@ -444,7 +445,8 @@ static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 			    loff_t *pos)
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
-	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns);
+	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns,
+				  f->f_cred);
 
 	aa_put_ns(ns);
 
@@ -462,7 +464,7 @@ static ssize_t profile_replace(struct file *f, const char __user *buf,
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
 	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
-				  buf, size, pos, ns);
+				  buf, size, pos, ns, f->f_cred);
 	aa_put_ns(ns);
 
 	return error;
@@ -486,7 +488,8 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, AA_MAY_REMOVE_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, ns,
+				     f->f_cred, AA_MAY_REMOVE_POLICY);
 	if (error)
 		goto out;
 
@@ -1808,7 +1811,8 @@ static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, NULL, NULL,
+				     AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
@@ -1857,7 +1861,8 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, NULL, NULL,
+				     AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 639b5b248e63..cb004abab3bd 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -307,8 +307,9 @@ static inline int AUDIT_MODE(struct aa_profile *profile)
 
 bool aa_policy_view_capable(struct aa_label *label, struct aa_ns *ns);
 bool aa_policy_admin_capable(struct aa_label *label, struct aa_ns *ns);
-int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
-			 u32 mask);
+int aa_may_manage_policy(const struct cred *subj_cred,
+			 struct aa_label *label, struct aa_ns *ns,
+			 const struct cred *ocred, u32 mask);
 bool aa_current_policy_view_capable(struct aa_ns *ns);
 bool aa_current_policy_admin_capable(struct aa_ns *ns);
 
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index fa8cdcb3a356..ba94b3f7f9da 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -736,14 +736,44 @@ bool aa_current_policy_admin_capable(struct aa_ns *ns)
 	return res;
 }
 
+static bool is_subset_of_obj_privilege(const struct cred *cred,
+				       struct aa_label *label,
+				       const struct cred *ocred)
+{
+	if (cred == ocred)
+		return true;
+
+	if (!aa_label_is_subset(label, cred_label(ocred)))
+		return false;
+	/* don't allow crossing userns for now */
+	if (cred->user_ns != ocred->user_ns)
+		return false;
+	if (!cap_issubset(cred->cap_inheritable, ocred->cap_inheritable))
+		return false;
+	if (!cap_issubset(cred->cap_permitted, ocred->cap_permitted))
+		return false;
+	if (!cap_issubset(cred->cap_effective, ocred->cap_effective))
+		return false;
+	if (!cap_issubset(cred->cap_bset, ocred->cap_bset))
+		return false;
+	if (!cap_issubset(cred->cap_ambient, ocred->cap_ambient))
+		return false;
+	return true;
+}
+
+
 /**
  * aa_may_manage_policy - can the current task manage policy
+ * @subj_cred; subjects cred
  * @label: label to check if it can manage policy
- * @op: the policy manipulation operation being done
+ * @ns: namespace being managed by @label (may be NULL if @label's ns)
+ * @ocred: object cred if request is coming from an open object
+ * @mask: contains the policy manipulation operation being done
  *
  * Returns: 0 if the task is allowed to manipulate policy else error
  */
-int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
+int aa_may_manage_policy(const struct cred *subj_cred, struct aa_label *label,
+			 struct aa_ns *ns, const struct cred *ocred, u32 mask)
 {
 	const char *op;
 
@@ -759,6 +789,11 @@ int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
 		return audit_policy(label, op, NULL, NULL, "policy_locked",
 				    -EACCES);
 
+	if (ocred && !is_subset_of_obj_privilege(subj_cred, label, ocred))
+		return audit_policy(label, op, NULL, NULL,
+				    "not privileged for target profile",
+				    -EACCES);
+
 	if (!aa_policy_admin_capable(label, ns))
 		return audit_policy(label, op, NULL, NULL, "not policy admin",
 				    -EACCES);
-- 
2.51.0


