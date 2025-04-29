Return-Path: <stable+bounces-136992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C23AA01EF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40411896DAD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52105188CB1;
	Tue, 29 Apr 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="gTOem4HB"
X-Original-To: stable@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569512C544
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905516; cv=none; b=plPBG63bGwCcoWNZmoriCowH2RgTtQHYkxTJcdkS51j7kYtuvKjMz4bE6cs4MrFOa85mUZlnfH5Hh2t48jgTCOpt5Tzq/Pe/4sboy1dIdsxBCDYf0rGWIIzrKqcrZul201ulolbfhyKkAY7l6Z7QiIRaBDMjvRic57d7PvuM1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905516; c=relaxed/simple;
	bh=9vFk3XqjXCcSiRKRbvNiCnrM/wnNABfiVM5ubygzOt0=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GpIprPQTB7tx8v1FAnqWANgCgeEGIs2k0BGjJ0EAVKpHKP6OytuwMzW0BG21+PMYMap+WwoW9WCWoXHR+a/u/oYyNmtjjD5gsHy5vOJi18Td8aStB7PjYxvY86NfPsipkQJmAlO7O/285ldCE6xiYwIhfyQIKq8ZAQLTEbhJRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=gTOem4HB; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 14862 invoked from network); 29 Apr 2025 07:38:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1745905109; bh=BLLE0lJH5Tu3PIBVlQ471kyUgfvClz4s9OIgul1X7Gc=;
          h=From:To:Subject;
          b=gTOem4HBtkc9JRsc/0NiPyAwrSQGypOsBlY7zl9lAEzgE+S2eR1i+9/VFFSvoR4bv
           cNpcTrHO/wvyHGXywFe75/FMOaIkLmxDmBAjGH8InqKLjp9f2KBlIqgjpPZhSJgJcS
           A0tft6v/C0n5n80eUbry00LTVA+GrFzaQ1X9bpmBnPZfmR3t0F0fVATINBd3bUb86h
           k5IjY8xnedbGiAI6oJxx7zMHYG9IO5dhqyEFq1eLT/brtE5n5ZQn7gYR+L6cHQ/aTK
           rTtCbZaKfKOepysHTyHdyUGwGLHESqIViZKK4A4lkEuDdVj3h1ykcgiWT4mFJWRh88
           cEpRzA1+3mC2A==
Received: from 37.31.6.53.mobile.internet.t-mobile.pl (HELO [127.0.0.1]) (mat.jonczyk@o2.pl@[37.31.6.53])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <stable@vger.kernel.org>; 29 Apr 2025 07:38:28 +0200
Date: Tue, 29 Apr 2025 07:38:25 +0200
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Patch_=22x86/Kconfig=3A_Mak?=
 =?US-ASCII?Q?e_CONFIG=5FPCI=5FCNB20LE=5FQUIRK_d?=
 =?US-ASCII?Q?epend_on_X86=5F32=22_has_been_a?=
 =?US-ASCII?Q?dded_to_the_6=2E14-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250429014148.400200-1-sashal@kernel.org>
References: <20250429014148.400200-1-sashal@kernel.org>
Message-ID: <76952D8A-500F-491B-9565-C8EB12BDA897@o2.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WP-MailID: 33f8177a5e290dbda87a837329aa028a
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [gRJi]                               

Dnia 29 kwietnia 2025 03:41:48 CEST, Sasha Levin <sashal@kernel=2Eorg> napi=
sa=C5=82/a:
>This is a note to let you know that I've just added the patch titled
>
>    x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
>
>to the 6=2E14-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     x86-kconfig-make-config_pci_cnb20le_quirk-depend-on-=2Epatch
>and it can be found in the queue-6=2E14 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E

Hello,=20

I'd like to ask that this patch be dropped from the stable queues (for 6=
=2E14 and earlier kernels)=2E It does not fix
anything important, it is just for convenience - to
hide this one option from amd64 kernel Kconfig=2E

Greetings,=20

Mateusz

>
>
>
>commit 8cc03c8c367ced0228a5fbaec8c02274f11b2a38
>Author: Mateusz Jo=C5=84czyk <mat=2Ejonczyk@o2=2Epl>
>Date:   Fri Mar 21 21:48:48 2025 +0100
>
>    x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
>   =20
>    [ Upstream commit d9f87802676bb23b9425aea8ad95c76ad9b50c6e ]
>   =20
>    I was unable to find a good description of the ServerWorks CNB20LE
>    chipset=2E However, it was probably exclusively used with the Pentium=
 III
