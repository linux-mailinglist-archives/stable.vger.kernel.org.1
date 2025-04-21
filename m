Return-Path: <stable+bounces-134877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D8A9567E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 21:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37A7188C116
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A111EB1AA;
	Mon, 21 Apr 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="kER7spcG"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB91E8320;
	Mon, 21 Apr 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262382; cv=none; b=An/cm4Jruo0kE/UuQlKjhQC64BTR3GXOG1SaVoQCg/BcgYT3ltwzxXb48193qXNpJZsEFrRiISC+3B09I5M23LtU8DQOi0ZPfYFkmlgwksJLRaC7qXDX5VqhlM3O0V5Lvyzbg0eIFq4IIErkwcVXO3FGvGni3AC7hO4hyZht7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262382; c=relaxed/simple;
	bh=vTKRaKFRv9kn3SC+rgDREeTrII8g8FovnKvl8R6ktrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDFPbiD7ldwmekLHyGzQEL2ciglvquoExfbQjcqYGlEZST+yfoz590TJBui5YqwsTzz549CHW+188oF0PJhDKgKKKbjFX+j8Skr6hTi+lGPWuMfOpIbXt1lMY8x1SoIFO2Ws7kdh9uVlLObavW9EkOEqRP6OhuPePSBudcsaKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=kER7spcG; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id AEEC8120872;
	Mon, 21 Apr 2025 20:06:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745262361;
	bh=vTKRaKFRv9kn3SC+rgDREeTrII8g8FovnKvl8R6ktrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kER7spcG8m1/KVwt7QtEORa89/IQs8He89mAmuggsVNgfbYTiGrGrFUm5Kf+aXDD1
	 yIDlyMWEcjSn1P2Z2/l0Qo3J2yfpWx2An9gyplWX1UBpt9dZYt9MXmquNYHYagdz2T
	 9ECiMMLPXw970VTiITkgmltKHjlshoM39nKBw0vZxM62cHh4OT4FTxQo1krPZds+BY
	 g0lCe2WOttRKl3+F10oLJdCRlmFNVr3p9/kNCjohIoum2WwGsyXZSeDiDNE+eb7xYV
	 aAunimqsXz2zlGLobDK0ZMO3ZH69wfUVed6/CQu0LEA4Cm6K91aTr6r44of3kHxAzN
	 N/tiLL0XO6Qlg==
Date: Mon, 21 Apr 2025 20:06:01 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila
 <tavip@google.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
In-Reply-To: <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
	<20250421131000.6299a8e0@frodo.int.wylie.me.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 13:10:00 +0100
"Alan J. Wylie" <alan@wylie.me.uk> wrote:

> On Mon, 21 Apr 2025 13:50:52 +0200
> Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com> wrote:

> > If so, try either reverting the above or adding:
> > "sch_htb: make htb_qlen_notify() idempotent" aka
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D5ba8b837b522d7051ef81bacf3d95383ff8edce5
> >=20
> > which was successfully not added to 6.14.3, along with the rest of
> > the series:
> > https://lore.kernel.org/all/20250403211033.166059-2-xiyou.wangcong@gmai=
l.com/ =20
>=20
> "successfully not added"?
>=20
> $ git cherry-pick  5ba8b837b522d7051ef81bacf3d95383ff8edce5
> [linux-6.14.y 2285c724bf7d] sch_htb: make htb_qlen_notify() idempotent
>  Author: Cong Wang <xiyou.wangcong@gmail.com>
>  Date: Thu Apr 3 14:10:23 2025 -0700
>  1 file changed, 2 insertions(+)
>=20
> It will take a while (perhaps days?) before I can confirm success.

I'm afraid that didn't help. Same panic.


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 139bfa067 P4D 139bfa067 PUD 133bf1067 PMD 0=20
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00=
001-g2285c724bf7d #21
Tainted: [O]=3DOOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS=
3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d =
41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f=
8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881052e9000 RCX: ffff8881052e9180
RDX: ffff8881e5e4f400 RSI: ffff888190075ee8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8881052e92b0 R09: 00000000e49ea9dc
R10: 000000000000278a R11: 001dcd6500000000 R12: ffff8881e5e4f400
R13: ffff8881052e92b8 R14: 00000b92b6422fbf R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000139952000 CR4: 00000000000406f0
Call Trace:
 <IRQ>
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
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a =
2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 0=
0 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff8881008e7400 RCX: 0000000000000000
RDX: 00000b927d3d4a20 RSI: fffffffc3199eb61 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 00000b927aa897c0
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 00000b927d3d4a20 R15: 0000000000000000
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred netc=
onsole xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper =
nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat =
nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT=
 nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_=
multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_def=
rag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe=
 tun pppox binfmt_misc ppp_generic slhc af_packet bridge stp llc ctr ccm dm=
_crypt radeon drm_client_lib ath9k video wmi drm_exec ath9k_common drm_suba=
lloc_helper ath9k_hw drm_ttm_helper syscopyarea ttm ath sysfillrect sysimgb=
lt fb_sys_fops mac80211 pl2303 drm_display_helper snd_hda_codec_realtek usb=
serial drm_kms_helper snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_scod=
ec_component snd_hda_intel agpgart snd_intel_dspcfg snd_hda_codec cfbfillre=
ct cfbimgblt cfg80211 snd_hda_core fb_io_fops
 cfbcopyarea i2c_algo_bit fb e1000 snd_pcm font cdc_acm snd_timer aesni_int=
el libarc4 snd at24 acpi_cpufreq k10temp crypto_simd soundcore fam15h_power=
 cryptd regmap_i2c evdev nfsd sch_fq_codel auth_rpcgss lockd grace sunrpc d=
rm configfs drm_panel_orientation_quirks fuse backlight loop nfnetlink usbh=
id xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd sha512_ssse3 sha25=
6_ssse3 sha1_ssse3 usbcore sha1_generic gf128mul usb_common dm_mirror dm_re=
gion_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid =
msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d =
41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f=
8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881052e9000 RCX: ffff8881052e9180
RDX: ffff8881e5e4f400 RSI: ffff888190075ee8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8881052e92b0 R09: 00000000e49ea9dc
R10: 000000000000278a R11: 001dcd6500000000 R12: ffff8881e5e4f400
R13: ffff8881052e92b8 R14: 00000b92b6422fbf R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000139952000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..


--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

