Return-Path: <stable+bounces-252927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGeoHh8ZDmqA6AUAu9opvQ
	(envelope-from <stable+bounces-252927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AC599994
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E22A3252B27
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EE5333441;
	Wed, 20 May 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qe43p2+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8D285CBA;
	Wed, 20 May 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301955; cv=none; b=I28jVWDTT1UJQVKpYPDmSMg0A0hQpYI4IZq6x9sDPgF5AocXGYNq9r6a9Lj2iTPDjK/Mrdr7r4gYRFX7gBRxkm00xM0TOR1q14CrClw6fqcS3sUL1enwdE3rR4Po/cbXpg6cPqTHyJ+AzJqOftQ2r2F5xO163RPpIFkW5RV74Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301955; c=relaxed/simple;
	bh=rN2XnANR8011/FqVej+XTFR9mtplqJmKIFygKr92ZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppIh5ehAIZZTPKhhcu8HQCfDoohKWQSqdu2tkalLHyh/FVjlcJ9CjWdF9ngTOx8/ynUfpNXAmx0va919jgKe2vN8L4lQ2I7URBRz8ibjJKwCks2tEb+6PwE0SDO5RY1n8yuu5+eltQ5I2OV0oLIzTR5Z5cUnplg03cGDFavE4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qe43p2+/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A651F000E9;
	Wed, 20 May 2026 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301953;
	bh=5+5Qas/7QWUZYB1ig9502XsCKY8W5BMIwZQ3RV4mzDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qe43p2+/B/oujCryPehJ0uxJgpqS//N1lcSogupLDLS4+VmPqTN7G0jaYwNHn50C0
	 wPwQuf9FtLj+3I8cn4TvAN45heszh4dM8XTrAXjP8fciQFVrm4clRS9D5LxIqS6xzm
	 dBVtscof36b0fTlMPefWBFCmUY+/JzNADQbOw6HE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/508] module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
Date: Wed, 20 May 2026 18:17:34 +0200
Message-ID: <20260520162059.264893893@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252927-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA9AC599994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit deffe1edba626d474fef38007c03646ca5876a0e ]

When setting a charp module parameter, the param_set_charp() function
allocates memory to store a copy of the input value. Later, when the module
is potentially unloaded, the destroy_params() function is called to free
this allocated memory.

However, destroy_params() is available only when CONFIG_SYSFS=y, otherwise
only a dummy variant is present. In the unlikely case that the kernel is
configured with CONFIG_MODULES=y and CONFIG_SYSFS=n, this results in
a memory leak of charp values when a module is unloaded.

Fix this issue by making destroy_params() always available when
CONFIG_MODULES=y. Rename the function to module_destroy_params() to clarify
that it is intended for use by the module loader.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/moduleparam.h | 11 +++--------
 kernel/module/main.c        |  4 ++--
 kernel/params.c             | 27 ++++++++++++++++++---------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 061e19c94a6bc..f73ca4d62683b 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -392,14 +392,9 @@ extern char *parse_args(const char *name,
 				     const char *doing, void *arg));
 
 /* Called by module remove. */
-#ifdef CONFIG_SYSFS
-extern void destroy_params(const struct kernel_param *params, unsigned num);
-#else
-static inline void destroy_params(const struct kernel_param *params,
-				  unsigned num)
-{
-}
-#endif /* !CONFIG_SYSFS */
+#ifdef CONFIG_MODULES
+void module_destroy_params(const struct kernel_param *params, unsigned int num);
+#endif
 
 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 76d90c20de674..ac528fbb62824 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1261,7 +1261,7 @@ static void free_module(struct module *mod)
 	module_unload_free(mod);
 
 	/* Free any allocated parameters. */
-	destroy_params(mod->kp, mod->num_kp);
+	module_destroy_params(mod->kp, mod->num_kp);
 
 	if (is_livepatch_module(mod))
 		free_module_elf(mod);
@@ -2998,7 +2998,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mod_sysfs_teardown(mod);
  coming_cleanup:
 	mod->state = MODULE_STATE_GOING;
-	destroy_params(mod->kp, mod->num_kp);
+	module_destroy_params(mod->kp, mod->num_kp);
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
diff --git a/kernel/params.c b/kernel/params.c
index 2cfa12404ed0b..9d09ea99363fc 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -744,15 +744,6 @@ void module_param_sysfs_remove(struct module *mod)
 }
 #endif
 
-void destroy_params(const struct kernel_param *params, unsigned num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++)
-		if (params[i].ops->free)
-			params[i].ops->free(params[i].arg);
-}
-
 struct module_kobject * __init_or_module
 lookup_or_create_module_kobject(const char *name)
 {
@@ -987,3 +978,21 @@ static int __init param_sysfs_builtin_init(void)
 late_initcall(param_sysfs_builtin_init);
 
 #endif /* CONFIG_SYSFS */
+
+#ifdef CONFIG_MODULES
+
+/*
+ * module_destroy_params - free all parameters for one module
+ * @params: module parameters (array)
+ * @num: number of module parameters
+ */
+void module_destroy_params(const struct kernel_param *params, unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (params[i].ops->free)
+			params[i].ops->free(params[i].arg);
+}
+
+#endif /* CONFIG_MODULES */
-- 
2.53.0




