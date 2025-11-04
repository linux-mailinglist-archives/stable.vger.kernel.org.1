Return-Path: <stable+bounces-192426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D24C320FB
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72059189B692
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6503321BD;
	Tue,  4 Nov 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfi4YtlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpHOZdNL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103B3321B9;
	Tue,  4 Nov 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273797; cv=none; b=bZ5nYr9akCnFueO6KAImOI7sPnmNmsNy0HIux/589UBCposLCbAGyPRTy4Z5JHCOupxVVG8i1dK/xUjrBroPbu/NL2xTqnkN49NQMYYtcWunfeoCEefJ+TtV1Cb5sGNNiUbtAwybizXMom5In0ReR/daLKbOmjtVxZtLYSoFnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273797; c=relaxed/simple;
	bh=p/wL15ltRQMA7xHQHlwW+F0Dn4OSM+rQzz+9sz7NPo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AZhd2T6HefCVYTyT5xmOsD4Iom68vMhdqCSTtTYuWxj3ZXJ3l4uZNFLixhQNgBn/R5DToCKUyWhwhbbEOIQ20LtJDtdRLhSOMIDRqZSNOAanKvUEms8VOgIZ5XGtidxJTUcsWqCcXX1rhr9iNxetWx9Gq7m04E7lkU2pgJZHBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfi4YtlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpHOZdNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 16:29:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762273794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrXcUSoFJHKRTIVScdblOEvfsRgIkajExksL2bVTLmw=;
	b=zfi4YtlLtmWWyx7KkWnx48k+vFcshRNuTkcAQUJ93Fsw1lhtfRBTIOjLhYqyT49fS395D1
	3Dc5IRKTFxL8pEug+3ZH3ov45rPRhx46WMIzDk71xghtreLdLAlOoPmeAwZQmVkOMB4qy/
	CqkFFkxGrukKIOgEFQmlFRekc3LoLJgq26xx7vKsPkSmu2HsS+L6dnWCIhuJz5Jidh5oEX
	cCTrsX/r3v0Wnb2J05Haclxf81UtTfPvK11idJO47RqdUaHh9SHCl9JaDfsLQlSngg0YfW
	DiwR/d3y/DaWxeVtftz5XqHaUCsPeaLwVXtv/oD570lZZ8I7s/sAVgb2uiYrkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762273794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrXcUSoFJHKRTIVScdblOEvfsRgIkajExksL2bVTLmw=;
	b=vpHOZdNLainHCeAucuhziOHskdqBWh9Kh3B1Bwcipub11dl0Y+2kReX2YEI0USW7cKzxii
	CffeYwziDhvF+qAQ==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add missing terminator for
 zen5_rdseed_microcode
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251104161007.269885-1-mario.limonciello@amd.com>
References: <20251104161007.269885-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176227378838.2601451.3901587952089036568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f1fdffe0afea02ba783acfe815b6a60e7180df40
Gitweb:        https://git.kernel.org/tip/f1fdffe0afea02ba783acfe815b6a60e718=
0df40
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 04 Nov 2025 10:10:06 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 04 Nov 2025 17:16:14 +01:00

x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode

Running x86_match_min_microcode_rev() on a Zen5 CPU trips up KASAN for an out
of bounds access.

Fixes: 607b9fb2ce248 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251104161007.269885-1-mario.limonciello@amd.=
com
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8e36964..2ba9f2d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1038,6 +1038,7 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 static const struct x86_cpu_id zen5_rdseed_microcode[] =3D {
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+	{},
 };
=20
 static void init_amd_zen5(struct cpuinfo_x86 *c)

