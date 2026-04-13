Return-Path: <stable+bounces-235929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGcxK4+R3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45A3E7E99
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 480CF301484E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256F3859D9;
	Mon, 13 Apr 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QwsKkSEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA835C181
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062851; cv=none; b=HFVg9Ab84TDZlK4dfCQskk/JkHjpsXcSVwibRy+CCPSz0s10rZY6B8LL+oFIpqasK6niMv5hJqLoFUaoPpeWChtouTQgyq0Jr2DSkcELfzUQcUeDStag9IuDzNLdd6/XTP2RxGjpjIKgXio27DCHQURdFQc7/k7TaBoHifJ2Agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062851; c=relaxed/simple;
	bh=SxsOWQWdrQZ5WUvpkUkxIrbutbtkK41tYSeOnnsjJUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9O3OuXfEXUVePPZuRwADMorGHKWMgEIq3TkOCocj6EyfEKH/D3Lr4zRT9AVwpLaPLkMJIwYbhc8KJk1H5fFMgZhuBv42xjJrbXaHwyZG6/A6ZragSvzrKtttxm2JELYDinh31Kluz32ynMeQ8mwtCxZQ1NQDVF0I6PpNDGCIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QwsKkSEp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06DC73F21F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062849;
	bh=Z8GwMRxEblMsfaDYa614T+Z+qK+ksSIIkNQXJ8TEeSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=QwsKkSEpeKNje75qb05PJhW+lC8XW/jXI3w0Ve30JZbGltw3KGOjaz2zcfnyOvf4L
	 7M3hLxENb5npxwklZeoCyN1dM3paTxRaDAY9kTASrIwnnRd0uaRSi728aRWM6MeAej
	 w5xoEY9Nf0Jnwf555fGXjWTeVFsZDSQtj2QeuIeZYfd52NKiHchzXQHx1ix2LDGUT0
	 pWKeIQmQ0tno0jKGP0z1JwcYRseGptD7CztByNN3OuOcCyaq5jSUxlsCxI/XcqCpaA
	 XFiM4pOhrYbvG642QO9BcSlPcJOUPjRP0Qxgbnwoh5jmViXaTGVBiVPjVnAB0BNU9w
	 8Sy4gD6ZOYjs5asd/6B88/Dw14YOqN0ZIX+7hH0rYyHSjCQqu7ZDuzn+FbVSLWzwgC
	 zTR99uJ+L2aB7mNDNIZS7Vtb7Dr14WYSbKuTuxAbALi2ZT5hezKKNmZdq8jcpjj5Vo
	 k0w5xrdpf5IKIpNsZxG8AkjYUIBOoK4p6C/xJMtI5jy2m+gN6dsdYVSpaU57vljQ4w
	 EHNobXyFLV9oZu7VcInF07LXI4G0zDu37rOGAwrMavWYzRKqSP9Wyp3ZEMHIEn415q
	 WRvoMbt6+pztV1PSvH8LTLelkb+wNu3qSvGsPhdspFGep/uWS0uef94CtAP7Jei3T9
	 GqSskVolp7AEh3AKLAxzEI44=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso4782292b3a.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062847; x=1776667647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z8GwMRxEblMsfaDYa614T+Z+qK+ksSIIkNQXJ8TEeSo=;
        b=JWP8AVVk/QJMW17/ezxZsQ1DvQ4asv/2Sc8j04DDOsk51Qr61QwCxB/FfAs/hgMwzT
         xZhb32eQqYlxr/KzvuaR7iOAxtGwDP0vF6tHAlEyXMsC65CfnETpOgEoWyE0G6fA8S6x
         ABXsgxH4XVBkUaZUkMIklaA/sxwWssxVLHSNMuv6/LMCzmthhYkiox467NkKS5MyWkGv
         xLKHXWYelJpkSMeI2fGd5H2OVi/KYEC2ynnzKKdT6w0BpImKgj81Co78bJnQmgEs4tmP
         feFc5SvSSe9tFrD/4/bnEPyUVcGwRfpRR6nOI0rr8jOPjUrfUbFhwxs8YxkSaxRxGnCV
         UoUQ==
X-Gm-Message-State: AOJu0YxPy9z+fZBaAz4J6EPfxg6FmeuhOV4ld3lj4fOLLxo5HHBFi2C/
	juJl9MTflOOpMAxyxCnlSnaDn6aj/JV8QV8YyYCRdkwK0y/8cMc8vPboHpV7tNYiDCMUi2F/D3O
	w08X/9QSgq5wHWQH6qJKlje20NP+VBYWHlJf+N9TnPjJ8NEXmSXyjUARa80igNMi5bxvkdF8mKg
	shDP8vrA==
