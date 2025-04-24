Return-Path: <stable+bounces-136521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C81A9A2A5
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AC11944C8A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21061E7C07;
	Thu, 24 Apr 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="ePCFYwTr"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA91ABED9;
	Thu, 24 Apr 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477664; cv=none; b=U8JooEo2b2qVDg0RbiFH4ts82qi7qfYOeCnDa+V3LTfm4JAMcwQyBG7Zs7/rzQyT4GbeNwZi6q3XHtSsN8S6gw0Qk9/iK2Evutc6eRoRseOZAcy6dl43v8pyKX0MzpwpvbmzboYH9ERf3Tpto1uoKlq4Q/mNH8pI6XN6Jeia4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477664; c=relaxed/simple;
	bh=ayvszURiu6Bq/5zoWQ9yZKm8+mKpz4NdDjLuL1b4VuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTEiEOsdsd3l2HNwIZp5e1H5ealkOXu+v/8gUbRcRd5rQ58C6zIIMPPhDme8JuInzJmntGGfN8RdHOk0z88mtAKDS5FzM6Y7kIOPx2eG3cVppP0Q6lJT517dRlJH5pOImu0x33GXsNU0tdI9+b+z82Gp0GgkEfXK+d3KJutqKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=fail (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=ePCFYwTr reason="signature verification failed"; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id E5C6C120049;
	Thu, 24 Apr 2025 07:53:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745477638;
	bh=GpYtWWR8SBIhF5WTk3l0d80xwFB8yK+5qNXQFk177zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ePCFYwTr6iXVYiC3/88NaxvTKJhqfSK/7ZVGd2Pba6HbESaaO0iPKwYjtBgWJ/yBM
	 vF8JgKflvF5xNk1S5anFChFGSbskdcstpb1HkSf4sSJPDJUOck7rwY6tW/dau56lZO
	 KrJoHXvb3+tr3+KfUIQ8XHcyNYCkFKz2/ZRElwipSTyIp6b5VwyxGXvpTBOhQrf9Na
	 8KoRlQ4bZFHdhn7Tg+ubZDQCCGFto/QASqxJeAziglEo/LgRywrOj9fr6HefClvTF7
	 XtDrX37DI/fXy0WAYQAlz3q7Y3GncJ4jYQIuJGpiMejkywt4xp9XJAV6B/0RPXLZ7b
	 qOJqBncDUBf9A==
Date: Thu, 24 Apr 2025 07:53:56 +0100
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
Message-ID: <20250424075356.3cd88aaf@frodo.int.wylie.me.uk>
In-Reply-To: <aAlAakEUu4XSEdXF@pop-os.localdomain>
References: <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
	<20250421200601.5b2e28de@frodo.int.wylie.me.uk>
	<89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
	<20250421210927.50d6a355@frodo.int.wylie.me.uk>
	<20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
	<4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
	<aAf/K7F9TmCJIT+N@pop-os.localdomain>
	<20250422214716.5e181523@frodo.int.wylie.me.uk>
	<aAgO59L0ccXl6kUs@pop-os.localdomain>
	<20250423105131.7ab46a47@frodo.int.wylie.me.uk>
	<aAlAakEUu4XSEdXF@pop-os.localdomain>
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

On Wed, 23 Apr 2025 12:32:58 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Wed, Apr 23, 2025 at 10:51:49AM +0100, Alan J. Wylie wrote:
> > On Tue, 22 Apr 2025 14:49:27 -0700
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >   
> > > Although I am still trying to understand the NULL pointer, which seems
> > > likely from:
> > > 
> > >  478                         if (p->inner.clprio[prio].ptr == cl->node + prio) {
> > >  479                                 /* we are removing child which is pointed to from
> > >  480                                  * parent feed - forget the pointer but remember
> > >  481                                  * classid
> > >  482                                  */
> > >  483                                 p->inner.clprio[prio].last_ptr_id = cl->common.classid;
> > >  484                                 p->inner.clprio[prio].ptr = NULL;
> > >  485                         }
> > > 
> > > Does the following patch work? I mean not just fixing the crash, but
> > > also not causing any other problem.  
> >   
> > > ---
> > > 
> > > diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> > > index 4b9a639b642e..0cdc778fddef 100644
> > > --- a/net/sched/sch_htb.c
> > > +++ b/net/sched/sch_htb.c
> > > @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
> > >   */
> > >  static inline void htb_next_rb_node(struct rb_node **n)
> > >  {
> > > -	*n = rb_next(*n);
> > > +	if (*n)
> > > +		*n = rb_next(*n);
> > >  }
> > >  
> > >  /**  
> > 
> > There's been three of these: 
> > 
> > Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> > Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> > Apr 23 10:41:36 bilbo kernel: WARNING: CPU: 1 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> > 
> > But no panic.
> > 
> > I've run scripts/decode.sh on the last one.
> >   
> 
> Thanks a lot for testing! This helped a lot to verify how far we can go
> beyond the panic and what I still missed. To me it looks a bit
> complicated for -stable if we make everything idempotent along the path.
> 
> Do you mind testing the following one instead? Please revert the
> above one for htb_next_rb_node(). I think maybe this is the safest fix
> we could have for -stable.
> 
> Thanks!
> 
> --------->  
> 
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 4b9a639b642e..3786abbdc4c3 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -1487,7 +1487,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
>  
>  	if (!cl->prio_activity)
>  		return;
> -	htb_deactivate(qdisc_priv(sch), cl);
> +	if (!cl->leaf.q->q.qlen)
> +		htb_deactivate(qdisc_priv(sch), cl);
>  }
>  
>  static inline int htb_parent_last_child(struct htb_class *cl)

With that patch, on top of origin/linux-6.14.y and
git cherry-pick  5ba8b837b522d7051ef81bacf3d95383ff8edce5

we're back to panics again. No WARNINGs in the log.

All at htb_dequeue+0x42f/0x610 [sch_htb]

I've decoded the last one.

reboot   system boot  6.14.3-00001-ge4 Thu Apr 24 05:41   still running
reboot   system boot  6.14.3-00001-ge4 Thu Apr 24 05:32   still running
reboot   system boot  6.14.3-00001-ge4 Thu Apr 24 02:06   still running
reboot   system boot  6.14.3-00001-ge4 Thu Apr 24 00:35   still running
reboot   system boot  6.14.3-00001-ge4 Wed Apr 23 23:12   still running


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888219993000 RCX: ffff888219993180
RDX: ffff888177830400 RSI: ffff888313064ce8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8882199932b0 R09: 00000000e928705c
R10: 0000000000002aef R11: ffffc90000003ff8 R12: ffff888177830400
R13: ffff8882199932b8 R14: 000003a4dd5c3455 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001572e8000 CR4: 00000000000406f0
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
RIP: 0010:acpi_safe_halt+0x22/0x30
Code: 0f 1f 84 00 00 00 00 00 65 48 8b 05 b8 38 71 7e 48 8b 00 a8 08 75 14 8b 05 a3 92 bb 00 85 c0 7e 07 0f 00 2d 60 4f 15 00 fb f4 <fa> e9 18 77 00 00 0f 1f 84 00 00 00 00 00 8a 47 08 3c 01 75 05 e9
RSP: 0018:ffffffff81e03e28 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88842ec00000
RDX: ffff888100ddc864 RSI: ffff888100ddc800 RDI: ffff888100ddc864
RBP: 0000000000000001 R08: 0000000000000001 R09: 000003e3dca10680
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: ffffffff81f982e8 R14: ffffffff81f98300 R15: 0000000000000000
 acpi_idle_enter+0x8f/0xa0
 cpuidle_enter_state+0xb3/0x220
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables binfmt_misc pppoe tun pppox ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon drm_client_lib video wmi ath9k drm_exec drm_suballoc_helper drm_ttm_helper syscopyarea ath9k_common ttm ath9k_hw sysfillrect sysimgblt fb_sys_fops drm_display_helper ath drm_kms_helper mac80211 agpgart snd_hda_codec_realtek cfbfillrect snd_hda_codec_generic cfbimgblt snd_hda_codec_hdmi snd_hda_scodec_component snd_hda_intel fb_io_fops snd_intel_dspcfg pl2303 cfbcopyarea snd_hda_cod
 ec usbserial
 i2c_algo_bit snd_hda_core fb cfg80211 snd_pcm cdc_acm snd_timer font snd aesni_intel at24 e1000 crypto_simd soundcore cryptd k10temp regmap_i2c libarc4 acpi_cpufreq fam15h_power evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks fuse backlight loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd usbcore sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888219993000 RCX: ffff888219993180
RDX: ffff888177830400 RSI: ffff888313064ce8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8882199932b0 R09: 00000000e928705c
R10: 0000000000002aef R11: ffffc90000003ff8 R12: ffff888177830400
R13: ffff8882199932b8 R14: 000003a4dd5c3455 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001572e8000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..
netconsole: network logging started
Wed 23 Apr 23:13:45 BST 2025


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13978b067 P4D 13978b067 PUD 13979b067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811a783000 RCX: ffff88811a783180
RDX: ffff8882bd40e400 RSI: ffff8882dbc58ee8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811a7832b0 R09: 000000002068e72f
R10: 0000000000000cb0 R11: ffffc90000003ff8 R12: ffff8882bd40e400
R13: ffff88811a7832b8 R14: 00000481df377e05 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000104ef2000 CR4: 00000000000406f0
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
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff8881008e6000 RCX: 0000000000000000
RDX: 00000481a5333d42 RSI: fffffff65224a3d4 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 00000481a3a82cc0
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 00000481a5333d42 R15: 0000000000000000
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables pppoe tun pppox binfmt_misc ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon drm_client_lib video wmi drm_exec ath9k drm_suballoc_helper drm_ttm_helper syscopyarea ath9k_common ttm ath9k_hw sysfillrect sysimgblt fb_sys_fops ath snd_hda_codec_realtek drm_display_helper drm_kms_helper snd_hda_codec_generic snd_hda_codec_hdmi pl2303 snd_hda_scodec_component mac80211 usbserial agpgart snd_hda_intel snd_intel_dspcfg cfbfillrect cfbimgblt snd_hda_codec fb_io_fops
  cfbcopyarea
 snd_hda_core i2c_algo_bit snd_pcm fb cfg80211 snd_timer cdc_acm aesni_intel font snd acpi_cpufreq at24 crypto_simd e1000 cryptd libarc4 soundcore k10temp regmap_i2c fam15h_power evdev nfsd sch_fq_codel auth_rpcgss lockd drm grace sunrpc drm_panel_orientation_quirks backlight fuse loop configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd sha512_ssse3 sha256_ssse3 usbcore sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811a783000 RCX: ffff88811a783180
RDX: ffff8882bd40e400 RSI: ffff8882dbc58ee8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811a7832b0 R09: 000000002068e72f
R10: 0000000000000cb0 R11: ffffc90000003ff8 R12: ffff8882bd40e400
R13: ffff88811a7832b8 R14: 00000481df377e05 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000104ef2000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..
netconsole: network logging started
Thu 24 Apr 00:36:40 BST 2025


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc9000010ce50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811d22c000 RCX: ffff88811d22c180
RDX: ffff88829c80a400 RSI: ffff88810445c500 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811d22c2b0 R09: 000000003b4da56b
R10: 0000000000000db3 R11: 001dcd6500000000 R12: ffff88829c80a400
R13: ffff88811d22c2b8 R14: 000004ed72306e80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000028f056000 CR4: 00000000000406f0
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
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffc900000c7e98 EFLAGS: 00000202
RAX: ffff88842ec80000 RBX: ffff888101c7d400 RCX: 0000000000000000
RDX: 000004ed38350e30 RSI: fffffffc356687b0 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 000004ed369cb580
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 000004ed38350e30 R15: 0000000000000000
 ? cpuidle_enter_state+0x116/0x220
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 start_secondary+0xed/0xf0
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables binfmt_misc pppoe tun pppox ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k drm_client_lib video wmi ath9k_common drm_exec ath9k_hw drm_suballoc_helper drm_ttm_helper syscopyarea ttm ath sysfillrect snd_hda_codec_realtek sysimgblt snd_hda_codec_generic fb_sys_fops mac80211 snd_hda_codec_hdmi drm_display_helper pl2303 snd_hda_scodec_component snd_hda_intel usbserial drm_kms_helper snd_intel_dspcfg snd_hda_codec agpgart cfbfillrect snd_hda_core cfbimgb
 lt fb_io_fops cfg80211
 cfbcopyarea snd_pcm i2c_algo_bit snd_timer fb aesni_intel cdc_acm snd e1000 font crypto_simd at24 cryptd libarc4 k10temp regmap_i2c soundcore acpi_cpufreq fam15h_power evdev nfsd auth_rpcgss sch_fq_codel lockd drm grace sunrpc drm_panel_orientation_quirks backlight loop fuse configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd sha512_ssse3 usbcore sha256_ssse3 sha1_ssse3 sha1_generic gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc9000010ce50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811d22c000 RCX: ffff88811d22c180
RDX: ffff88829c80a400 RSI: ffff88810445c500 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811d22c2b0 R09: 000000003b4da56b
R10: 0000000000000db3 R11: 001dcd6500000000 R12: ffff88829c80a400
R13: ffff88811d22c2b8 R14: 000004ed72306e80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000028f056000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..
netconsole: network logging started
Thu 24 Apr 02:07:13 BST 2025


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88813d31a000 RCX: ffff88813d31a180
RDX: ffff8883ff834800 RSI: ffff88810aede6e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813d31a2b0 R09: 00000000cdfec307
R10: 0000000000000d0a R11: 001dcd6500000000 R12: ffff8883ff834800
R13: ffff88813d31a2b8 R14: 00000b3836a6dc49 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001507ca000 CR4: 00000000000406f0
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
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff8881008dac00 RCX: 0000000000000000
RDX: 00000b37fdd1d950 RSI: fffffffc371b8b62 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 00000b37fb496cc0
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 00000b37fdd1d950 R15: 0000000000000000
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: udp_diag sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables binfmt_misc pppoe pppox ppp_generic tun slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon ath9k ath9k_common drm_client_lib video ath9k_hw wmi drm_exec drm_suballoc_helper drm_ttm_helper ath syscopyarea ttm sysfillrect mac80211 sysimgblt fb_sys_fops snd_hda_codec_realtek drm_display_helper snd_hda_codec_generic snd_hda_codec_hdmi drm_kms_helper pl2303 snd_hda_scodec_component usbserial snd_hda_intel agpgart snd_intel_dspcfg cfbfillrect snd_hda_codec cfbimgblt f
 b_io_fops cfbcopyarea
 cfg80211 snd_hda_core cdc_acm i2c_algo_bit snd_pcm aesni_intel fb snd_timer e1000 at24 font snd crypto_simd acpi_cpufreq k10temp cryptd libarc4 soundcore regmap_i2c fam15h_power evdev nfsd sch_fq_codel auth_rpcgss lockd grace sunrpc drm drm_panel_orientation_quirks loop fuse backlight configfs nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd sha512_ssse3 sha256_ssse3 sha1_ssse3 sha1_generic usbcore gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88813d31a000 RCX: ffff88813d31a180
RDX: ffff8883ff834800 RSI: ffff88810aede6e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813d31a2b0 R09: 00000000cdfec307
R10: 0000000000000d0a R11: 001dcd6500000000 R12: ffff8883ff834800
R13: ffff88813d31a2b8 R14: 00000b3836a6dc49 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001507ca000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..
netconsole: network logging started
Thu 24 Apr 05:33:20 BST 2025


BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11d659067 P4D 11d659067 PUD 11d66a067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639c00
R13: ffff88811c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012e18c000 CR4: 00000000000406f0
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
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff888101b26800 RCX: 0000000000000000
RDX: 000000737ef85069 RSI: fffffffc38107585 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 000000737dcfa800
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 000000737ef85069 R15: 0000000000000000
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernel+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun binfmt_misc pppoe pppox ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon drm_client_lib video wmi ath9k drm_exec drm_suballoc_helper ath9k_common drm_ttm_helper syscopyarea ath9k_hw ttm sysfillrect sysimgblt ath fb_sys_fops drm_display_helper snd_hda_codec_realtek pl2303 drm_kms_helper snd_hda_codec_generic mac80211 usbserial snd_hda_codec_hdmi snd_hda_scodec_component agpgart snd_hda_intel cfbfillrect snd_intel_dspcfg cfbimgblt snd_hda_codec fb_io_fops
  cfbcopyarea
 aesni_intel snd_hda_core i2c_algo_bit cdc_acm cfg80211 fb snd_pcm snd_timer font crypto_simd e1000 at24 snd cryptd libarc4 soundcore acpi_cpufreq regmap_i2c fam15h_power k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd grace sunrpc drm drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci sha512_ssse3 ehci_hcd sha256_ssse3 sha1_ssse3 sha1_generic usbcore gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639c00
R13: ffff88811c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012e18c000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..
netconsole: network logging started
Thu 24 Apr 05:42:15 BST 2025


$ ./scripts/decode_stacktrace.sh vmlinux
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11d659067 P4D 11d659067 PUD 11d66a067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
Tainted: [O]=OOT_MODULE
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639BUG: kernel NULL pointer dereference, address: 0000000000000000
c00
R13: ffff88811c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012e18c000 CR4: 00000000000406f0
Call Trace:
 <IRQ>
 htb_dequeue+0x42f/0x610 [sch_htb]
 __qdisc_run+0x253/0x480
 ? timerqueue_del+0x2c/0x40
 qdisc_run+0x15/0x30
 net_tx_action+0x182/0x1b0
 handle_softirqs+0x102/0x240
 __irq_exit_rcu+0x3e/0xb0
 sysvec_apic#PF: supervisor read access in kernel mode
_timer_interrupt+0x5b/0x70
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:cpuidle_enter_state+0x126/0x220
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842e#PF: error_code(0x0000) - not-present page
c00000 RBX: ffff888101b26800 RCX: 0000000000000000
RDX: 000000737ef85069 RSI: fffffffc38107585 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 000000737dcfa800
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 000000737ef85069 R15: 0000000000000000
 cpuidle_enter+0x2a/0x40
 do_idle+0x12d/0x1a0
 cpu_startup_entry+0x29/0x30
 rest_init+0xbc/0xc0
 start_kernePGD 11d659067 P4D 11d659067 PUD 11d66a067 PMD 0
l+0x630/0x630
 x86_64_start_reservations+0x25/0x30
 x86_64_start_kernel+0x73/0x80
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xOops: Oops: 0000 [#1] PREEMPT SMP NOPTI
t_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun binfmt_misc pppoe pppox ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon drm_client_lib video wmi ath9k drm_exec drm_suballoc_helper ath9k_common drm_ttm_helper syscopyarea ath9k_hw ttm sysfillrect sysimgblt ath fb_sys_fops drm_display_helper snd_hda_codec_realtek pl2303 drm_kms_helper snd_hda_codec_generic mac80211 usbserial snd_hda_codec_hdmi snd_hda_scodCPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O       6.14.3-00001-ge44dd93d7907-dirty #24
ec_component agpgart snd_hda_intel cfbfillrect snd_intel_dspcfg cfbimgblt snd_hda_codec fb_io_fops cfbcopyarea
 aesni_intel snd_hda_core i2c_algo_bit cdc_acm cfg80211 fb snd_pcm snd_timer font crypto_simd e1000 at24 snd cryptd libarc4 soundcore acpi_cpufreq regmap_i2c fam15h_power k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd grace sunrpc drm drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci sha512_ssse3 ehci_hcd sha256_ssse3 sha1_sTainted: [O]=OOT_MODULE
sse3 sha1_generic usbcore gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x0/0x50
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
RSP: 0018:ffffc90000003e50 EHardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
FLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639c00
R13: ffff888RIP: 0010:rb_next (lib/rbtree.c:496) 
11c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
All code
========
   0:	e8 d5 fa ff ff       	call   0xfffffffffffffada
   5:	5b                   	pop    %rbx
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
  2a:*	48 3b 3f             	cmp    (%rdi),%rdi		<-- trapping instruction
  2d:	48 89 f8             	mov    %rdi,%rax
  30:	74 38                	je     0x6a
  32:	48 8b 57 08          	mov    0x8(%rdi),%rdx
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
00 CR3: 000000012e18c000 CR4: 00000000000406RSP: 0018:ffffc90000003e50 EFLAGS: 00010246
f0
Kernel panic - not syncing: Fatal exception in interrupt
KernelRAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
 Offset: disabled
Rebooting in 3 seconds..
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639c00
R13: ffff88811c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012e18c000 CR4: 00000000000406f0
Call Trace:
<IRQ>
htb_dequeue (net/sched/sch_htb.c:351 (discriminator 1) net/sched/sch_htb.c:924 (discriminator 1) net/sched/sch_htb.c:982 (discriminator 1)) sch_htb 
__qdisc_run (net/sched/sch_generic.c:294 net/sched/sch_generic.c:398 net/sched/sch_generic.c:416) 
? timerqueue_del (lib/timerqueue.c:58) 
qdisc_run (./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124) 
net_tx_action (net/core/dev.c:5553) 
handle_softirqs (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/jump_label.h:262 ./include/trace/events/irq.h:142 kernel/softirq.c:562) 
__irq_exit_rcu (kernel/softirq.c:435 kernel/softirq.c:662) 
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 (discriminator 35) arch/x86/kernel/apic/apic.c:1049 (discriminator 35)) 
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:574) 
RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:292) 
Code: 18 4c 6f 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 a1 22 e5 ff 31 ff e8 9a 2e 98 ff 45 84 ff 74 07 31 ff e8 0e 58 9d ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 8b 3c 24 48 6b c8 68 48 6b d0 30 49
All code
========
   0:	18 4c 6f 00          	sbb    %cl,0x0(%rdi,%rbp,2)
   4:	85 c0                	test   %eax,%eax
   6:	7e 0b                	jle    0x13
   8:	8b 73 04             	mov    0x4(%rbx),%esi
   b:	83 cf ff             	or     $0xffffffff,%edi
   e:	e8 a1 22 e5 ff       	call   0xffffffffffe522b4
  13:	31 ff                	xor    %edi,%edi
  15:	e8 9a 2e 98 ff       	call   0xffffffffff982eb4
  1a:	45 84 ff             	test   %r15b,%r15b
  1d:	74 07                	je     0x26
  1f:	31 ff                	xor    %edi,%edi
  21:	e8 0e 58 9d ff       	call   0xffffffffff9d5834
  26:	fb                   	sti
  27:	45 85 ed             	test   %r13d,%r13d
  2a:*	0f 88 cc 00 00 00    	js     0xfc		<-- trapping instruction
  30:	49 63 c5             	movslq %r13d,%rax
  33:	48 8b 3c 24          	mov    (%rsp),%rdi
  37:	48 6b c8 68          	imul   $0x68,%rax,%rcx
  3b:	48 6b d0 30          	imul   $0x30,%rax,%rdx
  3f:	49                   	rex.WB

Code starting with the faulting instruction
===========================================
   0:	0f 88 cc 00 00 00    	js     0xd2
   6:	49 63 c5             	movslq %r13d,%rax
   9:	48 8b 3c 24          	mov    (%rsp),%rdi
   d:	48 6b c8 68          	imul   $0x68,%rax,%rcx
  11:	48 6b d0 30          	imul   $0x30,%rax,%rdx
  15:	49                   	rex.WB
RSP: 0018:ffffffff81e03e40 EFLAGS: 00000202
RAX: ffff88842ec00000 RBX: ffff888101b26800 RCX: 0000000000000000
RDX: 000000737ef85069 RSI: fffffffc38107585 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000002 R09: 000000737dcfa800
R10: 0000000000000006 R11: 0000000000000020 R12: ffffffff81f98280
R13: 0000000000000002 R14: 000000737ef85069 R15: 0000000000000000
cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2)) 
do_idle (kernel/sched/idle.c:234 kernel/sched/idle.c:325) 
cpu_startup_entry (kernel/sched/idle.c:422) 
rest_init (init/main.c:743) 
start_kernel (init/main.c:1525) 
x86_64_start_reservations (arch/x86/kernel/head64.c:513) 
x86_64_start_kernel (??:?) 
common_startup_64 (arch/x86/kernel/head_64.S:421) 
</TASK>
Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_ftp ip6t_rt ip6table_nat xt_MASQUERADE iptable_nat nf_nat xt_TCPMSS xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip6table_raw iptable_raw ip6table_mangle iptable_mangle xt_multiport xt_state xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter ip_tables x_tables tun binfmt_misc pppoe pppox ppp_generic slhc netconsole af_packet bridge stp llc ctr ccm dm_crypt radeon drm_client_lib video wmi ath9k drm_exec drm_suballoc_helper ath9k_common drm_ttm_helper syscopyarea ath9k_hw ttm sysfillrect sysimgblt ath fb_sys_fops drm_display_helper snd_hda_codec_realtek pl2303 drm_kms_helper snd_hda_codec_generic mac80211 usbserial snd_hda_codec_hdmi snd_hda_scodec_component agpgart snd_hda_intel cfbfillrect snd_intel_dspcfg cfbimgblt snd_hda_codec fb_io_fops
  cfbcopyarea
aesni_intel snd_hda_core i2c_algo_bit cdc_acm cfg80211 fb snd_pcm snd_timer font crypto_simd e1000 at24 snd cryptd libarc4 soundcore acpi_cpufreq regmap_i2c fam15h_power k10temp evdev nfsd sch_fq_codel auth_rpcgss lockd grace sunrpc drm drm_panel_orientation_quirks fuse backlight configfs loop nfnetlink usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci sha512_ssse3 ehci_hcd sha256_ssse3 sha1_ssse3 sha1_generic usbcore gf128mul usb_common dm_mirror dm_region_hash dm_log cpuid i2c_piix4 i2c_smbus i2c_dev i2c_core it87 hwmon_vid msr dmi_sysfs autofs4
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next (lib/rbtree.c:496) 
Code: e8 d5 fa ff ff 5b 4c 89 e0 5d 41 5c 41 5d 41 5e e9 85 73 01 00 5b 5d 41 5c 41 5d 41 5e e9 38 76 01 00 0f 1f 84 00 00 00 00 00 <48> 3b 3f 48 89 f8 74 38 48 8b 57 08 48 85 d2 74 11 48 89 d0 48 8b
All code
========
   0:	e8 d5 fa ff ff       	call   0xfffffffffffffada
   5:	5b                   	pop    %rbx
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
  2a:*	48 3b 3f             	cmp    (%rdi),%rdi		<-- trapping instruction
  2d:	48 89 f8             	mov    %rdi,%rax
  30:	74 38                	je     0x6a
  32:	48 8b 57 08          	mov    0x8(%rdi),%rdx
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
RAX: 0000000000000000 RBX: ffff88811c311000 RCX: ffff88811c311180
RDX: ffff888124639c00 RSI: ffff8881cf56d2e8 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88811c3112b0 R09: 000000001cdf6fee
R10: 0000000000000bad R11: ffffc90000003ff8 R12: ffff888124639c00
R13: ffff88811c3112b8 R14: 00000073b95a79bb R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012e18c000 CR4: 00000000000406f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 3 seconds..

-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

