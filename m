Return-Path: <stable+bounces-134765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CBA94ED1
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F337A4AE2
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 09:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82832586C2;
	Mon, 21 Apr 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="SoSA1nZA"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAC1C2437;
	Mon, 21 Apr 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228439; cv=none; b=HQMpISxBuZt3RHvC24qh5geALYbWkzn4BTMQJBIc0/plzDCDyhUJlMEpj+NIctdFsPZREjVnazehD50hlHZGrpacOj+w3wRAJVyxG5aHVk1165INwvLp8aTNnnbNiivqr6kuLWbV8sliVtbsDIsv6ftBPP+RnWPlS98UGHXtAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228439; c=relaxed/simple;
	bh=/aGJWK22tQe/Ha4UsmQkXaFakHVo7zvmcLaGu2MOQvk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BLIk5CLSuUOKWQE8YAuAFP0TjlOfrXDQdefrG7DPdrr2AaQaxVmuEU/k0LnTZuKLJIRJSqrF1D/J1WTF8T1OnbF9nEFVaGewXbSMFkP94xLRExyu3dV3yRttW5lNikO/vrcN5mJUxCngBhLofxUIA/BCZtDF9t7mcf9PIP1haTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=SoSA1nZA; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 77ECE120872;
	Mon, 21 Apr 2025 10:40:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745228420;
	bh=/aGJWK22tQe/Ha4UsmQkXaFakHVo7zvmcLaGu2MOQvk=;
	h=Date:From:To:Subject;
	b=SoSA1nZAr3fhMORJk/x8gXQOWQf2UMF+rbIWxnZRFNAIYLIibsfqNgFvDiP3//J7s
	 Fm4P53y3HyVJfrGgS828VPMidUKxOZ2eTWMKLCYGLGO7tsVHl3F17hzqWknNxlC5BC
	 s8RDawYWuvd2OH18eTeX1dSS2j8wWwHm+7ix5R8omY+5/8bAbo5/cRzCkAUeFtuOIg
	 tgbsA7zBFA48ZU5cXpcs9lDlqqebSnWchEKZj5rbUPwEwkv2qaW9SBVPeB3E5NTX6A
	 eixmApAYLr+N1ZVjsybrnT06jGTH9xMXBAJCtWYDFpbnjIv3bo7OFhDIrUqUmqp+Rv
	 1atQMwD9V8y5A==
Date: Mon, 21 Apr 2025 10:40:19 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila
 <tavip@google.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, stable@vger.kernel.org
Subject: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250421104019.7880108d@frodo.int.wylie.me.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

#regzbot introduced: 6.14.2..6.14.3


Since 6.14.3 I have been seeing random panics, all in htb_dequeue.
6.14.2 was fine.

One only happened 8 hours after the reboot, so bisecting would be
prolonged, since I have no idea what is triggering the crash.

I've captured three panics with netconsole. All are very similar.

I've also included the script I use to initialise tc. As well as when
the ppp over ethernet interface comes up, I also run this every 5
minutes as a cron job since my ADSL line can fluctuate between 22 and
30 Mb/s. However, from the timings of the last few lines in
/var/log/messages before the crash, it doesn't seem that this is
directly related.

Finally, I've decoded the first panic.

I'm more than happy to help with debugging, if necessary.

The system is running up-to-date Gentoo.

Linux version 6.14.3 (alan@bilbo) (gcc (Gentoo Hardened
14.2.1_p20241221 p7) 14.2.1 20241221, GNU ld (Gentoo 2.44 p1) 2.44.0)
#20 SMP PREEMPT_DYNAMIC Sun Apr 20 21:18:54 BST 2025

Linux bilbo 6.14.3 #20 SMP PREEMPT_DYNAMIC Sun Apr 20 21:18:54 BST 2025
x86_64 AMD FX(tm)-4300 Quad-Core Processor AuthenticAMD GNU/Linux

