Return-Path: <stable+bounces-269653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuTSOBoWQmqqzwkAu9opvQ
	(envelope-from <stable+bounces-269653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909B6D68D5
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 08:52:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=Pf8xFVKV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269653-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269653-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F85302A6F6
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD33A6B8E;
	Mon, 29 Jun 2026 06:46:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03878303A37;
	Mon, 29 Jun 2026 06:46:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715597; cv=none; b=ntz3sl/C0eDeKEMEQLJHMCh4kM0mg7OSbbCPLDVNBOriCrxf/iuu4OBxAsqjaxp/N3AMtOSuD2T8TGkXN8aY352sLBY6Hn++YRN/Oqv8gzw9N8QPsRBNNohWijySiENKOCvvOtVI6oE9z8/Rs0ThXMLesmr+0Fsa3y6SYVWUxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715597; c=relaxed/simple;
	bh=/RkF59PZPSOpnNK7H4vSewsvE7k7qKrBfk8PqJeAOGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QztfKnP9F0DqMMpKOOKUJQ+8AFCsA53diNSeYp1ShUEmh11tUkUuiGeQPRIzdq/vHFyEJRM+L7DvZhVEOxRT7Mv8zK+yUSK5TR01q6Ui8PJM0ryqaPtVLaWxoPPsXN8CBcaLsk1pFqJogUVInjuXj2aKYiEm5FKBCzqNKRZbVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pf8xFVKV; arc=none smtp.client-ip=113.46.200.219
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=82zkxaEI8uR+qMXD7gBzmQv42ToBsOivHdabU9oJF4c=;
	b=Pf8xFVKVTgAh1OLaNOb7TNQt2/emT6BLpwNHCkDXGK5Sd6+5WStQ6/kPxNR3uyF84kAjbimU5
	ibVAbAhUF+36GfePQVri0qT96uHUm/BOTvg0vlTBrl+8ABQ912GjNC5VEMWpIfE4f4W55jLbdSn
	yruVYRqvh8INTdcvZknYNcc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gpc5V4cWTz1prM5;
	Mon, 29 Jun 2026 14:37:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5549F40538;
	Mon, 29 Jun 2026 14:38:55 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:38:55 +0800
Received: from octopus.huawei.com (10.67.174.191) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jun 2026 14:38:54 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<miklos@szeredi.hu>, <amir73il@gmail.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<bboscaccy@linux.microsoft.com>, <caixinchen1@huawei.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-unionfs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<selinux@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH stable/linux-5.10.y 4/7] lsm: constify the 'file' parameter in security_binder_transfer_file()
Date: Mon, 29 Jun 2026 15:06:50 +0800
Message-ID: <20260629070653.580879-5-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:miklos@szeredi.hu,m:amir73il@gmail.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bboscaccy@linux.microsoft.com,m:caixinchen1@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:lujialin4@huawei.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,paul-moore.com,namei.org,hallyn.com,redhat.com,linuxfoundation.org,linux.microsoft.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269653-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paul-moore.com:email,vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3909B6D68D5

From: Khadija Kamran <kamrankhadijadj@gmail.com>

[ Upstream commit 8e4672d6f902d5c4db1e87e8aa9f530149d85bc6 ]

SELinux registers the implementation for the "binder_transfer_file"
hook. Looking at the function implementation we observe that the
parameter "file" is not changing.

Mark the "file" parameter of LSM hook security_binder_transfer_file() as
"const" since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
[PM: subject line whitespace fix]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 35bb13ce1faf..e34b295bc15a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -32,7 +32,7 @@ LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
 LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
-	 const struct cred *to, struct file *file)
+	 const struct cred *to, const struct file *file)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index 2b8a00118903..f3c9d640b60b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -264,7 +264,7 @@ int security_binder_transaction(const struct cred *from,
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file);
+				  const struct cred *to, const struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -518,7 +518,7 @@ static inline int security_binder_transfer_binder(const struct cred *from,
 
 static inline int security_binder_transfer_file(const struct cred *from,
 						const struct cred *to,
-						struct file *file)
+						const struct file *file)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 6de10b6699a4..d6b1b82094b7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -744,7 +744,7 @@ int security_binder_transfer_binder(const struct cred *from,
 }
 
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file)
+				  const struct cred *to, const struct file *file)
 {
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 90935ed3d8d8..e1bbdef0bcd3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1700,7 +1700,7 @@ static inline int file_path_has_perm(const struct cred *cred,
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static int bpf_fd_pass(struct file *file, u32 sid);
+static int bpf_fd_pass(const struct file *file, u32 sid);
 #endif
 
 /* Check whether a task can use an open file descriptor to
@@ -1972,7 +1972,7 @@ static inline u32 file_mask_to_av(int mode, int mask)
 }
 
 /* Convert a Linux file to an access vector. */
-static inline u32 file_to_av(struct file *file)
+static inline u32 file_to_av(const struct file *file)
 {
 	u32 av = 0;
 
@@ -2050,7 +2050,7 @@ static int selinux_binder_transfer_binder(const struct cred *from,
 
 static int selinux_binder_transfer_file(const struct cred *from,
 					const struct cred *to,
-					struct file *file)
+					const struct file *file)
 {
 	u32 sid = cred_sid(to);
 	struct file_security_struct *fsec = selinux_file(file);
@@ -6799,7 +6799,7 @@ static u32 bpf_map_fmode_to_av(fmode_t fmode)
  * access the bpf object and that's why we have to add this additional check in
  * selinux_file_receive and selinux_binder_transfer_files.
  */
-static int bpf_fd_pass(struct file *file, u32 sid)
+static int bpf_fd_pass(const struct file *file, u32 sid)
 {
 	struct bpf_security_struct *bpfsec;
 	struct bpf_prog *prog;
-- 
2.18.0.huawei.25


