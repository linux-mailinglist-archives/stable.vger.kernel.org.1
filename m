Return-Path: <stable+bounces-128182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22AAA7B30A
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4030189B400
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748312F5A5;
	Fri,  4 Apr 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcj9bvYn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332791DA53;
	Fri,  4 Apr 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725088; cv=none; b=kPGtVRZR+XUz4gzNZzcG3AoWPLtauzn6c9eY/OCW4geG6G8VGpaMtFEefLz3JxAZQRkp0orA8wJ8qNlxouAibS6J3RGoUKOPiqHo/f903gJ8PJT6pK24RfzVxtn2+0kzQBNEE+vju+J9RxZ3TKraHvb/bRTQbVUoNsVUPGJcBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725088; c=relaxed/simple;
	bh=COmDqjrBOFYSrR5d1GMiNDg4qNI5KwRFsrJQEVDcl4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O51tS2QpXwvxMXqaKT0zGOBESHh9JUts7pArOblJczyxuWIIV9LK2TkyovJa4eyKOgpCTSjdnL2ZflgfU2LbSyIwDJr4esECNBM4uCIW0FRzUtB1HTAC01cMlgHSl8DevkG63EaHKOgYcZjKIl2Hx6EGo7BVWvd4s1Lj7bIiPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcj9bvYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B310EC4CEEA;
	Fri,  4 Apr 2025 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725088;
	bh=COmDqjrBOFYSrR5d1GMiNDg4qNI5KwRFsrJQEVDcl4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tcj9bvYnH3eQrvuufa+UJlurANnYPSk2nClIpXjO3P+51JF4FRfuHjfn0Ow6Oaaaq
	 uE5hJO3fqRzxl27+IOrO320MSEOw/IvHGV0jnpxWIFsxDNDJz3O3n/VOfdNr5AsXqJ
	 D+BZFwJaCG7i+3kcBUfNpxdUyDkz8oUHqKMvxodA2rgX7lFNt9XNhilL6J4a7iwvD7
	 jS1jdf94rvkxZxpLQnqVqszD0nUIPGoG/uZSG5rU9HB6+iAmUiIsRns5XfeyiMZ+Qa
	 7vq1smG0HeouVZvu3om5Lz9hU5tLrmpJXSi6HGoVID/7gxxdiyG4on0I9yRyfz6gdd
	 pd5iS8pX+xJDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	David Heideberg <david@ixit.cz>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.14 21/23] x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
Date: Thu,  3 Apr 2025 20:03:58 -0400
Message-Id: <20250404000402.2688049-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

[ Upstream commit d9f87802676bb23b9425aea8ad95c76ad9b50c6e ]

I was unable to find a good description of the ServerWorks CNB20LE
chipset. However, it was probably exclusively used with the Pentium III
processor (this CPU model was used in all references to it that I
found where the CPU model was provided: dmesgs in [1] and [2];
[3] page 2; [4]-[7]).

As is widely known, the Pentium III processor did not support the 64-bit
mode, support for which was introduced by Intel a couple of years later.
So it is safe to assume that no systems with the CNB20LE chipset have
amd64 and the CONFIG_PCI_CNB20LE_QUIRK may now depend on X86_32.

Additionally, I have determined that most computers with the CNB20LE
chipset did have ACPI support and this driver was inactive on them.
I have submitted a patch to remove this driver, but it was met with
resistance [8].

[1] Jim Studt, Re: Problem with ServerWorks CNB20LE and lost interrupts
    Linux Kernel Mailing List, https://lkml.org/lkml/2002/1/11/111

[2] RedHat Bug 665109 - e100 problems on old Compaq Proliant DL320
    https://bugzilla.redhat.com/show_bug.cgi?id=665109

[3] R. Hughes-Jones, S. Dallison, G. Fairey, Performance Measurements on
    Gigabit Ethernet NICs and Server Quality Motherboards,
    http://datatag.web.cern.ch/papers/pfldnet2003-rhj.doc

[4] "Hardware for Linux",
    Probe #d6b5151873 of Intel STL2-bd A28808-302 Desktop Computer (STL2)
    https://linux-hardware.org/?probe=d6b5151873

[5] "Hardware for Linux", Probe #0b5d843f10 of Compaq ProLiant DL380
    https://linux-hardware.org/?probe=0b5d843f10

[6] Ubuntu Forums, Dell Poweredge 2400 - Adaptec SCSI Bus AIC-7880
    https://ubuntuforums.org/showthread.php?t=1689552

[7] Ira W. Snyder, "BISECTED: 2.6.35 (and -git) fail to boot: APIC problems"
    https://lkml.org/lkml/2010/8/13/220

[8] Bjorn Helgaas, "Re: [PATCH] x86/pci: drop ServerWorks / Broadcom
    CNB20LE PCI host bridge driver"
    https://lore.kernel.org/lkml/20220318165535.GA840063@bhelgaas/T/

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-6-b0cbaa6fa338@ixit.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e27ebd7e36a9..a9746246f2d95 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2978,13 +2978,21 @@ config MMCONF_FAM10H
 	depends on X86_64 && PCI_MMCONFIG && ACPI
 
 config PCI_CNB20LE_QUIRK
-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
-	depends on PCI
+	bool "Read PCI host bridge windows from the CNB20LE chipset" if EXPERT
+	depends on X86_32 && PCI
 	help
 	  Read the PCI windows out of the CNB20LE host bridge. This allows
 	  PCI hotplug to work on systems with the CNB20LE chipset which do
 	  not have ACPI.
 
+	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
+	  most probably only for Pentium III.
+
+	  To find out if you have such a chipset, search for a PCI device with
+	  1166:0009 PCI IDs, for example by executing
+		lspci -nn | grep '1166:0009'
+	  The code is inactive if there is none.
+
 	  There's no public spec for this chipset, and this functionality
 	  is known to be incomplete.
 
-- 
2.39.5


