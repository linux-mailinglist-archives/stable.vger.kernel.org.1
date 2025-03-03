Return-Path: <stable+bounces-120124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4AAA4C7CD
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF7B3A55D5
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA92505D1;
	Mon,  3 Mar 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN3FPjAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F12500BE;
	Mon,  3 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019453; cv=none; b=joeN5eGwap2QMU/iH6mHN+Ti+q5dMqRI7UH8kw7ClpIs2t874jc616xDfDZTZpA4leYa21M+ohBjXe0VsEwRnE1PyO+68y8/eZNs+LbYjkNaLFXkNkOzC7EAXpyab75lG2lhoACvDgnDpDVjcE3sSklUi5AeQPn5VKNR0DTtOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019453; c=relaxed/simple;
	bh=2x2c56vUaSgQ5YrhLH2S+NjGLifAOf+kx0rtKNh6/N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiIB1A1BvkZKpsBG9SkeM5ql5h1xYw4tCDJ3hOHNuDy2hMS5nFEhFFgmq3JuH4vFZU7hFRl5W5bRoAZnyy0kapQ44eV7dHUqIm6YIwVtWhbz1WgGSm/WNI61cm0ltZnK0P+KfnHu67wf2Zc8i3wHvxkF1Lr04egdlPhSL+aLqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN3FPjAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4B9C4CED6;
	Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019453;
	bh=2x2c56vUaSgQ5YrhLH2S+NjGLifAOf+kx0rtKNh6/N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BN3FPjAaiAmowBKKtQwWkJYtfNKfpqRV2uMBEAG0SB0HbARcFvAC1U612vWmRgUfP
	 564JxL0nNGb0oQGSi9GVe/JW+6CPjBKbsNKHlAFqQCcFeyOqzlTA0csuUvxeqk+MkV
	 JQG1Gr7JW2MtC3d+0ion0ZObzEBCPa1BIvtjmoE/hEi2eaPI+VtSOGxkErU54cDNeQ
	 +dBO6/dQhTJOkMu4fco2AYXnjjQ5QKhxifeqldghd9AW1nHUxLjbf3mZ+58WFKAvb9
	 +KbP0qtudk9KA0OGEDlVOyy/hj1rfXTrADFk8fX8KjLY6vZOVmybFwnImTKiTX73SP
	 Jr+bwto2DHHcg==
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
	sboyd@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	usamaarif642@gmail.com
Subject: [PATCH AUTOSEL 6.12 10/17] x86/of: Don't use DTB for SMP setup if ACPI is enabled
Date: Mon,  3 Mar 2025 11:30:22 -0500
Message-Id: <20250303163031.3763651-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
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


