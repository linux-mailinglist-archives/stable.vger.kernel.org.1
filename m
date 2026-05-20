Return-Path: <stable+bounces-252875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCoCJZsYDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-252875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CF5998C9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 985C73201382
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE2333441;
	Wed, 20 May 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJC7TcDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39169270545;
	Wed, 20 May 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301817; cv=none; b=aDzkjchQ/2HCd9NJA1a5L9kAu98YBfEUn/a9/IGUDbaBF/JrgPiAKWoxOxDi/T7wBJt+FDxhP63SCkM/NVpnDSuDAGH4ZUzMe+V8jc1Xfe38N5i3xmpz6SwP8/SmPTZE5IeM2RAaSNEoUPrWEpWDqkCeiYluG2oil9JLVc0utbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301817; c=relaxed/simple;
	bh=PY15ED9vfYOtezuY0gzkngrWhJFoU4S/CuJuwA1MAY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6QDsiyr6+NrWmkpqBNS4MkIXihgrCnjD+QeNst77ViDhyqRYlke/PWGpI+IJ7qa4tR8jdfHOJysdUEOxvEYV39YVexGqUJXHdmEIxABFwyNbDN49Mx7kXXCi1gaTET+euyDHlPWg3+6Ungkp7GHAhDTscYz2EDl2WX8tcYcPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJC7TcDx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7111F000E9;
	Wed, 20 May 2026 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301816;
	bh=TpsBP09FHxnxZUyPQUCBB3pobk9XUryq+ak5kclhcDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vJC7TcDxUj9pwP/s9DdyHs85vR/mEzH30ngjSDMSzq4+BlF6ASaL2uBI0HsN5MOpK
	 fvpahZdTwZvdvtXB+Tu3u79hMWFYgNaEvA/VYMlBpgqYJIzSN3q7gmugy46iFJgTVy
	 r+IKdCDrcsEDQ/b8tokU4ZK7PPDoUkV8F+iZ6vsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Pavlu <petr.pavlu@suse.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/508] params: Replace __modinit with __init_or_module
Date: Wed, 20 May 2026 18:17:33 +0200
Message-ID: <20260520162059.243308244@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252875-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 936CF5998C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index e39ac5420cd6d..2cfa12404ed0b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -593,12 +593,6 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
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
@@ -623,9 +617,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
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
@@ -759,7 +753,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
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




