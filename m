Return-Path: <stable+bounces-270982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MC8LKEOVRmp5ZAsAu9opvQ
	(envelope-from <stable+bounces-270982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DB6FA73F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dYqTbs8Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270982-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270982-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB61630031FA
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E273403E7;
	Thu,  2 Jul 2026 16:39:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC333A033;
	Thu,  2 Jul 2026 16:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010360; cv=none; b=bwxxHitVg2Os40MJuY5c03iZ5qCa0hSNkIYiMyede1qJtxKY+Vigx1NDGb0GGNsPD0g6NoEvY1LbD2AayVtI78Sp2NQNZScFufsUnXLkvQLWQo1ba8pkhnVz01PQF55IVzeNqYgd+SETlahvIjNFn6DOJrX2lQp7I5qhDnrcTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010360; c=relaxed/simple;
	bh=66zBd/QzTqPs1iOKjlgqCHKnZCVr+6TMF1Y3vbzCMiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqlBo/1aBKUmraQ8iJJNmzGSWF1lZvC0fEjLBCtHtWM0UAyx7X0A1Tzty7BYDzvMTPBtoOOpQk2iTVHi2x8USwhlHHHqjlyN5+yWRaA8IPYr8IXgJGAX3jlodOY26zT1+HCtBBnsrB0q6+lKQkjnFUjgNguc+zWo6lz+z5K6E30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYqTbs8Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A751F000E9;
	Thu,  2 Jul 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010358;
	bh=mX/YclM4Uwk6pX22Ou+ktpF3bcG2BH+cXG2OYJlXCbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYqTbs8Zot9kpDCYFiFtto6lG95ZpOUsrTbVnSRkKss/ZB0Twbzs51r5tQteJ2bDT
	 i+ynZfygtIsemr7AYotUKO+TA89TRqqwUKT4VD3Bs4Z8eIEjcbdgmu2kp+l9ZP3UWh
	 Z27hIy42+0YSbfgKmZBfSwXf+Vipe5aR2rMs8BV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: [PATCH 6.12 080/204] ftrace: Check against is_kernel_text() instead of kaslr_offset()
Date: Thu,  2 Jul 2026 18:18:57 +0200
Message-ID: <20260702155120.344150487@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270982-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:masahiroy@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:arnd@arndb.de,m:nathan@kernel.org,m:broonie@kernel.org,m:rostedt@goodmis.org,m:andrey.grodzovsky@crowdstrike.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,vger.kernel.org:from_smtp,arndb.de:email,efficios.com:email,goodmis.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A5DB6FA73F

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit da0f622b344be769ed61e7c1caf95cd0cdb47964 ]

As kaslr_offset() is architecture dependent and also may not be defined by
all architectures, when zeroing out unused weak functions, do not check
against kaslr_offset(), but instead check if the address is within the
kernel text sections. If KASLR added a shift to the zeroed out function,
it would still not be located in the kernel text. This is a more robust
way to test if the text is valid or not.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Link: https://lore.kernel.org/20250225182054.471759017@goodmis.org
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250224180805.GA1536711@ax162/
Closes: https://lore.kernel.org/all/5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ftrace.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7051,7 +7051,6 @@ static int ftrace_process_locs(struct mo
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
-	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
 	unsigned long pages;
 	int ret = -ENOMEM;
@@ -7101,9 +7100,6 @@ static int ftrace_process_locs(struct mo
 		ftrace_pages->next = start_pg;
 	}
 
-	/* For zeroed locations that were shifted for core kernel */
-	kaslr = !mod ? kaslr_offset() : 0;
-
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -7117,7 +7113,18 @@ static int ftrace_process_locs(struct mo
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr || addr == kaslr) {
+		if (!addr) {
+			skipped++;
+			continue;
+		}
+
+		/*
+		 * If this is core kernel, make sure the address is in core
+		 * or inittext, as weak functions get zeroed and KASLR can
+		 * move them to something other than zero. It just will not
+		 * move it to an area where kernel text is.
+		 */
+		if (!mod && !(is_kernel_text(addr) || is_kernel_inittext(addr))) {
 			skipped++;
 			continue;
 		}



