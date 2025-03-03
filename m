Return-Path: <stable+bounces-120107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0EA4C750
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D6188457A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816D22FDEA;
	Mon,  3 Mar 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsfqZjDE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6C21518D;
	Mon,  3 Mar 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019414; cv=none; b=Aaoj4j5mMBJn/xCxvLnd2g4WJ0tSYlQR4TPmsLtB81MAzls/xrDkICeC1gbQdcjg4748gnqx9to7bz1E7woCxqHvBdVTLKhbQhcMZIHliJKVtldrwSztJKDcf2vsg8xFWGzKn4t4BYYUGrgjkQ4TDIR/mOudSxOXfY69UeKGtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019414; c=relaxed/simple;
	bh=2x2c56vUaSgQ5YrhLH2S+NjGLifAOf+kx0rtKNh6/N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRfmqm2SrskVETA5k+9169FmHPomiACSSqJkWRB2TwC+KgMS0u3tneRuIFsaewsrkQootNt6wHMFxgz9plZIdt1a1mSrXX/hpQPUGxkIb5ROUncmbD1etIHOGveY+HEVqpImm4V4utaC7P36srwzADgPDwJDxTIN+TYXd2glaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsfqZjDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA793C4CEEA;
	Mon,  3 Mar 2025 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019413;
	bh=2x2c56vUaSgQ5YrhLH2S+NjGLifAOf+kx0rtKNh6/N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsfqZjDE5fkSIDKA3YzQKxrXFuDiYYKXXXhBVeaRgLKqJojEWLzkRGjR4ilL+86xk
	 4AQXIk0Es3O43kRdkoSk6cIF/szgKiX7HOv7C7Ahyceglznj+5meTBJbGFIwJTMr/f
	 KXefXdxP76mSCLpRIoBbKduiuVA3qFeV2a3ryOwrB/rarmjpVmpYwNCzKB5H7gQvI/
	 pJQwJLCX5NgflRp1+sgUHDs8sIKVB4LsQqlgNiHcRrL+fcEffedMVrd5KOxWGwkVdi
	 b6vfxOU9PHyJ0jYYgq+4MUE4DiX8JZC6ELHqnLU0k25w3iStEI+x6J62xwM56fkPV1
	 DFAmJf5v7zzvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	ssengar@linux.microsoft.com,
	robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	usamaarif642@gmail.com,
	sboyd@kernel.org
Subject: [PATCH AUTOSEL 6.13 10/17] x86/of: Don't use DTB for SMP setup if ACPI is enabled
Date: Mon,  3 Mar 2025 11:29:42 -0500
Message-Id: <20250303162951.3763346-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Dmytro Maluka <dmaluka@chromium.org>

[ Upstream commit 96f41f644c4885761b0d117fc36dc5dcf92e15ec ]

There are cases when it is useful to use both ACPI and DTB provided by
the bootloader, however in such cases we should make sure to prevent
conflicts between the two. Namely, don't try to use DTB for SMP setup
if ACPI is enabled.

Precisely, this prevents at least:

- incorrectly calling register_lapic_address(APIC_DEFAULT_PHYS_BASE)
  after the LAPIC was already successfully enumerated via ACPI, causing
  noisy kernel warnings and probably potential real issues as well

- failed IOAPIC setup in the case when IOAPIC is enumerated via mptable
  instead of ACPI (e.g. with acpi=noirq), due to
  mpparse_parse_smp_config() overridden by x86_dtb_parse_smp_config()

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250105172741.3476758-2-dmaluka@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/devicetree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 59d23cdf4ed0f..dd8748c45529a 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -2,6 +2,7 @@
 /*
  * Architecture specific OF callbacks.
  */
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -313,6 +314,6 @@ void __init x86_flattree_get_config(void)
 	if (initial_dtb)
 		early_memunmap(dt, map_len);
 #endif
-	if (of_have_populated_dt())
+	if (acpi_disabled && of_have_populated_dt())
 		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 }
-- 
2.39.5


