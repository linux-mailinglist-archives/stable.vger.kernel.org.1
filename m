Return-Path: <stable+bounces-128273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76AA7B41D
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597583BACF2
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09C21E091;
	Fri,  4 Apr 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoSSXNHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8019D8BC;
	Fri,  4 Apr 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725304; cv=none; b=D4dC1O2R+uGhyisltaCNH+wuK6j2olJBQQH/iv8Ixd2rx3Gub7FNvwMQBmOhvBqLCDfc//IZBX51Rxd0ovnZ0ZoMkAm5CnjJ8Fp3t0bOEFBS2WrkBcVfPLpqx6IMpE2kuEKUBBnhOhTUO6yCpFbSEhppoXoVW2cOcm/brbUmBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725304; c=relaxed/simple;
	bh=iy2D5YLYmk2gy5lxIjxylUPpte9UH890+9ZU0eVjUTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdhgX2P4oH/O+/vS4L+kYZc3yDKMmdHcxQa72ACp2iAwN/xL+dRCEiaQXtA3+uTGNRcH8w3rEHzHvgugrmpfKtCM/XhfkNYLlXBLbNoKes1kiSH2BH+OsziV+ehZe+gaN4fWvjghIiHAMShZi7qcTGPRHcQDuAVtcY96Loguxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoSSXNHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC658C4CEE5;
	Fri,  4 Apr 2025 00:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725304;
	bh=iy2D5YLYmk2gy5lxIjxylUPpte9UH890+9ZU0eVjUTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoSSXNHemigGsUy13Ik8e29aXweQqlKc2soKFZbTOLUluWg+rnkoKv+IaT3Z9lF5w
	 oeiXb1kAEubV4MHUSlCZRsSC66/Qo6z7BavxbDd2+An7MKDQ7w8WBmHKxaeZB8XwDm
	 thnDx6feFAkAOpRXdcsEqpaUMf6zl97Ez/pyxB00+RtSmRwpbgerve9INgKqovKQ39
	 Ucf2x/GULngSwiQUZevoxqiPqLGqbImzL5N/6FmmsvPTwBtkWoaXW6M2DgpPasdPSs
	 KD0+dfdUN90wgGe8UYlQpDVvDtXbEqHlRavG08Tjxhp+WhdrgXn5diFDpqh+hAl5io
	 YGMMczuUpvdpg==
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
Subject: [PATCH AUTOSEL 5.4 6/6] x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
Date: Thu,  3 Apr 2025 20:08:07 -0400
Message-Id: <20250404000809.2689525-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000809.2689525-1-sashal@kernel.org>
References: <20250404000809.2689525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index df0a3a1b08ae0..772ce6f3c16cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2743,13 +2743,21 @@ config MMCONF_FAM10H
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


