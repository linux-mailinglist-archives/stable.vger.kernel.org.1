Return-Path: <stable+bounces-260965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47vUKLlCJWoCFQIAu9opvQ
	(envelope-from <stable+bounces-260965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:06:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2564F54D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:06:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mAYfd4bx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260965-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260965-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B65E73001326
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F82FE59C;
	Sun,  7 Jun 2026 10:06:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562378C9C;
	Sun,  7 Jun 2026 10:06:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826805; cv=none; b=eIq+Owtg7CnhP5LaV9NwvKUKY1RP6QqjGmfSDmun+qVc/flg0dtSBp+1u3gLkLdxOUK9KQ+JeJUwbyZY2HKLJvy/t26/B86TFqP3cTjl3ZZy2Q3F967gOP/XSL0nstzdVKCb1EQu/OVqT6Hp6dkx+vLo2BMOdxe3Y+ahuh9HmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826805; c=relaxed/simple;
	bh=iGhCnIY5XkL1h9eEB9dTeHKqgcnY8MOTNHH9x3B1XsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mkc1cQCbSZzFrpwRovGwU5o4/hEIB41b4cUFygf8W6A+ZY0zQrSIz/G9dq1BRr28Jtf4eGOnQgiFRaGjk9q7bTIrCEwxNBWz4DNRNK+oTVfDgMqVfqwIsjo6g9VxbhvjxqOHu8an47cohQwHsCQNKACJg60yMWJSJF2ZZjf2TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mAYfd4bx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757351F00893;
	Sun,  7 Jun 2026 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826803;
	bh=bsxdCk996hMbeJNntipLiFkgkv9xCi+HN4YMmKHYM20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAYfd4bxaQwEbeF3LoZ1HoqdFHwOZ7/Byza2SH8GiNiLZ3Qj7KZ98KUeu0uGt7qGP
	 gu/tkSqXhUa2fNeYPQw7Jq4qrNm0la99XMRV37QVBf98kkYyohVQhzM0x/wpi0mx48
	 Ik4mO3PmPBEg08L2h4JHCIDH0IzsM6VH2Dlvk7SQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Schmaus <florian.schmaus@codasip.com>,
	Martin Kaiser <martin@kaiser.cx>,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 013/332] kunit: fix use-after-free in debugfs when using kunit.filter
Date: Sun,  7 Jun 2026 11:56:22 +0200
Message-ID: <20260607095728.517799019@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260965-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:florian.schmaus@codasip.com,m:martin@kaiser.cx,m:david@davidgow.net,m:skhan@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidgow.net:email,kaiser.cx:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E2564F54D

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Schmaus <florian.schmaus@codasip.com>

[ Upstream commit fb6988b83b4cafe8db63999c1ddff1b7c66d2ff5 ]

When the kernel is booted with a kunit filter (e.g.,
kunit.filter="speed!=slow"), the kunit executor dynamically allocates
copies of the filtered test suites using kmalloc/kmemdup.

During the initial boot execution, kunit_debugfs_create_suite() creates
debugfs files (such as /sys/kernel/debug/kunit/<suite>/run) and
permanently stores a pointer to the dynamically allocated suite in the
inode's i_private field.

Previously, the executor freed this dynamically allocated suite_set
immediately after executing the boot-time tests. Because the debugfs
nodes were not destroyed, any subsequent interaction with the debugfs
`run` file from userspace triggered a use-after-free (UAF). On systems
with architectural capabilities, like CHERI RISC-V, this resulted in
an immediate fatal hardware exception due to the invalidation of the
capability tags on the reclaimed memory. On other architectures, it
resulted in silent memory corruption.

Fix this UAF by properly coupling the lifetime of the filtered suite
memory allocation to the lifetime of the kunit subsystem and its
associated VFS nodes. Ownership of the boot-time suite_set is now
transferred to a global tracker ('kunit_boot_suites'), and the memory
is cleanly released in kunit_exit() during module teardown.

Link: https://lore.kernel.org/r/20260507084854.233984-1-florian.schmaus@codasip.com
Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/kunit/test.h |  1 +
 lib/kunit/executor.c | 19 ++++++++++++++++---
 lib/kunit/test.c     |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9cd1594ab697d9..ce0573e196ce75 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -613,6 +613,7 @@ unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
 			    unsigned long offset);
 
 void kunit_cleanup(struct kunit *test);
+void kunit_free_boot_suites(void);
 
 void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1fef217de11db1..b0f8a41d61d367 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,6 +15,16 @@ extern struct kunit_suite * const __kunit_suites_end[];
 extern struct kunit_suite * const __kunit_init_suites_start[];
 extern struct kunit_suite * const __kunit_init_suites_end[];
 
+static struct kunit_suite_set kunit_boot_suites;
+
+void kunit_free_boot_suites(void)
+{
+	if (kunit_boot_suites.start) {
+		kunit_free_suite_set(kunit_boot_suites);
+		kunit_boot_suites = (struct kunit_suite_set){ NULL, NULL };
+	}
+}
+
 static char *action_param;
 
 module_param_named(action, action_param, charp, 0400);
@@ -411,9 +421,12 @@ int kunit_run_all_tests(void)
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
 free_out:
-	if (filter_glob_param || filter_param)
-		kunit_free_suite_set(suite_set);
-	else if (init_num_suites > 0)
+	if (filter_glob_param || filter_param) {
+		if (err)
+			kunit_free_suite_set(suite_set);
+		else
+			kunit_boot_suites = suite_set;
+	} else if (init_num_suites > 0)
 		/* Don't use kunit_free_suite_set because suites aren't individually allocated */
 		kfree(suite_set.start);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 41e1c89799b6a7..99773e000e1b77 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -1075,6 +1075,7 @@ static void __exit kunit_exit(void)
 	kunit_bus_shutdown();
 
 	kunit_debugfs_cleanup();
+	kunit_free_boot_suites();
 }
 module_exit(kunit_exit);
 
-- 
2.53.0




