Return-Path: <stable+bounces-52053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E2990741A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C43F28E30E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815801448D2;
	Thu, 13 Jun 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="i8LdqZyQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751F143C7E;
	Thu, 13 Jun 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286238; cv=none; b=mshPs2KCh8Iy9KlLTZHYm2P5vDwYnwC5zPBAafXakvDNxFftxQJG4PO46KcYN/9YMZF0q8q9jHUfh3tnPYQkrdBeUK1aFqvAg+gZFR6w8oN8sfe2BHNapFQq1BHcg1R45cZbc6KXpNhRk0ylvawktiLJpvBhV84InsfBAjzZ/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286238; c=relaxed/simple;
	bh=zHxHiSmMPETqUKs1iEyxup3NYKf1M/Uatm9vKpXqSmk=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Fa7Ht7QS+qc5SXyjq9dSrmifmaB02KV5hPhd9ocLTDmfcE6R1jCGcDxM83g0kzx05ihFVwQF91cRvHLOyjbB1w0g26AnfGUvaEN3f7dmbNBxCFenQPJ0sFQX+Z9qrPZADNInteEfPMM18xsvipD7AwEuUE5k4CiBLlGmfKj/qSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=i8LdqZyQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718286233; x=1718891033; i=rwarsow@gmx.de;
	bh=ST1f7I+SSE9EmwPLo8OL2snR68KMl7z4uuZ9+nMzg9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i8LdqZyQ1pS7LAQdjq1uVCsUws1xZilCB5t/HaG05FQQTbDCI9eM3bN42xRaBrVJ
	 egcMzF2ORRBkft6UoNRV2N+V0MtAt28k8P50H7KPFzCvq+P9MIXLz2fm7xwj7yX44
	 VG39+c2zmBxW1inrFfLHxMRIjwU+k6B9W8xrEafk+5jXz8lh145htaEztjqfYPWR2
	 +Yd05mXUmgr3Zj49MVbGuaoBGY/VAoTL7UrzAQGenzQ0SefCSkL2gxJP/TuX30XeS
	 +f7IjnsYtMNtgX/3hANBR5GpYd4iJ6lCY2C8Iv6+0y4lFCtSiteJmJ/vawl+Q+J1m
	 NMPiJKiHKbxOJdleHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.28]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1sBvaZ3k6h-001OYA; Thu, 13
 Jun 2024 15:43:52 +0200
Message-ID: <dcb3959e-3b3d-4500-95a9-55cdbd06813c@gmx.de>
Date: Thu, 13 Jun 2024 15:43:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M9AkE0Gr8mNwD44w1ooNFWi/m2R41dg76BVNSqM2KI/t7davOMP
 +WcraEurU6VNe2SyJJ5Oc8PjQqrQYWe5HtSuxuW2VInsW1JhnfMDGQKzHNmRceKtefjRMNs
 tC0fklLyrQzcjitKiY0oT82uIX9wK8WvVHb+EuUqEF4WCL4WRNH3AwmIZPVvWbXbNRKKkg2
 m+ATTn9bZsSe0ZOG+ictA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZGRvU+Dy4JU=;nwdoKvnDqw9zYjWKS4Wh0vuJQ/Q
 4LT0FyOHZzX1aX6xv0sRkALnq1zghL3peMFTyQbsCa7Sqsrv0+qCKPkVFEZVOSoufRS9foj/C
 rsmX5E7YENgP9IbmxxUp+NV3W514L65Kp0g/CDdi+Ze1YguRGO1TPH+4myR6yDRpzm2R3qXlG
 7Xw9YH879ZSzOwGDV7agMV31WF5K7F/+uqCbeLjD7plbhjuBTdzAroakmhGqMLvBdfIoOvwQi
 pONV+ZVYXcbdYb1rgW8UH8O1fQTegiZ4BK5sGX9fvwtlK8jo9Wj5PAhseCSEnCRYAB8Nbh84S
 zYmAjSSmxu5AwyhGuUYSmwCsqqGwY8PV/ogXIY3ZL4ja2FU69Rn6+F1P0zsN8rZZNLWmAcIzU
 FabI2FFcnQ5RLfrytjdQy/h/z3xJmtQ3QwpNmWq+cxujBuP64o4QsdRmRAJsu9YtcMoAe0WIE
 35T52GZDZtKzlpzop0GSb/YruHLJntUyQ+mfFw00Xn29JCvxn5qW53nA6Rux49DSAhMAwlDyo
 KwUOODlquw+RIk03ezBwfbAQhgV/Zfj5NTVe/POsikBATwPFl/rkD/mV9k50MXFyE0YB0SCDw
 We1wnK+LhZx7NHEdP7f54lHhmYrIujMTJT+3NAijOTO4CPRUOVtuIGyx3h5rS2XKsbPIg54l1
 GEDgX87TXty93Tdrj+NgvIOnlrwhtzo51mUil4IgTycHti4A8TQfM/A4KUfPio5QqAIprm0p8
 fnx5lTVPsDAQZeq8vKskfIU/odwsxW2kPrGJxQdNyAWAu7oSmc+Ji1M7O8s4T7NNdjDsc0/5+
 Rp5SE+r0oEihTpkPKgTERGTPIc3F5IZKz+4Do60IjFxu4=