# equery -q list  iproute2
sys-apps/iproute2-6.13.0


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O
6.14.3 #20 Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by
O.E.M./970A-DS3P, BIOS FD 02/26/2016 RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b
5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f
48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b RSP:
0018:ffffc90000003e50 EFLAGS: 00010246 RAX: 0000000000000000 RBX:
ffff88811a764000 RCX: ffff88811a764180 RDX: ffff88835e4c6c00 RSI:
ffff888162c998e8 RDI: 0000000000000000 RBP: 0000000000000000 R08:
ffff88811a7642b0 R09: 00000000a535eebc R10: 0000000000000d09 R11:
ffffc90000003ff8 R12: ffff88835e4c6c00 R13: ffff88811a7642b8 R14:
00001a951355b383 R15: 0000000000000000 FS:  0000000000000000(0000)
GS:ffff88842ec00000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033 CR2: 0000000000000000 CR3: 00000001084b4000
CR4: 00000000000406f0 Call Trace: <IRQ>
 htb_dequeue+0x42f/0x610 [sch_htb]
 __qdisc_run+0x253/0x480
 ? timerqueue_del+0x2c/0x40
 qdisc_run+0x15/0x30
 net_tx_action+0x182/0x1b0
 handle_softirqs+0x102/0x240
 __irq_exit_rcu+0x3e/0xb0
 sysvec_apic_timer_interrupt+0x5b/0x70
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:cpuidle_enter_state+0x126/0x220
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8
9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc
00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49 RSP:
0018:ffffffff81e03e40 EFLAGS: 00000202 RAX: ffff88842ec00000 RBX:
ffff8881008d9400 RCX: 0000000000000000 RDX: 00001a94d9502071 RSI:
fffffffbb3498394 RDI: 0000000000000000 RBP: 0000000000000002 R08:
0000000000000002 R09: 00001a94d7bd7640 R10: 0000000000000006 R11:
0000000000000020 R12: ffffffff81f98280 R13: 0000000000000002 R14:
00001a94d9502071 R15: 0000000000000000 cpuidle_enter+0x2a/0x40
do_idle+0x12d/0x1a0 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: udp_diag netconsole sch_htb cls_u32 sch_ingress
sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT
xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat
xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog
ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw
iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun pppoe
binfmt_misc pppox ppp_generic slhc af_packet bridge stp llc ctr ccm
dm_crypt radeon drm_client_lib video wmi drm_exec drm_suballoc_helper
ath9k drm_ttm_helper syscopyarea ttm sysfillrect ath9k_common sysimgblt
ath9k_hw fb_sys_fops drm_display_helper drm_kms_helper ath mac80211
agpgart pl2303 snd_hda_codec_realtek cfbfillrect snd_hda_codec_generic
usbserial snd_hda_codec_hdmi snd_hda_scodec_component cfbimgblt
snd_hda_intel fb_io_fops snd_intel_dspcfg cfbcopyarea snd_hda_codec
i2c_algo_bit fb snd_hda_core aesni_intel cfg80211 cdc_acm snd_pcm
crypto_simd font snd_timer cryptd snd at24 e1000 regmap_i2c
acpi_cpufreq libarc4 soundcore k10temp fam15h_power evdev nfsd
sch_fq_codel auth_rpcgss lockd grace drm sunrpc
drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink
usbhid ohci_pci xhci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd
sha512_ssse3 usbcore sha256_ssse3 sha1_ssse3 sha1_generic gf128mul
usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus
i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4 CR2:
0000000000000000 ---[ end trace 0000000000000000 ]--- RIP:
0010:rb_next+0x0/0x50 Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d
41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00
00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89
d0 48 8b RSP: 0018:ffffc90000003e50 EFLAGS: 00010246 RAX:
0000000000000000 RBX: ffff88811a764000 RCX: ffff88811a764180 RDX:
ffff88835e4c6c00 RSI: ffff888162c998e8 RDI: 0000000000000000 RBP:
0000000000000000 R08: ffff88811a7642b0 R09: 00000000a535eebc R10:
0000000000000d09 R11: ffffc90000003ff8 R12: ffff88835e4c6c00 R13:
ffff88811a7642b8 R14: 00001a951355b383 R15: 0000000000000000 FS:
0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 CR2: 0000000000000000
CR3: 00000001084b4000 CR4: 00000000000406f0 Kernel panic - not syncing:
Fatal exception in interrupt Kernel Offset: disabled ---[ end Kernel
panic - not syncing: Fatal exception in interrupt ]---



BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1062b1067 P4D 1062b1067 PUD 1062ae067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G           O
6.14.3 #20 Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by
O.E.M./970A-DS3P, BIOS FD 02/26/2016 RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b
5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f
48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b RSP:
0018:ffffc9000010ce50 EFLAGS: 00010246 RAX: 0000000000000000 RBX:
ffff88812106e000 RCX: ffff88812106e180 RDX: ffff888129726c00 RSI:
ffff888106a052e8 RDI: 0000000000000000 RBP: 0000000000000000 R08:
ffff88812106e2b0 R09: 0000000036705a4e R10: 0000000000000d03 R11:
ffffc9000010cff8 R12: ffff888129726c00 R13: ffff88812106e2b8 R14:
000000d9fd03fce6 R15: 0000000000000000 FS:  0000000000000000(0000)
GS:ffff88842ec80000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033 CR2: 0000000000000000 CR3: 0000000112716000
CR4: 00000000000406f0 Call Trace: <IRQ>
 htb_dequeue+0x42f/0x610 [sch_htb]
 __qdisc_run+0x253/0x480
 ? timerqueue_del+0x2c/0x40
 qdisc_run+0x15/0x30
 net_tx_action+0x182/0x1b0
 handle_softirqs+0x102/0x240
 __irq_exit_rcu+0x3e/0xb0
 sysvec_apic_timer_interrupt+0x5b/0x70
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:acpi_safe_halt+0x22/0x30
Code: 0f 1f 84 00 00 00 00 00 65 48 8b 05 b8 38 71 7e 48 8b 00 a8 08 75
14 8b 05 a3 92 bb 00 85 c0 7e 07 0f 00 2d 20 4f 15 00 fb f4 <fa> e9 18
77 00 00 0f 1f 84 00 00 00 00 00 8a 47 08 3c 01 75 05 e9 RSP:
0018:ffffc900000c7e80 EFLAGS: 00000246 RAX: 0000000000000000 RBX:
0000000000000001 RCX: ffff88842ec80000 RDX: ffff888100ddd464 RSI:
ffff888100ddd400 RDI: ffff888100ddd464 RBP: 0000000000000001 R08:
0000000000000001 R09: 071c71c71c71c71c R10: 0000000000000006 R11:
0000000000000020 R12: ffffffff81f98280 R13: ffffffff81f982e8 R14:
ffffffff81f98300 R15: 0000000000000000 acpi_idle_enter+0x8f/0xa0
cpuidle_enter_state+0xb3/0x220 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 start_secondary+0xed/0xf0
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: netconsole sch_htb cls_u32 sch_ingress sch_cake ifb
act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp
xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat
xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog
ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw
iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun pppoe
pppox binfmt_misc ppp_generic slhc af_packet bridge stp llc ctr ccm
dm_crypt radeon drm_client_lib ath9k video wmi drm_exec ath9k_common
drm_suballoc_helper ath9k_hw drm_ttm_helper syscopyarea ttm sysfillrect
sysimgblt ath pl2303 snd_hda_codec_realtek fb_sys_fops
snd_hda_codec_generic usbserial mac80211 drm_display_helper
snd_hda_codec_hdmi snd_hda_scodec_component drm_kms_helper
snd_hda_intel snd_intel_dspcfg snd_hda_codec agpgart cfbfillrect
snd_hda_core cfbimgblt fb_io_fops aesni_intel snd_pcm cfg80211 e1000
cfbcopyarea i2c_algo_bit cdc_acm fb crypto_simd snd_timer snd cryptd
acpi_cpufreq at24 font fam15h_power libarc4 soundcore k10temp
regmap_i2c evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc
drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink
usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore
sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common
dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev
i2c_core it87 hwmon_vid msr dmi_sysfs autofs4 CR2: 0000000000000000
---[ end trace 0000000000000000 ]--- RIP: 0010:rb_next+0x0/0x50 Code:
e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41
5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89
f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b RSP:
0018:ffffc9000010ce50 EFLAGS: 00010246 RAX: 0000000000000000 RBX:
ffff88812106e000 RCX: ffff88812106e180 RDX: ffff888129726c00 RSI:
ffff888106a052e8 RDI: 0000000000000000 RBP: 0000000000000000 R08:
ffff88812106e2b0 R09: 0000000036705a4e R10: 0000000000000d03 R11:
ffffc9000010cff8 R12: ffff888129726c00 R13: ffff88812106e2b8 R14:
000000d9fd03fce6 R15: 0000000000000000 FS:  0000000000000000(0000)
GS:ffff88842ec80000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033 CR2: 0000000000000000 CR3: 0000000112716000
CR4: 00000000000406f0 Kernel panic - not syncing: Fatal exception in
interrupt Kernel Offset: disabled ---[ end Kernel panic - not syncing:
Fatal exception in interrupt ]---



BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G           O
6.14.3 #20 Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by
O.E.M./970A-DS3P, BIOS FD 02/26/2016 RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b
5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f
48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b RSP:
0018:ffffc9000010ce50 EFLAGS: 00010246 RAX: 0000000000000000 RBX:
ffff88811899d000 RCX: ffff88811899d180 RDX: ffff8881845f2800 RSI:
ffff8881069b7ae8 RDI: 0000000000000000 RBP: 0000000000000000 R08:
ffff88811899d2b0 R09: 000000002997d2aa R10: 0000000000003fbf R11:
ffffc9000010cff8 R12: ffff8881845f2800 R13: ffff88811899d2b8 R14:
000000a69ae56401 R15: 0000000000000000 FS:  0000000000000000(0000)
GS:ffff88842ec80000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033 CR2: 0000000000000000 CR3: 0000000103c80000
CR4: 00000000000406f0 Call Trace: <IRQ>
 htb_dequeue+0x42f/0x610 [sch_htb]
 __qdisc_run+0x253/0x480
 ? timerqueue_del+0x2c/0x40
 qdisc_run+0x15/0x30
 net_tx_action+0x182/0x1b0
 handle_softirqs+0x102/0x240
 __irq_exit_rcu+0x3e/0xb0
 sysvec_apic_timer_interrupt+0x5b/0x70
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:cpuidle_enter_state+0x126/0x220
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8
9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc
00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49 RSP:
0018:ffffc900000c7e98 EFLAGS: 00000202 RAX: ffff88842ec80000 RBX:
ffff888101d7f800 RCX: 0000000000000000 RDX: 000000a6607c6802 RSI:
fffffffc350c4254 RDI: 0000000000000000 RBP: 0000000000000002 R08:
0000000000000002 R09: 000000e8ec11c440 R10: 0000000000000006 R11:
0000000000000020 R12: ffffffff81f98280 R13: 0000000000000002 R14:
000000a6607c6802 R15: 0000000000000000 ?
cpuidle_enter_state+0x116/0x220 cpuidle_enter+0x2a/0x40
do_idle+0x12d/0x1a0 cpu_startup_entry+0x29/0x30
 start_secondary+0xed/0xf0
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred
xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper
nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE
iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw
ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter
ip6_tables iptable_filter ip_tables x_tables pppoe tun pppox
binfmt_misc ppp_generic slhc netconsole af_packet bridge stp llc ctr
ccm dm_crypt radeon drm_client_lib video wmi drm_exec ath9k
drm_suballoc_helper drm_ttm_helper syscopyarea ttm ath9k_common
ath9k_hw sysfillrect sysimgblt fb_sys_fops drm_display_helper ath
pl2303 drm_kms_helper usbserial mac80211 snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi agpgart
snd_hda_scodec_component cfbfillrect snd_hda_intel cfbimgblt
snd_intel_dspcfg snd_hda_codec fb_io_fops snd_hda_core cfbcopyarea
aesni_intel i2c_algo_bit cfg80211 snd_pcm fb snd_timer e1000 snd
crypto_simd cdc_acm cryptd at24 font acpi_cpufreq libarc4 soundcore
fam15h_power regmap_i2c k10temp evdev nfsd sch_fq_codel auth_rpcgss
lockd grace sunrpc drm fuse configfs drm_panel_orientation_quirks
backlight loop nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd
ehci_pci ehci_hcd sha512_ssse3 sha256_ssse3 usbcore sha1_ssse3
sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid
i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs
autofs4 CR2: 0000000000000000 ---[ end trace 0000000000000000 ]--- RIP:
0010:rb_next+0x0/0x50 Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d
41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00
00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89
d0 48 8b RSP: 0018:ffffc9000010ce50 EFLAGS: 00010246 RAX:
0000000000000000 RBX: ffff88811899d000 RCX: ffff88811899d180 RDX:
ffff8881845f2800 RSI: ffff8881069b7ae8 RDI: 0000000000000000 RBP:
0000000000000000 R08: ffff88811899d2b0 R09: 000000002997d2aa R10:
0000000000003fbf R11: ffffc9000010cff8 R12: ffff8881845f2800 R13:
ffff88811899d2b8 R14: 000000a69ae56401 R15: 0000000000000000 FS:
0000000000000000(0000) GS:ffff88842ec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 CR2: 0000000000000000
CR3: 0000000103c80000 CR4: 00000000000406f0 Kernel panic - not syncing:
Fatal exception in interrupt Kernel Offset: disabled ---[ end Kernel
panic - not syncing: Fatal exception in interrupt ]---


