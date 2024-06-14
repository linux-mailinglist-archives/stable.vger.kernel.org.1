Return-Path: <stable+bounces-52239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D2909314
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF270285A4A
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D119DF64;
	Fri, 14 Jun 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="ssAoF0p/"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBC136E09;
	Fri, 14 Jun 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718394745; cv=none; b=CqHeSMBnCGNG7HKrz0lhB5J71y+pVtISG6+7DTqKAxZrPGmyr7POLycSrp+jTpYimls2QeuQ1wreoaoktDG2hCO/vXrCHVTXBzvBZyinh6ZwEzhhy0aFdCTtvPrRF6pKr723pCWNJsMpSHoZ2p809tDFW4rxTKxP7z9W0LL7qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718394745; c=relaxed/simple;
	bh=3ay8Bu7Y0avzOGuBDO9yeqyZBsGvD7EF0UukT/5+kLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UZvucvOMJiZYDvzIt3m++rhB6ZPDsYDCNGF6rfZyn4zhxLfOcZNyc9NOHblC+IrNzrTyQYaIkmFazcX8k50wrZatQ+evDNkH8SR8xZdhYyxRnWg0Q6OZWfQE1l8XA9TiAcqiZJAMokmH5YgzYlYEN/q0/GHp6SE8Nyzjuo4C6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=ssAoF0p/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718394739; x=1718999539; i=rwarsow@gmx.de;
	bh=hIFR4FX61ee6/oi4Gw7rxSf32kMPsrT9yVDVbkAu9RA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ssAoF0p/O8DGZmeQzKn8ULY69mtA6F8FwcWdEa9jvxeFQCXD7ndSq93UryZKAJNy
	 wsDaRQpFmdIMMMc2l+NaUFAIZ7OgS3FdxutUiY9vIqAVgyLIDhyZ10gIbIlOOKOq2
	 nIdEDCQFmP8sEy1RLIGQfd2F2B88+tuRTANlZmPODOErjpI9gxTb2IbWyWKJEPXfE
	 9ZlTAeRiJMWruW+V8FsOzPXe8qLVkEPkGwqAtrl8GleAZS3gjgU2bseI9IrY277w9
	 dJmavBRyddXd2/yEzbD9PuZq1FHXtJyKQ+7cA7/afu9zArrhBOhSxEPktg9tlXoMh
	 EpoaPCwrNJ3ExE/4RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.197]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1sbue31HyK-00w2wa; Fri, 14
 Jun 2024 21:52:19 +0200
Message-ID: <65626dc2-26e8-4eba-8513-e439098d9252@gmx.de>
Date: Fri, 14 Jun 2024 21:52:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bme0tHAHBnF9zmJ8sMRtQRB9tQwtVy86jI2l4hkwQOpiRdU3OXz
 1Zvm5b6fSCwmdaUlqN3RKu1DAZG1wL6l9QkYtJiTkrG+RN4Wsps9f+T6o1T+dhErIvhBHfB
 /HHjcNKl2IJsA7cBRL4XJtbNjIpfBaDPBflsbGgO8FoJYN4WNwEb/rNnM0mYN6FOd8TvB/R
 W6urI351BwJkKZnA1uLLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MWILO5Hvsqs=;xl3JTa68SvUh1zPYGRZBbbeEdI3
 LEpeObmDwceGe8/fwwhhJrqG7DkjL/eMrotAFaLuunGzUHBqXNmTfYnQKp8pQGd0bYlcri/dZ
 ToPNUVNzzyDxna+i2mf0RWfiv4uyZU4EejwGVcuHhai6pHNY2MzijWaQIk1yG/dlYeMhhD8Bq
 JID1tH412D14QGD8WW9csgXJgzUPakFvgldjMRifGzPT6JO87V6f6v8bP6ep3AQaMYDMPSAxg
 UU2zrDZkd1jpcyUd9DelIyaJcqWFfDefpm/K3MTbX1ItW+plxM8wwQj4yctFBVMP1kCyibL7N
 hfJoHSVQLQ/KZl/ofjHr51DUY69Yb9TIQOrt/zKzUHHh9h34A1YZiogQLXy83PhYvwLgloL5+
 ZRoIc6C13g4XDw/BSCYnFtOtbZr22jpFwsAPpGWZnCb0vVLglb1SJ4uutgwg4Rziwxudy2jHZ
 Sw7CB1EU8TsxCCTCROeKBdQXVAyS0QzBaNDgdHupjjMaYavNO+lzhors8ypj76Urd/gL8DFbS
 HMJkcQMmwpBpOixRkCi2JQerqq/o8biD2ESL457W0UrD0K3CNY8Riw82OfOJ4OpYdWzYVvEla
 0jPMSi6sMNY7yy6pV57VFmWcow/VT41NGuzi6lI+kY+AgqtLs1HSH5UPfj7Xv55KkOoq+B+Z2
 BcThmAgKIL37s5xFusezK0wcLfpX49nan/tX+KyWWKsM34jxzDDPXn/tXiLNttudOP+L0VFBT
 X+bNLDORkKL5/4l+7hHxtNd7C1NK9uTt21JLLEmF3Erju7RGJYW+4PzTAldev5OqenrOSDmSs
 oQ9w4gFZOt696XduCJ2C0DlEzD0XuNgM65uWAVjgxBgsI=

