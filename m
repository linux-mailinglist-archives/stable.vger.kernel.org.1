Return-Path: <stable+bounces-268593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oOqxKjRJPWpE0wgAu9opvQ
	(envelope-from <stable+bounces-268593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:28:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F56C70EF
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=AejoM5t5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268593-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268593-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C8630BF092
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5F3E8C44;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A23E8345;
	Thu, 25 Jun 2026 15:26:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401174; cv=none; b=X4wnfYfepPvGFyveY6taBfFGnY0809xO4SoZkLx57LFyoM/SaXDgvmVyeXofrQjqhJZaRwrh1CqK1nmpQbmIgrPRy1i3p9lwhOaxXf7iOyBqG3PS36//nyE0l06SBV7epb17arXby1AXtTeuR6dGo6J4nH4BfKn/2VaPIe4q9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401174; c=relaxed/simple;
	bh=zWcOFKGwPWajhwcGSb2AhPT6/90yQXPi6eWRU2WWDJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et2LPf+dPqpSDh96EMTdk0Bs2OEJHOBWuRvAT5Qlk8ool9wOk+DPSSjvtlOBuMke4zI7qe7KSeJ/k0qsjM2+/+Ueb+9qV4WpDGm7jo8yPrUpmSsTP96YiCUmYI2jR3vwJaO0EkfccuzV7SD2JDCx7xT+jA5eUv3RAW99WjaIaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=AejoM5t5; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401171;
	bh=j9CXKAHhdqi4eGx4YYPuER2s6anoRJJPXHxXpa88ucY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AejoM5t5GdalaI4l4XhlRetAHYf/V5T7rGkxgbNeppUK8YtW5cjkxWATG88jRZPO1
	 BiFQubOMPudqnCw3jKkGx+9c4RNSGoF/Al7sNc5lHFk6H1oRsuiUM+UJuk9HiXh1FW
	 4vCiT0/xI9UlRLs7KywMGskJunpS1Q29vGsrw66g=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1b3cczz10sy;
	Thu, 25 Jun 2026 15:26:11 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1Z5mh1z10jY;
	Thu, 25 Jun 2026 15:26:10 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 1/4] sys_info: add helper for callers that print some sys_info on their own
Date: Thu, 25 Jun 2026 15:25:55 +0000
Message-ID: <20260625152558.7450-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268593-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,linux.alibaba.com,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org,grrlz.net];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 109F56C70EF

Some callers print some sys_info on their own before calling sys_info().

Add a helper which would allow to prevent a duplicated output.

It is a bit tricky because kernel_si_mask should be used only
when the call-specific si_mask is empty. But the duplicated
output must be prevented there as well.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..f1c2552ca3d1 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..d411fee10415 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -136,8 +136,10 @@ static int __init sys_info_sysctl_init(void)
 subsys_initcall(sys_info_sysctl_init);
 #endif
 
-static void __sys_info(unsigned long si_mask)
+static void __sys_info(unsigned long si_mask, unsigned long si_ignore_mask)
 {
+	si_mask &= ~si_ignore_mask;
+
 	if (si_mask & SYS_INFO_TASKS)
 		show_state();
 
@@ -160,7 +162,21 @@ static void __sys_info(unsigned long si_mask)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask)
+{
+	unsigned long dump_mask = si_mask & ~si_ignore_mask;
+
+	/*
+	 * Do not fall back to kernel_si_mask when the caller context
+	 * required only the ignored information.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	__sys_info(dump_mask ? : kernel_si_mask, si_ignore_mask);
+}
+
 void sys_info(unsigned long si_mask)
 {
-	__sys_info(si_mask ? : kernel_si_mask);
+	sys_info_with_filter(si_mask, 0);
 }
-- 
2.53.0


