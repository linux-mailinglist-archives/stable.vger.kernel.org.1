Return-Path: <stable+bounces-48284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA258FE413
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7185F1F271F6
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9A194AE4;
	Thu,  6 Jun 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="udBssSLH"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A788194A74;
	Thu,  6 Jun 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669103; cv=none; b=KS2qyfCI1iI9Unc9otWbBMSelsr9U/fdnm93LIUOa/rKBmOXLRDHPPai1TXLPnECq2o4dLiX63Rl5NL2GdrRd1YuBwHuskh9bnBBBSNcOqP5WtxMQDlvpLWNYyc7qPQyjhFI0H7FFVFzT3vveU9T2w+XWPPSqWE2KW/DD5SsE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669103; c=relaxed/simple;
	bh=4BkHntbcbNxwx6A8rzC9SXJVpauMc85WvuNkuBlvhgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtkfQ/K1yIPjhpOMdgpzmmYRpFsTW62R9rjixjTqrU/srekdPA/L5/3be5pds7bzDM2rz2eNvv7/y1PzVi3enYHUokFuy+zvbKoWHAqvGHQX7wpFlQ5yupbmTzG8+wROr0NUlgtwNHpnjfp/xrl1at/xrqtr3WxyXtfo6ziKF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=udBssSLH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=IP1N4QPeOhfnxSknl2JunkbY7wey9LDoXvM37stTPG8=; t=1717669101;
	x=1718101101; b=udBssSLH7S3ESMt9qI6xFsbfH6UMzAm+nnYnCZ61GXOt3QbDeo1YWS1ub9o65
	reHpH9ouncJ2bUCOyXcXQ0KrJo0YYGTXuWRCCiF19EoXtzob+3ZLFt60M8V6WDIdz8v7HgPo/ZuZW
	BxC8rwXSi6+wxWb2sOpXioYdun+7vJzNflq9CDhBrr49T3YjhmEScMFCVGQwyQOYxtwVOtBTHqSu+
	6KmEMkSOG4tSTChnB2Gim/jLwYvQQzJ933YKnk3WYhEOdb+pyxMa1MJ0seaPh8QJf7yAMcQPqHj55
	RsAReki/vaZMKKsckuyjHlep7bf+yMh9xSIHCudLfG0p6kgRvA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFACJ-0003pU-0J; Thu, 06 Jun 2024 12:18:19 +0200
Message-ID: <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
Date: Thu, 6 Jun 2024 12:18:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Jeremy_Lain=C3=A9?=
 <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Mike <user.service2016@gmail.com>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717669101;34ae2c28;
X-HE-SMSGID: 1sFACJ-0003pU-0J

On 03.06.24 22:03, Mike wrote:
> On 29.05.24 11:06, Thorsten Leemhuis wrote:
>> Might be a good idea to share it, the developers might want to confirm
>> it's really the same bug.
> I'm attaching the stacktrace [1] and decodecode [2] at the end, generated
> on 6.1.92 vanilla+patch (1.).
> [...]
> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> time to be
> included in Debian stable, so having a patch for 6.1.x will be much
> appreciated.
> I do not have the time to follow the vanilla (latest) release as is
> likely the case for
> many other Linux users.
> 
> Let me know if there's anything else useful I can do for you.
> Thank you,

Still no reaction from the bluetooth developers. Guess they are busy
and/or do not care about 6.1.y. In that case:

@Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
("Bluetooth: hci_conn: Consolidate code for aborting connections") might
cause this or if it's missing some per-requisite? If not I wonder if
reverting that patch from 6.1.y might be the best move to resolve this
regression. Mike earlier in
https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
confirmed that this fixed the problem in tests. Jeremy (who started the
thread and afaics has the same problem) did not reply.

Ciao, Thorsten