#!/bin/bash

# https://www.bufferbloat.net/projects/codel/wiki/Cake/#installing-cake-out-of-tree-on-linux
# https://trofi.github.io/posts/217-mitigating%20bufferbloat.html

#set -x

set -o nounset
set -o errexit

export PATH=/sbin:/bin:/usr/sbin:/usr/bin

ext=ppp0
ext_ingress=ppp0ifb0

# [query ADSL modem for up and down rates]

echo -e "pppd pppoe UP $UP DN $DN" | systemd-cat -t traffic-control

ext_up=$((UP * 95 / 100))kbit
ext_down=$((DN * 95 / 100))kbit

# below taken from https://wiki.gentoo.org/wiki/Traffic_shaping

q=1486                  # HTB Quantum = 1500bytes IP + 14 bytes ethernet.
			# Higher bandwidths may require a higher htb quantum. MEASURE.
			# Some ADSL devices might require a stab setting.

quantum=300		# fq_codel quantum 300 gives a boost to interactive flows
			# At higher bandwidths (50Mbit+) don't bother

modprobe act_mirred
modprobe ifb
modprobe sch_cake
modprobe sch_fq_codel

ethtool -K "$ext" tso off gso off gro off # Also turn of gro on ALL interfaces
                                        # e.g ethtool -K eth1 gro off if you have eth1
					# some devices you may need to run these
					# commands independently

# Clear old queuing disciplines (qdisc) on the interfaces
tc qdisc del dev "$ext" root		>& /dev/null || true
tc qdisc del dev "$ext" ingress		>& /dev/null || true
tc qdisc del dev "$ext_ingress" root	>& /dev/null || true
tc qdisc del dev "$ext_ingress" ingress	>& /dev/null || true
ip link del "$ext_ingress"  		>& /dev/null || true

#########
# INGRESS
#########

# Create ingress on external interface
tc qdisc add dev "$ext" handle ffff: ingress

ip link add name "$ext_ingress"  type ifb
ip link set dev "$ext_ingress" up || true # if the interace is not up bad things happen

# Forward all ingress traffic to the IFB device
tc filter add dev "$ext" parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev "$ext_ingress"

# Create an EGRESS filter on the IFB device

# Warning: sch_htb: quantum of class 10001 is big. Consider r2q change
# https://web.archive.org/web/20030514055053/http://www.docum.org/stef.coene/qos/faq/cache/31.html
# default r2q is 10
# since up ADSL rate went from 24.4 Mb/s to 26.8 Mb/s, "r2q 15" started giving a "too big" error
# up it to 20, now OK again
tc qdisc add dev "$ext_ingress" root handle 1: htb default 11 r2q 20

# Add root class HTB with rate limiting

tc class add dev "$ext_ingress" parent 1: classid 1:1 htb rate $ext_down #|& grep -v "Consider r2q change" || true
tc class add dev "$ext_ingress" parent 1:1 classid 1:11 htb rate $ext_down prio 0 quantum $q

# Add FQ_CODEL qdisc with ECN support (if you want ecn)
tc qdisc add dev "$ext_ingress" parent 1:11 fq_codel quantum $quantum ecn

#########
# EGRESS
#########
# Add FQ_CODEL to EGRESS on external interface
tc qdisc add dev "$ext" root handle 1: htb default 11

# Add root class HTB with rate limiting
tc class add dev "$ext" parent 1: classid 1:1 htb rate $ext_up
tc class add dev "$ext" parent 1:1 classid 1:11 htb rate $ext_up prio 0 quantum $q

# Note: You can apply a packet limit here and on ingress if you are memory constrained - e.g
# for low bandwidths and machines with < 64MB of ram, limit 1000 is good, otherwise no point

# Add FQ_CODEL qdisc without ECN support - on egress it's generally better to just drop the packet
# but feel free to enable it if you want.

tc qdisc add dev "$ext" parent 1:11 fq_codel quantum $quantum noecn