>    processor (this CPU model was used in all references to it that I
>    found where the CPU model was provided: dmesgs in [1] and [2];
>    [3] page 2; [4]-[7])=2E
>   =20
>    As is widely known, the Pentium III processor did not support the 64-=
bit
>    mode, support for which was introduced by Intel a couple of years lat=
er=2E
>    So it is safe to assume that no systems with the CNB20LE chipset have
>    amd64 and the CONFIG_PCI_CNB20LE_QUIRK may now depend on X86_32=2E
>   =20
>    Additionally, I have determined that most computers with the CNB20LE
>    chipset did have ACPI support and this driver was inactive on them=2E
>    I have submitted a patch to remove this driver, but it was met with
>    resistance [8]=2E
>   =20
>    [1] Jim Studt, Re: Problem with ServerWorks CNB20LE and lost interrup=
ts
>        Linux Kernel Mailing List, https://lkml=2Eorg/lkml/2002/1/11/111
>   =20
>    [2] RedHat Bug 665109 - e100 problems on old Compaq Proliant DL320
>        https://bugzilla=2Eredhat=2Ecom/show_bug=2Ecgi?id=3D665109
>   =20
>    [3] R=2E Hughes-Jones, S=2E Dallison, G=2E Fairey, Performance Measur=
ements on
>        Gigabit Ethernet NICs and Server Quality Motherboards,
>        http://datatag=2Eweb=2Ecern=2Ech/papers/pfldnet2003-rhj=2Edoc
>   =20
>    [4] "Hardware for Linux",
>        Probe #d6b5151873 of Intel STL2-bd A28808-302 Desktop Computer (S=
TL2)
>        https://linux-hardware=2Eorg/?probe=3Dd6b5151873
>   =20
>    [5] "Hardware for Linux", Probe #0b5d843f10 of Compaq ProLiant DL380
>        https://linux-hardware=2Eorg/?probe=3D0b5d843f10
>   =20
>    [6] Ubuntu Forums, Dell Poweredge 2400 - Adaptec SCSI Bus AIC-7880
>        https://ubuntuforums=2Eorg/showthread=2Ephp?t=3D1689552
>   =20
>    [7] Ira W=2E Snyder, "BISECTED: 2=2E6=2E35 (and -git) fail to boot: A=
PIC problems"
>        https://lkml=2Eorg/lkml/2010/8/13/220
>   =20
>    [8] Bjorn Helgaas, "Re: [PATCH] x86/pci: drop ServerWorks / Broadcom
>        CNB20LE PCI host bridge driver"
>        https://lore=2Ekernel=2Eorg/lkml/20220318165535=2EGA840063@bhelga=
as/T/
>   =20
>    Signed-off-by: Mateusz Jo=C5=84czyk <mat=2Ejonczyk@o2=2Epl>
>    Signed-off-by: David Heideberg <david@ixit=2Ecz>
>    Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>    Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>    Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>    Link: https://lore=2Ekernel=2Eorg/r/20250321-x86_x2apic-v3-6-b0cbaa6f=
a338@ixit=2Ecz
>    Signed-off-by: Sasha Levin <sashal@kernel=2Eorg>
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index aeb95b6e55369=2E=2Ede47e7c435679 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -2981,13 +2981,21 @@ config MMCONF_FAM10H
> 	depends on X86_64 && PCI_MMCONFIG && ACPI
>=20
> config PCI_CNB20LE_QUIRK
>-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
>-	depends on PCI
>+	bool "Read PCI host bridge windows from the CNB20LE chipset" if EXPERT
>+	depends on X86_32 && PCI
> 	help
> 	  Read the PCI windows out of the CNB20LE host bridge=2E This allows
> 	  PCI hotplug to work on systems with the CNB20LE chipset which do
> 	  not have ACPI=2E
>=20
>+	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
>+	  most probably only for Pentium III=2E
>+
>+	  To find out if you have such a chipset, search for a PCI device with
>+	  1166:0009 PCI IDs, for example by executing
>+		lspci -nn | grep '1166:0009'
>+	  The code is inactive if there is none=2E
>+
> 	  There's no public spec for this chipset, and this functionality
> 	  is known to be incomplete=2E
>=20


