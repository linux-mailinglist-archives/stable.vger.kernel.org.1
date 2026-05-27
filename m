Return-Path: <stable+bounces-254643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB92O3guF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:48:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E295E8804
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A9EB300D771
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217273126A0;
	Wed, 27 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTxyCAzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DB262FC0;
	Wed, 27 May 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903933; cv=none; b=M3KLMdH/Q74khWuWmalwj95dxVYd/QBDJfP7hSnFvE7gtSdseJ0i9AHepROGTb1zrH/Hky4TFJPSpMyy+jvgttsLBRhUN/Y0pgVDbYdDlprjTO8OPLJrZOAjmb+KyE+gIVNbBRXbNXEaXNzKeCHAJkPwdVJ40Rr2AwzVMo3RRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903933; c=relaxed/simple;
	bh=ef62bATNZwIn1y4mzGz79jm63fmplokSG360GSv7uQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bmgjYAMtwpiggDRWu7Z9wuOzXtMLT+nbJILz0i+oGpwpVXDdRijT8sZB9wIJHO+l/2D+ESIdI/L+VMa6KzaglHzyLShy/2NLDiZAC16Z7QvTLeBsZeD9ph2T4wo9YqZ9mg3YUDuUZ2WeFxQFM1pmYw9LlFfvHNUKEe7qEMrdX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTxyCAzc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B724C1F000E9;
	Wed, 27 May 2026 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903932;
	bh=r2fgV4oQbyZPfYYsNWWxqOHK60lQRJS58r3I7jp0oZo=;
	h=From:Date:Subject:To:Cc;
	b=PTxyCAzcKIjQ+ICd1fM5kCyaxLFJUsQAPDZF9+oYZ8eZIIpc54mqLqYb76OE+a3lB
	 FjVh9G/bavWC4vse1Foh8b3KYcIfe31auADabUsYHNmHsNoTWpxof4DY2UyRHzdVD/
	 uu3ieW6aXp/ByMtKAsvff5qaUWXqMs9QDHOa3CwnlaSrj+kXq0QAJ1hp51lovwqJ3I
	 cwh13pPiwYR8H9s0WJ6UJuou2hUCa0fIniupBQrC36Tr6891pIsqbDSG6pOYC+cUJo
	 45X3U0fO0QkG64oHhP/QdguYaUnxhD8Kz2p6SKO0gEF1SiaaciYl9fbeFzaZhOZqQ3
	 DeEDcrAKP1fJw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 27 May 2026 10:45:26 -0700
Subject: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTtQg8bgVcTFNPnVEWxLJilC6
 d2NuvwW761kyAqjc7dSxqKm09iw33UUHzLewZqayfXO90d3YqlJC9c5SQG/JOaJrdTB2OOQAoI
 E50EtnzNu+v6tL9e/rQ5PxPL90bZ9APJ9onN8AAAA
X-Change-ID: 20260527-audit-update-macro-stubs-6e4d8e8a826e
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, Waiman Long <longman@redhat.com>, 
 Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ef62bATNZwIn1y4mzGz79jm63fmplokSG360GSv7uQY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFniurs6fX7xmj+5OLeipyL2u1lLUv/8k2V635VtWkom7
 7Zz+pPUUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACayU56R4dbCSds1F80qfhFY
 uKdn6sLSAGvNdxuuSHWIf73rocTkc4fhny3nN6MS9idCLCKNOjvfzbjbdztIYn52fORNt/i/m63
 vcgMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2E295E8804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
audit_dupe_exe() but did not update the macro stubs used when
CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for this
configuration:

  kernel/auditfilter.c: In function 'audit_data_to_entry':
  kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4 arguments, but takes just 3
    592 |                         audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
        |                                                                                     ^
  In file included from kernel/auditfilter.c:23:
  kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
    327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
        |         ^~~~~~~~~~~~~~~~
  kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (first use in this function)
    592 |                         audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
        |                                      ^~~~~~~~~~~~~~~~
  kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function-like macro and might be used incorrectly
  kernel/auditfilter.c:592:38: note: each undeclared identifier is reported only once for each function it appears in
  kernel/auditfilter.c: In function 'audit_dupe_rule':
  kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 arguments, but takes just 2
    879 |                         err = audit_dupe_exe(new, old, ctx);
        |                                                           ^
  kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
    333 | #define audit_dupe_exe(n, o) (-EINVAL)
        |         ^~~~~~~~~~~~~~
  kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (first use in this function)
    879 |                         err = audit_dupe_exe(new, old, ctx);
        |                               ^~~~~~~~~~~~~~
  kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-like macro and might be used incorrectly

Update the macros with the correct number of parameters to resolve the
build error.

Cc: stable@vger.kernel.org
Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_dupe_exe()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/audit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index f1a77aef4533..92d5e723d570 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(void);
 #define audit_watch_path(w) ""
 #define audit_watch_compare(w, i, d) 0
 
-#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
+#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
 #define audit_mark_path(m) ""
 #define audit_remove_mark(m) do { } while (0)
 #define audit_remove_mark_rule(k) do { } while (0)
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
-#define audit_dupe_exe(n, o) (-EINVAL)
+#define audit_dupe_exe(n, o, c) (-EINVAL)
 
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL

---
base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e

Best regards,
--  
Cheers,
Nathan


