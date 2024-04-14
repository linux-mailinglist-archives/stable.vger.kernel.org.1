Return-Path: <stable+bounces-37874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7B89D9F3
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08F81F22BFF
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5D12E1EE;
	Tue,  9 Apr 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICb93lJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB627F47E;
	Tue,  9 Apr 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668588; cv=none; b=ZGwA8gnJU9nmoQVGfeRD2Dro/s3CKaG/yscs45XFH7JUkZSkoOjoKMNFeDm4k3trgTAI2SrK0w8pjhacZ42Utb1/mHmdigWz24Dmz2BnZffwjeTkZPrYrzWLnSu/frwTgnn7zMUZRHeCGwoJVy88kEXAcCVQdFiTfrYyuGeDWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668588; c=relaxed/simple;
	bh=1KEKYPrCh4pzaS4YcpZEGSNcffHQeeo1/OdtEkkG/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CtBB2dneZ9SgsIkZZ3Xu8ttpBfIHUTU51SPLYBJBV/btkGPrEsjGYtArSq/0hyXj8N16fJb2akSWLJFqAkwxuJ+AQRp2ruYPaZfABvB3OjGz8CjlOXxOB1dSskSGBZdJcmQsz5fUu2FdRmdDQOwaiaijo3jKFf3N8iS+/rKaC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICb93lJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC4C433F1;
	Tue,  9 Apr 2024 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668588;
	bh=1KEKYPrCh4pzaS4YcpZEGSNcffHQeeo1/OdtEkkG/Mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ICb93lJL1UqGY7MM+WRH2fPhGYhVFbeQH1tGis1FYV4b19lUPmZq7/mpfN2JgVm4r
	 UY1+csojtPkjn5OJzy5aS977YymJrMAs8T+GPdKh/aEYeBfeKhpo2EXwS6pjTXaTXH
	 XtHzW8UA1RnXclMK+8efutvv0DnAZFfJ50xPVDi7phJS6jLF746HhwUXUOEwVBf0wO
	 uh1+i+I6AsKkyvWcMRWeQwaojxqjQxBRo+dFy8xQkgYsSD2VzZy2VhqAsachbwSo2e
	 oLNf1enuK2CTNzCT5Dm6CxhQ/9P3G2m2+nOOGQVVi8FWUcXcX9ZiViW+6x0m3LgRvl
	 2rbmKDZ8zeXag==
Date: Tue, 9 Apr 2024 08:16:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ricky WU <ricky_wu@realtek.com>
Cc: stable@vger.kernel.org, scott@spiteful.org, linux-pci@vger.kernel.org,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <20240409131625.GA2071261@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a608b5930d0a48f092f717c0e137454b@realtek.com>

[+cc Lukas]

On Tue, Apr 09, 2024 at 05:44:38AM +0000, Ricky WU wrote:
> Hi All,
> 
> Here is my PC info
> OS Name : Ubuntu 20.04.06 LTS
> OS Type : 64-bit
> Kernel version: 6.8.0
> System sleep support: cat /sys/power/mem_sleep 
> s2idle [deep]
> M.2 SSD1 : Kingston A2000 250GB
> M.2 SSD2 : Intel 760p 256GB
> 
> I find some problem in S3 mode maybe S2idle has the same situation. 
> The current situation is: Enter S3 mode I unplugged a correctly recognized Kingston A2000 250GB and switched it for a Intel 760p 256GB, when back to S0 there is also Kingston A2000 still installed.
> It did not call pciehp_ist(), pciehp_handle_presence_or_link_change() when back to S0, I don't know if this is the reason.

This sounds like a PCI issue, probably not an nvme issue.