> [1]
> 2024-06-03T21:04:49.730983+02:00 mike kernel: [   24.110172] kernel BUG
> at lib/list_debug.c:56!
> 2024-06-03T21:04:49.730984+02:00 mike kernel: [   24.110181] invalid
> opcode: 0000 [#1] PREEMPT SMP NOPTI
> 2024-06-03T21:04:49.730985+02:00 mike kernel: [   24.110184] CPU: 2 PID:
> 868 Comm: kworker/u65:2 Not tainted 6.1.92 #2
> 2024-06-03T21:04:49.730985+02:00 mike kernel: [   24.110187] Hardware
> name: Micro-Star International Co., Ltd. MS-7B93/MPG X570 GAMING PRO
> CARBON WIFI (MS-7B93), BIOS 1.M0 04/02/2024
> 2024-06-03T21:04:49.730986+02:00 mike kernel: [   24.110191] Workqueue:
> hci0 hci_cmd_sync_work [bluetooth]
> 2024-06-03T21:04:49.730986+02:00 mike kernel: [   24.110234] RIP:
> 0010:__list_del_entry_valid.cold+0x4b/0x6f
> 2024-06-03T21:04:49.730987+02:00 mike kernel: [   24.110240] Code: fe ff
> 0f 0b 48 89 f2 48 89 fe 48 c7 c7 c0 2d fa a6 e8 07 a1 fe ff 0f 0b 48 89
> fe 48 89 ca 48 c7 c7 88 2d fa a6 e8 f3 a0 fe ff <0f> 0b 48 89 fe 48 c7
> c7 50 2d fa a6 e8 e2 a0 fe ff 0f 0b 48 89 fe
> 2024-06-03T21:04:49.730987+02:00 mike kernel: [   24.110243] RSP:
> 0018:ffffb5fe04863de0 EFLAGS: 00010246
> 2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110247] RAX:
> 000000000000004e RBX: ffff9bff53430800 RCX: 0000000000000027
> 2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110249] RDX:
> 0000000000000000 RSI: 0000000000000001 RDI: ffff9c064eaa03a0
> 2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110252] RBP:
> ffff9bff4d2ce000 R08: 0000000000000000 R09: ffffb5fe04863c78
> 2024-06-03T21:04:49.730989+02:00 mike kernel: [   24.110254] R10:
> 0000000000000003 R11: ffff9c066f2fc3e8 R12: ffff9bff4d2ce000
> 2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110256] R13:
> ffff9bff4d2ce770 R14: ffff9bff62e919c0 R15: dead000000000100
> 2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110259] FS:
> 0000000000000000(0000) GS:ffff9c064ea80000(0000) knlGS:0000000000000000
> 2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110262] CS: 0010
> DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-06-03T21:04:49.730998+02:00 mike kernel: [   24.110265] CR2:
> 000055ff08f14638 CR3: 0000000169804000 CR4: 0000000000350ee0
> 2024-06-03T21:04:49.730998+02:00 mike kernel: [   24.110268] Call Trace:
> 2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110270] <TASK>
> 2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110273]  ?
> __die_body.cold+0x1a/0x1f
> 2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110278]  ?
> die+0x2a/0x50
> 2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110283]  ?
> do_trap+0xc5/0x110
> 2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110287]  ?
> __list_del_entry_valid.cold+0x4b/0x6f
> 2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110293]  ?
> do_error_trap+0x6a/0x90
> 2024-06-03T21:04:49.731001+02:00 mike kernel: [   24.110296]  ?
> __list_del_entry_valid.cold+0x4b/0x6f
> 2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110301]  ?
> exc_invalid_op+0x4c/0x60
> 2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110305]  ?
> __list_del_entry_valid.cold+0x4b/0x6f
> 2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110309]  ?
> asm_exc_invalid_op+0x16/0x20
> 2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110316]  ?
> __list_del_entry_valid.cold+0x4b/0x6f
> 2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110321]
> hci_conn_del+0x136/0x3e0 [bluetooth]
> 2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110357]
> hci_abort_conn_sync+0xaa/0x230 [bluetooth]
> 2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110395]  ?
> srso_return_thunk+0x5/0x10
> 2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110399]  ?
> abort_conn_sync+0x3d/0x70 [bluetooth]
> 2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110435]
> hci_cmd_sync_work+0xa2/0x150 [bluetooth]
> 2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110471]
> process_one_work+0x1c7/0x380
> 2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110477]
> worker_thread+0x4d/0x380
> 2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110482]  ?
> rescuer_thread+0x3a0/0x3a0
> 2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110486]
> kthread+0xda/0x100
> 2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110490]  ?
> kthread_complete_and_exit+0x20/0x20
> 2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110494]
> ret_from_fork+0x22/0x30
> 2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110503] </TASK>
> 2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110505] Modules
> linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device
> xt_CHECKSUM tun uhid bridge stp llc qrtr cpufreq_powersave
> cpufreq_userspace cpufreq_conservative cpufreq_ondemand cmac algif_hash
> algif_skcipher af_alg bnep uinput nft_chain_nat xt_MASQUERADE nf_nat
> xt_LOG nf_log_syslog xt_mac ipt_REJECT nf_reject_ipv4 xt_conntrack
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp xt_pkttype
> nft_compat sunrpc binfmt_misc nf_tables nfnetlink pktcdvd nls_ascii
> nls_cp437 vfat fat snd_hda_codec_realtek snd_hda_codec_generic
> ledtrig_audio snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common
> edac_mce_amd btusb snd_hda_intel btrtl snd_intel_dspcfg btbcm
> snd_intel_sdw_acpi btintel kvm_amd iwlmvm btmtk snd_hda_codec ccp
> bluetooth mac80211 snd_hda_core libarc4 snd_hwdep jitterentropy_rng
> snd_pcm kvm snd_timer irqbypass iwlwifi drbg snd sp5100_tco rapl
> wmi_bmof soundcore ansi_cprng k10temp watchdog cfg80211 ecdh_generic ecc
> rfkill joydev evdev button acpi_cpufreq sg msr
> 2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110606] dm_crypt
> loop fuse efi_pstore configfs ip_tables x_tables autofs4 ext4 crc16
> mbcache jbd2 btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c
> crc32c_generic efivarfs linear dm_mirror dm_region_hash dm_log
> hid_logitech_hidpp hid_logitech_dj hid_generic dm_mod raid1 usbhid hid
> md_mod amdgpu drm_ttm_helper ttm video crc32_pclmul gpu_sched uas
> crc32c_intel usb_storage sr_mod drm_buddy sd_mod ghash_clmulni_intel
> cdrom sha512_ssse3 drm_display_helper sha512_generic drm_kms_helper
> sha256_ssse3 nvme ahci sha1_ssse3 xhci_pci nvme_core libahci drm
> xhci_hcd t10_pi aesni_intel libata crypto_simd cec cryptd
> crc64_rocksoft_generic usbcore igb rc_core i2c_piix4 crc64_rocksoft
> scsi_mod crc_t10dif crct10dif_generic usb_common dca crct10dif_pclmul
> scsi_common i2c_algo_bit crc64 crct10dif_common wmi
> 2024-06-03T21:04:49.731008+02:00 mike kernel: [   24.110695] ---[ end
> trace 0000000000000000 ]---
> 
> [2]
> 2024-06-03T21:04:49.731009+02:00 mike kernel: [ 24.243204] Code: fe ff
> 0f 0b 48 89 f2 48 89 fe 48 c7 c7 c0 2d fa a6 e8 07 a1 fe ff 0f 0b 48 89
> fe 48 89 ca 48 c7 c7 88 2d fa a6 e8 f3 a0 fe ff <0f> 0b 48 89 fe 48 c7
> c7 50 2d fa a6 e8 e2 a0 fe ff 0f 0b 48 89 fe
> All code
> ========
>    0:   fe                      (bad)
>    1:   ff 0f                   decl   (%rdi)
>    3:   0b 48 89                or     -0x77(%rax),%ecx
>    6:   f2 48 89 fe             repnz mov %rdi,%rsi
>    a:   48 c7 c7 c0 2d fa a6    mov    $0xffffffffa6fa2dc0,%rdi
>   11:   e8 07 a1 fe ff          call   0xfffffffffffea11d
>   16:   0f 0b                   ud2
>   18:   48 89 fe                mov    %rdi,%rsi
>   1b:   48 89 ca                mov    %rcx,%rdx
>   1e:   48 c7 c7 88 2d fa a6    mov    $0xffffffffa6fa2d88,%rdi
>   25:   e8 f3 a0 fe ff          call   0xfffffffffffea11d
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   48 89 fe                mov    %rdi,%rsi
>   2f:   48 c7 c7 50 2d fa a6    mov    $0xffffffffa6fa2d50,%rdi
>   36:   e8 e2 a0 fe ff          call   0xfffffffffffea11d
>   3b:   0f 0b                   ud2
>   3d:   48 89 fe                mov    %rdi,%rsi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   48 89 fe                mov    %rdi,%rsi
>    5:   48 c7 c7 50 2d fa a6    mov    $0xffffffffa6fa2d50,%rdi
>    c:   e8 e2 a0 fe ff          call   0xfffffffffffea0f3
>   11:   0f 0b                   ud2
>   13:   48 89 fe                mov    %rdi,%rsi
> 
> 

