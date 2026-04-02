Return-Path: <stable+bounces-232917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM6yKZYEzml+kQYAu9opvQ
	(envelope-from <stable+bounces-232917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A6384353
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 07:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58AB9304994C
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25B36607F;
	Thu,  2 Apr 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BG4jFXhk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE5366570
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109238; cv=none; b=rHRGmgo7y2wBfc8HYzZdJOzWuD+K27NI78y2dfgGmYGolOnNaJnldaQTpNxsSY8G492SbDmmqxgUz6OCEfeVOhyDGxLUE9OUIAvbMPAq7WcBDUSCY/c0wA5+hI5rKYu6KVt1Ba8AozA6O+WkLNqTu2l4jczLL5tDv7QAxvF3oSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109238; c=relaxed/simple;
	bh=0C8xk+345SX9ejuaWyFE+tCyFjEXUYoECt072z2BA2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOtVbmWkFGbV19YvzNJNH6LiXqwGPGoL2qvvCnKUVT2hnQozXjrYQHg+ShYvbdzD+mj7H1DXJjGVhpwU8i6joo+J4C0EB1jgBlrsUTotJGJqJ4IHtff+4alHnYBA4IJKJPa7nGwnlSoN5R+EWHLdn4pT+dOTmqA4W8Q/t0JZE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BG4jFXhk; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-95393ca9cb3so16211241.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 22:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775109236; x=1775714036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVFmR/coGugPGOD5D8t57xuLW0pWKEfclUCRJYgoO14=;
        b=jRoPzzqLE6VPaP9wy8sltv97doeQtVNjexFyPYHzk2qlyZG+kpyw7dg8OZ11Ey+Djo
         3zBWj1rbgbUsdwjNzGwHr7GXQI5RqfsKAYQsWDLxRGdp83n9/UyDjwTt7DtiRGlgRvQm
         d1JHNQJ5l/nzqmCQalhrebwTXK5HkctwazUiVzLD7UoLHqMLAOL71qHcBkM+ECYFOirC
         3sv+PX52tVmoWYFMCr209k8UffX/cBkfoxSa+rcAk5LrHb+2Ax2Rm5Nzb2zxjzPWU9OO
         RfBCUxDt0ZTtreX2nVpwGhaieqmszaWick+/G4s+zCAOCLcUfsHUW0Lt9NMjcQDd2TTm
         xMoQ==
X-Gm-Message-State: AOJu0YxHu7AVfl1X8rwHeicKcWffjRhuiZd3I3rtxWtgiR3bHRwkvLtx
	4XEbdNRThptlqMWYMpeFiuH+Pn6sFpMT44Q1GpN9ojOXcVig3BZvzaFJW3pvJ0XZgDKtBfTFRbQ
	twAsjEUVhth7CNoo1YayZdzPwenRSRkC0tFVz65wbZFPrI85LEg2RqR1M4m0/iSN4KldF5vDX77
	ShuUyvXAcX3gMCMCvnqFG7Gax7yF8abSpb42gnGTjenwiB1JKc/7vuVmqEocP56WS+duiVSa71T
	4m+ullu9M9BK/mTvJPNO1oCGLFi7M0=
X-Gm-Gg: ATEYQzw/KR/LJv5Z8dknGGdlGD2EolO0ZsW5Y0/cZMBPYaTPoHsyZx44cskVnL6pBKG
	AnwjVMtu3qOm+grcflKtSuvvhdg1BNHWkMvqcL+bRBNx14Zbax0QuucmPDE58hqpJsD8eTGLnsd
	xm83HE78BPBRioz1tt9EqYkZqz8uQ+WNVhsB3jhVHVcEhhPnqKSqkec/dN6dN0uREu7OH7Kaonb
	WYfdioEiL7jSzztVx1yL5a0ITMrRdVcdWCcA7HTVbBBkcakCy7qeacM5Eejf3xATSemIq7QW81+
	F0zGOXE2FELddybGuaC5rC5SqnDLfvIyZq1N4HasKNBZJnF3MpAAUyYS2vzgMev+FUidZNXJOa4
	FnS25teqFZ6dirVC9I+P0viScQehz4aMRLwRErAPr3qPA0jqZSuQmdKY7Zrwlx/gXNOBw0WHgoC
	8zlMZSs9qUvteXuaxU8InJOF43yV4cM7S8PFRGDJB1S1oZD4kxfQufG2c6IxEQilqDB8Th/z9Jr
	z+R
X-Received: by 2002:a05:6102:1150:b0:605:5c61:4371 with SMTP id ada2fe7eead31-6056817fb6emr896942137.3.1775109235644;
        Wed, 01 Apr 2026 22:53:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60583028351sm145053137.22.2026.04.01.22.53.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2026 22:53:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c98235c243so103004eec.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 22:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775109234; x=1775714034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVFmR/coGugPGOD5D8t57xuLW0pWKEfclUCRJYgoO14=;
        b=BG4jFXhkqaG1FgHSP6E1aYT6cI5UPls6SOgBabO/3CAZPFPfSGIhwLCSbQKGKS/kyD
         6ovFNNbVobjC7EZ6+GPkqI9eopnFWGomleJXiFMZf5iJ9w+KsWxFNCfC9K8qRUjvNbYt
         7e+35gPKfwpgwSX9UC5TSHDdHBL9J+DHz+Hk4=
X-Received: by 2002:a05:7300:d70e:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2c930798a42mr1523908eec.2.1775109233948;
        Wed, 01 Apr 2026 22:53:53 -0700 (PDT)
X-Received: by 2002:a05:7300:d70e:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2c930798a42mr1523884eec.2.1775109232974;
        Wed, 01 Apr 2026 22:53:52 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf1271asm2180380eec.26.2026.04.01.22.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:53:51 -0700 (PDT)
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
Subject: [PATCH v6.1] apparmor: fix unprivileged local user can do privileged policy management
Date: Thu,  2 Apr 2026 05:47:00 +0000
Message-ID: <20260402054700.2798707-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232917-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualys.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F7A6384353
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
index fa518cd82366..fa4a6f20f58e 100644
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
+	error = aa_may_manage_policy(label, ns, ocred, mask);
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
@@ -486,7 +488,7 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	/* high level check about policy management - fine grained in
 	 * below after unpack
 	 */
-	error = aa_may_manage_policy(label, ns, AA_MAY_REMOVE_POLICY);
+	error = aa_may_manage_policy(label, ns, f->f_cred, AA_MAY_REMOVE_POLICY);
 	if (error)
 		goto out;
 
@@ -1808,7 +1810,7 @@ static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
@@ -1857,7 +1859,7 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	label = begin_current_label_crit_section();
-	error = aa_may_manage_policy(label, NULL, AA_MAY_LOAD_POLICY);
+	error = aa_may_manage_policy(label, NULL, NULL, AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
 		return error;
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 639b5b248e63..3f776f5e8de4 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -308,7 +308,7 @@ static inline int AUDIT_MODE(struct aa_profile *profile)
 bool aa_policy_view_capable(struct aa_label *label, struct aa_ns *ns);
 bool aa_policy_admin_capable(struct aa_label *label, struct aa_ns *ns);
 int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns,
-			 u32 mask);
+			 const struct cred *ocred, u32 mask);
 bool aa_current_policy_view_capable(struct aa_ns *ns);
 bool aa_current_policy_admin_capable(struct aa_ns *ns);
 
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 4ee5a450d118..e7412a221551 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -712,14 +712,42 @@ bool aa_current_policy_admin_capable(struct aa_ns *ns)
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
 
@@ -735,6 +763,11 @@ int aa_may_manage_policy(struct aa_label *label, struct aa_ns *ns, u32 mask)
 		return audit_policy(label, op, NULL, NULL, "policy_locked",
 				    -EACCES);
 
+	if (ocred && !is_subset_of_obj_privilege(current_cred(), label, ocred))
+		return audit_policy(label, op, NULL, NULL,
+				    "not privileged for target profile",
+				    -EACCES);
+
 	if (!aa_policy_admin_capable(label, ns))
 		return audit_policy(label, op, NULL, NULL, "not policy admin",
 				    -EACCES);
-- 
2.43.7


