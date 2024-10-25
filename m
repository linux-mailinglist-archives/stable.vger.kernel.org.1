Return-Path: <stable+bounces-88162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA29B0599
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6D02845DA
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F11FB8B9;
	Fri, 25 Oct 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nSOCrHfJ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10E20D4E6
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866058; cv=none; b=TS24xpV2CFYGKTPfXBdU6rJLJFNYGbWnntBMtTPaLxE+5nVHIVqYWpXnTgNkPPOhZNbhzRYHEFQJXs5GHfS6yyOkUQeVrVGmwzkdFzWWGcU3QGLZqRj2oHISFj/inJH2QIvJT8VwTaw79YaUvVj6GhNBOTklQRmvNt3Ay2hYblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866058; c=relaxed/simple;
	bh=t7ADqRXIElNZhnXHFbfDTmcGzpmCiSvMXQhjgXrIEV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=melzSrhEOAvjzRTML2GeECybeuahq8y97S39/aegLTbO+Vb7pI163GGEX++bpl8khxcLi9iAFtPL4iAZi02Xq18eg/BS47FMgDPlTP6dapxGiOJoV9Gdh4jwegnhSP7B1LIllI14WDt8IyzFZOWZulj5Cl70iQNF2uCNeHIQYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nSOCrHfJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AO8Kj603KQjyUMdI+Xge7ltvPvn5yM7EGzBzsLiVDSU=; b=nSOCrHfJl+c4Y5XNRUlemxRdnu
	/DVf59OJ9/OkRNn2zTRsQOtCCCr16hzDoVMVJJVRqhvDpPSxoRXEzc8SaRe6b/0HzilziYukV+Ezk
	5n1DlLFB2HO+BWwmFeDfbwuYzrGIfDUJyTnZNfOadUX57ftVSRbV5Cr+FMlB5Hyw0b5gw9NSRDlGd
	4FO6niTHIAosUddloVorH92lGAkKfOG9UrUv0m2BvUmF5ADw21+AG1SrqvNv/9SiY6rtQPPRwJs5t
	PgkYxeO6tnSoR5XDmYPox+MXSTrgrrh4clxfLC/vz1hECku115EtsPjvAJAWg8c0aI3H7RQ7Zacdb
	bm7/iMqQ==;
Received: from 179-125-75-201-dinamico.pombonet.net.br ([179.125.75.201] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4LBM-00F3iE-7f; Fri, 25 Oct 2024 16:20:52 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Sam Sun <samsun1006219@gmail.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1] selinux: improve error checking in sel_write_load()
Date: Fri, 25 Oct 2024 11:20:46 -0300
Message-Id: <20241025142046.862779-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 42c773238037c90b3302bf37a57ae3b5c3f6004a ]

Move our existing input sanity checking to the top of sel_write_load()
and add a check to ensure the buffer size is non-zero.

Move a local variable initialization from the declaration to before it
is used.

Minor style adjustments.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
[cascardo: keep fsi initialization at its declaration point as it is used earlier]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 security/selinux/selinuxfs.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a00d19139436..ab804d4ea911 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -621,6 +621,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
 	mutex_lock(&fsi->state->policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -629,26 +636,21 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -657,13 +659,12 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	}
 
 	selinux_policy_commit(fsi->state, &load_state);
-
 	length = count;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->state->policy_mutex);
 	vfree(data);
-- 
2.34.1


