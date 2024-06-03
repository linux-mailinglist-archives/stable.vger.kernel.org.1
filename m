Return-Path: <stable+bounces-47888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657208D8AAF
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E931C2235F
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5513B28D;
	Mon,  3 Jun 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnWtZp18"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390746A4;
	Mon,  3 Jun 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445049; cv=none; b=gHLiuxjhct924QVEEj5PY1LWUefAUoXKD36ap8v5pcKdSqlhiKBgiNEwxHiaH0mdtDVF6m9ie3msptvwEEWjgqYtKtv0/mAQ9Ksn6fPi3DQtVTK2KGDtfSNRTDGKZrY2pdJfZmqifr9R8hZevKsR/ABtEcZTFereH/7v+WU+CRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445049; c=relaxed/simple;
	bh=dTQ590u9BBN6P6kAXKu5AEsLRHNC3Kd1FYejz8HRMnI=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=jqi0XZM9G60+RYoNUszP5BqFRH4C1/gwlDODiSFTvWJpfAeskHvsRbwR7o9xjS7GgFqpkmDzUJaZ7yh6NT25G2BVRyDCR6L7GSNWURS/ULTYDBO1vyEJWoy/YBuGVhVclZvSxhwnrkRlZaQUI9c6tuMbH6jpuz3bvmqhsXlKCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnWtZp18; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so14234155e9.0;
        Mon, 03 Jun 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717445046; x=1718049846; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:in-reply-to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lTlhY4ec0xXsC9o2CYMmIQINQsTrf8ZieKsdV0hMx4=;
        b=GnWtZp185BctrDZlJwKJcrOWPHFTj0HaorvH6V0pRmHpaxNEW06ZjvRHIJYEhpT8qK
         YZYHtJt147mWo3xrdQfMir1KTmcj7NNC7/b2Nxf6ZEpoAqrZTZzdAPl0tnBER84RGBfw
         y558/+jS91phxqeWOBFErUIFRsviu3bvUhGfdGLaBz19jl64DdX0rq9MnitWQ95kJfSp
         PsK9epN1/duJpehL857ZR2ckMpt/XYQRVeenMJ7+w9T89EcoOJgg+mzz3EY1hQLeuSdn
         GHGzdbWLMXQhtcxs7VO+RsUPAJYho1s3oxmwjKIyI6Nw9TYwp0OpWdZTBs2x+j2O9/pM
         PFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717445046; x=1718049846;
        h=content-transfer-encoding:subject:from:cc:to:in-reply-to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lTlhY4ec0xXsC9o2CYMmIQINQsTrf8ZieKsdV0hMx4=;
        b=QDsPF15NqDgpFpVt/8hSHP5zxdsxwockYUvgHYbGFNPCr2/1zgD0+Az0JOQHsfI8yE
         PTbZcsnpGoRDx4bRgymf+Vz0MxWOJf4fVmq6a2XnON4PmYqQH2JrKNI2JYRAzDJfJKbz
         zursXqB0xwH+k+XM0mq0kOEWVAhlug7xTygJ46PPBYajp88ujKhwpek4dAzP0htnmzPm
         PwTeFJ7KJw6bD8UkZ5iMpOKQy4ODaVbdEm5LVIRwPt2BafBH8eMJKwX44+gFemlXbUTa
         nb+31uaAy6Lz0kYeLnRWyUBmLVTB2VgCr+dm2Ofxg1Kr28LRwWnk1XLx+ERfuZlyRvfF
         Cweg==
X-Forwarded-Encrypted: i=1; AJvYcCU3iupZxn+ddYbu+MQ6/4iwILJzlI2ySU9xM3jcX6dhjPRa6ZPUYBhI588gr8nCE1wLsyJbGyCvZWmhJ04i6tEW0JMq+si1xyS6z3oWUFbP
X-Gm-Message-State: AOJu0YxsaePZNOj9Kx+0Mjer8Q9VFcJ1WrxeHpr/nBdnOJcfqmeEJugQ
	vjupGprsCTjyBjinGIFWhdEWS4MC8tjAvvBsFxGBRgCecCYsmiyt
