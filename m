Return-Path: <stable+bounces-52084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96714907A18
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222AC1F253C6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C314A098;
	Thu, 13 Jun 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="NhLmhTNX"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70780441D;
	Thu, 13 Jun 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300518; cv=none; b=aExk6fMwUK9DluvEr+1LNh2buGnaGogfawCRktC/zXdChaoJQLyxcSsrG5MSp8QOQ0RZ9aN9kD090oGNBAmxseYltn65tI8ezEcSpfZuLVBapVR4SugbanH2En6Ty3QVyL4ObCFq/xShYsazep9DoHkaGlaCly35/guwzKjWzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300518; c=relaxed/simple;
	bh=n7oxacKAEQRmFZiJpn1SXZ7nxx5u8NmL+3XYXeyvbY4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k/garSZjDkywgldgUEYoXs8ab0jQnRdElF3YWYyzcWA+Z5k6Xa7qOKlQZoE4V5wI9NDbHsrnC6HVIT9m71mFlNi/2D87K66Ou+pnFqQgYXXqK6iAdys0Potq8r0ovlpfG5V6jat0ipiQj8yPL1Y3TYUudBbEqx6P1q7NKAC5LPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=NhLmhTNX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718300513; x=1718905313; i=rwarsow@gmx.de;
	bh=2DNIu7KHOtuuKVFcLCH4EQUBSAuKuWrf69Z5OAhvIlU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NhLmhTNX4Z18KhMa4WbmOrsR6k8lQj1aUABSWVaxV7BAuQe7xxAI+D+V6FBir0qX
	 UpZUQZTrlZFnSX5d3MvPU4SD1rStKrJQsqOZDwBelzow5ZaIG/PhQprCruQ6+ENG0
	 Wf1s55UHHZDjd8pENTCER6JyP3G4/An1GYXdacG9JHKiRLzTwa6QG45funQgGJyys
	 +vibfAt/czadJ/m8CVJFAAUOGAHFDOeJMyGp0xeY99xq6f1i9Sy9r1T17SFmIzrMO
	 jEyzPGZ6ZEo/xxoXHp6859z3h9b9lB/jx245ZBOfpHnw/+VDvycGvJAwczv7VMFbP
	 9gnHi/s/Nt9U5YLyaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.28]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1sBSGd3Nzr-00FuZW; Thu, 13
 Jun 2024 19:41:52 +0200
Message-ID: <6e359d15-24a9-47ba-ad42-ddd18663d86e@gmx.de>
Date: Thu, 13 Jun 2024 19:41:52 +0200
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
X-Provags-ID: V03:K1:7iqhaFifrungt96QmSDVbE5rZCSBYrtqh5v7gjN6pmAd4MDlp0h
 3i8PX1JpLwwEJxJqTCeoMP/sVpNDi+QuG6UysmndhshiGuOB+LTe69hB4nr1orzurq9PU5W
 /uWlm2FBppHLDXWxu6Nifa1H6VTskOEoDYMhyKLUKiR+tREUTVCa7IbiX63AhNZfVmmqsnE
 7f7WVO7bTcf8B4pYBrhFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rBrNqq1dTvQ=;VyyDvWLKb9ztHYoRMlPmteSmdVu
 qlTlCEFUZe1dc1qYAOgpuYwPz42yrtag+T2n6UW8iAqDOczVhkyqjPPXsCTQxK37+e/3XM19w
 KnZzrRdqzeOzmVNW69BNC4yRacZ6E83CRCLXy/x+baYD6DLyWgPBa+m+JnY/Ld8yVuUlcPwS5
 hhSvO0bWvAgd48ypNgR3ydo2Rb86XkDux6DIc+vRa4YC4JtuZ2veQ7YllXLhZntxmakxLOqb+
 iyJ1lc0PcjMQdaGJJ3QEXuKIJflIdENoSkZDZAiFtx+ZIyjix4cShHyHrfhjmGVjy/p8RECs6
 HO+UpMA3J0x+22CBFC1njEa5+6lgiPgtAmt3fFpU8uI4qFdGz6zic1APvA44/YGpOIGh9vj8D
 zLXsnAeAoYFC9ogQ4w+EsvM8nAXwzcXpvKsBxoyvFqEmCs1D/JguaLdy4UxR/ZUTiSx2Ck+jP
 uSgmq9mqu+8N+k7PyE6IMN6k/Vw9+u8Jj3PMSETxdxKhzzVTlpq2dLvAtGafBxqU6NDiqVHgB
 imijaPbOa0IWKymhmdd5cpu3BjsYuIFZYY00gJvYoaCMOMosvHVy0LGMfbq6grgurCsGQVOK7
 i8cURxH6F6p1PuPl4y8BZ0/Opkh7L93Zkqaaf3slFvhKY8epM0pURbZiZml7itJK8jzm2+HVZ
 ntz/xr9ReL5nLQN2KnIvu/p9MV8I8sHjtsafREHWaM1RBxyKoSHiJ+4iIsmA8/6TKRq+zdK3s
 gHAIDUu9qgyT+AuTR2JCoZn1MwJ749lkQHs+HwQD8LjUflo1e1dtizMZCSja3w4CvY41mgh1G
 Db14mXv6xp7XgIn798JJnU4L/U+kUlMi1DLe8KQRZ8Gyc=

Hi Greg

...

today I had a crash with 6.9.4, see below
seems not to be reproduceable with 6.9.5-rc1

=3D=3D=3D=3D

the above last sentence is *NOT* true, cause 6.9.5-rc1 show the same
behavior (this time compiled with gcc)

Jun 13 18:49:22 obelix.fritz.box kernel: Hardware name: ASUS System
Product Name/ROG STRIX B560-G GAMING WIFI, BIOS 2203 02/06/2024
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
Jun 13 18:49:22 obelix.fritz.box kernel:
__xe_vma_op_execute+0x278/0x490 [xe]
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




