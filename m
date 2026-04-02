Return-Path: <stable+bounces-232918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAIEGN8Ezml+kQYAu9opvQ
	(envelope-from <stable+bounces-232918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:55:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45338438B
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C2B33036087
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1953750BD;
	Thu,  2 Apr 2026 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NO42xkJM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640632BF5D
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109268; cv=none; b=ZfELLgMkpksa2+Kn02pY7Gf461h9NFcnAPo1T1fFuV49tqJ0xmQngGfvypQHtppVGhy1YTxrvCmGtQWo23dkZ5sPGUxjeDjTMuC0zFu18JX4Hjazf29+3ZLVkBPDiKGTuqq32/+iObPScCktUn4VqOT3w7zUYBpM+YFIrduEsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109268; c=relaxed/simple;
	bh=6lMYEDk/4SORjeMQTREdR5RVJx70X24NOfnAF6DUR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+O5xsqlMlBMezvj6XbqnrNZ4jInhI7o3/8UhatseqwoUJY3NEvIbyMcOa9Hlw8FRZSoNQPmZfm53vmqeZOgR8vblAQrNkR8UYsyKUij+E40LIM/0aojFcYuHzwyE/uLwgStTb29iEFjI+8LRiQrFY75MqxqYTdcTss7f9scwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NO42xkJM; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8a0f848bebfso1015516d6.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 22:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775109266; x=1775714066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un0TrhH26CUN0UWgks1V0cLvA+RLLEZ2+uAxYkzc7Bs=;
        b=MSxV5J0yCA7SCI0VDqoW2rBHd7qdQsQEJSzYDFarVB7Uoe7NvrYPU46hv00u1XIMOq
         wqdt6SKnPKbTom7jd0lyYNN+5VR7JB33A3UWcb2GSnC9REr4mxWGtsFlEXgghlxwMWBv
         aRZZYgeP7UThxMDrFiQ3A4DRh/IIaWsRD2D0Ux6efxsxD9oToEiQQqXJd7hS/pSmAr2d
         4uR/HaMZPbcMfvElmvCwDWiE8JRlg/HMpXgWIRX9HuWlBuCuhpjNqfU8+cZocS79TJ+8
         liaDS5twVSfKe9zuUzBVXxq6VeXfxjCAeh6NLqyUs3RvyoXG+9vknMuJATR4r1m73PDr
         svpg==
X-Gm-Message-State: AOJu0Yxk3efDVYL4hB+0QV6T4Sxb3OYHhQQKxkrS7fqw1JxpCIkuQW8J
	F61CxY/JxTNlB0xfTKdNA18DefRqC827XBvBE8AScc13kO37IWtS7FqEqpFQvmyT1AN6Te6no/6
	1oQoFeAtMBa8IgBeIrTDB/uKnS7N95v4DdpL1yESpreWI/CrXeNzH7UHfu/F4vwD5B7AHlL4RBZ
	xJjvles8RjnTJdplhMZOBpnOqUOtn5NcgmpJmyxUeiRgDCst5olDPIKbbxXi6K8Wqw08dJbrbQx
	hjFHozlj3Qh4Shopk/TA/5XKn0j
X-Gm-Gg: ATEYQzxu+pBvE+c74WEEtk4heiiUpW0jAbRL0w+vRcZ2jTJ9PQcaGM4fntPxwiH/StA
	1eyG+u2uxcpyeNdsOnY++p4E4K2c5XdyqNF09UCMzHo/5muQFSuT2sclWUzja2r/7NyGF8Gq1/0
	2y7pq7COLgVweKVWFvyB2AIWlanMYY69fClmUmT0ZaIWzq72Mc7Dd6qQnX3ssgxUJ2m8a4PZPx5
	ltx/uyz3XQYYppmqhO482tHCXxVy/qyJ7SLrNoCIkHzvUPnD1vX65bDh07oUor/xsE3/YRkHT/k
	ZzvXTmlQEbVNuGqxStzTKCirDeZ0NWWryA1VO/EOVK5CxI2wnD8MdCASN2Kpzv76AQbGiFgotTz
	Zv/G9h0h5v2xsrNzJ/TvWXMRA6ZRa44V4sZ6ibV4Hrakq10uuSIpjql6xqJlc1mURQRaD7W36WX
	1JN/BR10MP24TRRcBNEQa4mg==
X-Received: by 2002:a05:622a:5a1b:b0:509:2a92:8088 with SMTP id d75a77b69052e-50d3bb89968mr70426321cf.1.1775109265417;
        Wed, 01 Apr 2026 22:54:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a593cef875sm1884396d6.11.2026.04.01.22.54.25
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2026 22:54:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-128d6d82b8aso112614c88.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 22:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775109264; x=1775714064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un0TrhH26CUN0UWgks1V0cLvA+RLLEZ2+uAxYkzc7Bs=;
        b=NO42xkJMI3wMShk5W+8m8CIF/dAKDcMS8HmLOqjB0FM2Xvk0evmkcw5lceZNpkRBfe
         KxvYrJckhLAXNWjrLxFYNHJ0vJShpXb2VmQBiYSyqOgl8JrRovfcRQbF+COK7x/TFQFZ
         gTjyN0EWMjxmohIsV2W8lw7coLEv2D6ynVlyE=
X-Received: by 2002:a05:7300:d50c:b0:2be:681:91b2 with SMTP id 5a478bee46e88-2c9326ad3c3mr1519636eec.6.1775109263676;
        Wed, 01 Apr 2026 22:54:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d50c:b0:2be:681:91b2 with SMTP id 5a478bee46e88-2c9326ad3c3mr1519610eec.6.1775109262899;
        Wed, 01 Apr 2026 22:54:22 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf126c9sm1634662eec.27.2026.04.01.22.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:54:22 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	georgia.garcia@canonical.com,
	cengiz.can@canonical.com,
	sashal@kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v5.15] apparmor: fix unprivileged local user can do privileged policy management