X-Google-Smtp-Source: AGHT+IEb6RifbNvpo4713uNSc5ohEhi0ZIe9kaqJLJe3o8ydvq9MVupPRidiypk/7LhcQyHgRJ66pg==
X-Received: by 2002:a05:600c:35c5:b0:41a:a4b1:c098 with SMTP id 5b1f17b1804b1-4212e076530mr87778505e9.19.1717445046042;
        Mon, 03 Jun 2024 13:04:06 -0700 (PDT)
Received: from [100.64.100.6] ([179.61.241.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85c61dsm130189965e9.28.2024.06.03.13.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:04:05 -0700 (PDT)
Message-ID: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
Date: Mon, 3 Jun 2024 22:03:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <ecee3a54-1a09-40fa-afdb-057ca02cb574@leemhuis.info>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
From: Mike <user.service2016@gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.05.24 11:06, Thorsten Leemhuis wrote:
 > Might be a good idea to share it, the developers might want to confirm
 > it's really the same bug.

I'm attaching the stacktrace [1] and decodecode [2] at the end, generated
on 6.1.92 vanilla+patch (1.).

 > 1. test another fix for the culprit I found on lore -- but note, this is
 > just a shot in the dark
 > https://lore.kernel.org/all/20240411151929.403263-1-kovalev@altlinux.org/

Looks like it was a miss :(
I tested the recent release version 6.1.92, and the bug is still 
reproducible.
Interestingly, I encountered fewer occurrences with this release..
I then applied the patch mentioned (1.), but the bug is still 
(immediately) reproducible.
The stack traces are the same for version 6.1.92, both with and without 
the patch.

I understand that 6.9-rc5[1] worked fine, but I guess it will take some 
time to be
included in Debian stable, so having a patch for 6.1.x will be much 
appreciated.
I do not have the time to follow the vanilla (latest) release as is 
likely the case for
many other Linux users.

Let me know if there's anything else useful I can do for you.
Thank you,
Mike

[1]
2024-06-03T21:04:49.730983+02:00 mike kernel: [   24.110172] kernel BUG 
at lib/list_debug.c:56!
2024-06-03T21:04:49.730984+02:00 mike kernel: [   24.110181] invalid 
opcode: 0000 [#1] PREEMPT SMP NOPTI
2024-06-03T21:04:49.730985+02:00 mike kernel: [   24.110184] CPU: 2 PID: 
868 Comm: kworker/u65:2 Not tainted 6.1.92 #2
2024-06-03T21:04:49.730985+02:00 mike kernel: [   24.110187] Hardware 
name: Micro-Star International Co., Ltd. MS-7B93/MPG X570 GAMING PRO 
CARBON WIFI (MS-7B93), BIOS 1.M0 04/02/2024
2024-06-03T21:04:49.730986+02:00 mike kernel: [   24.110191] Workqueue: 
hci0 hci_cmd_sync_work [bluetooth]
2024-06-03T21:04:49.730986+02:00 mike kernel: [   24.110234] RIP: 
0010:__list_del_entry_valid.cold+0x4b/0x6f
2024-06-03T21:04:49.730987+02:00 mike kernel: [   24.110240] Code: fe ff 
0f 0b 48 89 f2 48 89 fe 48 c7 c7 c0 2d fa a6 e8 07 a1 fe ff 0f 0b 48 89 
fe 48 89 ca 48 c7 c7 88 2d fa a6 e8 f3 a0 fe ff <0f> 0b 48 89 fe 48 c7 
c7 50 2d fa a6 e8 e2 a0 fe ff 0f 0b 48 89 fe
2024-06-03T21:04:49.730987+02:00 mike kernel: [   24.110243] RSP: 
0018:ffffb5fe04863de0 EFLAGS: 00010246
2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110247] RAX: 
000000000000004e RBX: ffff9bff53430800 RCX: 0000000000000027
2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110249] RDX: 
0000000000000000 RSI: 0000000000000001 RDI: ffff9c064eaa03a0
2024-06-03T21:04:49.730988+02:00 mike kernel: [   24.110252] RBP: 
ffff9bff4d2ce000 R08: 0000000000000000 R09: ffffb5fe04863c78
2024-06-03T21:04:49.730989+02:00 mike kernel: [   24.110254] R10: 
0000000000000003 R11: ffff9c066f2fc3e8 R12: ffff9bff4d2ce000
2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110256] R13: 
ffff9bff4d2ce770 R14: ffff9bff62e919c0 R15: dead000000000100
2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110259] FS: 
0000000000000000(0000) GS:ffff9c064ea80000(0000) knlGS:0000000000000000
2024-06-03T21:04:49.730997+02:00 mike kernel: [   24.110262] CS: 0010 
DS: 0000 ES: 0000 CR0: 0000000080050033
2024-06-03T21:04:49.730998+02:00 mike kernel: [   24.110265] CR2: 
000055ff08f14638 CR3: 0000000169804000 CR4: 0000000000350ee0
2024-06-03T21:04:49.730998+02:00 mike kernel: [   24.110268] Call Trace:
2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110270] <TASK>
2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110273]  ? 
__die_body.cold+0x1a/0x1f
2024-06-03T21:04:49.730999+02:00 mike kernel: [   24.110278]  ? 
die+0x2a/0x50
2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110283]  ? 
do_trap+0xc5/0x110
2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110287]  ? 
__list_del_entry_valid.cold+0x4b/0x6f
2024-06-03T21:04:49.731000+02:00 mike kernel: [   24.110293]  ? 
do_error_trap+0x6a/0x90
2024-06-03T21:04:49.731001+02:00 mike kernel: [   24.110296]  ? 
__list_del_entry_valid.cold+0x4b/0x6f
2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110301]  ? 
exc_invalid_op+0x4c/0x60
2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110305]  ? 
__list_del_entry_valid.cold+0x4b/0x6f
2024-06-03T21:04:49.731002+02:00 mike kernel: [   24.110309]  ? 
asm_exc_invalid_op+0x16/0x20
2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110316]  ? 
__list_del_entry_valid.cold+0x4b/0x6f
2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110321] 
hci_conn_del+0x136/0x3e0 [bluetooth]
2024-06-03T21:04:49.731003+02:00 mike kernel: [   24.110357] 
hci_abort_conn_sync+0xaa/0x230 [bluetooth]
2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110395]  ? 
srso_return_thunk+0x5/0x10
2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110399]  ? 
abort_conn_sync+0x3d/0x70 [bluetooth]
2024-06-03T21:04:49.731004+02:00 mike kernel: [   24.110435] 
hci_cmd_sync_work+0xa2/0x150 [bluetooth]
2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110471] 
process_one_work+0x1c7/0x380
2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110477] 
worker_thread+0x4d/0x380
2024-06-03T21:04:49.731005+02:00 mike kernel: [   24.110482]  ? 
rescuer_thread+0x3a0/0x3a0
2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110486] 
kthread+0xda/0x100
2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110490]  ? 
kthread_complete_and_exit+0x20/0x20
2024-06-03T21:04:49.731006+02:00 mike kernel: [   24.110494] 
ret_from_fork+0x22/0x30
2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110503] </TASK>
2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110505] Modules 
linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device 
xt_CHECKSUM tun uhid bridge stp llc qrtr cpufreq_powersave 
cpufreq_userspace cpufreq_conservative cpufreq_ondemand cmac algif_hash 
algif_skcipher af_alg bnep uinput nft_chain_nat xt_MASQUERADE nf_nat 
xt_LOG nf_log_syslog xt_mac ipt_REJECT nf_reject_ipv4 xt_conntrack 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp xt_pkttype 
nft_compat sunrpc binfmt_misc nf_tables nfnetlink pktcdvd nls_ascii 
nls_cp437 vfat fat snd_hda_codec_realtek snd_hda_codec_generic 
ledtrig_audio snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common 
edac_mce_amd btusb snd_hda_intel btrtl snd_intel_dspcfg btbcm 
snd_intel_sdw_acpi btintel kvm_amd iwlmvm btmtk snd_hda_codec ccp 
bluetooth mac80211 snd_hda_core libarc4 snd_hwdep jitterentropy_rng 
snd_pcm kvm snd_timer irqbypass iwlwifi drbg snd sp5100_tco rapl 
wmi_bmof soundcore ansi_cprng k10temp watchdog cfg80211 ecdh_generic ecc 
rfkill joydev evdev button acpi_cpufreq sg msr
2024-06-03T21:04:49.731007+02:00 mike kernel: [   24.110606] dm_crypt 
loop fuse efi_pstore configfs ip_tables x_tables autofs4 ext4 crc16 
mbcache jbd2 btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c 
crc32c_generic efivarfs linear dm_mirror dm_region_hash dm_log 
hid_logitech_hidpp hid_logitech_dj hid_generic dm_mod raid1 usbhid hid 
md_mod amdgpu drm_ttm_helper ttm video crc32_pclmul gpu_sched uas 
crc32c_intel usb_storage sr_mod drm_buddy sd_mod ghash_clmulni_intel 
cdrom sha512_ssse3 drm_display_helper sha512_generic drm_kms_helper 
sha256_ssse3 nvme ahci sha1_ssse3 xhci_pci nvme_core libahci drm 
xhci_hcd t10_pi aesni_intel libata crypto_simd cec cryptd 
crc64_rocksoft_generic usbcore igb rc_core i2c_piix4 crc64_rocksoft 
scsi_mod crc_t10dif crct10dif_generic usb_common dca crct10dif_pclmul 
scsi_common i2c_algo_bit crc64 crct10dif_common wmi
2024-06-03T21:04:49.731008+02:00 mike kernel: [   24.110695] ---[ end 
trace 0000000000000000 ]---

