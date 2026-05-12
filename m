Return-Path: <stable+bounces-245908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMh2LNhnA2qj5gEAu9opvQ
	(envelope-from <stable+bounces-245908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BD526218
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F5E30B6C9C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB13DC86D;
	Tue, 12 May 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SIlgdwFh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C53E0721;
	Tue, 12 May 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607864; cv=none; b=c0BQeoxtT+QdMTUiT/xYveoyIgl/Lmav6iDDIeUfZzh9Ccx6WKEMU9wsgaPAQh2IqF09QZeADyCXpkoGsv9HdSa9OQnp1EZsrodJkgomwWfFICTT8PBsZpA8qSstKSJ4Jmap40ydszmtdH7be0o5A3TtiOBbnr+B53LKVKlAXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607864; c=relaxed/simple;
	bh=pNWdPQW1/OPjYTf6zPOA4Z7pZegY3122I0nmqKCuRFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMnVC9JqFbOOFmcB4yWO6e7fXbxvrlhzjNhxcNNGZdoUu37s27gr/opH7dJjTMljfYNt02J++mObOs3fmojusI2fNxd7Hu9M1Mj6F+50ZnXQ9kCdk0RTIT6cHNvT7iws3Bh4r8UR2jJP+gHoAwHDIIO70YIdn/lTzlXINMCtn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SIlgdwFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EA5C2BCF5;
	Tue, 12 May 2026 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607864;
	bh=pNWdPQW1/OPjYTf6zPOA4Z7pZegY3122I0nmqKCuRFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIlgdwFh4bEj1oN8jw/HLRig6+sZMnjCQTjLqcncfO18Df4Bq1uZtB/WHwqaBJ/Bv
	 i/Oulc9OjQv0encdLRmq3ddkwNl1OfTQQ+szrHKkilph3vhw7jJ50aE5ckui2+1K0i
	 xnS9JCmmYME30afhJUcIKp/5Ireqj3KU4vToqcgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.12 058/206] selinux: shrink critical section in sel_write_load()
Date: Tue, 12 May 2026 19:38:30 +0200
Message-ID: <20260512173934.069280148@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 288BD526218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paul-moore.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <stephen.smalley.work@gmail.com>

commit 868f31e4061eca8c3cd607d79d954d5e54f204aa upstream.

Currently sel_write_load() takes the policy mutex earlier than
necessary. Move the taking of the mutex later. This avoids
holding it unnecessarily across the vmalloc() and copy_from_user()
of the policy data.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/selinuxfs.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -583,34 +583,31 @@ static ssize_t sel_write_load(struct fil
 	if (!count)
 		return -EINVAL;
 
-	mutex_lock(&selinux_state.policy_mutex);
-
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
-		goto out;
+		return length;
 
 	data = vmalloc(count);
-	if (!data) {
-		length = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
 	if (copy_from_user(data, buf, count) != 0) {
 		length = -EFAULT;
 		goto out;
 	}
 
+	mutex_lock(&selinux_state.policy_mutex);
 	length = security_load_policy(data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
-		goto out;
+		goto out_unlock;
 	}
 	fsi = file_inode(file)->i_sb->s_fs_info;
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(&load_state);
-		goto out;
+		goto out_unlock;
 	}
 
 	selinux_policy_commit(&load_state);
@@ -620,8 +617,9 @@ static ssize_t sel_write_load(struct fil
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 
-out:
+out_unlock:
 	mutex_unlock(&selinux_state.policy_mutex);
+out:
 	vfree(data);
 	return length;
 }