$ cat ~/1.panic | scripts/decode_stacktrace.sh vmlinux
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O
6.14.3 #20 Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by
O.E.M./970A-DS3P, BIOS FD 02/26/2016 RIP: 0010:rb_next
(lib/rbtree.c:496) Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41
5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00
00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0
48 8b All code ======== 0:	e8 d5 fa ff ff       	call
0xfffffffffffffada 5:	5b                   	pop    %rbx
   6:	4c 89 e0             	mov    %r12,%rax
   9:	5d                   	pop    %rbp
   a:	41 5c                	pop    %r12
   c:	41 5d                	pop    %r13
   e:	41 5e                	pop    %r14
  10:	e9 85 73 01 00       	jmp    0x1739a
  15:	5b                   	pop    %rbx
  16:	5d                   	pop    %rbp
  17:	41 5c                	pop    %r12
  19:	41 5d                	pop    %r13
  1b:	41 5e                	pop    %r14
  1d:	e9 38 76 01 00       	jmp    0x1765a
  22:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  29:	00 
  2a:*	48 3b 3f             	cmp    (%rdi),%rdi
	<-- trapping instruction 2d:	48 89 f8
	mov    %rdi,%rax 30:	74 38                	je
0x6a 32:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  36:	48 85 d2             	test   %rdx,%rdx
  39:	74 11                	je     0x4c
  3b:	48 89 d0             	mov    %rdx,%rax
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	48 3b 3f             	cmp    (%rdi),%rdi
   3:	48 89 f8             	mov    %rdi,%rax
   6:	74 38                	je     0x40
   8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   c:	48 85 d2             	test   %rdx,%rdx
   f:	74 11                	je     0x22
  11:	48 89 d0             	mov    %rdx,%rax
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811a764000 RCX: ffff88811a764180
RDX: ffff88835e4c6c00 RSI: ffff888162c998e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811a7642b0 R09: 00000000a535eebc
R10: 0000000000000d09 R11: ffffc90000003ff8 R12: ffff88835e4c6c00
R13: ffff88811a7642b8 R14: 00001a951355b383 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000)
knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001084b4000 CR4: 00000000000406f0
Call Trace:
<IRQ>
htb_dequeue (net/sched/sch_htb.c:351 (discriminator 1)
net/sched/sch_htb.c:924 (discriminator 1) net/sched/sch_htb.c:982
(discriminator 1)) sch_htb __qdisc_run (net/sched/sch_generic.c:294
net/sched/sch_generic.c:398 net/sched/sch_generic.c:416) ?
timerqueue_del (lib/timerqueue.c:58) qdisc_run
(./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124)
net_tx_action (net/core/dev.c:5553) handle_softirqs
(./arch/x86/include/asm/atomic.h:23
./include/linux/atomic/atomic-arch-fallback.h:457
./include/linux/jump_label.h:262 ./include/trace/events/irq.h:142
kernel/softirq.c:562) __irq_exit_rcu (kernel/softirq.c:435
kernel/softirq.c:662) sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1049 (discriminator 35)
arch/x86/kernel/apic/apic.c:1049 (discriminator 35)) </IRQ> <TASK>
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:574)
RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:292) Code: 18
4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98
ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00
49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49 All code ========
0:	18 4c 6f 00          	sbb    %cl,0x0(%rdi,%rbp,2)
4:	85 c0                	test   %eax,%eax 6:	7e 0b
               	jle    0x13 8:	8b 73 04
	mov    0x4(%rbx),%esi b:	83 cf ff             	or
    $0xffffffff,%edi e:	e8 a1 22 e5 ff       	call
0xffffffffffe522b4 13:	31 ff                	xor
%edi,%edi 15:	e8 9a 2e 98 ff       	call
0xffffffffff982eb4 1a:	45 84 ff             	test
%r15b,%r15b 1d:	74 07                	je     0x26
1f:	31 ff                	xor    %edi,%edi 21:	e8
0e 58 9d ff       	call   0xffffffffff9d5834 26:	fb
            	sti 27:	45 85 ed             	test
%r13d,%r13d 2a:*	0f 88 cc 00 00 00    	js     0xfc
	<-- trapping instruction 30:	49 63 c5
	movslq %r13d,%rax 33:	48 8b 3c 24          	mov
 (%rsp),%rdi 37:	48 6b c8 68          	imul
$0x68,%rax,%rcx 3b:	48 6b d0 30          	imul
$0x30,%rax,%rdx 3f:	49                   	rex.WB

