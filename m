Return-Path: <stable+bounces-271175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zmVCKv2YRmqsZgsAu9opvQ
	(envelope-from <stable+bounces-271175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:59:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F06FAD50
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:59:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sqV4Bs3z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271175-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271175-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12383147F19
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F53AA1BA;
	Thu,  2 Jul 2026 16:47:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20B3AB29C;
	Thu,  2 Jul 2026 16:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010864; cv=none; b=lez0i4Zz8bsY58Tgbz8qRJZ2oOghyRxaCDfivwKK6/hMbwm/SV/6/JNUltzGZBdV5SBhIMIRkoiGddZuIGxddJyv0vE1KR9diuDGURtrYGWqam/3GPjpifQMoRIdc2OFS+pgGHxTcPCbdZWTyyusQxkCVOQlKNgsqAt0wMEbdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010864; c=relaxed/simple;
	bh=58EUM/OZJfwSMslqkPPragvYVB08FCT0DCqyoayx3D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kltNRC3L2LrEvt6PPUkyieTkqTgnyVMFSUXkblSmvTGD/RXYHlFWxGluMVL5gnVSR8heEI7Y+cUypjyEwFDuvVjcneZM3CCuswKj8CED1BEbg1AP37c75ZehO0cCbiy8G80tGbyZepReyrzaJQvv/FxipvedcV3pzdcO4sE+m64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqV4Bs3z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4520F1F000E9;
	Thu,  2 Jul 2026 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010863;
	bh=OcBnCiaIaQoyzm3p0UpDOqjJlVCPdYobHYQhnTufip4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sqV4Bs3z8xC0SmYeHEriT+BQEHDiGUfovHHU2BLrEPJvd8OaHQKA8UN3xtZKZ2NEF
	 VgyHJt1u2wCkEKlUrASD1yfrmU3Jz1jKdGJY2A9rbwhDkrWZ3D9tDDoHNTStIAA47M
	 RKKs0G/JtkZaqm8LjwXmAiIGSYolbckicB6SMs9E=
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
	Mark Brown <broonie@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: [PATCH 6.6 066/175] ftrace: Test mcount_loc addr before calling ftrace_call_addr()
Date: Thu,  2 Jul 2026 18:19:27 +0200
Message-ID: <20260702155117.184067911@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-271175-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:masahiroy@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:broonie@kernel.org,m:nathan@kernel.org,m:arnd@arndb.de,m:rostedt@goodmis.org,m:andrey.grodzovsky@crowdstrike.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,efficios.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:email,arndb.de:email,crowdstrike.com:email,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 455F06FAD50

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 6eeca746fa5f1dd03c6ee05cb03f5eb1ddda1c81 ]

The addresses in the mcount_loc can be zeroed and then moved by KASLR
making them invalid addresses. ftrace_call_addr() for ARM 64 expects a
valid address to kernel text. If the addr read from the mcount_loc section
is invalid, it must not call ftrace_call_addr(). Move the addr check
before calling ftrace_call_addr() in ftrace_process_locs().

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.290128736@goodmis.org
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250225025631.GA271248@ax162/
Closes: https://lore.kernel.org/all/91523154-072b-437b-bbdc-0b70e9783fd0@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ftrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6585,7 +6585,9 @@ static int ftrace_process_locs(struct mo
 	pg = start_pg;
 	while (p < end) {
 		unsigned long end_offset;
-		addr = ftrace_call_adjust(*p++);
+
+		addr = *p++;
+
 		/*
 		 * Some architecture linkers will pad between
 		 * the different mcount_loc sections of different
@@ -6597,6 +6599,8 @@ static int ftrace_process_locs(struct mo
 			continue;
 		}
 
+		addr = ftrace_call_adjust(addr);
+
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */



