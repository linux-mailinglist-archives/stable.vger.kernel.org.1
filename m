Return-Path: <stable+bounces-89899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D1C9BD31E
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321D1F233EF
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9D1E1322;
	Tue,  5 Nov 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dy+zmAlA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJTvdAy5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3A1DD88D;
	Tue,  5 Nov 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826698; cv=none; b=JHt/h24r2eCjzeBCBm2g+ZJiO1XBn2FUd3LyMsiFgLbVwPhqYjKqs/GHgkO0GaDgYZkxKBmThGYPl9v+8V2gBDdAtTJ7t/PBnjiWU1FHqnBIeubZG2xnF2hIytBB70t8uNwBbMqTO72VhoqGIgokesV/pJ5TjsorPh5qQPEYRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826698; c=relaxed/simple;
	bh=f89m6lFOvRMNPhbT9eRUs6Oj097Fi09Sr+vQs7Qi23U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dRXzOqF5ni9Mv0fJv77EGakAzAxjrdy5nqqyaq+I8EVwoAs0dHXK2dJ/fkOeh6VOrIWh3//4B6/inOr378SFWX3giMMnCYMgwCUpY7JmEEojd/aPq1eWtsYxsYaHizOxlguUsINiyzJdOW3OLzwjsH7XvGqv67bdprAeZIUcijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dy+zmAlA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJTvdAy5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Nov 2024 17:11:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730826695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RcEGGPe/PUC/HcrVe2t78dT3wUi51psGgKqiD0q02WE=;
	b=dy+zmAlAPCkgoLEUpdWIiN/nimzwo1xK+XI30ETMLuo8BvauEWDih7S2Q2qrFzJiVFKUGZ
	NJFarDFuI4/D7kiGLFDgf70nc8PmatWMVhDpiqEetysgUifo27mDx9C72ZXZ91u0c5smq+
	WL4tzsXJoYHhPcbgWkdIT+bn6jduLGQEL4y8sscDmNqBht241hqegsvOUtoeyFhPwVPvD+
	aGZ/OpEeWzu4nVs5to+0TukNvwItXcTzNHqj/Sd8lKQfXeNAN1e6nqiCRKsAdSHfiRIoka
	QhsUBAdMlHuHvSxleIIQ5LKNAYyZf181zeTfj0TttlLFO1ToL//3KzJ4RTotlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730826695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RcEGGPe/PUC/HcrVe2t78dT3wUi51psGgKqiD0q02WE=;
	b=aJTvdAy5Ck0mRt2VRo3yIQToaaoecZmj3JQa/sT3w7F/ESQ2N+bpGgdhPOo1DKg24cT2TU
	yhTr9HaqOYv062BA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173082669399.32228.18413426871343797924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0
Gitweb:        https://git.kernel.org/tip/a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 05 Nov 2024 10:02:34 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 05 Nov 2024 17:48:32 +01:00

x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

A number of Zen4 client SoCs advertise the ability to use virtualized
VMLOAD/VMSAVE, but using these instructions is reported to be a cause
of a random host reboot.

These instructions aren't intended to be advertised on Zen4 client
so clear the capability.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
---
 arch/x86/kernel/cpu/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fab5cae..823f44f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -924,6 +924,17 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
+
+	/*
+	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
+	 * in some BIOS versions but they can lead to random host reboots.
+	 */
+	switch (c->x86_model) {
+	case 0x18 ... 0x1f:
+	case 0x60 ... 0x7f:
+		clear_cpu_cap(c, X86_FEATURE_V_VMSAVE_VMLOAD);
+		break;
+	}
 }
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)

