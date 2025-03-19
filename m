Return-Path: <stable+bounces-125296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090FAA69290
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A921B88212
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC61E503D;
	Wed, 19 Mar 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGbzzQaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FD1E47D6;
	Wed, 19 Mar 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395089; cv=none; b=thCexZtyyL6frv2ICSo3v0yCIlki25d7Q8SUCCwy0sLRil6S/q5PAPGBIH6fZHWscFJU3q4qBHO7NQCMDHY+RrXs/vCh26QqD2YSmsk9SFBsiCcLkx7go9p/q060ZhCyR0u8nH/OeR+xeMW1pg2L6ADfwcbTMZd9J2Eu1fEn32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395089; c=relaxed/simple;
	bh=L0HDrEaGSgGWLnd4ONieOE1EfRQVM/HcqCxV9mYra1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxXWWtndx2QgrZfDaO091bhPieFC/xdHd93maf+ee2kFUsXkR1HQnvYKwb0/ug4ivnciBJCCBibJsTyxtksXSIPG+zZ98mQKCyCbAYO1+EvdwBhlBadT2XpYtTMGTFu6e2MxxSX9i+c7CR9vuxbmUj+ZeZ12/TtOHUXKEE7Rp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGbzzQaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C901C4CEE4;
	Wed, 19 Mar 2025 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395089;
	bh=L0HDrEaGSgGWLnd4ONieOE1EfRQVM/HcqCxV9mYra1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGbzzQaqeH4PiM9JKIoA69JwpbHoHX8ahkNiaPT/njd5EMx1x61GFR4BeNTc1ChSM
	 9nZ0n6D+RmhmXmGKgGQfBE4kqZE3/5SXS3xdmGgDRpoXQ7uU1ADfZj2DqEapOwR0un
	 hSiIMT7FSPsO0NsN1v1hiC4WsXhFnnz7Hzl1n12Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmytro Maluka <dmaluka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 136/231] x86/of: Dont use DTB for SMP setup if ACPI is enabled
Date: Wed, 19 Mar 2025 07:30:29 -0700
Message-ID: <20250319143030.195660563@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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