Code starting with the faulting instruction
===========================================
   0:	0f 88 cc 00 00 00    	js     0xd2
   6:	49 63 c5             	movslq %r13d,%rax
   9:	48 8b 3c 24          	mov    (%rsp),%rdi
   d:	48 6b c8 68          	imul   $0x68,%rax,%rcx
  11:	48 6b d0 30          	imul   $0x30,%rax,%rdx
  15:	49                   	rex.WB
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff8881008d9400 RCX: 0000000000000000
RDX: 00001a94d9502071 RSI: fffffffbb3498394 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 00001a94d7bd7640
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 00001a94d9502071 R15: 0000000000000000
cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2)) 
do_idle (kernel/sched/idle.c:234 kernel/sched/idle.c:325) 
cpu_startup_entry (kernel/sched/idle.c:422) 
rest_init (init/main.c:743) 
start_kernel (init/main.c:1525) 
x86_64_start_reservations (arch/x86/kernel/head64.c:513) 
x86_64_start_kernel (??:?) 
common_startup_64 (arch/x86/kernel/head_64.S:421) 
</TASK>
Modules linked in: udp_diag netconsole sch_htb cls_u32 sch_ingress
sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT
xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat
xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog
ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw
iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun pppoe
binfmt_misc pppox ppp_generic slhc af_packet bridge stp llc ctr ccm
dm_crypt radeon drm_client_lib video wmi drm_exec drm_suballoc_helper
ath9k drm_ttm_helper syscopyarea ttm sysfillrect ath9k_common sysimgblt
ath9k_hw fb_sys_fops drm_display_helper drm_kms_helper ath mac80211
agpgart pl2303 snd_hda_codec_realtek cfbfillrect snd_hda_codec_generic
usbserial snd_hda_codec_hdmi snd_hda_scodec_component cfbimgblt
snd_hda_intel fb_io_fops snd_intel_dspcfg cfbcopyarea snd_hda_codec
i2c_algo_bit fb snd_hda_core aesni_intel cfg80211 cdc_acm snd_pcm
crypto_simd font snd_timer cryptd snd at24 e1000 regmap_i2c
acpi_cpufreq libarc4 soundcore k10temp fam15h_power evdev nfsd
sch_fq_codel auth_rpcgss lockd grace drm sunrpc
drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink
usbhid ohci_pci xhci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd
sha512_ssse3 usbcore sha256_ssse3 sha1_ssse3 sha1_generic gf128mul
usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus
i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4 CR2:
0000000000000000 ---[ end trace 0000000000000000 ]--- RIP: 0010:rb_next
(lib/rbtree.c:496) Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41
5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00
00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0
48 8b All code ======== 0:	e8 d5 fa ff ff       	call
0xfffffffffffffada 5:	5b                   	pop    %rbx
6:	4c 89 e0             	mov    %r12,%rax 9:	5d
               	pop    %rbp a:	41 5c
	pop    %r12 c:	41 5d                	pop    %r13
e:	41 5e                	pop    %r14 10:	e9 85 73
01 00       	jmp    0x1739a 15:	5b
	pop    %rbx 16:	5d                   	pop    %rbp
17:	41 5c                	pop    %r12 19:	41 5d
            	pop    %r13 1b:	41 5e
pop    %r14 1d:	e9 38 76 01 00       	jmp    0x1765a
22:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
29:	00 2a:*	48 3b 3f             	cmp
(%rdi),%rdi		<-- trapping instruction 2d:	48 89 f8
            	mov    %rdi,%rax 30:	74 38
	je     0x6a 32:	48 8b 57 08          	mov
0x8(%rdi),%rdx 36:	48 85 d2             	test   %rdx,%rdx
39:	74 11                	je     0x4c 3b:	48 89 d0
            	mov    %rdx,%rax 3e:	48
	rex.W 3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	48 3b 3f             	cmp    (%rdi),%rdi
   3:	48 89 f8             	mov    %rdi,%rax
   6:	74 38                	je     0x40
   8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   c:	48 85 d2             	test   %rdx,%rdx
   f:	74 11                	je     0x22
  11:	48 89 d0             	mov    %rdx,%rax
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811a764000 RCX: ffff88811a764180
RDX: ffff88835e4c6c00 RSI: ffff888162c998e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811a7642b0 R09: 00000000a535eebc
R10: 0000000000000d09 R11: ffffc90000003ff8 R12: ffff88835e4c6c00
R13: ffff88811a7642b8 R14: 00001a951355b383 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000)
knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001084b4000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
$ 


-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

