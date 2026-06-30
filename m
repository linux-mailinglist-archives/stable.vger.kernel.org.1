Return-Path: <stable+bounces-269944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +iCEFIybQ2rrdAoAu9opvQ
	(envelope-from <stable+bounces-269944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730296E2E9A
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=COQPLKmv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269944-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269944-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122F03045446
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70CB3EF65F;
	Tue, 30 Jun 2026 10:28:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A63E6DE7;
	Tue, 30 Jun 2026 10:28:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815327; cv=none; b=HQ8DxV4hD+ftzXblf0wGLzps4D/FHgdAfJZRi3/yyeK1doP+9MVse9VUSNMMvvWjMoVVdAPrANaKAp5TN1JUeGrEZDfHhWrqWgvK0HpchkqeACaLZMKyJ/o3uLBf4XkHPFMb8y8fcQB80n+MFJUQZEHQUN8o7vTMZBzfhunGMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815327; c=relaxed/simple;
	bh=+pX07a2u5TkbqrO4azJbx+91thfYIYeQVNU0vPSkC7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9FiDK0G9TohKjfJ9qiypupS/mIhBUWR0yYr5GoxORjbEVPLLbS2NkAVJtavaO5L/fl14b6MRuhR1GeIkG4UytWtfPefpWjRNoByGvK8+hOP9AkCKEISIREsYz5ggTK+zNsE9BzugteBKMP9cbXev7z3FrfmT+mRKbZKMbMv0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=COQPLKmv; arc=none smtp.client-ip=91.218.175.184
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782815324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sRyqpi+BAHs5WUp31Tgpjj0ZLVkhU0Gr2GsoSexZcO4=;
	b=COQPLKmvp3nt6ZbZQIVudhiGCgGCEPJrfnbR1T06o8vWsf9wvIf/QVayAZ20/gHRA979tp
	Jl6V28cRxvERUg9G1mXzxYOlhQjpeGA6X86chStFwtbH7okRabIMvtpeaA0VMVx9xGCxFX
	8USVIVDv7D4K6371CUpUIVU5Oq/J3QE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/boot: Validate console=uart8250 baud rate to avoid early boot hang
Date: Tue, 30 Jun 2026 12:28:11 +0200
Message-ID: <20260630102810.685658-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=thorsten.blum@linux.dev; h=from:subject; bh=+pX07a2u5TkbqrO4azJbx+91thfYIYeQVNU0vPSkC7I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnOs6yUOX5raP0zXfb2r8Dywy/k1b0L/v++cmTyYiX+f +zXfi5V7ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJBCUxMtxtPJu9vvrItwMK KYeaDqbzfDXmSz5/9tG7JTwFp/d+WirLyHAnoYo9oyfDwVXy5JO11pNtEo5pa5haZzzbeGlf2d6 kX+wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269944-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:penberg@cs.helsinki.fi,m:yinghai@kernel.org,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:hpa@linux.intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 730296E2E9A

When the baud rate is empty, 0, invalid, or overflows to 0 when stored
as an int, the system will hang during early boot because of a division
by zero in early_serial_init().

Fall back to DEFAULT_BAUD when the resulting baud rate is 0 to prevent
an early system hang.

Fixes: ce0aa5dd20e4 ("x86, setup: Make the setup code also accept console=uart8250")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/boot/early_serial_console.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..5b83beab89e1 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -117,7 +117,7 @@ static unsigned int probe_baud(int port)
 static void parse_console_uart8250(void)
 {
 	char optstr[64], *options;
-	int baud = DEFAULT_BAUD;
+	int baud;
 	int port = 0;
 
 	/*
@@ -136,10 +136,13 @@ static void parse_console_uart8250(void)
 	else
 		return;
 
-	if (options && (options[0] == ','))
-		baud = simple_strtoull(options + 1, &options, 0);
-	else
+	if (options && (options[0] == ',')) {
+		baud = simple_strtoull(options + 1, NULL, 0);
+		if (!baud)
+			baud = DEFAULT_BAUD;
+	} else {
 		baud = probe_baud(port);
+	}
 
 	if (port)
 		early_serial_init(port, baud);