Hi Greg

+++ Update +++

the below crash seems to only to happen with mesa-24.1.x
mesa-24.0.9 is fine

filled a bug report:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2292434


=3D=3D=3D=3D

Jun 13 18:49:22 obelix.fritz.box kernel: RIP:
0010:drm_suballoc_free+0x13/0x110 [drm_suballoc_helper]
Jun 13 18:49:22 obelix.fritz.box kernel: Code: eb ce 0f 1f 44 00 00 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 85 ff 0f 84 e1 00 00 00
41 54 55 48 89 fd 53 48 89 f3 <4c> 8b 67 20 4c 89 e7 e8 61 53 bd e2 48
85 db 0f 84 9f 00 00 00 48
Jun 13 18:49:22 obelix.fritz.box kernel: RSP: 0018:ffff9caa851f7630
EFLAGS: 00010286
Jun 13 18:49:22 obelix.fritz.box kernel: RAX: fffffffffffffe00 RBX:
0000000000000000 RCX: 000000000000890b
Jun 13 18:49:22 obelix.fritz.box kernel: RDX: 00000000000088fb RSI:
0000000000000000 RDI: fffffffffffffe00
Jun 13 18:49:22 obelix.fritz.box kernel: RBP: fffffffffffffe00 R08:
0000000000000000 R09: 0000000000000001
Jun 13 18:49:22 obelix.fritz.box kernel: R10: 0000000000000000 R11:
0000000000000180 R12: ffff8ebf913c1158
Jun 13 18:49:22 obelix.fritz.box kernel: R13: fffffffffffffe00 R14:
ffff9caa851f78a8 R15: ffff8ebf913c0000
Jun 13 18:49:22 obelix.fritz.box kernel: FS:  00007fd4f4640b00(0000)
GS:ffff8ec2cf980000(0000) knlGS:0000000000000000
Jun 13 18:49:22 obelix.fritz.box kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jun 13 18:49:22 obelix.fritz.box kernel: CR2: fffffffffffffe20 CR3:
0000000110bc4001 CR4: 0000000000770ef0
Jun 13 18:49:22 obelix.fritz.box kernel: PKRU: 55555554
Jun 13 18:49:22 obelix.fritz.box kernel: Call Trace:
Jun 13 18:49:22 obelix.fritz.box kernel:  <TASK>
Jun 13 18:49:22 obelix.fritz.box kernel:  ? __die_body.cold+0x19/0x2c
Jun 13 18:49:22 obelix.fritz.box kernel:  ? page_fault_oops+0x155/0x280
Jun 13 18:49:22 obelix.fritz.box kernel:  ? search_module_extables+0x10/0x=
50
Jun 13 18:49:22 obelix.fritz.box kernel:  ? search_bpf_extables+0x56/0x80
Jun 13 18:49:22 obelix.fritz.box kernel:  ? exc_page_fault+0x7a/0x80
Jun 13 18:49:22 obelix.fritz.box kernel:  ? asm_exc_page_fault+0x22/0x30
Jun 13 18:49:22 obelix.fritz.box kernel:  ? drm_suballoc_free+0x13/0x110
[drm_suballoc_helper]
Jun 13 18:49:22 obelix.fritz.box kernel:
xe_migrate_update_pgtables+0x692/0x9b0 [xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  ? kmalloc_trace+0x11f/0x2d0
Jun 13 18:49:22 obelix.fritz.box kernel:  __xe_pt_bind_vma+0x492/0xbe0 [xe=
]
Jun 13 18:49:22 obelix.fritz.box kernel:  xe_vm_bind_vma+0xa6/0x2e0 [xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  xe_vm_bind+0xf3/0x200 [xe]
Jun 13 18:49:22 obelix.fritz.box kernel: __xe_vma_op_execute+0x278/0x490
[xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  xe_vm_bind_ioctl+0x1ce0/0x1f20
[xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  ?
__pfx_xe_vm_bind_ioctl+0x10/0x10 [xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  drm_ioctl_kernel+0xa7/0x100 [drm=
]
Jun 13 18:49:22 obelix.fritz.box kernel:  drm_ioctl+0x312/0x5c0 [drm]
Jun 13 18:49:22 obelix.fritz.box kernel:  ?
__pfx_xe_vm_bind_ioctl+0x10/0x10 [xe]
Jun 13 18:49:22 obelix.fritz.box kernel:  __x64_sys_ioctl+0x40d/0xb70
Jun 13 18:49:22 obelix.fritz.box kernel:  do_syscall_64+0x7a/0x160
Jun 13 18:49:22 obelix.fritz.box kernel:  ? __x64_sys_ioctl+0x13e/0xb70
Jun 13 18:49:22 obelix.fritz.box kernel:  ? __count_memcg_events+0x43/0xb0
Jun 13 18:49:22 obelix.fritz.box kernel:  ? handle_mm_fault+0x1f9/0x300
Jun 13 18:49:22 obelix.fritz.box kernel:  ?
syscall_exit_to_user_mode+0x68/0x1e0
Jun 13 18:49:22 obelix.fritz.box kernel:  ? do_syscall_64+0x86/0x160
Jun 13 18:49:22 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 18:49:22 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 18:49:22 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 18:49:22 obelix.fritz.box kernel:
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 13 18:49:22 obelix.fritz.box kernel: RIP: 0033:0x7fd4f4d23d2d
Jun 13 18:49:22 obelix.fritz.box kernel: Code: 04 25 28 00 00 00 48 89
45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48
89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8
64 48 2b 04 25 28 00 00 00
Jun 13 18:49:22 obelix.fritz.box kernel: RSP: 002b:00007fff94738650
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jun 13 18:49:22 obelix.fritz.box kernel: RAX: ffffffffffffffda RBX:
00007fff94738710 RCX: 00007fd4f4d23d2d
Jun 13 18:49:22 obelix.fritz.box kernel: RDX: 00007fff94738710 RSI:
0000000040886445 RDI: 0000000000000010
Jun 13 18:49:22 obelix.fritz.box kernel: RBP: 00007fff947386a0 R08:
0000000000001000 R09: 0000000000000000
Jun 13 18:49:22 obelix.fritz.box kernel: R10: 0000555a7a0fded0 R11:
0000000000000246 R12: 0000000000000010
Jun 13 18:49:22 obelix.fritz.box kernel: R13: 0000000000000000 R14:
0000555a78671160 R15: 0000555a7a234fa0
Jun 13 18:49:22 obelix.fritz.box kernel:  </TASK>
Jun 13 18:49:22 obelix.fritz.box kernel: Modules linked in:
vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) rfcomm nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables bnep iwlmvm mac80211
libarc4 snd_hda_codec_hdmi intel_rapl_common kvm_intel iwlwifi
snd_hda_codec_realtek kvm btusb snd_hda_codec_generic btintel
snd_hda_scodec_component bluetooth snd_hda_intel cfg80211
snd_intel_dspcfg snd_hda_codec snd_hda_core mei_hdcp mei_pxp rfkill
nfnetlink xe drm_ttm_helper ttm agpgart i2c_algo_bit gpu_sched drm_buddy
drm_suballoc_helper drm_gpuvm drm_exec drm_display_helper drm_kms_helper d=
rm
Jun 13 18:49:22 obelix.fritz.box kernel: CR2: fffffffffffffe20
Jun 13 18:49:22 obelix.fritz.box kernel: ---[ end trace 0000000000000000
]---
Jun 13 18:49:22 obelix.fritz.box kernel: RIP:
0010:drm_suballoc_free+0x13/0x110 [drm_suballoc_helper]
Jun 13 18:49:22 obelix.fritz.box kernel: Code: eb ce 0f 1f 44 00 00 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 85 ff 0f 84 e1 00 00 00
41 54 55 48 89 fd 53 48 89 f3 <4c> 8b 67 20 4c 89 e7 e8 61 53 bd e2 48
85 db 0f 84 9f 00 00 00 48
Jun 13 18:49:22 obelix.fritz.box kernel: RSP: 0018:ffff9caa851f7630
EFLAGS: 00010286
Jun 13 18:49:22 obelix.fritz.box kernel: RAX: fffffffffffffe00 RBX:
0000000000000000 RCX: 000000000000890b
Jun 13 18:49:22 obelix.fritz.box kernel: RDX: 00000000000088fb RSI:
0000000000000000 RDI: fffffffffffffe00
Jun 13 18:49:22 obelix.fritz.box kernel: RBP: fffffffffffffe00 R08:
0000000000000000 R09: 0000000000000001
Jun 13 18:49:22 obelix.fritz.box kernel: R10: 0000000000000000 R11:
0000000000000180 R12: ffff8ebf913c1158
Jun 13 18:49:22 obelix.fritz.box kernel: R13: fffffffffffffe00 R14:
ffff9caa851f78a8 R15: ffff8ebf913c0000
Jun 13 18:49:22 obelix.fritz.box kernel: FS:  00007fd4f4640b00(0000)
GS:ffff8ec2cf980000(0000) knlGS:0000000000000000
Jun 13 18:49:22 obelix.fritz.box kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jun 13 18:49:22 obelix.fritz.box kernel: CR2: fffffffffffffe20 CR3:
0000000110bc4001 CR4: 0000000000770ef0
Jun 13 18:49:22 obelix.fritz.box kernel: PKRU: 55555554
Jun 13 18:49:22 obelix.fritz.box kernel: note: Xorg[3657] exited with
irqs disabled




