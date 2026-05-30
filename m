Return-Path: <stable+bounces-258309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIxwM/8nG2rM/ggAu9opvQ
	(envelope-from <stable+bounces-258309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B7611235
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C3730E26DD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F52329C6D;
	Sat, 30 May 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cG5HYePg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4934041A;
	Sat, 30 May 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163917; cv=none; b=KKt0w45BAdBQ62g87EUdA7WePY6Hhsz7BYQQBmEZBTZWTtr34fiFnR9u2LWI+iYjvzeLAWVOBRrYe4DicfPrl3XAQg10qua7Q1ukjB6kjVnudTA0GdPM99vzc1EoU/5exWHgxlP3JMANQrVob1eI+QucCgd4vBlgtEPOZJCEC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163917; c=relaxed/simple;
	bh=Ddx/Ko1RYXDnhu6URiWOydC/dMAEcNKw1bGVABGl3lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNSLI0v+FP4XP3X7NQ/uGvKMjSL8ZmYJxc3oAQ43CuQ+p/3+KuuQNBpZdO/DchjYv348HdZTmjsieGMrrLlQoEYkPCDZorTgY/KL7nRi0PdLBNJC1m3Thso307c2spttoZ/XG00oMHcUUKmS7LcIvWa3SCiXm3EMLawV1yhIi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cG5HYePg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D95F1F00893;
	Sat, 30 May 2026 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163916;
	bh=8uao0kM0N3h3gSPGDnKuWp0PDpaOFwgmT7+oRE+sjCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG5HYePgPqw00aw1wtqseFBDkGtv2tTy8vZmqutnTwWpgkWARRaN3gxiRH5lw2g21
	 nbwIfVtKBifcSVeI1RjwfIxI1mAXRpE5j95zgQ1qQ+oXtNt/K5GerVG7JVshINglZQ
	 2Sv1l4I/t1uVOp/TKpVvz7913pmQV6Ber8tFkc0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Pavlu <petr.pavlu@suse.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 401/776] params: Replace __modinit with __init_or_module
Date: Sat, 30 May 2026 18:01:55 +0200
Message-ID: <20260530160250.870413196@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258309-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 538B7611235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit 3cb0c3bdea5388519bc1bf575dca6421b133302b ]

Remove the custom __modinit macro from kernel/params.c and instead use the
common __init_or_module macro from include/linux/module.h. Both provide the
same functionality.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Stable-dep-of: deffe1edba62 ("module: Fix freeing of charp module parameters when CONFIG_SYSFS=n")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index cedda487df96b..9a76f556b898a 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -592,12 +592,6 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 }
 #endif
 
-#ifdef CONFIG_MODULES
-#define __modinit
-#else
-#define __modinit __init
-#endif
-
 #ifdef CONFIG_SYSFS
 void kernel_param_lock(struct module *mod)
 {
@@ -622,9 +616,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
  * create file in sysfs.  Returns an error on out of memory.  Always cleans up
  * if there's an error.
  */
-static __modinit int add_sysfs_param(struct module_kobject *mk,
-				     const struct kernel_param *kp,
-				     const char *name)
+static __init_or_module int add_sysfs_param(struct module_kobject *mk,
+					    const struct kernel_param *kp,
+					    const char *name)
 {
 	struct module_param_attrs *new_mp;
 	struct attribute **new_attrs;
@@ -758,7 +752,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
+struct module_kobject * __init_or_module
+lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
-- 
2.53.0




