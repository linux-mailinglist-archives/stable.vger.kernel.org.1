Return-Path: <stable+bounces-247218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFb+JFDeBWokcgIAu9opvQ
	(envelope-from <stable+bounces-247218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB854344D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3083054FF3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DAB40757E;
	Thu, 14 May 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PdtbCsXA"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6B407582
	for <stable@vger.kernel.org>; Thu, 14 May 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769069; cv=none; b=Z4cCrQY/KajliAdZfQwaNk5YALAOiTg9QdqL5th8XKmlmY7bw+v4zmTBpA+TSmnJ4b0v0zYQwRlqltuUhvBrdi2Ub3Oq+R0HCDHwkyGA/G/fTjUOVXW7u/W6yf2G9EDgQW/uAwsZJwVdUP9MF3rN7qiALWaNvGwdZJgjZSOMbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769069; c=relaxed/simple;
	bh=YyWaZMeiJz9T5X4EUNvY6ADsp4aJr7uTDn7N6DZe6RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ove/Hfw5myZ1vxrfNYnTlf+hwVrtb2X7t43OJh1CXgJCdZeVVcaylRG3b45TmonvHtvT2/b3Cwbzz4ZQT1lNK4dXL3236aRUj1sRjI7kBSQhc/jsxOn1tLVl/4COfq/TgOxPeSQa+kjDMkoB40bEd6RfCOPw1TgBqK6xyA/WNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PdtbCsXA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778769065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PjiDFNRvDjNvFgEga9MgPvmaO5o63mGNwkS79Mluow=;
	b=PdtbCsXA12Gkq6L3hTdX6JBUToS00HIJtduGODTT0haoxSppG43+sL9QmCYl4lQUmyIX8b
	+Sq+cZ/Tps6umikht/yOYZG+0WpY03SNb09fzJSRp2r7/c6n6/NKDCMmYsobcVmRxhvbhb
	AQz3OAfA/qqH/lHmCvRZc37ctbrES5k=
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
Subject: [PATCH] x86/boot: validate console=uart8250 baud rate to avoid early boot hang
Date: Thu, 14 May 2026 16:30:15 +0200
Message-ID: <20260514143014.516303-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=thorsten.blum@linux.dev; h=from:subject; bh=YyWaZMeiJz9T5X4EUNvY6ADsp4aJr7uTDn7N6DZe6RU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmsd8pEv8/X7bj3+Lvvli8e9T3hRrPakthOmvllrIkSa +9+G3mvo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYSFc/wv+KXxJ/nlidqJ9xL iGtsXbMuVk7QmvNJjTDfpmjDrFseOxn+V6pm2j16cvCW2IWHmRwNb4180/u087z+8qzbnKkaJaX ACgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 04FB854344D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247218-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the baud rate is empty, 0, invalid, or overflows to 0 when stored
as an int, the system will hang during early boot because of a division
by zero in early_serial_init().

Fall back to DEFAULT_BAUD when the resulting baud rate is 0 to prevent
an early system hang.

Fixes: ce0aa5dd20e4 ("x86, setup: Make the setup code also accept console=uart8250")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/boot/early_serial_console.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..28a887af430d 100644
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
@@ -136,9 +136,11 @@ static void parse_console_uart8250(void)
 	else
 		return;
 
-	if (options && (options[0] == ','))
-		baud = simple_strtoull(options + 1, &options, 0);
-	else
+	if (options && (options[0] == ',')) {
+		baud = simple_strtoull(options + 1, NULL, 0);
+		if (!baud)
+			baud = DEFAULT_BAUD;
+	} else
 		baud = probe_baud(port);
 
 	if (port)

