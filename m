Return-Path: <stable+bounces-196567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0217C7BB57
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21EA435AC8E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480B305957;
	Fri, 21 Nov 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vP7B5gzk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BR3FDrTS"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061ED22E3F0;
	Fri, 21 Nov 2025 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759107; cv=none; b=bbE966WT52HmLsgt2dyGsxAPZAK7o6Ro7caeRnW1mvFnxsnRQLpt9mkbd4xaQJMAZ5HVt7K2r2nWqi7JV/JB0oafduOaKXvJ7f2hYEa+mA4yx4RjCiQi1J+evQPzw4yH29kMWbLKY9qzA6191pNWV2ziwWgk1nNAn/y2QxH7EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759107; c=relaxed/simple;
	bh=qHq02nPMWRFZ4qAZ1c71cBk710r3nPoMdhTVgW1tTbw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M34K5w4bQqW/tvr7y0miD71258rQPZf0PZShutvU7sBa27+1+IMrT/ECY0aUu2AVfE8GcdZuH7g9T8nppHK2YFVkWWEcOEBmb7VFXgLU6A/x/9Kx1fHtxYBaHX8iFSVwZQX97wNoqZhGSSl0ErAZZZFmttOy3WQexC0+lmWWq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vP7B5gzk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BR3FDrTS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 21:05:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763759103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rm8iUuffrYglEuUAboi3pgCuhaZOVNYV12kyvo71NS4=;
	b=vP7B5gzkLFE5KF/5P7Qk5cGBEDdZm9HMkR4yrtZY5eb34+cU3nsx3vhCPoeGu1Jbqul0JK
	N2qplEiWwk5hUOzbVM2XXf1rU5O1dHDO4oLIZqIIUoTaqVYNcguYtm+nCz8361XVf4Gidu
	gUGfWlAoaLmphrdYYI7J8cYSAz3/Ysf/5i31comDgRnfS8hRDzfPq5fCGMLGZoXB5XjK7X
	voTsN4bZD9z/vqUZRNl8zZFImnI8LU4eIwabalqxEH9cx8OBZtYT7GICxWiu5++RR9TjLS
	uOxLqBLmCKOJRIVDGDVe+qanU7oGhulfAHVaijV9EBme4afjCaKz9j0B6UJCOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763759103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rm8iUuffrYglEuUAboi3pgCuhaZOVNYV12kyvo71NS4=;
	b=BR3FDrTSnjrfudXGgtRhN/kkc2rVhK/Be70WAIeeTQFVQdVT3V3ks5w7GzeIWH2vr9iAEI
	DDRODE0oVBkiiaAw==
From: "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Do not clear bank's poll bit in
 mce_poll_banks on AMD SMCA systems
Cc: Avadhut Naik <avadhut.naik@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251121190542.2447913-2-avadhut.naik@amd.com>
References: <20251121190542.2447913-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176375910192.498.7060304431995266255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d7ac083f095d894a0b8ac0573516bfd035e6b25a
Gitweb:        https://git.kernel.org/tip/d7ac083f095d894a0b8ac0573516bfd035e=
6b25a
Author:        Avadhut Naik <avadhut.naik@amd.com>
AuthorDate:    Fri, 21 Nov 2025 19:04:04=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 20:33:12 +01:00

x86/mce: Do not clear bank's poll bit in mce_poll_banks on AMD SMCA systems

Currently, when a CMCI storm detected on a Machine Check bank, subsides, the
bank's corresponding bit in the mce_poll_banks per-CPU variable is cleared
unconditionally by cmci_storm_end().

On AMD SMCA systems, this essentially disables polling on that particular bank
on that CPU. Consequently, any subsequent correctable errors or storms will n=
ot
be logged.

Since AMD SMCA systems allow banks to be managed by both polling and
interrupts, the polling banks bitmap for a CPU, i.e., mce_poll_banks, should
not be modified when a storm subsides.

Fixes: 7eae17c4add5 ("x86/mce: Add per-bank CMCI storm mitigation")
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251121190542.2447913-2-avadhut.naik@amd.com
---
 arch/x86/kernel/cpu/mce/threshold.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/th=
reshold.c
index eebaa63..f19dd5b 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -98,7 +98,8 @@ void cmci_storm_end(unsigned int bank)
 {
 	struct mca_storm_desc *storm =3D this_cpu_ptr(&storm_desc);
=20
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	if (!mce_flags.amd_threshold)
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	storm->banks[bank].history =3D 0;
 	storm->banks[bank].in_storm_mode =3D false;
=20