X-Gm-Gg: AeBDiescyyH7Va+/hMuyUPOSXE4moR+mChYJroJ2aRKkJWGdWOKth3V6BvXoJM3/L5K
	d2cA+qVKE4AcLEmHy/sT/pHFC7E6q4V7xW5UgNwxs2CkJmzMTEpodfDYbGoX2N9NpzxRYwCWsbg
	uMnMrsTJvC5yiXIQQQay9eyFWtpufK+/SZlFh+MZhnqaBbxQ5bGcKqdJFyRWFhoQ63ESvQUorj5
	RlCuqSPTATiiX15UxY0DdSZeybX5lj8uILFwatjppwti1Xa7rxckZ6j3TaJodqSFMCYI3Rlp0Bi
	CBP63BqQBYr3zW8KHz71eBC2ONc5fFq5aXjl2UWZXvoSK8XFPfS+688DB1tnECUD5dk10CqcuVF
	OA1ks7/u514qnVIvCr6EhcxVd5xE=
X-Received: by 2002:a05:6a00:27aa:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-82f2243e66cmr6930235b3a.32.1776062847703;
        Sun, 12 Apr 2026 23:47:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:27aa:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-82f2243e66cmr6930220b3a.32.1776062847309;
        Sun, 12 Apr 2026 23:47:27 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-82f45defa02sm1161327b3a.39.2026.04.12.23.47.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:26 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 08/11] apparmor: fix unprivileged local user can do privileged policy management
Date: Sun, 12 Apr 2026 23:46:33 -0700
Message-ID: <20260413064712.1581137-9-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235929-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D45A3E7E99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 6601e13e82841879406bf9f369032656f441a425 upstream.

Backport for api changes introduced in
- 90c436a64a6e ("apparmor: pass cred through to audit info.")
- 92de220a7f33 ("apparmor: update policy capable checks to use a label")

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
index bd822f13e325..c73f15c76df9 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -409,7 +409,8 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
 }
 
 static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
-			     loff_t *pos, struct aa_ns *ns)
+			     loff_t *pos, struct aa_ns *ns,
+			     const struct cred *ocred)
 {
 	struct aa_loaddata *data;
 	struct aa_label *label;
@@ -420,7 +421,7 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, mask);
+	error = aa_may_manage_policy(current_cred(), label, ns, ocred, mask);
 	if (error)
 		goto end_section;
 
@@ -441,7 +442,8 @@ static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 			    loff_t *pos)
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
-	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns);
+	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns,
+				  f->f_cred);
 
 	aa_put_ns(ns);
 
@@ -459,7 +461,7 @@ static ssize_t profile_replace(struct file *f, const char __user *buf,
 {
 	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
 	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
-				  buf, size, pos, ns);
+				  buf, size, pos, ns, f->f_cred);
 	aa_put_ns(ns);
 
 	return error;
@@ -483,7 +485,8 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, AA_MAY_REMOVE_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, ns,
+				     f->f_cred, AA_MAY_REMOVE_POLICY);
 	if (error)
 		goto out;
 
@@ -1797,7 +1800,8 @@ static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, NULL, NULL,
+				     AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
@@ -1846,7 +1850,8 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(current_cred(), label, NULL, NULL,
+				     AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index b5aa4231af68..049405dad5a9 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -303,7 +303,8 @@ static inline int AUDIT_MODE(struct aa_profile *profile)
 
 bool policy_view_capable(struct aa_ns *ns);
 bool policy_admin_capable(struct aa_ns *ns);
-int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
-			 u32 mask);
+int aa_may_manage_policy(const struct cred *subj_cred,
+			 struct aa_label *label, struct aa_ns *ns,
+			 const struct cred *ocred, u32 mask);
 
 #endif /* __AA_POLICY_H */
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 40a2fc50eea1..760ec0d50f6e 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -695,14 +695,44 @@ bool policy_admin_capable(struct aa_ns *ns)
 	return policy_view_capable(ns) && capable && !aa_g_lock_policy;
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
 
@@ -718,6 +748,11 @@ int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
 		return audit_policy(label, op, NULL, NULL, "policy_locked",
 				    -EACCES);
 
+	if (ocred && !is_subset_of_obj_privilege(subj_cred, label, ocred))
+		return audit_policy(label, op, NULL, NULL,
+				    "not privileged for target profile",
+				    -EACCES);
+
 	if (!policy_admin_capable(ns))
 		return audit_policy(label, op, NULL, NULL, "not policy admin",
 				    -EACCES);
-- 
2.51.0