> Back to S3 lspci:
> -------------------------------------------------------------------------------------------------------------------------------------------
> 00:00.0 Host bridge: Intel Corporation Device 3e0f (rev 07)
> 00:02.0 VGA compatible controller: Intel Corporation Device 3e90
> 00:12.0 Signal processing controller: Intel Corporation Cannon Lake PCH Thermal Controller (rev 10)
> 00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
> 00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
> 00:16.0 Communication controller: Intel Corporation Cannon Lake PCH HECI Controller (rev 10)
> 00:17.0 SATA controller: Intel Corporation Cannon Lake PCH SATA AHCI Controller (rev 10)
> 00:1b.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #21 (rev f0)
> 00:1c.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #5 (rev f0)
> 00:1d.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #9 (rev f0)
> 00:1d.3 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #12 (rev f0)
> 00:1f.0 ISA bridge: Intel Corporation H370 Chipset LPC/eSPI Controller (rev 10)
> 00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
> 00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
> 00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller (rev 10)
> 00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7) I219-V (rev 10)
> 04:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. Device 2263 (rev 03)
> -------------------------------------------------------------------------------------------------------------------------------------------
> 
> Dmesg Log as below(boot ->plug Kingston A2000->S3->change Kingston A2000 to Intel 760p->S0):
> 
> [    0.000000] Linux version 6.8.0 (root@cr-desktop) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #30 SMP PREEMPT_DYNAMIC Mon Apr  8 14:25:58 CST 2024
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.8.0 root=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro quiet splash resume=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 resume_offset=2172927 resumedelay=15 vt.handoff=7
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000005ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000060000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007c764fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007c765000-0x000000007dfd0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007dfd1000-0x000000007e04dfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007e04e000-0x000000007e526fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007e527000-0x000000007ed0dfff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007ed0e000-0x000000007ed0efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007ed0f000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000016dffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] e820: update [mem 0x67cec018-0x67cfc057] usable ==> usable
> [    0.000000] e820: update [mem 0x67cec018-0x67cfc057] usable ==> usable
> [    0.000000] e820: update [mem 0x67cdb018-0x67cebe57] usable ==> usable
> [    0.000000] e820: update [mem 0x67cdb018-0x67cebe57] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000005efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000005f000-0x000000000005ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000060000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000067cdb017] usable
> [    0.000000] reserve setup_data: [mem 0x0000000067cdb018-0x0000000067cebe57] usable
> [    0.000000] reserve setup_data: [mem 0x0000000067cebe58-0x0000000067cec017] usable
> [    0.000000] reserve setup_data: [mem 0x0000000067cec018-0x0000000067cfc057] usable
> [    0.000000] reserve setup_data: [mem 0x0000000067cfc058-0x000000007c764fff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007c765000-0x000000007dfd0fff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000007dfd1000-0x000000007e04dfff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000007e04e000-0x000000007e526fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000007e527000-0x000000007ed0dfff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000007ed0e000-0x000000007ed0efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007ed0f000-0x000000008fffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000016dffffff] usable
> [    0.000000] efi: EFI v2.7 by American Megatrends
> [    0.000000] efi: ACPI 2.0=0x7e468000 ACPI=0x7e468000 TPMFinalLog=0x7e4d1000 SMBIOS=0x7ea7a000 SMBIOS 3.0=0x7ea79000 MEMATTR=0x79559098 ESRT=0x7adddd18 MOKvar=0x7ea92000 RNG=0x7e04d018 TPMEventLog=0x67cfd018 
> [    0.000000] random: crng init done
> [    0.000000] efi: Remove mem44: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
> [    0.000000] efi: Not removing mem45: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
> [    0.000000] efi: Not removing mem46: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
> [    0.000000] efi: Not removing mem47: MMIO range=[0xfed00000-0xfed03fff] (16KB) from e820 map
> [    0.000000] efi: Not removing mem48: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
> [    0.000000] efi: Remove mem49: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
> [    0.000000] SMBIOS 3.1.1 present.
> [    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, BIOS P3.40 10/25/2018
> [    0.000000] tsc: Detected 3700.000 MHz processor
> [    0.000000] tsc: Detected 3699.850 MHz TSC
> [    0.000569] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000572] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000578] last_pfn = 0x16e000 max_arch_pfn = 0x400000000
> [    0.000582] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
> [    0.000584] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000964] last_pfn = 0x7ed0f max_arch_pfn = 0x400000000
> [    0.006982] found SMP MP-table at [mem 0x000fcd40-0x000fcd4f]
> [    0.006992] esrt: Reserving ESRT space from 0x000000007adddd18 to 0x000000007adddd50.
> [    0.006997] e820: update [mem 0x7addd000-0x7adddfff] usable ==> reserved
> [    0.007010] Using GB pages for direct mapping
> [    0.007366] Secure boot disabled
> [    0.007366] RAMDISK: [mem 0x67d08000-0x70f30fff]
> [    0.007370] ACPI: Early table checksum verification disabled
> [    0.007373] ACPI: RSDP 0x000000007E468000 000024 (v02 ALASKA)
> [    0.007376] ACPI: XSDT 0x000000007E4680B0 0000DC (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007381] ACPI: FACP 0x000000007E4A7808 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
> [    0.007386] ACPI: DSDT 0x000000007E468220 03F5E6 (v02 ALASKA A M I    01072009 INTL 20160527)
> [    0.007389] ACPI: FACS 0x000000007E526080 000040
> [    0.007391] ACPI: APIC 0x000000007E4A7920 000084 (v04 ALASKA A M I    01072009 AMI  00010013)
> [    0.007394] ACPI: FPDT 0x000000007E4A79A8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007397] ACPI: FIDT 0x000000007E4A79F0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007399] ACPI: MCFG 0x000000007E4A7A90 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
> [    0.007402] ACPI: SSDT 0x000000007E4A7AD0 000378 (v01 SataRe SataTabl 00001000 INTL 20160527)
> [    0.007405] ACPI: SSDT 0x000000007E4A7E48 001B1C (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
> [    0.007407] ACPI: AAFT 0x000000007E4A9968 00023D (v01 ALASKA OEMAAFT  01072009 MSFT 00000097)
> [    0.007410] ACPI: SSDT 0x000000007E4A9BA8 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
> [    0.007413] ACPI: HPET 0x000000007E4ACD70 000038 (v01 ALASKA A M I    00000002      01000013)
> [    0.007416] ACPI: SSDT 0x000000007E4ACDA8 001C01 (v02 ALASKA CflS_Rvp 00001000 INTL 20160527)
> [    0.007418] ACPI: SSDT 0x000000007E4AE9B0 002950 (v02 INTEL  xh_cfsd4 00000000 INTL 20160527)
> [    0.007421] ACPI: UEFI 0x000000007E4B1300 000042 (v01 ALASKA A M I    00000002      01000013)
> [    0.007424] ACPI: LPIT 0x000000007E4B1348 00005C (v01 ALASKA A M I    00000002      01000013)
> [    0.007426] ACPI: SSDT 0x000000007E4B13A8 0014E2 (v02 ALASKA TbtTypeC 00000000 INTL 20160527)
> [    0.007429] ACPI: DBGP 0x000000007E4B2890 000034 (v01 ALASKA A M I    00000002      01000013)
> [    0.007432] ACPI: DBG2 0x000000007E4B28C8 000054 (v00 ALASKA A M I    00000002      01000013)
> [    0.007434] ACPI: SSDT 0x000000007E4B2920 001B67 (v02 ALASKA UsbCTabl 00001000 INTL 20160527)
> [    0.007437] ACPI: SSDT 0x000000007E4B4488 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
> [    0.007439] ACPI: DMAR 0x000000007E4B45D0 0000A8 (v01 INTEL  EDK2     00000002      01000013)
> [    0.007442] ACPI: BGRT 0x000000007E4B4678 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007445] ACPI: TPM2 0x000000007E4B46B0 000034 (v04 ALASKA A M I    00000001 AMI  00000000)
> [    0.007447] ACPI: WSMT 0x000000007E4B46E8 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007450] ACPI: Reserving FACP table memory at [mem 0x7e4a7808-0x7e4a791b]
> [    0.007451] ACPI: Reserving DSDT table memory at [mem 0x7e468220-0x7e4a7805]
> [    0.007452] ACPI: Reserving FACS table memory at [mem 0x7e526080-0x7e5260bf]
> [    0.007452] ACPI: Reserving APIC table memory at [mem 0x7e4a7920-0x7e4a79a3]
> [    0.007453] ACPI: Reserving FPDT table memory at [mem 0x7e4a79a8-0x7e4a79eb]
> [    0.007454] ACPI: Reserving FIDT table memory at [mem 0x7e4a79f0-0x7e4a7a8b]
> [    0.007454] ACPI: Reserving MCFG table memory at [mem 0x7e4a7a90-0x7e4a7acb]
> [    0.007455] ACPI: Reserving SSDT table memory at [mem 0x7e4a7ad0-0x7e4a7e47]
> [    0.007456] ACPI: Reserving SSDT table memory at [mem 0x7e4a7e48-0x7e4a9963]
> [    0.007456] ACPI: Reserving AAFT table memory at [mem 0x7e4a9968-0x7e4a9ba4]
> [    0.007457] ACPI: Reserving SSDT table memory at [mem 0x7e4a9ba8-0x7e4acd6d]
> [    0.007458] ACPI: Reserving HPET table memory at [mem 0x7e4acd70-0x7e4acda7]
> [    0.007458] ACPI: Reserving SSDT table memory at [mem 0x7e4acda8-0x7e4ae9a8]
> [    0.007459] ACPI: Reserving SSDT table memory at [mem 0x7e4ae9b0-0x7e4b12ff]
> [    0.007460] ACPI: Reserving UEFI table memory at [mem 0x7e4b1300-0x7e4b1341]
> [    0.007460] ACPI: Reserving LPIT table memory at [mem 0x7e4b1348-0x7e4b13a3]
> [    0.007461] ACPI: Reserving SSDT table memory at [mem 0x7e4b13a8-0x7e4b2889]
> [    0.007462] ACPI: Reserving DBGP table memory at [mem 0x7e4b2890-0x7e4b28c3]
> [    0.007462] ACPI: Reserving DBG2 table memory at [mem 0x7e4b28c8-0x7e4b291b]
> [    0.007463] ACPI: Reserving SSDT table memory at [mem 0x7e4b2920-0x7e4b4486]
> [    0.007464] ACPI: Reserving SSDT table memory at [mem 0x7e4b4488-0x7e4b45cb]
> [    0.007464] ACPI: Reserving DMAR table memory at [mem 0x7e4b45d0-0x7e4b4677]
> [    0.007465] ACPI: Reserving BGRT table memory at [mem 0x7e4b4678-0x7e4b46af]
> [    0.007466] ACPI: Reserving TPM2 table memory at [mem 0x7e4b46b0-0x7e4b46e3]
> [    0.007466] ACPI: Reserving WSMT table memory at [mem 0x7e4b46e8-0x7e4b470f]
> [    0.007743] No NUMA configuration found
> [    0.007744] Faking a node at [mem 0x0000000000000000-0x000000016dffffff]
> [    0.007751] NODE_DATA(0) allocated [mem 0x16dfd5000-0x16dffffff]
> [    0.007886] Zone ranges:
> [    0.007887]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.007888]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.007890]   Normal   [mem 0x0000000100000000-0x000000016dffffff]
> [    0.007891]   Device   empty
> [    0.007892] Movable zone start for each node
> [    0.007894] Early memory node ranges
> [    0.007894]   node   0: [mem 0x0000000000001000-0x000000000005efff]
> [    0.007896]   node   0: [mem 0x0000000000060000-0x000000000009ffff]
> [    0.007896]   node   0: [mem 0x0000000000100000-0x000000007c764fff]
> [    0.007897]   node   0: [mem 0x000000007ed0e000-0x000000007ed0efff]
> [    0.007898]   node   0: [mem 0x0000000100000000-0x000000016dffffff]
> [    0.007899] Initmem setup node 0 [mem 0x0000000000001000-0x000000016dffffff]
> [    0.007902] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.007903] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.007923] On node 0, zone DMA: 96 pages in unavailable ranges
> [    0.012542] On node 0, zone DMA32: 9641 pages in unavailable ranges
> [    0.016729] On node 0, zone Normal: 4849 pages in unavailable ranges
> [    0.016857] On node 0, zone Normal: 8192 pages in unavailable ranges
> [    0.016875] Reserving Intel graphics memory at [mem 0x80000000-0x8fffffff]
> [    0.017335] ACPI: PM-Timer IO Port: 0x1808
> [    0.017341] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.017342] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.017343] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.017344] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.017405] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.017407] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.017409] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.017413] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.017414] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.017419] e820: update [mem 0x78a53000-0x78a93fff] usable ==> reserved
> [    0.017429] TSC deadline timer available
> [    0.017430] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.017441] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.017443] PM: hibernation: Registered nosave memory: [mem 0x0005f000-0x0005ffff]
> [    0.017444] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.017445] PM: hibernation: Registered nosave memory: [mem 0x67cdb000-0x67cdbfff]
> [    0.017447] PM: hibernation: Registered nosave memory: [mem 0x67ceb000-0x67cebfff]
> [    0.017447] PM: hibernation: Registered nosave memory: [mem 0x67cec000-0x67cecfff]
> [    0.017449] PM: hibernation: Registered nosave memory: [mem 0x67cfc000-0x67cfcfff]
> [    0.017450] PM: hibernation: Registered nosave memory: [mem 0x78a53000-0x78a93fff]
> [    0.017451] PM: hibernation: Registered nosave memory: [mem 0x7addd000-0x7adddfff]
> [    0.017452] PM: hibernation: Registered nosave memory: [mem 0x7c765000-0x7dfd0fff]
> [    0.017453] PM: hibernation: Registered nosave memory: [mem 0x7dfd1000-0x7e04dfff]
> [    0.017454] PM: hibernation: Registered nosave memory: [mem 0x7e04e000-0x7e526fff]
> [    0.017454] PM: hibernation: Registered nosave memory: [mem 0x7e527000-0x7ed0dfff]
> [    0.017455] PM: hibernation: Registered nosave memory: [mem 0x7ed0f000-0x8fffffff]
> [    0.017456] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfdffffff]
> [    0.017457] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.017457] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> [    0.017458] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.017458] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
> [    0.017459] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
> [    0.017459] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfedfffff]
> [    0.017460] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.017460] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
> [    0.017462] [mem 0x90000000-0xfdffffff] available for PCI devices
> [    0.017463] Booting paravirtualized kernel on bare hardware
> [    0.017465] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.017470] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.017929] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u524288
> [    0.017934] pcpu-alloc: s225280 r8192 d28672 u524288 alloc=1*2097152
> [    0.017936] pcpu-alloc: [0] 0 1 2 3 
> [    0.017953] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.8.0 root=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro quiet splash resume=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 resume_offset=2172927 resumedelay=15 vt.handoff=7
> [    0.018044] Unknown kernel command line parameters "splash BOOT_IMAGE=/boot/vmlinuz-6.8.0", will be passed to user space.
> [    0.018648] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.018930] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.018995] Fallback order for Node 0: 0 
> [    0.018998] Built 1 zonelists, mobility grouping on.  Total pages: 945096
> [    0.018999] Policy zone: Normal
> [    0.019003] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.019010] software IO TLB: area num 4.
> [    0.048669] Memory: 3464128K/3841040K available (18432K kernel code, 3225K rwdata, 7212K rodata, 4580K init, 4312K bss, 376652K reserved, 0K cma-reserved)
> [    0.048874] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.048885] Kernel/User page tables isolation: enabled
> [    0.048912] ftrace: allocating 53981 entries in 211 pages
> [    0.056577] ftrace: allocated 211 pages with 5 groups
> [    0.057207] Dynamic Preempt: voluntary
> [    0.057236] rcu: Preemptible hierarchical RCU implementation.
> [    0.057237] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.057238] 	Trampoline variant of Tasks RCU enabled.
> [    0.057239] 	Rude variant of Tasks RCU enabled.
> [    0.057239] 	Tracing variant of Tasks RCU enabled.
> [    0.057239] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.057240] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.059780] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> [    0.060068] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.060424] Console: colour dummy device 80x25
> [    0.060426] printk: legacy console [tty0] enabled
> [    0.060464] ACPI: Core revision 20230628
> [    0.060875] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    0.061032] APIC: Switch to symmetric I/O mode setup
> [    0.061034] DMAR: Host address width 39
> [    0.061035] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.061040] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.061042] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.061045] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.061047] DMAR: RMRR base: 0x0000007e809000 end: 0x0000007ea52fff
> [    0.061048] DMAR: RMRR base: 0x0000007f800000 end: 0x0000008fffffff
> [    0.061050] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.061051] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.061051] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.064470] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.064472] x2apic enabled
> [    0.064535] APIC: Switched APIC routing to: cluster x2apic
> [    0.073916] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.092939] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6aa99074b1c, max_idle_ns: 881590506587 ns
> [    0.092944] Calibrating delay loop (skipped), value calculated using timer frequency.. 7399.70 BogoMIPS (lpj=14799400)
> [    0.092963] x86/cpu: SGX disabled by BIOS.
> [    0.092969] CPU0: Thermal monitoring enabled (TM1)
> [    0.093005] process: using mwait in idle threads
> [    0.093007] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.093008] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.093011] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.093013] Spectre V2 : Mitigation: IBRS
> [    0.093014] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.093015] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> [    0.093015] RETBleed: Mitigation: IBRS
> [    0.093017] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.093018] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.093019] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.093024] MDS: Mitigation: Clear CPU buffers
> [    0.093025] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    0.093029] SRBDS: Mitigation: Microcode
> [    0.093034] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.093035] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.093036] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.093037] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.093039] x86/fpu: xstate_offset[3]:  576, xstate_sizes[3]:   64
> [    0.093040] x86/fpu: xstate_offset[4]:  640, xstate_sizes[4]:   64
> [    0.093041] x86/fpu: Enabled xstate features 0x1b, context size is 704 bytes, using 'compacted' format.
> [    0.121725] Freeing SMP alternatives memory: 44K
> [    0.121729] pid_max: default: 32768 minimum: 301
> [    0.124293] LSM: initializing lsm=lockdown,capability,yama,apparmor,integrity
> [    0.124307] Yama: becoming mindful.
> [    0.124340] AppArmor: AppArmor initialized
> [    0.124372] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    0.124378] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    0.124847] smpboot: CPU0: Intel(R) Pentium(R) Gold G5400 CPU @ 3.70GHz (family: 0x6, model: 0x9e, stepping: 0xa)
> [    0.124941] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.124941] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.124941] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.124941] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.124941] ... version:                4
> [    0.124941] ... bit width:              48
> [    0.124941] ... generic registers:      4
> [    0.124941] ... value mask:             0000ffffffffffff
> [    0.124941] ... max period:             00007fffffffffff
> [    0.124941] ... fixed-purpose events:   3
> [    0.124941] ... event mask:             000000070000000f
> [    0.124941] signal: max sigframe size: 2032
> [    0.124941] Estimated ratio of average max frequency by base frequency (times 1024): 1024
> [    0.124941] rcu: Hierarchical SRCU implementation.
> [    0.124941] rcu: 	Max phase no-delay instances is 1000.
> [    0.124941] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.124941] smp: Bringing up secondary CPUs ...
> [    0.124941] smpboot: x86: Booting SMP configuration:
> [    0.124941] .... node  #0, CPUs:      #1 #2 #3
> [    0.125036] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.125036] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
> [    0.125036] smp: Brought up 1 node, 4 CPUs
> [    0.125036] smpboot: Max logical packages: 1
> [    0.125036] smpboot: Total of 4 processors activated (29598.80 BogoMIPS)
> [    0.126698] devtmpfs: initialized
> [    0.126698] x86/mm: Memory block size: 128MB
> [    0.126698] ACPI: PM: Registering ACPI NVS region [mem 0x7e04e000-0x7e526fff] (5083136 bytes)
> [    0.126698] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.126698] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.126698] pinctrl core: initialized pinctrl subsystem
> [    0.126698] PM: RTC time: 20:41:21, date: 2024-04-08
> [    0.126698] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.126698] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
> [    0.126698] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.128994] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.129014] audit: initializing netlink subsys (disabled)
> [    0.129023] audit: type=2000 audit(1712608881.060:1): state=initialized audit_enabled=0 res=1
> [    0.129066] thermal_sys: Registered thermal governor 'fair_share'
> [    0.129067] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.129068] thermal_sys: Registered thermal governor 'step_wise'
> [    0.129069] thermal_sys: Registered thermal governor 'user_space'
> [    0.129070] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.129076] EISA bus registered
> [    0.129085] cpuidle: using governor ladder
> [    0.129089] cpuidle: using governor menu
> [    0.129023] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.129121] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.129125] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
> [    0.129127] PCI: Using configuration type 1 for base access
> [    0.129243] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.129243] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.129243] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.129243] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.129243] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.129243] fbcon: Taking over console
> [    0.129243] ACPI: Added _OSI(Module Device)
> [    0.129243] ACPI: Added _OSI(Processor Device)
> [    0.129243] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.129243] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.204834] ACPI: 9 ACPI AML tables successfully acquired and loaded
> [    0.217305] ACPI: Dynamic OEM Table Load:
> [    0.217312] ACPI: SSDT 0xFFFF8F8D802FD000 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> [    0.219074] ACPI: Dynamic OEM Table Load:
> [    0.219079] ACPI: SSDT 0xFFFF8F8D80CBB000 0006CB (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
> [    0.220930] ACPI: Dynamic OEM Table Load:
> [    0.220934] ACPI: SSDT 0xFFFF8F8D80D51100 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20160527)
> [    0.222906] ACPI: Dynamic OEM Table Load:
> [    0.222912] ACPI: SSDT 0xFFFF8F8D80CBD000 0005FC (v02 PmRef  ApIst    00003000 INTL 20160527)
> [    0.224911] ACPI: Dynamic OEM Table Load:
> [    0.224918] ACPI: SSDT 0xFFFF8F8D80164000 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20160527)
> [    0.227368] ACPI: Dynamic OEM Table Load:
> [    0.227373] ACPI: SSDT 0xFFFF8F8D802FC400 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
> [    0.231078] ACPI: _OSC evaluated successfully for all CPUs
> [    0.232407] ACPI: Interpreter enabled
> [    0.232441] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.232443] ACPI: Using IOAPIC for interrupt routing
> [    0.232557] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.234390] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
> [    0.234401] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.234402] PCI: Using E820 reservations for host bridge windows
> [    0.235868] ACPI: Enabled 9 GPEs in block 00 to 7F
> [    0.253437] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
> [    0.253626] ACPI: \_SB_.PCI0.PAUD: New power resource
> [    0.257492] ACPI: \SPR2: New power resource
> [    0.257844] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
> [    0.258294] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
> [    0.258734] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
> [    0.265560] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
> [    0.273523] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
> [    0.280011] ACPI: \PIN_: New power resource
> [    0.280212] ACPI: \SPR0: New power resource
> [    0.280276] ACPI: \SPR1: New power resource
> [    0.280338] ACPI: \SPR3: New power resource
> [    0.280403] ACPI: \SPR5: New power resource
> [    0.280755] ACPI: \ZPDR: New power resource
> [    0.281265] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    0.281271] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.284463] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> [    0.285976] PCI host bridge to bus 0000:00
> [    0.285978] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.285980] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.285981] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.285983] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdfffffff window]
> [    0.285984] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> [    0.285986] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    0.286079] pci 0000:00:00.0: [8086:3e0f] type 00 class 0x060000 conventional PCI endpoint
> [    0.286170] pci 0000:00:02.0: [8086:3e90] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
> [    0.286178] pci 0000:00:02.0: BAR 0 [mem 0xa2000000-0xa2ffffff 64bit]
> [    0.286183] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.286187] pci 0000:00:02.0: BAR 4 [io  0x6000-0x603f]
> [    0.286200] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    0.286203] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.286575] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 conventional PCI endpoint
> [    0.286601] pci 0000:00:12.0: BAR 0 [mem 0xa4f3d000-0xa4f3dfff 64bit]
> [    0.286830] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 conventional PCI endpoint
> [    0.286857] pci 0000:00:14.0: BAR 0 [mem 0xa4f20000-0xa4f2ffff 64bit]
> [    0.286959] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.288441] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 conventional PCI endpoint
> [    0.288464] pci 0000:00:14.2: BAR 0 [mem 0xa4f36000-0xa4f37fff 64bit]
> [    0.288479] pci 0000:00:14.2: BAR 2 [mem 0xa4f3c000-0xa4f3cfff 64bit]
> [    0.288655] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 conventional PCI endpoint
> [    0.288679] pci 0000:00:16.0: BAR 0 [mem 0xa4f3b000-0xa4f3bfff 64bit]
> [    0.288766] pci 0000:00:16.0: PME# supported from D3hot
> [    0.289286] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 conventional PCI endpoint
> [    0.289307] pci 0000:00:17.0: BAR 0 [mem 0xa4f34000-0xa4f35fff]
> [    0.289319] pci 0000:00:17.0: BAR 1 [mem 0xa4f3a000-0xa4f3a0ff]
> [    0.289330] pci 0000:00:17.0: BAR 2 [io  0x6090-0x6097]
> [    0.289341] pci 0000:00:17.0: BAR 3 [io  0x6080-0x6083]
> [    0.289353] pci 0000:00:17.0: BAR 4 [io  0x6060-0x607f]
> [    0.289364] pci 0000:00:17.0: BAR 5 [mem 0xa4f39000-0xa4f397ff]
> [    0.289427] pci 0000:00:17.0: PME# supported from D3hot
> [    0.289970] pci 0000:00:1b.0: [8086:a32c] type 01 class 0x060400 PCIe Root Port
> [    0.290013] pci 0000:00:1b.0: PCI bridge to [bus 01]
> [    0.290019] pci 0000:00:1b.0:   bridge window [io  0x5000-0x5fff]
> [    0.290023] pci 0000:00:1b.0:   bridge window [mem 0xa4500000-0xa4efffff]
> [    0.290038] pci 0000:00:1b.0:   bridge window [mem 0xa1400000-0xa1dfffff 64bit pref]
> [    0.290141] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.290178] pci 0000:00:1b.0: PTM enabled (root), 4ns granularity
> [    0.290913] pci 0000:00:1c.0: [8086:a33c] type 01 class 0x060400 PCIe Root Port
> [    0.290956] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.290962] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
> [    0.290966] pci 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
> [    0.290980] pci 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
> [    0.291084] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.291127] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
> [    0.291874] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Root Port
> [    0.291915] pci 0000:00:1d.0: PCI bridge to [bus 03]
> [    0.292021] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.292724] pci 0000:00:1d.3: [8086:a333] type 01 class 0x060400 PCIe Root Port
> [    0.292767] pci 0000:00:1d.3: PCI bridge to [bus 04]
> [    0.292773] pci 0000:00:1d.3:   bridge window [io  0x3000-0x3fff]
> [    0.292777] pci 0000:00:1d.3:   bridge window [mem 0xa3100000-0xa3afffff]
> [    0.292791] pci 0000:00:1d.3:   bridge window [mem 0xa0000000-0xa09fffff 64bit pref]
> [    0.292902] pci 0000:00:1d.3: PME# supported from D0 D3hot D3cold
> [    0.292950] pci 0000:00:1d.3: PTM enabled (root), 4ns granularity
> [    0.293667] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 conventional PCI endpoint
> [    0.294210] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 conventional PCI endpoint
> [    0.294270] pci 0000:00:1f.3: BAR 0 [mem 0xa4f30000-0xa4f33fff 64bit]
> [    0.294354] pci 0000:00:1f.3: BAR 4 [mem 0xa3000000-0xa30fffff 64bit]
> [    0.294494] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.297344] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.297388] pci 0000:00:1f.4: BAR 0 [mem 0xa4f38000-0xa4f380ff 64bit]
> [    0.297440] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
> [    0.297782] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 conventional PCI endpoint
> [    0.297802] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
> [    0.297972] pci 0000:00:1f.6: [8086:15bc] type 00 class 0x020000 conventional PCI endpoint
> [    0.298017] pci 0000:00:1f.6: BAR 0 [mem 0xa4f00000-0xa4f1ffff]
> [    0.298251] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> [    0.298447] pci 0000:00:1b.0: PCI bridge to [bus 01]
> [    0.298557] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.298666] acpiphp: Slot [1] registered
> [    0.298679] pci 0000:00:1d.0: PCI bridge to [bus 03]
> [    0.298786] pci 0000:00:1d.3: PCI bridge to [bus 04]
> [    0.300193] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
> [    0.300279] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
> [    0.300362] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
> [    0.300445] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
> [    0.300528] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    0.300610] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
> [    0.300693] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [    0.300775] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
> [    0.307402] iommu: Default domain type: Translated
> [    0.307402] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.307402] SCSI subsystem initialized
> [    0.307402] libata version 3.00 loaded.
> [    0.307402] ACPI: bus type USB registered
> [    0.307402] usbcore: registered new interface driver usbfs
> [    0.307402] usbcore: registered new interface driver hub
> [    0.307402] usbcore: registered new device driver usb
> [    0.307402] pps_core: LinuxPPS API ver. 1 registered
> [    0.307402] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.307402] PTP clock support registered
> [    0.307402] EDAC MC: Ver: 3.0.0
> [    0.307402] efivars: Registered efivars operations
> [    0.307402] NetLabel: Initializing
> [    0.307402] NetLabel:  domain hash size = 128
> [    0.307402] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.307402] NetLabel:  unlabeled traffic allowed by default
> [    0.307402] PCI: Using ACPI for IRQ routing
> [    0.387885] PCI: pci_cache_line_size set to 64 bytes
> [    0.387962] e820: reserve RAM buffer [mem 0x0005f000-0x0005ffff]
> [    0.387964] e820: reserve RAM buffer [mem 0x67cdb018-0x67ffffff]
> [    0.387965] e820: reserve RAM buffer [mem 0x67cec018-0x67ffffff]
> [    0.387966] e820: reserve RAM buffer [mem 0x78a53000-0x7bffffff]
> [    0.387967] e820: reserve RAM buffer [mem 0x7addd000-0x7bffffff]
> [    0.387968] e820: reserve RAM buffer [mem 0x7c765000-0x7fffffff]
> [    0.387969] e820: reserve RAM buffer [mem 0x7ed0f000-0x7fffffff]
> [    0.387970] e820: reserve RAM buffer [mem 0x16e000000-0x16fffffff]
> [    0.388946] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.388948] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.388949] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.388953] vgaarb: loaded
> [    0.389019] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.389026] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    0.392953] clocksource: Switched to clocksource tsc-early
> [    0.392953] VFS: Disk quotas dquot_6.6.0
> [    0.392953] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.392953] AppArmor: AppArmor Filesystem Enabled
> [    0.392953] pnp: PnP ACPI init
> [    0.392953] system 00:00: [io  0x0280-0x028f] has been reserved
> [    0.392953] system 00:00: [io  0x0290-0x029f] has been reserved
> [    0.392953] system 00:00: [io  0x02a0-0x02af] has been reserved
> [    0.392953] system 00:00: [io  0x02b0-0x02bf] has been reserved
> [    0.392953] pnp 00:01: [dma 0 disabled]
> [    0.392953] system 00:02: [io  0x0680-0x069f] has been reserved
> [    0.392953] system 00:02: [io  0x164e-0x164f] has been reserved
> [    0.392953] system 00:03: [io  0x1854-0x1857] has been reserved
> [    0.392953] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.392953] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.392953] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.392953] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.392953] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.392953] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.392953] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.392953] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.392953] system 00:05: [io  0x1800-0x18fe] could not be reserved
> [    0.392953] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
> [    0.392953] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
> [    0.392953] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
> [    0.392953] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.392953] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
> [    0.392953] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> [    0.392953] system 00:06: [io  0x2000-0x20fe] has been reserved
> [    0.392953] system 00:07: [mem 0xfd6e0000-0xfd6effff] has been reserved
> [    0.392953] system 00:07: [mem 0xfd6d0000-0xfd6dffff] has been reserved
> [    0.392953] system 00:07: [mem 0xfd6b0000-0xfd6bffff] has been reserved
> [    0.392953] system 00:07: [mem 0xfd6a0000-0xfd6affff] has been reserved
> [    0.397330] pnp: PnP ACPI: found 9 devices
> [    0.403152] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.403263] NET: Registered PF_INET protocol family
> [    0.403305] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.403921] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    0.403940] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.403965] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.404035] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
> [    0.404127] TCP: Hash tables configured (established 32768 bind 32768)
> [    0.404171] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
> [    0.404187] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
> [    0.404196] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
> [    0.404226] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.404232] NET: Registered PF_XDP protocol family
> [    0.404242] pci 0000:00:1b.0: PCI bridge to [bus 01]
> [    0.404255] pci 0000:00:1b.0:   bridge window [io  0x5000-0x5fff]
> [    0.404261] pci 0000:00:1b.0:   bridge window [mem 0xa4500000-0xa4efffff]
> [    0.404265] pci 0000:00:1b.0:   bridge window [mem 0xa1400000-0xa1dfffff 64bit pref]
> [    0.404272] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.404275] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
> [    0.404280] pci 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
> [    0.404285] pci 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
> [    0.404292] pci 0000:00:1d.0: PCI bridge to [bus 03]
> [    0.404306] pci 0000:00:1d.3: PCI bridge to [bus 04]
> [    0.404309] pci 0000:00:1d.3:   bridge window [io  0x3000-0x3fff]
> [    0.404314] pci 0000:00:1d.3:   bridge window [mem 0xa3100000-0xa3afffff]
> [    0.404318] pci 0000:00:1d.3:   bridge window [mem 0xa0000000-0xa09fffff 64bit pref]
> [    0.404326] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.404328] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.404329] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.404330] pci_bus 0000:00: resource 7 [mem 0x90000000-0xdfffffff window]
> [    0.404332] pci_bus 0000:00: resource 8 [mem 0xfc800000-0xfe7fffff window]
> [    0.404333] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
> [    0.404334] pci_bus 0000:01: resource 1 [mem 0xa4500000-0xa4efffff]
> [    0.404336] pci_bus 0000:01: resource 2 [mem 0xa1400000-0xa1dfffff 64bit pref]
> [    0.404337] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
> [    0.404338] pci_bus 0000:02: resource 1 [mem 0xa3b00000-0xa44fffff]
> [    0.404339] pci_bus 0000:02: resource 2 [mem 0xa0a00000-0xa13fffff 64bit pref]
> [    0.404341] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
> [    0.404342] pci_bus 0000:04: resource 1 [mem 0xa3100000-0xa3afffff]
> [    0.404343] pci_bus 0000:04: resource 2 [mem 0xa0000000-0xa09fffff 64bit pref]
> [    0.405350] PCI: CLS 64 bytes, default 64
> [    0.405367] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.405368] software IO TLB: mapped [mem 0x0000000074a53000-0x0000000078a53000] (64MB)
> [    0.405402] Trying to unpack rootfs image as initramfs...
> [    0.408717] platform rtc_cmos: registered platform RTC device (no PNP device found)
> [    0.409329] Initialise system trusted keyrings
> [    0.409340] Key type blacklist registered
> [    0.409414] workingset: timestamp_bits=36 max_order=20 bucket_order=0
> [    0.409425] zbud: loaded
> [    0.409724] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.409829] fuse: init (API version 7.39)
> [    0.409966] integrity: Platform Keyring initialized
> [    0.424763] Key type asymmetric registered
> [    0.424767] Asymmetric key parser 'x509' registered
> [    0.424793] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [    0.424858] io scheduler mq-deadline registered
> [    0.425417] pcieport 0000:00:1b.0: PME: Signaling with IRQ 122
> [    0.425472] pcieport 0000:00:1b.0: pciehp: Slot #24 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.425920] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
> [    0.425968] pcieport 0000:00:1c.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.426240] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
> [    0.426604] pcieport 0000:00:1d.3: PME: Signaling with IRQ 125
> [    0.426651] pcieport 0000:00:1d.3: pciehp: Slot #15 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.426889] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.428539] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> [    0.428580] ACPI: button: Sleep Button [SLPB]
> [    0.428623] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    0.428658] ACPI: button: Power Button [PWRB]
> [    0.428704] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    0.428758] ACPI: button: Power Button [PWRF]
> [    0.429339] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    0.451391] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.457017] Linux agpgart interface v0.103
> [    0.467644] loop: module loaded
> [    0.468054] tun: Universal TUN/TAP device driver, 1.6
> [    0.468123] PPP generic driver version 2.4.2
> [    0.468343] VFIO - User Level meta-driver version: 0.3
> [    0.468474] i8042: PNP: No PS/2 controller found.
> [    0.468556] mousedev: PS/2 mouse device common for all mice
> [    0.468715] rtc_cmos rtc_cmos: RTC can wake from S4
> [    0.470316] rtc_cmos rtc_cmos: registered as rtc0
> [    0.470633] rtc_cmos rtc_cmos: setting system clock to 2024-04-08T20:41:22 UTC (1712608882)
> [    0.470675] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
> [    0.470686] i2c_dev: i2c /dev entries driver
> [    0.470759] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [    0.470773] device-mapper: uevent: version 1.0.3
> [    0.470817] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
> [    0.470848] platform eisa.0: Probing EISA bus 0
> [    0.470851] platform eisa.0: EISA: Cannot allocate resource for mainboard
> [    0.470853] platform eisa.0: Cannot allocate resource for EISA slot 1
> [    0.470854] platform eisa.0: Cannot allocate resource for EISA slot 2
> [    0.470856] platform eisa.0: Cannot allocate resource for EISA slot 3
> [    0.470858] platform eisa.0: Cannot allocate resource for EISA slot 4
> [    0.470859] platform eisa.0: Cannot allocate resource for EISA slot 5
> [    0.470861] platform eisa.0: Cannot allocate resource for EISA slot 6
> [    0.470862] platform eisa.0: Cannot allocate resource for EISA slot 7
> [    0.470864] platform eisa.0: Cannot allocate resource for EISA slot 8
> [    0.470865] platform eisa.0: EISA: Detected 0 cards
> [    0.470868] intel_pstate: Intel P-state driver initializing
> [    0.471134] intel_pstate: Disabling energy efficiency optimization
> [    0.471135] intel_pstate: HWP enabled
> [    0.471231] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.471261] efifb: probing for efifb
> [    0.471282] efifb: showing boot graphics
> [    0.472356] efifb: framebuffer at 0x90000000, using 8100k, total 8100k
> [    0.472359] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [    0.472361] efifb: scrolling: redraw
> [    0.472362] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.472508] Console: switching to colour frame buffer device 240x67
> [    0.474661] fb0: EFI VGA frame buffer device
> [    0.474815] drop_monitor: Initializing network drop monitor service
> [    0.474926] NET: Registered PF_INET6 protocol family
> [    0.782617] Freeing initrd memory: 149668K
> [    0.789019] Segment Routing with IPv6
> [    0.789032] In-situ OAM (IOAM) with IPv6
> [    0.789070] NET: Registered PF_PACKET protocol family
> [    0.789161] Key type dns_resolver registered
> [    0.789588] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.789686] microcode: Current revision: 0x000000f4
> [    0.789687] microcode: Updated early from: 0x00000096
> [    0.789830] IPI shorthand broadcast: enabled
> [    0.791749] sched_clock: Marking stable (781258941, 8557784)->(794638026, -4821301)
> [    0.791916] registered taskstats version 1
> [    0.792047] Loading compiled-in X.509 certificates
> [    0.792520] Loaded X.509 cert 'Build time autogenerated kernel key: 8b7471cc9a0f57660f75ca5499023b7650454f8d'
> [    0.794869] Key type .fscrypt registered
> [    0.794870] Key type fscrypt-provisioning registered
> [    0.794918] Key type trusted registered
> [    0.809365] Key type encrypted registered
> [    0.809370] AppArmor: AppArmor sha256 policy hashing enabled
> [    0.810322] integrity: Loading X.509 certificate: UEFI:db
> [    0.810350] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [    0.810351] integrity: Loading X.509 certificate: UEFI:db
> [    0.810366] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [    0.811113] Loading compiled-in module X.509 certificates
> [    0.811556] Loaded X.509 cert 'Build time autogenerated kernel key: 8b7471cc9a0f57660f75ca5499023b7650454f8d'
> [    0.811558] ima: Allocated hash algorithm: sha1
> [    0.840837] ima: No architecture policies found
> [    0.840878] evm: Initialising EVM extended attributes:
> [    0.840880] evm: security.selinux
> [    0.840885] evm: security.SMACK64
> [    0.840888] evm: security.SMACK64EXEC
> [    0.840891] evm: security.SMACK64TRANSMUTE
> [    0.840894] evm: security.SMACK64MMAP
> [    0.840897] evm: security.apparmor
> [    0.840900] evm: security.ima
> [    0.840903] evm: security.capability
> [    0.840906] evm: HMAC attrs: 0x1
> [    0.841814] PM:   Magic number: 4:842:699
> [    0.841898] acpi LNXCPU:0d: hash matches
> [    0.842475] RAS: Correctable Errors collector initialized.
> [    0.842498] PM: hibernation: Waiting 15sec before reading resume device ...
> [    1.412662] tsc: Refined TSC clocksource calibration: 3696.002 MHz
> [    1.412682] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a8d2ad56ed, max_idle_ns: 881591064802 ns
> [    1.412758] clocksource: Switched to clocksource tsc
> [   15.908715] clk: Disabling unused clocks
> [   15.912586] Freeing unused decrypted memory: 2028K
> [   15.914552] Freeing unused kernel image (initmem) memory: 4580K
> [   15.924674] Write protecting the kernel read-only data: 26624k
> [   15.925123] Freeing unused kernel image (rodata/data gap) memory: 980K
> [   15.977580] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   15.977582] x86/mm: Checking user space page tables
> [   16.017472] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   16.017477] Run /init as init process
> [   16.017478]   with arguments:
> [   16.017479]     /init
> [   16.017480]     splash
> [   16.017481]   with environment:
> [   16.017482]     HOME=/
> [   16.017482]     TERM=linux
> [   16.017483]     BOOT_IMAGE=/boot/vmlinuz-6.8.0
> [   16.170300] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   16.171573] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [   16.172727] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
> [   16.173265] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   16.173271] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [   16.173275] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> [   16.173339] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> [   16.173343] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   16.173345] usb usb1: Product: xHCI Host Controller
> [   16.173347] usb usb1: Manufacturer: Linux 6.8.0 xhci-hcd
> [   16.173349] usb usb1: SerialNumber: 0000:00:14.0
> [   16.173641] hub 1-0:1.0: USB hub found
> [   16.173679] hub 1-0:1.0: 16 ports detected
> [   16.178278] e1000e: Intel(R) PRO/1000 Network Driver
> [   16.178280] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   16.179081] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
> [   16.179085] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   16.179087] usb usb2: Product: xHCI Host Controller
> [   16.179089] usb usb2: Manufacturer: Linux 6.8.0 xhci-hcd
> [   16.179091] usb usb2: SerialNumber: 0000:00:14.0
> [   16.179385] ahci 0000:00:17.0: version 3.0
> [   16.179740] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   16.179899] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> [   16.179904] ahci 0000:00:17.0: flags: 64bit ncq sntf clo only pio slum part ems deso sadm sds apst 
> [   16.182014] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   16.191840] hub 2-0:1.0: USB hub found
> [   16.192490] i2c i2c-0: 1/4 memory slots populated (from DMI)
> [   16.192585] hub 2-0:1.0: 8 ports detected
> [   16.193275] i2c i2c-0: Successfully instantiated SPD at 0x51
> [   16.237227] scsi host0: ahci
> [   16.237441] scsi host1: ahci
> [   16.237612] scsi host2: ahci
> [   16.237795] scsi host3: ahci
> [   16.237927] scsi host4: ahci
> [   16.238094] scsi host5: ahci
> [   16.238148] ata1: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39100 irq 131 lpm-pol 0
> [   16.238151] ata2: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39180 irq 131 lpm-pol 0
> [   16.238154] ata3: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39200 irq 131 lpm-pol 0
> [   16.238157] ata4: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39280 irq 131 lpm-pol 0
> [   16.238160] ata5: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39300 irq 131 lpm-pol 0
> [   16.238162] ata6: SATA max UDMA/133 abar m2048@0xa4f39000 port 0xa4f39380 irq 131 lpm-pol 0
> [   16.392898] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [   16.432643] usb 1-7: new low-speed USB device number 2 using xhci_hcd
> [   16.463479] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 70:85:c2:a4:19:95
> [   16.463497] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [   16.463712] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: FFFFFF-0FF
> [   16.552119] ata5: SATA link down (SStatus 4 SControl 300)
> [   16.552171] ata6: SATA link down (SStatus 4 SControl 300)
> [   16.552224] ata2: SATA link down (SStatus 4 SControl 300)
> [   16.552274] ata1: SATA link down (SStatus 4 SControl 300)
> [   16.552330] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   16.552377] ata4: SATA link down (SStatus 4 SControl 300)
> [   16.558591] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
> [   16.558607] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
> [   16.561746] ata3.00: ATA-11: WDC  WDS250G2B0A-00SM50, 401020WD, max UDMA/133
> [   16.564786] ata3.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [   16.566382] ata3.00: Features: Dev-Sleep
> [   16.572793] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
> [   16.572809] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
> [   16.581110] ata3.00: configured for UDMA/133
> [   16.581423] scsi 2:0:0:0: Direct-Access     ATA      WDC  WDS250G2B0A 20WD PQ: 0 ANSI: 5
> [   16.582938] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [   16.583063] sd 2:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
> [   16.583096] sd 2:0:0:0: [sda] Write Protect is off
> [   16.583106] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   16.583164] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   16.583244] sd 2:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [   16.585312] usb 1-7: New USB device found, idVendor=17ef, idProduct=6044, bcdDevice= 0.08
> [   16.585327] usb 1-7: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [   16.585335] usb 1-7: Product: ThinkPad USB Laser Mouse
> [   16.586761]  sda: sda1 sda2
> [   16.587436] sd 2:0:0:0: [sda] Attached SCSI disk
> [   16.648704] e1000e 0000:00:1f.6 eno1: renamed from eth0
> [   16.736642] usb 1-8: new low-speed USB device number 3 using xhci_hcd
> [   16.890225] usb 1-8: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
> [   16.890239] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   16.890247] usb 1-8: Product: USB Keyboard
> [   16.890254] usb 1-8: Manufacturer: Logitech
> [   16.922543] hid: raw HID events driver (C) Jiri Kosina
> [   16.942368] usbcore: registered new interface driver usbhid
> [   16.942372] usbhid: USB HID core driver
> [   16.948215] input: ThinkPad USB Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/0003:17EF:6044.0001/input/input3
> [   16.948488] hid-generic 0003:17EF:6044.0001: input,hidraw0: USB HID v1.11 Mouse [ThinkPad USB Laser Mouse] on usb-0000:00:14.0-7/input0
> [   16.948965] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:046D:C31C.0002/input/input4
> [   17.009119] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:14.0-8/input0
> [   17.009907] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C31C.0003/input/input5
> [   17.069095] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C31C.0003/input/input6
> [   17.069584] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:14.0-8/input1
> [   17.124193] random: crng reseeded on system resumption
> [   17.124511] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
> [   17.124523] PM: hibernation: Marking nosave pages: [mem 0x0005f000-0x0005ffff]
> [   17.124529] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
> [   17.124544] PM: hibernation: Marking nosave pages: [mem 0x67cdb000-0x67cdbfff]
> [   17.124550] PM: hibernation: Marking nosave pages: [mem 0x67ceb000-0x67cecfff]
> [   17.124555] PM: hibernation: Marking nosave pages: [mem 0x67cfc000-0x67cfcfff]
> [   17.124605] PM: hibernation: Marking nosave pages: [mem 0x78a53000-0x78a93fff]
> [   17.124617] PM: hibernation: Marking nosave pages: [mem 0x7addd000-0x7adddfff]
> [   17.124622] PM: hibernation: Marking nosave pages: [mem 0x7c765000-0x7ed0dfff]
> [   17.125677] PM: hibernation: Marking nosave pages: [mem 0x7ed0f000-0xffffffff]
> [   17.153575] PM: hibernation: Basic memory bitmaps created
> [   17.154248] PM: hibernation: Basic memory bitmaps freed
> [   17.206422] EXT4-fs (sda2): mounted filesystem 74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro with ordered data mode. Quota mode: none.
> [   17.489082] systemd[1]: Inserted module 'autofs4'
> [   17.574371] systemd[1]: systemd 245.4-4ubuntu3.22 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   17.574485] systemd[1]: Detected architecture x86-64.
> [   17.605098] systemd[1]: Set hostname to <cr-desktop>.
> [   17.828325] systemd[1]: Created slice system-modprobe.slice.
> [   17.828586] systemd[1]: Created slice system-postfix.slice.
> [   17.828805] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [   17.829003] systemd[1]: Created slice User and Session Slice.
> [   17.829068] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   17.829235] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [   17.829305] systemd[1]: Reached target User and Group Name Lookups.
> [   17.829320] systemd[1]: Reached target Remote File Systems.
> [   17.829333] systemd[1]: Reached target Slices.
> [   17.829353] systemd[1]: Reached target Mounting snaps.
> [   17.829373] systemd[1]: Reached target System Time Set.
> [   17.829490] systemd[1]: Listening on Syslog Socket.
> [   17.829580] systemd[1]: Listening on fsck to fsckd communication Socket.
> [   17.829630] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [   17.829828] systemd[1]: Listening on Journal Audit Socket.
> [   17.829910] systemd[1]: Listening on Journal Socket (/dev/log).
> [   17.830011] systemd[1]: Listening on Journal Socket.
> [   17.830118] systemd[1]: Listening on udev Control Socket.
> [   17.830185] systemd[1]: Listening on udev Kernel Socket.
> [   17.861047] systemd[1]: Mounting Huge Pages File System...
> [   17.864870] systemd[1]: Mounting POSIX Message Queue File System...
> [   17.870881] systemd[1]: Mounting Kernel Debug File System...
> [   17.875994] systemd[1]: Mounting Kernel Trace File System...
> [   17.881259] systemd[1]: Starting Journal Service...
> [   17.885476] systemd[1]: Starting Set the console keyboard layout...
> [   17.888676] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [   17.892091] systemd[1]: Starting Load Kernel Module chromeos_pstore...
> [   17.895452] systemd[1]: Starting Load Kernel Module drm...
> [   17.897820] systemd[1]: Starting Load Kernel Module efi_pstore...
> [   17.900366] systemd[1]: Starting Load Kernel Module pstore_blk...
> [   17.902535] systemd[1]: Starting Load Kernel Module pstore_zone...
> [   17.904397] systemd[1]: Starting Load Kernel Module ramoops...
> [   17.905785] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   17.905847] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [   17.907472] pstore: Using crash dump compression: deflate
> [   17.917262] systemd[1]: Starting Load Kernel Modules...
> [   17.921146] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   17.926852] systemd[1]: Starting udev Coldplug all Devices...
> [   17.934312] systemd[1]: Starting Uncomplicated firewall...
> [   17.936122] pstore: Registered efi_pstore as persistent store backend
> [   17.941335] systemd[1]: Mounted Huge Pages File System.
> [   17.941511] systemd[1]: Mounted POSIX Message Queue File System.
> [   17.941673] systemd[1]: Mounted Kernel Debug File System.
> [   17.941827] systemd[1]: Mounted Kernel Trace File System.
> [   17.942505] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [   17.942862] systemd[1]: modprobe@pstore_blk.service: Succeeded.
> [   17.943298] systemd[1]: Finished Load Kernel Module pstore_blk.
> [   17.943751] systemd[1]: modprobe@pstore_zone.service: Succeeded.
> [   17.944803] systemd[1]: Finished Load Kernel Module pstore_zone.
> [   17.950639] systemd[1]: Finished Uncomplicated firewall.
> [   17.968943] systemd[1]: modprobe@chromeos_pstore.service: Succeeded.
> [   17.969471] systemd[1]: Finished Load Kernel Module chromeos_pstore.
> [   17.969941] systemd[1]: modprobe@efi_pstore.service: Succeeded.
> [   17.971520] systemd[1]: Finished Load Kernel Module efi_pstore.
> [   17.984578] EXT4-fs (sda2): re-mounted 74fe52d0-e90f-4b0a-92f4-581b5fa98519 r/w. Quota mode: none.
> [   17.999187] ACPI: bus type drm_connector registered
> [   17.999774] systemd[1]: Finished Remount Root and Kernel File Systems.
> [   18.004947] systemd[1]: Activating swap /swapfile...
> [   18.005395] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [   18.007550] systemd[1]: Starting Load/Save Random Seed...
> [   18.008920] lp: driver loaded but no devices found
> [   18.010652] systemd[1]: Starting Create System Users...
> [   18.011023] systemd[1]: Started Journal Service.
> [   18.016817] Adding 4194300k swap on /swapfile.  Priority:-2 extents:59 across:78897152k SS
> [   18.023271] ppdev: user-space parallel port driver
> [   18.028678] systemd-journald[243]: Received client request to flush runtime journal.
> [   18.078395] loop0: detected capacity change from 0 to 8
> [   18.101076] loop1: detected capacity change from 0 to 114000
> [   18.101166] loop2: detected capacity change from 0 to 113992
> [   18.101335] loop3: detected capacity change from 0 to 129944
> [   18.128700] loop4: detected capacity change from 0 to 448512
> [   18.128790] loop5: detected capacity change from 0 to 994336
> [   18.128840] loop6: detected capacity change from 0 to 994336
> [   18.128915] loop7: detected capacity change from 0 to 133320
> [   18.129506] loop9: detected capacity change from 0 to 25240
> [   18.129584] loop8: detected capacity change from 0 to 104360
> [   18.129721] loop11: detected capacity change from 0 to 130848
> [   18.129747] loop12: detected capacity change from 0 to 657576
> [   18.129860] loop13: detected capacity change from 0 to 109072
> [   18.129929] loop10: detected capacity change from 0 to 133424
> [   18.145144] loop15: detected capacity change from 0 to 447264
> [   18.145144] loop14: detected capacity change from 0 to 187776
> [   18.148957] loop16: detected capacity change from 0 to 151296
> [   18.477424] EDAC ie31200: No ECC support
> [   18.543387] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [   18.562874] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM, read-only
> [   18.637726] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [   18.637730] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   18.637732] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   18.637733] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   18.637734] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   18.674453] cryptd: max_cpu_qlen set to 1000
> [   18.712485] SSE version of gcm_enc/dec engaged.
> [   19.311225] Console: switching to colour dummy device 80x25
> [   19.311299] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   19.320389] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   19.324206] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [   19.327998] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [   19.357712] intel_rapl_common: Found RAPL domain package
> [   19.357716] intel_rapl_common: Found RAPL domain core
> [   19.357717] intel_rapl_common: Found RAPL domain uncore
> [   19.357718] intel_rapl_common: Found RAPL domain dram
> [   19.727131] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] failed to retrieve link info, disabling eDP
> [   19.727389] i915 0000:00:02.0: [drm] [ENCODER:94:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   19.727393] i915 0000:00:02.0: [drm] [ENCODER:108:DDI D/PHY D] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   19.727397] i915 0000:00:02.0: [drm] [ENCODER:119:DDI E/PHY E] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   19.753023] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 0
> [   19.764038] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   19.765874] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
> [   19.766756] i915 display info: display version: 9
> [   19.766769] i915 display info: cursor_needs_physical: no
> [   19.766780] i915 display info: has_cdclk_crawl: no
> [   19.766787] i915 display info: has_cdclk_squash: no
> [   19.766793] i915 display info: has_ddi: yes
> [   19.766800] i915 display info: has_dp_mst: yes
> [   19.766806] i915 display info: has_dsb: no
> [   19.766812] i915 display info: has_fpga_dbg: yes
> [   19.766818] i915 display info: has_gmch: no
> [   19.766824] i915 display info: has_hotplug: yes
> [   19.766830] i915 display info: has_hti: no
> [   19.766836] i915 display info: has_ipc: yes
> [   19.766842] i915 display info: has_overlay: no
> [   19.766848] i915 display info: has_psr: yes
> [   19.766854] i915 display info: has_psr_hw_tracking: yes
> [   19.766860] i915 display info: overlay_needs_physical: no
> [   19.766866] i915 display info: supports_tv: no
> [   19.766872] i915 display info: has_hdcp: yes
> [   19.766877] i915 display info: has_dmc: yes
> [   19.766881] i915 display info: has_dsc: no
> [   19.767058] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   19.840416] audit: type=1400 audit(1712608901.862:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=470 comm="apparmor_parser"
> [   19.840424] audit: type=1400 audit(1712608901.862:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=469 comm="apparmor_parser"
> [   19.849674] audit: type=1400 audit(1712608901.874:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=473 comm="apparmor_parser"
> [   19.849681] audit: type=1400 audit(1712608901.874:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=473 comm="apparmor_parser"
> [   19.851702] audit: type=1400 audit(1712608901.874:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=468 comm="apparmor_parser"
> [   19.851708] audit: type=1400 audit(1712608901.874:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=468 comm="apparmor_parser"
> [   19.851713] audit: type=1400 audit(1712608901.874:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=468 comm="apparmor_parser"
> [   19.851717] audit: type=1400 audit(1712608901.874:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=468 comm="apparmor_parser"
> [   19.857123] audit: type=1400 audit(1712608901.882:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=474 comm="apparmor_parser"
> [   19.864174] audit: type=1400 audit(1712608901.886:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/cups/backend/cups-pdf" pid=476 comm="apparmor_parser"
> [   19.901794] fbcon: i915drmfb (fb0) is primary device
> [   19.950198] Console: switching to colour frame buffer device 240x67
> [   19.969279] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [   20.006017] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [   20.006024] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   20.006026] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [   20.006028] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   20.006030] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   20.006031] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
> [   20.006033] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
> [   20.006034] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
> [   20.072462] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
> [   20.074752] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
> [   20.079934] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
> [   20.085472] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
> [   20.086707] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
> [   20.089926] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> [   20.097574] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
> [   20.098247] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> [   21.899828] loop17: detected capacity change from 0 to 8
> [   25.812150] rfkill: input handler disabled
> [   26.329380] kauditd_printk_skb: 29 callbacks suppressed
> [   26.329383] audit: type=1400 audit(1712608908.342:41): apparmor="DENIED" operation="capable" class="cap" profile="/snap/snapd/19457/usr/lib/snapd/snap-confine" pid=1346 comm="snap-confine" capability=4  capname="fsetid"
> [   29.327836] fwupd[2147]: segfault at 8 ip 00005577414a410d sp 00007ffdd5e5f700 error 4 in fwupd[55774149f000+26000] likely on CPU 2 (core 0, socket 0)
> [   29.327849] Code: ff 85 c0 0f 85 97 02 00 00 48 8b 7c 24 30 e8 5a d5 ff ff e9 67 01 00 00 48 8b 44 24 28 48 8d 3d d9 14 02 00 41 be 01 00 00 00 <48> 8b 70 08 31 c0 e8 08 f4 ff ff 4d 85 e4 74 08 4c 89 e7 e8 2b db
> [   42.363911] pcieport 0000:00:1d.3: pciehp: Slot(15): Card present
> [   42.363915] pcieport 0000:00:1d.3: pciehp: Slot(15): Link Up
> [   42.496936] pci 0000:04:00.0: [2646:2263] type 00 class 0x010802 PCIe Endpoint
> [   42.497041] pci 0000:04:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [   42.497435] pci 0000:04:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x1 link at 0000:00:1d.3 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [   42.498278] pci 0000:04:00.0: BAR 0 [mem 0xa3100000-0xa3103fff 64bit]: assigned
> [   42.498368] pcieport 0000:00:1d.3: PCI bridge to [bus 04]
> [   42.498385] pcieport 0000:00:1d.3:   bridge window [io  0x3000-0x3fff]
> [   42.498411] pcieport 0000:00:1d.3:   bridge window [mem 0xa3100000-0xa3afffff]
> [   42.498435] pcieport 0000:00:1d.3:   bridge window [mem 0xa0000000-0xa09fffff 64bit pref]
> [   42.560689] nvme nvme0: pci function 0000:04:00.0
> [   42.560756] nvme 0000:04:00.0: enabling device (0000 -> 0002)
> [   42.593330] nvme nvme0: missing or invalid SUBNQN field.
> [   42.599528] nvme nvme0: 4/0/0 default/read/poll queues
> [   42.604972]  nvme0n1: p1 p2 p3 p4 p5
> [   47.843145] PM: suspend entry (deep)
> [   47.911562] Filesystems sync: 0.068 seconds
> [   47.912244] Freezing user space processes
> [   47.916421] Freezing user space processes completed (elapsed 0.004 seconds)
> [   47.916435] OOM killer disabled.
> [   47.916438] Freezing remaining freezable tasks
> [   47.917787] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   47.917881] printk: Suspending console(s) (use no_console_suspend to debug)
> [   47.933715] serial 00:01: disabled
> [   47.933852] e1000e: EEE TX LPI TIMER: 00000011
> [   47.944891] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> [   47.950919] ata3.00: Entering standby power mode
> [   48.318069] ACPI: PM: Preparing to enter system sleep state S3
> [   48.685977] ACPI: PM: Saving platform NVS memory
> [   48.686137] Disabling non-boot CPUs ...
> [   48.688277] smpboot: CPU 1 is now offline
> [   48.691594] smpboot: CPU 2 is now offline
> [   48.693971] smpboot: CPU 3 is now offline
> [   48.698985] ACPI: PM: Low-level resume complete
> [   48.699055] ACPI: PM: Restoring platform NVS memory
> [   48.700054] Enabling non-boot CPUs ...
> [   48.700078] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   48.703570] CPU1 is up
> [   48.703590] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [   48.704280] CPU2 is up
> [   48.704297] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [   48.704895] CPU3 is up
> [   48.706559] ACPI: PM: Waking up from system sleep state S3
> [   49.799631] i915 0000:00:02.0: [drm] [ENCODER:94:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   49.799636] i915 0000:00:02.0: [drm] [ENCODER:104:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   49.799639] i915 0000:00:02.0: [drm] [ENCODER:108:DDI D/PHY D] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   49.799643] i915 0000:00:02.0: [drm] [ENCODER:119:DDI E/PHY E] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   49.802306] serial 00:01: activated
> [   49.883191] nvme nvme0: 4/0/0 default/read/poll queues
> [   49.883323] nvme nvme0: identifiers changed for nsid 1
> [   50.176065] ata4: SATA link down (SStatus 4 SControl 300)
> [   50.176095] ata1: SATA link down (SStatus 4 SControl 300)
> [   50.176116] ata5: SATA link down (SStatus 4 SControl 300)
> [   50.176133] ata2: SATA link down (SStatus 4 SControl 300)
> [   50.176152] ata6: SATA link down (SStatus 4 SControl 300)
> [   50.176176] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   50.177333] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
> [   50.177337] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
> [   50.181374] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
> [   50.181377] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
> [   50.184293] ata3.00: configured for UDMA/133
> [   50.908446] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [   50.914602] OOM killer enabled.
> [   50.914609] Restarting tasks ... done.
> [   50.922689] random: crng reseeded on system resumption
> [   50.922724] PM: suspend exit
> [   51.166103] e1000e 0000:00:1f.6 eno1: NIC Link is Down
> [   54.743511] audit: type=1400 audit(1712608955.040:42): apparmor="DENIED" operation="open" class="file" profile="snap.snap-store.ubuntu-software" name="/etc/appstream.conf" pid=1346 comm="snap-store" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
> [   54.802553] fwupd[2428]: segfault at 8 ip 000056021e74a10d sp 00007ffcb0d24140 error 4 in fwupd[56021e745000+26000] likely on CPU 0 (core 0, socket 0)
> [   54.802569] Code: ff 85 c0 0f 85 97 02 00 00 48 8b 7c 24 30 e8 5a d5 ff ff e9 67 01 00 00 48 8b 44 24 28 48 8d 3d d9 14 02 00 41 be 01 00 00 00 <48> 8b 70 08 31 c0 e8 08 f4 ff ff 4d 85 e4 74 08 4c 89 e7 e8 2b db
> 
> 
> 

