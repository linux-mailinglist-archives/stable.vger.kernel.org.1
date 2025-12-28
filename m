Return-Path: <stable+bounces-203450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E9CE55D7
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 19:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C6A3300C5F8
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3018DB01;
	Sun, 28 Dec 2025 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="qG5fQABQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-139-mta230.mxyeet.net (mail-139-mta230.mxyeet.net [23.172.139.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341979DA;
	Sun, 28 Dec 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.172.139.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766947634; cv=none; b=ecrSwjnLHzzOfIAEiEehgSKaQPHyOhIX0hzI2Hl+KBhC+4So6l3eDQ3xW9RMee/zOoFpjA7VbWzOlvjFL3+4E7WP1x58eIsUYz00mwnS5RgUMOqUqmE3VjN5tdkLMxEbuKs1Tr+RudCGlMjtEIzYB4+J4O4MwX5qZhe0JExQVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766947634; c=relaxed/simple;
	bh=po/ryQkfprQGZIURjr5h3oaUzbw7QHj0jMuDqejJmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CU4vsoAL2gZYogCdD833kRip/GdDneTEgaPlyYcANSKHlVUDILLz++jkjHLr3xCj9NC9YhApYfMRmoWkMeCDousKvLBaOE5DnXBlTMR70885+iIM1mG18wxovgyoeLNreo1Ex3UwunQ+KNuGAzo9jM1Xj7LHytXU4dW7TccvNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bbaa.fun; spf=pass smtp.mailfrom=bbaa.fun; dkim=pass (2048-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=qG5fQABQ; arc=none smtp.client-ip=23.172.139.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bbaa.fun
Received: from us1.workspace.org ([162.244.93.81])
	by mx1.mxfilter.net with esmtpa (Exim 4.94.2)
	(envelope-from <bbaa@bbaa.fun>)
	id 1vZvcO-001MVJ-S8; Sun, 28 Dec 2025 10:31:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; d=bbaa.fun; s=av8DE3008F7488933;
	c=relaxed/relaxed; t=1766946700;
	h=from:to:cc:subject:date:message-id:x-mailer:mime-version;
	bh=rKRx15FD2P/QOgmgNHJNUluLSu+ZDBdt6FLosJXwNHo=;
	b=qG5fQABQDLPwVYspu7sokridPGdCarHaVk/YsP/jmy1/JVs5GmCSrcoqC7BiUgQ6pTAAXGG86nA
	1c7br95I7cFSV981UethC6YacFYIf6cO2g5KXKZti2LhtBlZeLUrn07kYJJFo86aIFD/rdqxZ+kWi
	j4JCo+1tVwzTEMeKBpM4TkcBz5IzKu81UpAOP2bQXebUupQiqMsBQN8i33quvcdgPt7On7R5pZt0K
	a492IswbBUWNYmYbkheONjaJ+npZPw2CQexJeQwcgjXejniZ5M5qWtZRBzpfj5Jd0AaDgDZm1SKW1
	/6AriuH2KmXAKZ/A536qlWVJQwaPyUEdcE6Q==
From: Ban ZuoXiang <bbaa@bbaa.fun>
To: aliceryhl@google.com, gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [BUG] soft lockup in kswapd0 caused by Rust binder
Date: Mon, 29 Dec 2025 02:31:24 +0800
Message-ID: <20251228183129.17193-1-bbaa@bbaa.fun>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SpamExperts-Domain: mxyeet.net
X-SpamExperts-Username: smartermail
Authentication-Results: mxfilter.net; auth=pass (login) smtp.auth=smartermail@mxyeet.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (5.7092575112e-10)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUt70AhH2huZ0hssZU6iaDLChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt0FOl+ASFczY3noAPKuEEJhQHJfqQ64nI8OXcHHUR+UmMUI
 LYktuu3IV7f0/T27Pqkk4Ndu06h2Q8QP5GQeNUYf+DoI5ero3AmhIYfztx7bKQZmnW/XN+tohdLu
 D74c7RLm7rJaFabHdhRB1M5CpEevg8CBO1Snvm6qXHQp7O9kdY+UD7VHHpDYs+rEjiTXe4WKt+mB
 C7rFaes5rZKd35vJLDnQGgRgHjioU8fpt7xeC6lpK5rmsikWQyHoo01Us4Z1thv0hd9gZGlVL/SE
 DgzCG0XIswT4JTPNkebrIx8pyA5U9t4xcCUOm4tiv78RtCq8Ng3mYqtflZjDsBc5em/VPnrhyYEC
 sIe6J6jqDToibXfgD3PWF0irxjKk3/vWv1cHLUesOFho5kJn+h8T97+juMI5o/7ag+7fAeZ/0D/o
 aBtPVai8IsFJldnpxNC5oFbU9F4QK/47LgCAS8YT+zZ/XG4tO8kCg1cp84iMSAkGFeL+EuOJL/c5
 tJIVZhWv3apX07NPEMssOkqNyDaeeBep7MoHOmPp3YnNtmvPmSihMlNiLZt/QXQnOBRD+jq1HsIc
 b3vTWnDYyVC7/iU3LFoRU2Itm39BdCc4FEP6OrUewhMp7l2H6L1j3xQGrt05tlcy8V5TAE2MyU4x
 O6WjOUIW31/E3ahF5MMcDI7KdpjQKR1rRW2/Ber2PqroG23nxx1rW6geRibv9v24o8pyO+wfXw0w
 ikvZkulDqcrpWCoB+LaiUF9sHh1/NzLB7qIs483Nybl56sya0T9xEzVY363yx78pxU3yUjGNzx/G
 kJD0Lh/LIV1YxiRB+4L7xN5erWmQp6iQOcylg4zeIfjQL4cweUvsRehKMiBHeoTRkEMdtEl4PpOg
 bCAYLr2RF7WRTTfrce/yja8lj1X9smfLvXyMwCcp22CVjbX1GnCNi2ASYKPEJRIe0r/ece53u7ka
 x2AppUMd0V4zQuQzp0OBP9wD9B1rqsxWtMmzF3PUhbYHSFFfEoXm0/FPF8PR0w363lmTwJvcF16P
 8f5DknwNiAeqQWy02jken2lZ8tkIY+F6Z1bs1b+lPl6frsX3AK4aOFP5fYhnc+Ng6LSN+h+4QfaY
 Fuupjn2+p/TJWBvLviE0/0eN5gq2WsqFjibD3Odqt6z+KvZJ30NG3C5Vc/q0wxSGAk9jZlOhtXWT
 K6eQfdZUmg==
X-Report-Abuse-To: spam@mx1.mxfilter.net
X-Complaints-To: abuse@mx1.mxfilter.net

Hello,=20
Many users [1][2][3] have reported a kernel soft lockup in the
kswapd0 task when running Waydroid (an Android container solution) on
kernels with the new Rust Binder driver.

The issue manifests as a soft lockup where CPU utilization is pegged at
100% system time, stuck in the list_lru_walk path triggered by the Rust
binder's shrinker.

Kernel Log:
12 25 01:23:57 arch-laptop kernel: watchdog: BUG: soft lockup - CPU#0 stuck=
 for 22s! [kswapd0:142]
12 25 01:23:57 arch-laptop kernel: CPU#0 Utilization every 4000ms during lo=
ckup:
12 25 01:23:57 arch-laptop kernel:         #1: 100% system,          0% sof=
tirq,          1% hardirq,          0% idle
12 25 01:23:57 arch-laptop kernel:         #2: 100% system,          0% sof=
tirq,          1% hardirq,          0% idle
12 25 01:23:57 arch-laptop kernel:         #3: 100% system,          0% sof=
tirq,          1% hardirq,          0% idle
12 25 01:23:57 arch-laptop kernel:         #4: 100% system,          0% sof=
tirq,          1% hardirq,          0% idle
12 25 01:23:57 arch-laptop kernel:         #5: 100% system,          0% sof=
tirq,          1% hardirq,          0% idle
12 25 01:23:57 arch-laptop kernel: Modules linked in: sch_ingress af_key tc=
p_diag udp_diag inet_diag nfnetlink_log xfrm_user xfrm_algo xfrm_interface =
xfrm6_tunnel tunnel4 tunnel6 vsock_loopback vmw_vsock_virtio_transport_comm=
on vmw_vsock_vmci_transport vsock vmw_vmci veth overlay loop nft_masq nft_c=
hain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc n=
f_tables tun rfcomm snd_seq_dummy snd_hrtimer snd_seq cmac algif_hash algif=
_skcipher af_alg bnep vfat fat iwlmvm intel_rapl_msr amd_atl amdgpu intel_r=
apl_common mac80211 ptp pps_core libarc4 amdxcp snd_hda_codec_nvhdmi drm_pa=
nel_backlight_quirks snd_hda_codec_hdmi gpu_sched snd_usb_audio drm_buddy i=
wlwifi kvm_amd drm_exec uvcvideo drm_suballoc_helper snd_hda_intel drm_ttm_=
helper btusb kvm videobuf2_vmalloc spd5118 r8169 snd_hda_codec snd_usbmidi_=
lib ttm ucsi_acpi btmtk uvc snd_hda_core cfg80211 realtek btrtl irqbypass i=
2c_algo_bit snd_ump videobuf2_memops asus_nb_wmi typec_ucsi snd_intel_dspcf=
g sp5100_tco mdio_devres polyval_clmulni videobuf2_v4l2 btbcm amd_pmf
12 25 01:23:57 arch-laptop kernel:  ghash_clmulni_intel snd_rawmidi drm_dis=
play_helper snd_intel_sdw_acpi asus_wmi libphy typec videobuf2_common i2c_p=
iix4 btintel aesni_intel snd_hwdep snd_seq_device amdtee hid_multitouch blu=
etooth videodev cec wmi_bmof sparse_keymap rapl pcspkr roles ccp k10temp rf=
kill video i2c_smbus mdio_bus amd_sfh snd_pcm thunderbolt i2c_hid_acpi plat=
form_profile snd_timer wmi i2c_hid tee snd amd_pmc soundcore mc mousedev jo=
ydev mac_hid tcp_bbr sch_fq_pie sch_pie i2c_dev pkcs8_key_parser ntsync cry=
pto_user nfnetlink hid_logitech_hidpp hid_logitech_dj nvme nvme_core nvme_k=
eyring nvme_auth hkdf serio_raw
12 25 01:23:57 arch-laptop kernel: CPU: 0 UID: 0 PID: 142 Comm: kswapd0 Not=
 tainted 6.18.2-zen2-1-zen #1 PREEMPT(full)  817688afc19ca15a22737742591535=
351aba70f8
12 25 01:23:57 arch-laptop kernel: Hardware name: ASUSTeK COMPUTER INC. ASU=
S TUF Gaming A15 FA507RM_FA507RM/FA507RM, BIOS FA507RM.315 11/30/2022
12 25 01:23:57 arch-laptop kernel: RIP: 0010:native_queued_spin_lock_slowpa=
th+0x67/0x2e0
12 25 01:23:57 arch-laptop kernel: Code: 0f 92 c2 8b 01 0f b6 d2 c1 e2 08 3=
0 e4 09 d0 3d ff 00 00 00 0f 87 1e 02 00 00 85 c0 74 10 0f b6 01 84 c0 74 0=
9 f3 90 0f b6 01 <84> c0 75 f7 b8 01 00 00 00 66 89 01 65 48 ff 05 ad af ed=
 01 c3 cc
12 25 01:23:57 arch-laptop kernel: RSP: 0018:ffffd4c4c06e3a30 EFLAGS: 00000=
202
12 25 01:23:57 arch-laptop kernel: RAX: 0000000000000001 RBX: ffffd4c4c06e3=
b10 RCX: ffff8d69446aa698
12 25 01:23:57 arch-laptop kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8d69446aa698
12 25 01:23:57 arch-laptop kernel: RBP: ffffffff94118f38 R08: 0000000000000=
000 R09: 0000000000000000
12 25 01:23:57 arch-laptop kernel: R10: ffff8d6fa1e38340 R11: ffff8d6fbe2d6=
000 R12: ffff8d6c5aaf8000
12 25 01:23:57 arch-laptop kernel: R13: ffffffff91d15410 R14: ffff8d69446aa=
680 R15: ffff8d69446aa680
12 25 01:23:57 arch-laptop kernel: FS:  0000000000000000(0000) GS:ffff8d700=
deaf000(0000) knlGS:0000000000000000
12 25 01:23:57 arch-laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
12 25 01:23:57 arch-laptop kernel: CR2: 00000000100af568 CR3: 000000020da24=
000 CR4: 0000000000f50ef0
12 25 01:23:57 arch-laptop kernel: PKRU: 55555554
12 25 01:23:57 arch-laptop kernel: Call Trace:
12 25 01:23:57 arch-laptop kernel:  <TASK>
12 25 01:23:57 arch-laptop kernel:  _raw_spin_lock+0x29/0x30
12 25 01:23:57 arch-laptop kernel:  __list_lru_walk_one.constprop.0+0x94/0x=
1d0
12 25 01:23:57 arch-laptop kernel:  ? __pfx_rust_shrink_free_page_wrap+0x10=
/0x10
12 25 01:23:57 arch-laptop kernel:  ? __pfx_rust_shrink_free_page_wrap+0x10=
/0x10
12 25 01:23:57 arch-laptop kernel:  list_lru_walk_node+0x46/0x1f0
12 25 01:23:57 arch-laptop kernel:  ? __pfx_rust_shrink_free_page_wrap+0x10=
/0x10
12 25 01:23:57 arch-laptop kernel:  rust_helper_list_lru_walk+0x9d/0xe0
12 25 01:23:57 arch-laptop kernel:  do_shrink_slab+0x140/0x350
12 25 01:23:57 arch-laptop kernel:  shrink_slab+0xd7/0x3e0
12 25 01:23:57 arch-laptop kernel:  shrink_one+0xfe/0x1d0
12 25 01:23:57 arch-laptop kernel:  shrink_node+0xb4a/0xd60
12 25 01:23:57 arch-laptop kernel:  ? pgdat_balanced+0x83/0x140
12 25 01:23:57 arch-laptop kernel:  kswapd+0x870/0x1100
12 25 01:23:57 arch-laptop kernel:  ? __switch_to+0x103/0x3f0
12 25 01:23:57 arch-laptop kernel:  ? __pfx_kswapd+0x10/0x10
12 25 01:23:57 arch-laptop kernel:  kthread+0xfc/0x240
12 25 01:23:57 arch-laptop kernel:  ? __pfx_kthread+0x10/0x10
12 25 01:23:57 arch-laptop kernel:  ret_from_fork+0x1c2/0x1f0
12 25 01:23:57 arch-laptop kernel:  ? __pfx_kthread+0x10/0x10
12 25 01:23:57 arch-laptop kernel:  ret_from_fork_asm+0x1a/0x30
12 25 01:23:57 arch-laptop kernel:  </TASK>

rust/helpers/binder.c=EF=BC=9A
unsigned long rust_helper_list_lru_walk(struct list_lru *lru,
                                        list_lru_walk_cb isolate, void *cb_=
arg,
                                        unsigned long nr_to_walk)
{
        return list_lru_walk(lru, isolate, cb_arg, nr_to_walk);
}

It appears that there exists a patch addressing this issue:=20
'rust: binder: stop spinning in shrinker' [4]=20

I have tested this patch, and it appears to resolve the soft lockup
issue.=20

Could this patch be picked up to fix the regression?

[1] https://github.com/waydroid/waydroid/issues/2163
[2] https://bbs.archlinux.org/viewtopic.php?id=3D311223
[3] https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issue=
s/174
[4] https://lore.kernel.org/all/20251202-binder-shrink-unspin-v1-1-263efb9a=
d625@google.com/

regards,
Ban ZuoXiang