[2]
2024-06-03T21:04:49.731009+02:00 mike kernel: [ 24.243204] Code: fe ff 
0f 0b 48 89 f2 48 89 fe 48 c7 c7 c0 2d fa a6 e8 07 a1 fe ff 0f 0b 48 89 
fe 48 89 ca 48 c7 c7 88 2d fa a6 e8 f3 a0 fe ff <0f> 0b 48 89 fe 48 c7 
c7 50 2d fa a6 e8 e2 a0 fe ff 0f 0b 48 89 fe
All code
========
    0:   fe                      (bad)
    1:   ff 0f                   decl   (%rdi)
    3:   0b 48 89                or     -0x77(%rax),%ecx
    6:   f2 48 89 fe             repnz mov %rdi,%rsi
    a:   48 c7 c7 c0 2d fa a6    mov    $0xffffffffa6fa2dc0,%rdi
   11:   e8 07 a1 fe ff          call   0xfffffffffffea11d
   16:   0f 0b                   ud2
   18:   48 89 fe                mov    %rdi,%rsi
   1b:   48 89 ca                mov    %rcx,%rdx
   1e:   48 c7 c7 88 2d fa a6    mov    $0xffffffffa6fa2d88,%rdi
   25:   e8 f3 a0 fe ff          call   0xfffffffffffea11d
   2a:*  0f 0b                   ud2             <-- trapping instruction
   2c:   48 89 fe                mov    %rdi,%rsi
   2f:   48 c7 c7 50 2d fa a6    mov    $0xffffffffa6fa2d50,%rdi
   36:   e8 e2 a0 fe ff          call   0xfffffffffffea11d
   3b:   0f 0b                   ud2
   3d:   48 89 fe                mov    %rdi,%rsi

Code starting with the faulting instruction
===========================================
    0:   0f 0b                   ud2
    2:   48 89 fe                mov    %rdi,%rsi
    5:   48 c7 c7 50 2d fa a6    mov    $0xffffffffa6fa2d50,%rdi
    c:   e8 e2 a0 fe ff          call   0xfffffffffffea0f3
   11:   0f 0b                   ud2
   13:   48 89 fe                mov    %rdi,%rsi


