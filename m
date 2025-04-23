Return-Path: <stable+bounces-135253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02687A98676
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9811B61289
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED26267720;
	Wed, 23 Apr 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="f4kHKvcc"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F912638A6;
	Wed, 23 Apr 2025 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401931; cv=none; b=maRYMfoqz+hikmq4XuNd7kAcHNXEE7W69xFImavaIOjBbKXRVRk4FTyZSIy4U8zFz87jlB3sr/qo0jvwCCuwjtcVZE+s2Z/VA9MxDlnhCgIm2qvIYxu6n+qiQroxpvXt6Rs2iKL4TCPPQeRKpwJOoCyGv0fEzhN36boMlWA4dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401931; c=relaxed/simple;
	bh=WOozxA7JmAlAWd60GMX1b1lFDDZ/x+g9tSp/vPyYotM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6upJAC+uGS8slOgEVmKaOWCoMp3oMR85HxpzIfqewfSayAZ+QMS6wjBwZ3inrCda+0VTkAS5cvj7eba0N+rxBCaHd4toKQ9Z0SPf1O/PTLhd4+STfh76mV8tlR64qDSn3wO9LPSXpmj/VW+IMVxivwrRFt3gaBgBRC42EfHfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=fail (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=f4kHKvcc reason="signature verification failed"; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 3027112086D;
	Wed, 23 Apr 2025 10:51:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745401913;
	bh=AmSzq95jWT6ouFo+UPoV+fYl7qT29nUVb7RHNWFzkDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f4kHKvccdkpLVTXYh2k4o23SBUCWq266M6sjYavhPBccfQGme4FyII+ZJJ0+xDyTE
	 DBa6XcM45vo7nfWmR+uaTG4mmf9zo4ZDZchrhBmC2nFN4+4//ERv+Jla8HfhLnlI5n
	 Ul/WDRYt9Jl2+u8cbZ+AgD11jRf+HfdUF+CJdatOxOrc/UPDumrj5Pn0Ee56rRM8jq
	 poG6ndhAaBD19Z40k0jbMcvCftDJf5dD5hgCRcQ8nZCmv6ia8Dl0KRw4X4bqVrOJfb
	 diNH9UO+3Xyq7CZ1/gh3wE6399j51ExQ4p8B/St8TcMHmssy9BXR7nBu7I6P80RWtQ
	 bdNuRQKwTVLwg==
Date: Wed, 23 Apr 2025 10:51:49 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
In-Reply-To: <aAgO59L0ccXl6kUs@pop-os.localdomain>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
	<20250421131000.6299a8e0@frodo.int.wylie.me.uk>
	<20250421200601.5b2e28de@frodo.int.wylie.me.uk>
	<89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
	<20250421210927.50d6a355@frodo.int.wylie.me.uk>
	<20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
	<4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
	<aAf/K7F9TmCJIT+N@pop-os.localdomain>
	<20250422214716.5e181523@frodo.int.wylie.me.uk>
	<aAgO59L0ccXl6kUs@pop-os.localdomain>
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

On Tue, 22 Apr 2025 14:49:27 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> Although I am still trying to understand the NULL pointer, which seems
> likely from:
> 
>  478                         if (p->inner.clprio[prio].ptr == cl->node + prio) {
>  479                                 /* we are removing child which is pointed to from
>  480                                  * parent feed - forget the pointer but remember
>  481                                  * classid
>  482                                  */
>  483                                 p->inner.clprio[prio].last_ptr_id = cl->common.classid;
>  484                                 p->inner.clprio[prio].ptr = NULL;
>  485                         }
> 
> Does the following patch work? I mean not just fixing the crash, but
> also not causing any other problem.

> ---
> 
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 4b9a639b642e..0cdc778fddef 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
>   */
>  static inline void htb_next_rb_node(struct rb_node **n)
>  {
> -	*n = rb_next(*n);
> +	if (*n)
> +		*n = rb_next(*n);
>  }
>  
>  /**

There's been three of these: 

Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 10:41:36 bilbo kernel: WARNING: CPU: 1 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]

But no panic.

I've run scripts/decode.sh on the last one.

Apr 23 08:08:32 bilbo kernel: ------------[ cut here ]------------
Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 08:08:32 bilbo kernel: Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe pppox ppp_generic binfmt_misc tun slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k drm_client_lib ath9k_common video ath9k_hw wmi drm_exec drm_suballoc_helper snd_hda_codec_realtek drm_ttm_helper snd_hda_codec_generic snd_hda_codec_hdmi ath syscopyarea snd_hda_scodec_component ttm pl2303 snd_hda_intel usbserial mac80211 sysfillrect snd_intel_dspcfg sysimgblt snd_hda_codec fb_sys_fops drm_display_helper drm_kms_helper snd_hda_co
 re agpgart snd_pcm cfbfillrect cfbimgblt snd_timer
Apr 23 08:08:32 bilbo kernel: cfg80211 fb_io_fops cdc_acm cfbcopyarea aesni_intel i2c_algo_bit e1000 crypto_simd snd fb cryptd at24 libarc4 regmap_i2c font fam15h_power soundcore acpi_cpufreq k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks backlight fuse loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
Apr 23 08:08:32 bilbo kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-dirty #23
Apr 23 08:08:32 bilbo kernel: Tainted: [O]=OOT_MODULE
Apr 23 08:08:32 bilbo kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
Apr 23 08:08:32 bilbo kernel: RIP: 0010:htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 08:08:32 bilbo kernel: Code: d4 45 21 a4 87 08 01 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c1 c5 a7 e0 90 53 83 be a8 01 00 00 00 48 89 f3 75 02 <0f> 0b 48 89 de e8 29 fe ff ff 31 c0 89 83 a8 01 00 00 5b e9 9b c5
Apr 23 08:08:32 bilbo kernel: RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
Apr 23 08:08:32 bilbo kernel: RAX: ffff8881b7311c00 RBX: ffff8881b7312000 RCX: ffff8881b73121c8
Apr 23 08:08:32 bilbo kernel: RDX: ffff8881b7312000 RSI: ffff8881b7312000 RDI: ffff88811c353180
Apr 23 08:08:32 bilbo kernel: RBP: 0000000000000000 R08: ffff88811c3532b0 R09: 000000009ceae056
Apr 23 08:08:32 bilbo kernel: R10: 0000000000005de4 R11: ffffc90000003ff8 R12: 0000000000000000
Apr 23 08:08:32 bilbo kernel: R13: ffff8881b7312000 R14: 00000273e71c1348 R15: 0000000000000000
Apr 23 08:08:32 bilbo kernel: FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
Apr 23 08:08:32 bilbo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 23 08:08:32 bilbo kernel: CR2: 000000c00050b000 CR3: 000000018920e000 CR4: 00000000000406f0
Apr 23 08:08:32 bilbo kernel: Call Trace:
Apr 23 08:08:32 bilbo kernel: <IRQ>
Apr 23 08:08:32 bilbo kernel: htb_dequeue+0x3f1/0x5a0 [sch_htb]
Apr 23 08:08:32 bilbo kernel: __qdisc_run+0x253/0x480
Apr 23 08:08:32 bilbo kernel: ? timerqueue_del+0x2c/0x40
Apr 23 08:08:32 bilbo kernel: qdisc_run+0x15/0x30
Apr 23 08:08:32 bilbo kernel: net_tx_action+0x182/0x1b0
Apr 23 08:08:32 bilbo kernel: handle_softirqs+0x102/0x240
Apr 23 08:08:32 bilbo kernel: __irq_exit_rcu+0x3e/0xb0
Apr 23 08:08:32 bilbo kernel: sysvec_apic_timer_interrupt+0x5b/0x70
Apr 23 08:08:32 bilbo kernel: </IRQ>
Apr 23 08:08:32 bilbo kernel: <TASK>
Apr 23 08:08:32 bilbo kernel: asm_sysvec_apic_timer_interrupt+0x16/0x20
Apr 23 08:08:32 bilbo kernel: RIP: 0010:cpuidle_enter_state+0x126/0x220
Apr 23 08:08:32 bilbo kernel: Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
Apr 23 08:08:32 bilbo kernel: RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
Apr 23 08:08:32 bilbo kernel: RAX: ffff88842ec00000 RBX: ffff8881008d8000 RCX: 0000000000000000
Apr 23 08:08:32 bilbo kernel: RDX: 00000273acf9a9e7 RSI: fffffff6533d45e7 RDI: 0000000000000000
Apr 23 08:08:32 bilbo kernel: RBP: 0000000000000002 R08: 0000000000000002 R09: 071c71c71c71c71c
Apr 23 08:08:32 bilbo kernel: R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
Apr 23 08:08:32 bilbo kernel: R13: 0000000000000002 R14: 00000273acf9a9e7 R15: 0000000000000000
Apr 23 08:08:32 bilbo kernel: cpuidle_enter+0x2a/0x40
Apr 23 08:08:32 bilbo kernel: do_idle+0x12d/0x1a0
Apr 23 08:08:32 bilbo kernel: cpu_startup_entry+0x29/0x30
Apr 23 08:08:32 bilbo kernel: rest_init+0xbc/0xc0
Apr 23 08:08:32 bilbo kernel: start_kernel+0x630/0x630
Apr 23 08:08:32 bilbo kernel: x86_64_start_reservations+0x25/0x30
Apr 23 08:08:32 bilbo kernel: x86_64_start_kernel+0x73/0x80
Apr 23 08:08:32 bilbo kernel: common_startup_64+0x12c/0x138
Apr 23 08:08:32 bilbo kernel: </TASK>
Apr 23 08:08:32 bilbo kernel: ---[ end trace 0000000000000000 ]---

Apr 23 08:08:32 bilbo kernel: ------------[ cut here ]------------
Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 08:08:32 bilbo kernel: Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe pppox ppp_generic binfmt_misc tun slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k drm_client_lib ath9k_common video ath9k_hw wmi drm_exec drm_suballoc_helper snd_hda_codec_realtek drm_ttm_helper snd_hda_codec_generic snd_hda_codec_hdmi ath syscopyarea snd_hda_scodec_component ttm pl2303 snd_hda_intel usbserial mac80211 sysfillrect snd_intel_dspcfg sysimgblt snd_hda_codec fb_sys_fops drm_display_helper drm_kms_helper snd_hda_co
 re agpgart snd_pcm cfbfillrect cfbimgblt snd_timer
Apr 23 08:08:32 bilbo kernel: cfg80211 fb_io_fops cdc_acm cfbcopyarea aesni_intel i2c_algo_bit e1000 crypto_simd snd fb cryptd at24 libarc4 regmap_i2c font fam15h_power soundcore acpi_cpufreq k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks backlight fuse loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
Apr 23 08:08:32 bilbo kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.14.3-dirty #23
Apr 23 08:08:32 bilbo kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
Apr 23 08:08:32 bilbo kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
Apr 23 08:08:32 bilbo kernel: RIP: 0010:htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 08:08:32 bilbo kernel: Code: d4 45 21 a4 87 08 01 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c1 c5 a7 e0 90 53 83 be a8 01 00 00 00 48 89 f3 75 02 <0f> 0b 48 89 de e8 29 fe ff ff 31 c0 89 83 a8 01 00 00 5b e9 9b c5
Apr 23 08:08:32 bilbo kernel: RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
Apr 23 08:08:32 bilbo kernel: RAX: ffff8881b7311c00 RBX: ffff8881b7312000 RCX: ffff8881b73121c8
Apr 23 08:08:32 bilbo kernel: RDX: ffff8881b7312000 RSI: ffff8881b7312000 RDI: ffff88811c353180
Apr 23 08:08:32 bilbo kernel: RBP: 0000000000000000 R08: ffff88811c3532b0 R09: 000000009cee5629
Apr 23 08:08:32 bilbo kernel: R10: 00000000000033ab R11: 001dcd6500000000 R12: 0000000000000000
Apr 23 08:08:32 bilbo kernel: R13: ffff8881b7312000 R14: 00000273f4f3639c R15: 0000000000000000
Apr 23 08:08:32 bilbo kernel: FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
Apr 23 08:08:32 bilbo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 23 08:08:32 bilbo kernel: CR2: 00007fc3b0cb0000 CR3: 0000000126e70000 CR4: 00000000000406f0
Apr 23 08:08:32 bilbo kernel: Call Trace:
Apr 23 08:08:32 bilbo kernel: <IRQ>
Apr 23 08:08:32 bilbo kernel: htb_dequeue+0x3f1/0x5a0 [sch_htb]
Apr 23 08:08:32 bilbo kernel: __qdisc_run+0x253/0x480
Apr 23 08:08:32 bilbo kernel: ? timerqueue_del+0x2c/0x40
Apr 23 08:08:32 bilbo kernel: qdisc_run+0x15/0x30
Apr 23 08:08:32 bilbo kernel: net_tx_action+0x182/0x1b0
Apr 23 08:08:32 bilbo kernel: handle_softirqs+0x102/0x240
Apr 23 08:08:32 bilbo kernel: __irq_exit_rcu+0x3e/0xb0
Apr 23 08:08:32 bilbo kernel: sysvec_apic_timer_interrupt+0x5b/0x70
Apr 23 08:08:32 bilbo kernel: </IRQ>
Apr 23 08:08:32 bilbo kernel: <TASK>
Apr 23 08:08:32 bilbo kernel: asm_sysvec_apic_timer_interrupt+0x16/0x20
Apr 23 08:08:32 bilbo kernel: RIP: 0010:cpuidle_enter_state+0x126/0x220
Apr 23 08:08:32 bilbo kernel: Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
Apr 23 08:08:32 bilbo kernel: RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
Apr 23 08:08:32 bilbo kernel: RAX: ffff88842ec00000 RBX: ffff8881008d8000 RCX: 0000000000000000
Apr 23 08:08:32 bilbo kernel: RDX: 00000273bad0f26e RSI: fffffff6533d45e7 RDI: 0000000000000000
Apr 23 08:08:32 bilbo kernel: RBP: 0000000000000002 R08: 0000000000000002 R09: 000002b2b12dc100
Apr 23 08:08:32 bilbo kernel: R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
Apr 23 08:08:32 bilbo kernel: R13: 0000000000000002 R14: 00000273bad0f26e R15: 0000000000000000
Apr 23 08:08:32 bilbo kernel: cpuidle_enter+0x2a/0x40
Apr 23 08:08:32 bilbo kernel: do_idle+0x12d/0x1a0
Apr 23 08:08:32 bilbo kernel: cpu_startup_entry+0x29/0x30
Apr 23 08:08:32 bilbo kernel: rest_init+0xbc/0xc0
Apr 23 08:08:32 bilbo kernel: start_kernel+0x630/0x630
Apr 23 08:08:32 bilbo kernel: x86_64_start_reservations+0x25/0x30
Apr 23 08:08:32 bilbo kernel: x86_64_start_kernel+0x73/0x80
Apr 23 08:08:32 bilbo kernel: common_startup_64+0x12c/0x138
Apr 23 08:08:32 bilbo kernel: </TASK>
Apr 23 08:08:32 bilbo kernel: ---[ end trace 0000000000000000 ]---
Apr 23 08:08:35 bilbo kernel: AIF:UNPRIV TCP packet: IN=ppp0 OUT= MAC= SRC=23.94.171.218 DST=82.68.155.94 LEN=44 TOS=0x00 PREC=0x00 TTL=245 ID=16537 PROTO=TCP SPT=49012 DPT=25634 WINDOW=1024 RES=0x00 SYN URGP=0 


Apr 23 10:41:36 bilbo kernel: ------------[ cut here ]------------
Apr 23 10:41:36 bilbo kernel: WARNING: CPU: 1 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 10:41:36 bilbo kernel: Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe pppox ppp_generic binfmt_misc tun slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k drm_client_lib ath9k_common video ath9k_hw wmi drm_exec drm_suballoc_helper snd_hda_codec_realtek drm_ttm_helper snd_hda_codec_generic snd_hda_codec_hdmi ath syscopyarea snd_hda_scodec_component ttm pl2303 snd_hda_intel usbserial mac80211 sysfillrect snd_intel_dspcfg sysimgblt snd_hda_codec fb_sys_fops drm_display_helper drm_kms_helper snd_hda_co
 re agpgart snd_pcm cfbfillrect cfbimgblt snd_timer
Apr 23 10:41:36 bilbo kernel: cfg80211 fb_io_fops cdc_acm cfbcopyarea aesni_intel i2c_algo_bit e1000 crypto_simd snd fb cryptd at24 libarc4 regmap_i2c font fam15h_power soundcore acpi_cpufreq k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks backlight fuse loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
Apr 23 10:41:36 bilbo kernel: CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W  O       6.14.3-dirty #23
Apr 23 10:41:36 bilbo kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
Apr 23 10:41:36 bilbo kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
Apr 23 10:41:36 bilbo kernel: RIP: 0010:htb_deactivate+0xd/0x30 [sch_htb]
Apr 23 10:41:36 bilbo kernel: Code: d4 45 21 a4 87 08 01 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c1 c5 a7 e0 90 53 83 be a8 01 00 00 00 48 89 f3 75 02 <0f> 0b 48 89 de e8 29 fe ff ff 31 c0 89 83 a8 01 00 00 5b e9 9b c5
Apr 23 10:41:36 bilbo kernel: RSP: 0018:ffffc9000010ce50 EFLAGS: 00010246
Apr 23 10:41:36 bilbo kernel: RAX: ffff8881aab77800 RBX: ffff8881b7368400 RCX: ffff8881b73685c8
Apr 23 10:41:36 bilbo kernel: RDX: ffff8881b7368400 RSI: ffff8881b7368400 RDI: ffff88811c27a180
Apr 23 10:41:36 bilbo kernel: RBP: 0000000000000000 R08: ffff88811c27a2b0 R09: 00000000b37f4031
Apr 23 10:41:36 bilbo kernel: R10: 0000000000003819 R11: ffffc9000010cff8 R12: 0000000000000000
Apr 23 10:41:36 bilbo kernel: R13: ffff8881b7368400 R14: 00000ace389b7f34 R15: 0000000000000000
Apr 23 10:41:36 bilbo kernel: FS:  0000000000000000(0000) GS:ffff88842ec80000(0000) knlGS:0000000000000000
Apr 23 10:41:36 bilbo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 23 10:41:36 bilbo kernel: CR2: 00007f0030446000 CR3: 00000002c2cd6000 CR4: 00000000000406f0
Apr 23 10:41:36 bilbo kernel: Call Trace:
Apr 23 10:41:36 bilbo kernel: <IRQ>
Apr 23 10:41:36 bilbo kernel: htb_dequeue+0x3f1/0x5a0 [sch_htb]
Apr 23 10:41:36 bilbo kernel: __qdisc_run+0x253/0x480
Apr 23 10:41:36 bilbo kernel: ? timerqueue_del+0x2c/0x40
Apr 23 10:41:36 bilbo kernel: qdisc_run+0x15/0x30
Apr 23 10:41:36 bilbo kernel: net_tx_action+0x182/0x1b0
Apr 23 10:41:36 bilbo kernel: handle_softirqs+0x102/0x240
Apr 23 10:41:36 bilbo kernel: __irq_exit_rcu+0x3e/0xb0
Apr 23 10:41:36 bilbo kernel: sysvec_apic_timer_interrupt+0x5b/0x70
Apr 23 10:41:36 bilbo kernel: </IRQ>
Apr 23 10:41:36 bilbo kernel: <TASK>
Apr 23 10:41:36 bilbo kernel: asm_sysvec_apic_timer_interrupt+0x16/0x20
Apr 23 10:41:36 bilbo kernel: RIP: 0010:acpi_safe_halt+0x22/0x30
Apr 23 10:41:36 bilbo kernel: Code: 0f 1f 84 00 00 00 00 00 65 48 8b 05 b8 38 71 7e 48 8b 00 a8 08 75 14 8b 05 a3 92 bb 00 85 c0 7e 07 0f 00 2d 20 4f 15 00 fb f4 <fa> e9 18 77 00 00 0f 1f 84 00 00 00 00 00 8a 47 08 3c 01 75 05 e9
Apr 23 10:41:36 bilbo kernel: RSP: 0018:ffffc900000c7e80 EFLAGS: 00000246
Apr 23 10:41:36 bilbo kernel: RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88842ec80000
Apr 23 10:41:36 bilbo kernel: RDX: ffff888100ddc864 RSI: ffff888100ddc800 RDI: ffff888100ddc864
Apr 23 10:41:36 bilbo kernel: RBP: 0000000000000001 R08: 0000000000000001 R09: 00000acdfd2a9600
Apr 23 10:41:36 bilbo kernel: R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
Apr 23 10:41:36 bilbo kernel: R13: ffffffff81f982e8 R14: ffffffff81f98300 R15: 0000000000000000
Apr 23 10:41:36 bilbo kernel: acpi_idle_enter+0x8f/0xa0
Apr 23 10:41:36 bilbo kernel: cpuidle_enter_state+0xb3/0x220
Apr 23 10:41:36 bilbo kernel: cpuidle_enter+0x2a/0x40
Apr 23 10:41:36 bilbo kernel: do_idle+0x12d/0x1a0
Apr 23 10:41:36 bilbo kernel: cpu_startup_entry+0x29/0x30
Apr 23 10:41:36 bilbo kernel: start_secondary+0xed/0xf0
Apr 23 10:41:36 bilbo kernel: common_startup_64+0x12c/0x138
Apr 23 10:41:36 bilbo kernel: </TASK>
Apr 23 10:41:36 bilbo kernel: ---[ end trace 0000000000000000 ]---


$ scripts/decode_stacktrace.sh vmlinux

Apr 23 10:41:36 bilbo kernel: Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe pppox ppp_generic binfmt_misc tun slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k drm_client_lib ath9k_common video ath9k_hw wmi drm_exec drm_suballoc_helper snd_hda_codec_realtek drm_ttm_helper snd_hda_codec_generic snd_hda_codec_hdmi ath syscopyarea snd_hda_scodec_component ttm pl2303 snd_hda_intel usbserial mac80211 sysfillrect snd_intel_dspcfg sysimgblt snd_hda_codec fb_sys_fops drm_display_helper drm_kms_helper snd_hda_co
 re agpgart snd_pcm cfbfillrect cfbimgblt snd_timer
Apr 23 10:41:36 bilbo kernel: cfg80211 fb_io_fops cdc_acm cfbcopyarea aesni_intel i2c_algo_bit e1000 crypto_simd snd fb cryptd at24 libarc4 regmap_i2c font fam15h_power soundcore acpi_cpufreq k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks backlight fuse loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
Apr 23 10:41:36 bilbo kernel: CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W  O       6.14.3-dirty #23
Apr 23 10:41:36 bilbo kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
Apr 23 10:41:36 bilbo kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
Apr 23 10:41:36 bilbo kernel: RIP: 0010:htb_deactivate (net/sched/sch_htb.c:613 (discriminator 1)) sch_htb 
Apr 23 10:41:36 bilbo kernel: Code: d4 45 21 a4 87 08 01 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c1 c5 a7 e0 90 53 83 be a8 01 00 00 00 48 89 f3 75 02 <0f> 0b 48 89 de e8 29 fe ff ff 31 c0 89 83 a8 01 00 00 5b e9 9b c5
All code
========
   0:	d4                   	(bad)
   1:	45 21 a4 87 08 01 00 	and    %r12d,0x108(%r15,%rax,4)
   8:	00 
   9:	48 83 c4 18          	add    $0x18,%rsp
   d:	5b                   	pop    %rbx
   e:	5d                   	pop    %rbp
   f:	41 5c                	pop    %r12
  11:	41 5d                	pop    %r13
  13:	41 5e                	pop    %r14
  15:	41 5f                	pop    %r15
  17:	e9 c1 c5 a7 e0       	jmp    0xffffffffe0a7c5dd
  1c:	90                   	nop
  1d:	53                   	push   %rbx
  1e:	83 be a8 01 00 00 00 	cmpl   $0x0,0x1a8(%rsi)
  25:	48 89 f3             	mov    %rsi,%rbx
  28:	75 02                	jne    0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 de             	mov    %rbx,%rsi
  2f:	e8 29 fe ff ff       	call   0xfffffffffffffe5d
  34:	31 c0                	xor    %eax,%eax
  36:	89 83 a8 01 00 00    	mov    %eax,0x1a8(%rbx)
  3c:	5b                   	pop    %rbx
  3d:	e9                   	.byte 0xe9
  3e:	9b                   	fwait
  3f:	c5                   	.byte 0xc5

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 de             	mov    %rbx,%rsi
   5:	e8 29 fe ff ff       	call   0xfffffffffffffe33
   a:	31 c0                	xor    %eax,%eax
   c:	89 83 a8 01 00 00    	mov    %eax,0x1a8(%rbx)
  12:	5b                   	pop    %rbx
  13:	e9                   	.byte 0xe9
  14:	9b                   	fwait
  15:	c5                   	.byte 0xc5
Apr 23 10:41:36 bilbo kernel: RSP: 0018:ffffc9000010ce50 EFLAGS: 00010246
Apr 23 10:41:36 bilbo kernel: RAX: ffff8881aab77800 RBX: ffff8881b7368400 RCX: ffff8881b73685c8
Apr 23 10:41:36 bilbo kernel: RDX: ffff8881b7368400 RSI: ffff8881b7368400 RDI: ffff88811c27a180
Apr 23 10:41:36 bilbo kernel: RBP: 0000000000000000 R08: ffff88811c27a2b0 R09: 00000000b37f4031
Apr 23 10:41:36 bilbo kernel: R10: 0000000000003819 R11: ffffc9000010cff8 R12: 0000000000000000
Apr 23 10:41:36 bilbo kernel: R13: ffff8881b7368400 R14: 00000ace389b7f34 R15: 0000000000000000
Apr 23 10:41:36 bilbo kernel: FS:  0000000000000000(0000) GS:ffff88842ec80000(0000) knlGS:0000000000000000
Apr 23 10:41:36 bilbo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 23 10:41:36 bilbo kernel: CR2: 00007f0030446000 CR3: 00000002c2cd6000 CR4: 00000000000406f0
Apr 23 10:41:36 bilbo kernel: Call Trace:
Apr 23 10:41:36 bilbo kernel: <IRQ>
Apr 23 10:41:36 bilbo kernel: htb_dequeue (./include/net/sch_generic.h:821 (discriminator 1) net/sched/sch_htb.c:702 (discriminator 1) net/sched/sch_htb.c:933 (discriminator 1) net/sched/sch_htb.c:983 (discriminator 1)) sch_htb 
Apr 23 10:41:36 bilbo kernel: __qdisc_run (net/sched/sch_generic.c:294 net/sched/sch_generic.c:398 net/sched/sch_generic.c:416) 
Apr 23 10:41:36 bilbo kernel: ? timerqueue_del (lib/timerqueue.c:58) 
Apr 23 10:41:36 bilbo kernel: qdisc_run (./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124) 
Apr 23 10:41:36 bilbo kernel: net_tx_action (net/core/dev.c:5553) 
Apr 23 10:41:36 bilbo kernel: handle_softirqs (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/jump_label.h:262 ./include/trace/events/irq.h:142 kernel/softirq.c:562) 
Apr 23 10:41:36 bilbo kernel: __irq_exit_rcu (kernel/softirq.c:435 kernel/softirq.c:662) 
Apr 23 10:41:36 bilbo kernel: sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 (discriminator 35) arch/x86/kernel/apic/apic.c:1049 (discriminator 35)) 
Apr 23 10:41:36 bilbo kernel: </IRQ>
Apr 23 10:41:36 bilbo kernel: <TASK>
Apr 23 10:41:36 bilbo kernel: asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:574) 
Apr 23 10:41:36 bilbo kernel: RIP: 0010:acpi_safe_halt (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:114 drivers/acpi/processor_idle.c:112) 
Apr 23 10:41:36 bilbo kernel: Code: 0f 1f 84 00 00 00 00 00 65 48 8b 05 b8 38 71 7e 48 8b 00 a8 08 75 14 8b 05 a3 92 bb 00 85 c0 7e 07 0f 00 2d 20 4f 15 00 fb f4 <fa> e9 18 77 00 00 0f 1f 84 00 00 00 00 00 8a 47 08 3c 01 75 05 e9
All code
========
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00 
   8:	65 48 8b 05 b8 38 71 	mov    %gs:0x7e7138b8(%rip),%rax        # 0x7e7138c8
   f:	7e 
  10:	48 8b 00             	mov    (%rax),%rax
  13:	a8 08                	test   $0x8,%al
  15:	75 14                	jne    0x2b
  17:	8b 05 a3 92 bb 00    	mov    0xbb92a3(%rip),%eax        # 0xbb92c0
  1d:	85 c0                	test   %eax,%eax
  1f:	7e 07                	jle    0x28
  21:	0f 00 2d 20 4f 15 00 	verw   0x154f20(%rip)        # 0x154f48
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	e9 18 77 00 00       	jmp    0x7748
  30:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  37:	00 
  38:	8a 47 08             	mov    0x8(%rdi),%al
  3b:	3c 01                	cmp    $0x1,%al
  3d:	75 05                	jne    0x44
  3f:	e9                   	.byte 0xe9

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	e9 18 77 00 00       	jmp    0x771e
   6:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   d:	00 
   e:	8a 47 08             	mov    0x8(%rdi),%al
  11:	3c 01                	cmp    $0x1,%al
  13:	75 05                	jne    0x1a
  15:	e9                   	.byte 0xe9
Apr 23 10:41:36 bilbo kernel: RSP: 0018:ffffc900000c7e80 EFLAGS: 00000246
Apr 23 10:41:36 bilbo kernel: RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88842ec80000
Apr 23 10:41:36 bilbo kernel: RDX: ffff888100ddc864 RSI: ffff888100ddc800 RDI: ffff888100ddc864
Apr 23 10:41:36 bilbo kernel: RBP: 0000000000000001 R08: 0000000000000001 R09: 00000acdfd2a9600
Apr 23 10:41:36 bilbo kernel: R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
Apr 23 10:41:36 bilbo kernel: R13: ffffffff81f982e8 R14: ffffffff81f98300 R15: 0000000000000000
Apr 23 10:41:36 bilbo kernel: acpi_idle_enter (drivers/acpi/processor_idle.c:705) 
Apr 23 10:41:36 bilbo kernel: cpuidle_enter_state (drivers/cpuidle/cpuidle.c:268) 
Apr 23 10:41:36 bilbo kernel: cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2)) 
Apr 23 10:41:36 bilbo kernel: do_idle (kernel/sched/idle.c:234 kernel/sched/idle.c:325) 
Apr 23 10:41:36 bilbo kernel: cpu_startup_entry (kernel/sched/idle.c:422) 
Apr 23 10:41:36 bilbo kernel: start_secondary (arch/x86/kernel/smpboot.c:315) 
Apr 23 10:41:36 bilbo kernel: common_startup_64 (arch/x86/kernel/head_64.S:421) 
Apr 23 10:41:36 bilbo kernel: </TASK>
Apr 23 10:41:36 bilbo kernel: ---[ end trace 0000000000000000 ]---

-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