Hi Greg

no regressions *here* on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

=3D=3D=3D=3D
for the record:
today I had a crash with 6.9.4, see below
seems not to be reproduceable with 6.9.5-rc1

Kernel was compiled with LLVM=3D1 and Xe Graphic driver
Crash happend 3 times while editing a LibreOffice Calc sheet
only a hard reset got the box to live again


Jun 13 14:47:40 obelix.fritz.box kernel: BUG: unable to handle page
fault for address: fffffffffffffe20
Jun 13 14:47:40 obelix.fritz.box kernel: #PF: supervisor read access in
kernel mode
Jun 13 14:47:40 obelix.fritz.box kernel: #PF: error_code(0x0000) -
not-present page
Jun 13 14:47:40 obelix.fritz.box kernel: PGD 3d822f067 P4D 3d822f067 PUD
3d8231067 PMD 0
Jun 13 14:47:40 obelix.fritz.box kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Jun 13 14:47:40 obelix.fritz.box kernel: CPU: 5 PID: 2680 Comm: Xorg
Tainted: G           OE      6.9.4_MY_LLVM #1
Jun 13 14:47:40 obelix.fritz.box kernel: Hardware name: ASUS System
Product Name/ROG STRIX B560-G GAMING WIFI, BIOS 2203 02/06/2024
Jun 13 14:47:40 obelix.fritz.box kernel: RIP:
0010:drm_suballoc_free+0x10/0xf0 [drm_suballoc_helper]
Jun 13 14:47:40 obelix.fritz.box kernel: Code: e9 56 ff ff ff e8 20 6c
bd e9 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 85 ff 74 50 41
57 41 56 53 49 89 f7 49 89 fe <48> 8b 5f 20 48 89 df e8 94 2f be e9 4d
85 ff 74 2a 49 8b 47 30 a8
Jun 13 14:47:40 obelix.fritz.box kernel: RSP: 0018:ffff9ecb068fb570
EFLAGS: 00010286
Jun 13 14:47:40 obelix.fritz.box kernel: RAX: fffffffffffffe00 RBX:
00000000fffffe00 RCX: 0000000000003e45
Jun 13 14:47:40 obelix.fritz.box kernel: RDX: 0000000000003e35 RSI:
0000000000000000 RDI: fffffffffffffe00
Jun 13 14:47:40 obelix.fritz.box kernel: RBP: 0000000000000001 R08:
0000000000000000 R09: ffffffffab258530
Jun 13 14:47:40 obelix.fritz.box kernel: R10: 0000000000000001 R11:
0000000000000005 R12: 0000000000000008
Jun 13 14:47:40 obelix.fritz.box kernel: R13: ffff9ecb068fb710 R14:
fffffffffffffe00 R15: 0000000000000000
Jun 13 14:47:40 obelix.fritz.box kernel: FS:  00007f98cc24fb00(0000)
GS:ffff8f870f680000(0000) knlGS:0000000000000000
Jun 13 14:47:40 obelix.fritz.box kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jun 13 14:47:40 obelix.fritz.box kernel: CR2: fffffffffffffe20 CR3:
0000000112d62002 CR4: 0000000000770ef0
Jun 13 14:47:40 obelix.fritz.box kernel: PKRU: 55555554
Jun 13 14:47:40 obelix.fritz.box kernel: Call Trace:
Jun 13 14:47:40 obelix.fritz.box kernel:  <TASK>
Jun 13 14:47:40 obelix.fritz.box kernel:  ? __die_body+0x61/0xb0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? page_fault_oops+0x2f4/0x400
Jun 13 14:47:40 obelix.fritz.box kernel:  ? do_kern_addr_fault+0x92/0xd0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? exc_page_fault+0x60/0x70
Jun 13 14:47:40 obelix.fritz.box kernel:  ? asm_exc_page_fault+0x22/0x30
Jun 13 14:47:40 obelix.fritz.box kernel:  ? drm_suballoc_free+0x10/0xf0
[drm_suballoc_helper]
Jun 13 14:47:40 obelix.fritz.box kernel:
xe_migrate_update_pgtables+0x7d1/0x880 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:  __xe_pt_bind_vma+0x909/0xd40 [xe=
]
Jun 13 14:47:40 obelix.fritz.box kernel:  ? ttm_bo_validate+0x3f/0x1c0 [tt=
m]
Jun 13 14:47:40 obelix.fritz.box kernel:  xe_vm_bind_vma+0x12f/0x290 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:  xe_vm_bind+0xb3/0x1b0 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:
__xe_vma_op_execute+0x3cb/0x4e0 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:
vm_bind_ioctl_ops_execute+0x94/0x230 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:  xe_vm_bind_ioctl+0xe0a/0x1370 [x=
e]
Jun 13 14:47:40 obelix.fritz.box kernel:  ?
__pfx_xe_vm_bind_ioctl+0x10/0x10 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:  drm_ioctl_kernel+0xb6/0x100 [drm=
]
Jun 13 14:47:40 obelix.fritz.box kernel:  drm_ioctl+0x354/0x4d0 [drm]
Jun 13 14:47:40 obelix.fritz.box kernel:  ?
__pfx_xe_vm_bind_ioctl+0x10/0x10 [xe]
Jun 13 14:47:40 obelix.fritz.box kernel:  __x64_sys_ioctl+0xdc3/0xf10
Jun 13 14:47:40 obelix.fritz.box kernel:  ? do_syscall_64+0x96/0x140
Jun 13 14:47:40 obelix.fritz.box kernel:  ? __x64_sys_ioctl+0x66/0xf10
Jun 13 14:47:40 obelix.fritz.box kernel:  ? __count_memcg_events+0x47/0xb0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? handle_mm_fault+0xb39/0x11b0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? mt_find+0x99/0x140
Jun 13 14:47:40 obelix.fritz.box kernel:  do_syscall_64+0x8a/0x140
Jun 13 14:47:40 obelix.fritz.box kernel:  ?
syscall_exit_to_user_mode+0x71/0x90
Jun 13 14:47:40 obelix.fritz.box kernel:  ? do_syscall_64+0x96/0x140
Jun 13 14:47:40 obelix.fritz.box kernel:  ? do_user_addr_fault+0x372/0x720
Jun 13 14:47:40 obelix.fritz.box kernel:  ?
syscall_exit_to_user_mode+0x71/0x90
Jun 13 14:47:40 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 14:47:40 obelix.fritz.box kernel:  ? clear_bhb_loop+0x45/0xa0
Jun 13 14:47:40 obelix.fritz.box kernel:
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 13 14:47:40 obelix.fritz.box kernel: RIP: 0033:0x7f98cc955d2d
Jun 13 14:47:40 obelix.fritz.box kernel: Code: 04 25 28 00 00 00 48 89
45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48
89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8
64 48 2b 04 25 28 00 00 00
Jun 13 14:47:40 obelix.fritz.box kernel: RSP: 002b:00007ffd7b24c7d0
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jun 13 14:47:40 obelix.fritz.box kernel: RAX: ffffffffffffffda RBX:
00007ffd7b24c890 RCX: 00007f98cc955d2d
Jun 13 14:47:40 obelix.fritz.box kernel: RDX: 00007ffd7b24c890 RSI:
0000000040886445 RDI: 0000000000000010
Jun 13 14:47:40 obelix.fritz.box kernel: RBP: 00007ffd7b24c820 R08:
0000000000006000 R09: 0000000000000000
Jun 13 14:47:40 obelix.fritz.box kernel: R10: 000055fa0f794010 R11:
0000000000000246 R12: 0000000000000010
Jun 13 14:47:40 obelix.fritz.box kernel: R13: 0000000000000000 R14:
000055fa0f84a170 R15: 000055fa1140a090
Jun 13 14:47:40 obelix.fritz.box kernel:  </TASK>
Jun 13 14:47:40 obelix.fritz.box kernel: Modules linked in: rfcomm
nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet
nft_reject nf_reject_ipv6 nf_reject_ipv4 nft_ct nft_chain_nat nf_nat
vboxnetadp(OE) vboxnetflt(OE) nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip_set nf_tables vboxdrv(OE) bnep iwlmvm mac80211 btusb btintel
snd_hda_codec_hdmi bluetooth libarc4 snd_hda_codec_realtek
snd_hda_scodec_component snd_hda_codec_generic iwlwifi intel_rapl_common
kvm_intel snd_hda_intel snd_intel_dspcfg snd_hda_codec kvm cfg80211
snd_hda_core mei_pxp mei_hdcp rfkill nfnetlink xe i2c_algo_bit
drm_display_helper drm_kms_helper drm_buddy drm_suballoc_helper
gpu_sched drm_ttm_helper ttm agpgart drm_gpuvm drm_exec drm
Jun 13 14:47:40 obelix.fritz.box kernel: CR2: fffffffffffffe20
Jun 13 14:47:40 obelix.fritz.box kernel: ---[ end trace 0000000000000000
]---
Jun 13 14:47:40 obelix.fritz.box kernel: RIP:
0010:drm_suballoc_free+0x10/0xf0 [drm_suballoc_helper]
Jun 13 14:47:40 obelix.fritz.box kernel: Code: e9 56 ff ff ff e8 20 6c
bd e9 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 85 ff 74 50 41
57 41 56 53 49 89 f7 49 89 fe <48> 8b 5f 20 48 89 df e8 94 2f be e9 4d
85 ff 74 2a 49 8b 47 30 a8
Jun 13 14:47:40 obelix.fritz.box kernel: RSP: 0018:ffff9ecb068fb570
EFLAGS: 00010286
Jun 13 14:47:40 obelix.fritz.box kernel: RAX: fffffffffffffe00 RBX:
00000000fffffe00 RCX: 0000000000003e45
Jun 13 14:47:40 obelix.fritz.box kernel: RDX: 0000000000003e35 RSI:
0000000000000000 RDI: fffffffffffffe00
Jun 13 14:47:40 obelix.fritz.box kernel: RBP: 0000000000000001 R08:
0000000000000000 R09: ffffffffab258530
Jun 13 14:47:40 obelix.fritz.box kernel: R10: 0000000000000001 R11:
0000000000000005 R12: 0000000000000008
Jun 13 14:47:40 obelix.fritz.box kernel: R13: ffff9ecb068fb710 R14:
fffffffffffffe00 R15: 0000000000000000
Jun 13 14:47:40 obelix.fritz.box kernel: FS:  00007f98cc24fb00(0000)
GS:ffff8f870f680000(0000) knlGS:0000000000000000
Jun 13 14:47:40 obelix.fritz.box kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jun 13 14:47:40 obelix.fritz.box kernel: CR2: fffffffffffffe20 CR3:
0000000112d62002 CR4: 0000000000770ef0
Jun 13 14:47:40 obelix.fritz.box kernel: PKRU: 55555554
Jun 13 14:47:40 obelix.fritz.box kernel: note: Xorg[2680] exited with
irqs disabled