Date: Thu,  2 Apr 2026 05:47:31 +0000
Message-ID: <20260402054731.2798726-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232918-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,canonical.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,qualys.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF45338438B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: John Johansen <john.johansen@canonical.com>

commit 6601e13e82841879406bf9f369032656f441a425 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Keerthana: aa_may_manage_policy() does not take a subj_cred
parameter (added in 90c436a64a6e, merged in v6.7). Pass current_cred()
directly to is_subset_of_obj_privilege() in place of subj_cred, which
is equivalent since all call sites pass current_cred() as subj_cred.]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 security/apparmor/apparmorfs.c     | 16 ++++++++------
 security/apparmor/include/policy.h |  2 +-
 security/apparmor/policy.c         | 35 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index e736936f4f0b..3053e5731b02 100644
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
+	error = aa_may_manage_policy(label, ns, ocred, mask);
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
@@ -483,7 +485,7 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, AA_MAY_REMOVE_POLICY);
+	error = aa_may_manage_policy(label, ns, f->f_cred, AA_MAY_REMOVE_POLICY);
 	if (error)
 		goto out;
 
@@ -1796,7 +1798,7 @@ static int ns_mkdir_op(struct inode *dir, struct dentry *dentry, umode_t mode)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
@@ -1845,7 +1847,7 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index b5aa4231af68..f6682a31df23 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -304,6 +304,6 @@ static inline int AUDIT_MODE(struct aa_profile *profile)
 bool policy_view_capable(struct aa_ns *ns);
 bool policy_admin_capable(struct aa_ns *ns);
 int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
-			 u32 mask);
+			 const struct cred *ocred, u32 mask);
 
 #endif /* __AA_POLICY_H */
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index e59bdb750ef0..f2bc865bc7b6 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -671,14 +671,42 @@ bool policy_admin_capable(struct aa_ns *ns)
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
  * @label: label to check if it can manage policy
+ * @ocred: object cred if request is coming from an open object
  * @op: the policy manipulation operation being done
  *
  * Returns: 0 if the task is allowed to manipulate policy else error
  */
-int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
+int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
+			 const struct cred *ocred, u32 mask)
 {
 	const char *op;
 
@@ -694,6 +722,11 @@ int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
 		return audit_policy(label, op, NULL, NULL, "policy_locked",
 				    -EACCES);
 
+	if (ocred && !is_subset_of_obj_privilege(current_cred(), label, ocred))
+		return audit_policy(label, op, NULL, NULL,
+				    "not privileged for target profile",
+				    -EACCES);
+
 	if (!policy_admin_capable(ns))
 		return audit_policy(label, op, NULL, NULL, "not policy admin",
 				    -EACCES);
-- 
2.43.7


