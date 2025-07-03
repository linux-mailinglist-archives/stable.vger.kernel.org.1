Return-Path: <stable+bounces-159272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE5AF67AA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 04:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1F4E3762
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F301BC07A;
	Thu,  3 Jul 2025 02:03:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53E1C5D7A;
	Thu,  3 Jul 2025 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508201; cv=none; b=f2GCa0hbU0nC33DBrZq1833AKJOYhF8895NV8tY41mV6w2VJ3BppFEHEK8+/7Gkhc4f1lGHI9s/IMaieVePF9k/To2WkH0oK7SB85qCxni2xb/Muq4dK6obBM1BNhHleIxYhMwLoTRMdf3rpuzZPuQ+3WM9KxqBnsIOHSNmUvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508201; c=relaxed/simple;
	bh=n3Tghic/18IqDMDy2jkBxfc2uoC9E9SzL2N4QcymiqI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvqKMXbAfQFQHpbdTqsT3XNLY+PuuFUXMQKrzXhbrt+NUD2G2y518h3F8uXGHN4c4MY5y9Io8w6h63vPYE+8WHy6PviBydqrRgThLI5/Eis9NfNmdF1z+rHCLJ+TUq6381d6ImeKLaKuCBoo03w504BIXCdd61F/Y8LpIk/kir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1751508046t192t19742
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.151.178])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4031773321032660000
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>,
	<stable@vger.kernel.org>
References: <C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com> <20250702143152.6046ab7c@kernel.org>
In-Reply-To: <20250702143152.6046ab7c@kernel.org>
Subject: RE: [PATCH net] net: libwx: fix double put of page to page_pool
Date: Thu, 3 Jul 2025 10:00:38 +0800
Message-ID: <058101dbebbe$45de6d00$d19b4700$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH1mhRvT+Jm1sUm9s4wWw5UQ43aWgFPMsovs+HL6iA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MoP89Bxtn7IX6uPZ+7afajX6Ui68uSE7LVT0G55XeZDVq+8hEGs+nm0/
	FS7GhCVFvymLVpgPZGmRWLvlgVa6XygzdB7wPvtnifmqVpjoMfzqi5ndJaDZ5UfbTIuBfBL
	2a8K/gmQCUVFiCyuBIhcGNqWEtXfd0bE/8Mu2jIosQHlP1TjARhvpU7GQbmPK/ATyFGlTPD
	TrtJvY9YCaPOvcI1VkDU3Pt2WMxFeWk/y6PY92TmGIBCAY1Z/RGIg4f9LNhYyzRRfRau24A
	E+WUkAbW+DchwchMT4qDfENF2Qv6lSqzyNu9XYhQ3J5OHkFpf+AnLMz/NnPU8LUumQkagNy
	PMS9bAvkQuY9LPzi80t6mO9OrZLlAQpeSxdTea8RDCWwMMU/jUewg9FmahL1x9a914C0HFW
	LJbb3Lz5XabnrPrniFqTKnFzyBz2cs7OcFIcKsOxO79dYDV6+2GVh0lFXhXqGNLkBBk6tBp
	cU+4+Jz1PrnU3yFT4WFlMaA+KDQLYXnbwIYZf/2ycy52CE0GflGJQ9fNiitMyhEULfun17P
	/c9VfrU09pI80fJFQg4k7pI1Ln9SmIfVJ6gDZeWe3eJjQHOphjPui99ZjlfHtbtJ+DfVJsf
	gykvjbQ78lw9LJNRhTaAeOblgpcmqgw2txT5iIupmzustJ2q5jCfuGH8bUEbH+/BsMHwAS2
	wb0Sx81DMtFs/9UQ5iXoIzsf06kRbRmowpvq7NB5VpPSML5V0XYWbVv/RENt0dSvgRZ45UG
	WrcOKeoNH9ZA+I4IMqFY+OEsawJ4EAs2oRIDu1RpNAmek/KW4erXl0wH8f7xGqXmJJDAv2w
	KShWXX1VVMeuT/B/4rlFDaen7RP4qgtWa+bGIeS154bVu0TElpJPqnO2dlI5NEdyGtCHvhq
	GLy17RQHHaXMnPIrECAXflBVMdlzCW6PpPfdk6noT/m5A835iAGBvtHKNKElGscbJTktE20
	/Ww0tg6hekOoqasHVvAek2yV5yMsf9IiJVwM9j3aYlFIPl2duhq6i6NPF2gGNI75hs9uWLg
	4Ls/GYGLfGJKPU0FX9pnRVhXgqfk0sDXyMywWa6Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, Jul 3, 2025 5:32 AM, Jakub Kicinski wrote:
> On Mon, 30 Jun 2025 17:41:02 +0800 Jiawen Wu wrote:
> > wx_dma_sync_frag() incorrectly attempted to return the page to
> > page_pool, which is already handled via buffer reuse or wx_build_skb()
> > paths.
> 
> The conditions is:
> 
> 	if (unlikely(WX_CB(skb)->page_released))
> 
> And only wx_put_rx_buffer() sets that to true.  And it sets page to
> NULL, so I don't understand how this is supposed to work.

This is the incorrect point. Since the page has been released, it should
not be released again.

> 
> Please improve the commit message, if not the code..
> 
> > Under high MTU and high throughput, this causes list corruption
> > inside page_pool due to double free.
> >
> > [  876.949950] Call Trace:
> > [  876.949951]  <IRQ>
> > [  876.949952]  __rmqueue_pcplist+0x53/0x2c0
> > [  876.949955]  alloc_pages_bulk_noprof+0x2e0/0
> 
> This is just the stack trace you're missing the earlier lines which
> tell us what problem happened and where.

[  876.949834]  __irq_exit_rcu+0xc7/0x130
[  876.949836]  common_interrupt+0xb8/0xd0
[  876.949838]  </IRQ>
[  876.949838]  <TASK>
[  876.949840]  asm_common_interrupt+0x22/0x40
[  876.949841] RIP: 0010:cpuidle_enter_state+0xc2/0x420
[  876.949843] Code: 00 00 e8 d1 1d 5e ff e8 ac f0 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 cd fc 5c ff 45 84 ff 0f 85 40 02 00 00 fb
0f 1f 44 00 00 <45> 85 f6 0f 88 84 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  876.949844] RSP: 0018:ffffaa7340267e78 EFLAGS: 00000246
[  876.949845] RAX: ffff9e3f135be000 RBX: 0000000000000002 RCX: 0000000000000000
[  876.949846] RDX: 000000cc2dc4cb7c RSI: ffffffff89ee49ae RDI: ffffffff89ef9f9e
[  876.949847] RBP: ffff9e378f940800 R08: 0000000000000002 R09: 00000000000000ed
[  876.949848] R10: 000000000000afc8 R11: ffff9e3e9e5a9b6c R12: ffffffff8a6d8580
[  876.949849] R13: 000000cc2dc4cb7c R14: 0000000000000002 R15: 0000000000000000
[  876.949852]  ? cpuidle_enter_state+0xb3/0x420
[  876.949855]  cpuidle_enter+0x29/0x40
[  876.949857]  cpuidle_idle_call+0xfd/0x170
[  876.949859]  do_idle+0x7a/0xc0
[  876.949861]  cpu_startup_entry+0x25/0x30
[  876.949862]  start_secondary+0x117/0x140
[  876.949864]  common_startup_64+0x13e/0x148
[  876.949867]  </TASK>
[  876.949868] ---[ end trace 0000000000000000 ]---
[  876.949869] ------------[ cut here ]------------
[  876.949870] list_del corruption, ffffead40445a348->next is NULL
[  876.949873] WARNING: CPU: 14 PID: 0 at lib/list_debug.c:52 __list_del_entry_valid_or_report+0x67/0x120
[  876.949875] Modules linked in: snd_hrtimer(E) bnep(E) binfmt_misc(E) amdgpu(E) squashfs(E) vfat(E) loop(E) fat(E) amd_atl(E)
snd_hda_codec_realtek(E) intel_rapl_msr(E) snd_hda_codec_generic(E) intel_rapl_common(E) snd_hda_scodec_component(E)
snd_hda_codec_hdmi(E) snd_hda_intel(E) edac_mce_amd(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd_hda_core(E) amdxcp(E) kvm_amd(E)
snd_hwdep(E) gpu_sched(E) drm_panel_backlight_quirks(E) cec(E) snd_pcm(E) drm_buddy(E) snd_seq_dummy(E) drm_ttm_helper(E) btusb(E)
kvm(E) snd_seq_oss(E) btrtl(E) ttm(E) btintel(E) snd_seq_midi(E) btbcm(E) drm_exec(E) snd_seq_midi_event(E) i2c_algo_bit(E)
snd_rawmidi(E) bluetooth(E) drm_suballoc_helper(E) irqbypass(E) snd_seq(E) ghash_clmulni_intel(E) sha512_ssse3(E)
drm_display_helper(E) aesni_intel(E) snd_seq_device(E) rfkill(E) snd_timer(E) gf128mul(E) drm_client_lib(E) drm_kms_helper(E) snd(E)
i2c_piix4(E) joydev(E) soundcore(E) wmi_bmof(E) ccp(E) k10temp(E) i2c_smbus(E) gpio_amdpt(E) i2c_designware_platform(E)
gpio_generic(E) sg(E)
[  876.949914]  i2c_designware_core(E) sch_fq_codel(E) parport_pc(E) drm(E) ppdev(E) lp(E) parport(E) fuse(E) nfnetlink(E)
ip_tables(E) ext4 crc16 mbcache jbd2 sd_mod sfp mdio_i2c i2c_core txgbe ahci ngbe pcs_xpcs libahci libwx r8169 phylink libata
realtek ptp pps_core video wmi
[  876.949933] CPU: 14 UID: 0 PID: 0 Comm: swapper/14 Kdump: loaded Tainted: G        W   E       6.16.0-rc2+ #20 PREEMPT(voluntary)
[  876.949935] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  876.949936] Hardware name: Micro-Star International Co., Ltd. MS-7E16/X670E GAMING PLUS WIFI (MS-7E16), BIOS 1.90 12/31/2024
[  876.949936] RIP: 0010:__list_del_entry_valid_or_report+0x67/0x120
[  876.949938] Code: 00 00 00 48 39 7d 08 0f 85 a6 00 00 00 5b b8 01 00 00 00 5d 41 5c e9 73 0d 93 ff 48 89 fe 48 c7 c7 a0 31 e8 89
e8 59 7c b3 ff <0f> 0b 31 c0 5b 5d 41 5c e9 57 0d 93 ff 48 89 fe 48 c7 c7 c8 31 e8
[  876.949940] RSP: 0018:ffffaa73405d0c60 EFLAGS: 00010282
[  876.949941] RAX: 0000000000000000 RBX: ffffead40445a348 RCX: 0000000000000000
[  876.949942] RDX: 0000000000000105 RSI: 0000000000000001 RDI: 00000000ffffffff
[  876.949943] RBP: 0000000000000000 R08: 000000010006dfde R09: ffffffff8a47d150
[  876.949944] R10: ffffffff8a47d150 R11: 0000000000000003 R12: dead000000000122
[  876.949945] R13: ffff9e3e9e5af700 R14: ffffead40445a348 R15: ffff9e3e9e5af720
[  876.949946] FS:  0000000000000000(0000) GS:ffff9e3f135be000(0000) knlGS:0000000000000000
[  876.949947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  876.949948] CR2: 00007fa58b480048 CR3: 0000000156724000 CR4: 0000000000750ef0
[  876.949949] PKRU: 55555554
[  876.949950] Call Trace:
[  876.949951]  <IRQ>
[  876.949952]  __rmqueue_pcplist+0x53/0x2c0
[  876.949955]  alloc_pages_bulk_noprof+0x2e0/0x660
[  876.949958]  __page_pool_alloc_pages_slow+0xa9/0x400
[  876.949961]  page_pool_alloc_pages+0xa/0x20
[  876.949963]  wx_alloc_rx_buffers+0xd7/0x110 [libwx]
[  876.949967]  wx_clean_rx_irq+0x262/0x430 [libwx]
[  876.949971]  wx_poll+0x92/0x130 [libwx]
[  876.949975]  __napi_poll+0x28/0x190
[  876.949977]  net_rx_action+0x301/0x3f0
[  876.949980]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949981]  ? profile_tick+0x30/0x70
[  876.949983]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949984]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949986]  ? timerqueue_add+0xa3/0xc0
[  876.949988]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949989]  ? __raise_softirq_irqoff+0x16/0x70
[  876.949991]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949994]  ? wx_msix_clean_rings+0x41/0x50 [libwx]
[  876.949998]  handle_softirqs+0xf9/0x2c0


Would this clearly present the issue?



