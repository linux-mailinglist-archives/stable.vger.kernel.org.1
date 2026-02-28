Return-Path: <stable+bounces-221144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PJZE9lNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C961C8364
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4A3323CBCB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06BA37225E;
	Sat, 28 Feb 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPFY7WiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71606342146;
	Sat, 28 Feb 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301498; cv=none; b=hu9AezhIsUpO5iwldb6VdkAirplNWGr8CUK49JZLnePHAfHGd5yHtxs/FBJYHc9t8m+vGiCoXeMM9+Fi+NQ2E43l3UrZQkRkogmJK02CX1/0IAmqt6qvITo2VqizFOE+XVG9wKB2f2A2QrI1DcDhWGz24DfWxJKTpTwkazUl3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301498; c=relaxed/simple;
	bh=Ssi4ys2hsnK4l5iOGPWzKxKmZumXDR9aWBZNhATU+mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noiXrnXuKdmHCuKlWIq9Lqn95Enql79CVD6Ks8qxmuCGKoZRvYDrmF1bIe3+qTvsZPXa76qwqmXZKnaYbK8GXuOhHEJ17EAN+K6lEtYYlOqyPWgEiNF2310HoKCwp283/5FyIcDgw8Av2g3iRc9JC9LLrzbL0FAhBGzL/pDEQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPFY7WiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE41C2BC87;
	Sat, 28 Feb 2026 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301498;
	bh=Ssi4ys2hsnK4l5iOGPWzKxKmZumXDR9aWBZNhATU+mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPFY7WiZ5lGqN8uwFhAAhkV61ZfvllDWil6Fq4x55fSGlMZWk1u7dgWZjeZx1pNWg
	 DajxJ4J8uVmBZF1/yAmsKwblOcwRO36Wg0NuwUDuj1N32C330BkeuSvfx4WsflO7yN
	 SQnPLTcOgrWnq4tPxtS6iA4LMCMn4GqkueSZp91escgwfVhfsi9qQN7LOuIqefhXo4
	 6sHZhckKtPx3ZtKV7wSYl0hfGbYNjO1uQMf8oo7jDC+XwoA6UHQ1Whf7uu2r7YmZKj
	 xfyfx7R0jITbwl86SGqXnH97PPREAbuEzKpmlCuJa/9Y2pD5O5S/BEEL2UOEyGgBza
	 HmgmGUoIoyNOA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org,
	Waldemar Brodkorb <wbx@openadk.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 682/752] MIPS: rb532: Fix MMIO UART resource registration
Date: Sat, 28 Feb 2026 12:46:33 -0500
Message-ID: <20260228174750.1542406-682-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221144-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openadk.org:email,franken.de:email]
X-Rspamd-Queue-Id: C8C961C8364
X-Rspamd-Action: no action

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit e93bb4b76cfefb302534246e892c7667491cb8cc ]

Since commit 6e690d54cfa8 ("serial: 8250: fix return error code in
serial8250_request_std_resource()"), registering an 8250 MMIO port
without mapbase no longer works, as the resource range is derived from
mapbase/mapsize.

Populate mapbase and mapsize accordingly. Also drop ugly membase KSEG1
pointer and set UPF_IOREMAP instead, letting the 8250 core perform the
ioremap.

Fixes: 6e690d54cfa8 ("serial: 8250: fix return error code in serial8250_request_std_resource()")
Cc: stable@vger.kernel.org
Reported-by: Waldemar Brodkorb <wbx@openadk.org>
Link: https://lore.kernel.org/linux-mips/aX-d0ShTplHKZT33@waldemar-brodkorb.de/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/rb532/devices.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index b7f6f782d9a13..ffa4d38ca95df 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -212,11 +212,12 @@ static struct platform_device rb532_wdt = {
 static struct plat_serial8250_port rb532_uart_res[] = {
 	{
 		.type           = PORT_16550A,
-		.membase	= (char *)KSEG1ADDR(REGBASE + UART0BASE),
+		.mapbase        = REGBASE + UART0BASE,
+		.mapsize        = 0x1000,
 		.irq		= UART0_IRQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM,
-		.flags		= UPF_BOOT_AUTOCONF,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 	},
 	{
 		.flags		= 0,
-- 
2.51.0


