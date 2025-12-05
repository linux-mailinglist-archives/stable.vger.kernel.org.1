Return-Path: <stable+bounces-200175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD3CA854C
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A4232DC6E2
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB47B2FD672;
	Fri,  5 Dec 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=student.kit.edu header.i=@student.kit.edu header.b="G2Nv5vmI"
X-Original-To: stable@vger.kernel.org
Received: from scc-mailout-kit-01.scc.kit.edu (scc-mailout-kit-01.scc.kit.edu [141.52.71.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC82C3271;
	Fri,  5 Dec 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.52.71.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948824; cv=none; b=eWoegwo/JxJVTRYwPFiSvnJ4Bt+AFmuY0cHyX2QE7gjsIlPWRAQ6ld/VeUuaSQ+maF0nL+yxJJHZ6FB6ag9oV9BfGtM1iRfFxrXOFkEh3bGyH0tRCF8LeKZ7Af9OdHVMZ+JR4D53yO7sgU7vz3KI7aBoNq6W/Sh/SdPcZipIeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948824; c=relaxed/simple;
	bh=0ofOvd1etcfrER6r7B15147MfSEwdyrEW8A+zXybuv0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=S1mAnaU2K8YrpboBifSSkFOi2w1qLCF1TxiaIIyY7fEA8Et7IMjpJH0de9soy7kGQaUBmRhqP1xWu6XzCZnluU1AK6Cm8TLDZS/RMWEmxq1/HWex9pS0eeK1NAZ3w77cBUKnyOjG/SEc+Czb+mGJC6aYIGpZWTh1OLM0hyS9nDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.kit.edu; spf=pass smtp.mailfrom=student.kit.edu; dkim=pass (2048-bit key) header.d=student.kit.edu header.i=@student.kit.edu header.b=G2Nv5vmI; arc=none smtp.client-ip=141.52.71.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.kit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.kit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=student.kit.edu; s=kit1; h=Content-Transfer-Encoding:Content-Type:Subject:
	To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MwjmrheOlYth/1iAXiMPL8uYFC0hOdcFvisy7TwrliY=; b=G2Nv5vmIye2uLEh5N/ezL7frqA
	c5FokPKjj0F5C072u5uNql1UobXEcW2NT5JP/4TaPwqGZ2AUzwn08Qsb6fqcgBe93KVFnsA9vL2RB
	896btfyrcZbX793nGwMFbKcehevJbtd04/mvVXV4wdsmv8Rag0lm3VD021ev5CXPJUHetrVY+Do5M
	aF9aBf38H6S/pJ46z/IBZR8RvQUzvS3TI+8+BAJmOwfL0BMGVQrdjlkXJrWt4Q3HtqqA5+ZZVyIH9
	syFosANia7goFvTwhqjG/mPzYxiftQxuGG65MMI5IGq7StBBihny+LHAKg0bqyB+O+QCeKqVz4pso
	+t2dKMMw==;
Received: from kit-msx-44.kit.edu ([2a00:1398:9:f612::144])
	by scc-mailout-kit-01.scc.kit.edu with esmtps (TLS1.2:ECDHE_SECP384R1__RSA_SHA256__AES_256_GCM:256)
	(envelope-from <peter.bohner@student.kit.edu>)
	id 1vRXdc-00000000Lnp-0zgv;
	Fri, 05 Dec 2025 16:22:28 +0100
Received: from [IPV6:2001:7c7:20e8:134:5275:14f3:3282:3c3]
 (2001:7c7:20e8:134:5275:14f3:3282:3c3) by smtp.kit.edu
 (2a00:1398:9:f612::106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 5 Dec
 2025 16:22:27 +0100
Message-ID: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
Date: Fri, 5 Dec 2025 16:22:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>
Autocrypt: addr=peter.bohner@student.kit.edu; keydata=
 xjMEZlcqPBYJKwYBBAHaRw8BAQdAujEt8nGiqXlRzKWzklo/PFVaTiUdA6z4ptXk8gUpZZPN
 LFDDqXRlciBCb2huZXIgPHBldGVyLmJvaG5lckBzdHVkZW50LmtpdC5lZHU+wokEExYIADEW
 IQR4QiuKMuzoE9FfVrf+973rw/xgRwUCZlcqPAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEP73
 vevD/GBH4k4A/jn/XvRQH5Od/m9FpAc3xIwzOjOjFRogJqjNN8h7WGIpAP90BCUs7idkZS/U
 9ASZrK6ubOZV+pEHq9C0mSoVTjwkDc44BGZXKjwSCisGAQQBl1UBBQEBB0AyMulJt5lkL/5E
 hrwAaZiEOSigauCQR7o58Pnzh5hwGAMBCAfCeAQYFggAIBYhBHhCK4oy7OgT0V9Wt/73vevD
 /GBHBQJmVyo8AhsMAAoJEP73vevD/GBHRjYA/0Z40p2r7jZGqQeJB5Exh3sBjLNnuuMw5DXr
 KxFIdY8/AQDj6Xn+3dAOMHJfo17HT8zHn61PvclzVJZCriEmBcSsDQ==
To: <amd-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>,
	<regressions@lists.linux.dev>, <bugs@lists.linux.dev>
Subject: [6.12.60 lts] [amdgpu]: regression: broken multi-monitor USB4 dock on
 Ryzen 7840U
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

upgrading from 6.12.59 to 6.12.60 broke my USB4 (Dynabook Thunderbolt 4 
Dock)'s video output with my Framework 13 (AMD Ryzen 7840U / Radeom 780M 
igpu) .
With two monitors plugged in, only one of them works, the other (always 
the one on the 'video 2' output) remains blank (but receives signal).

relevant dmesg [note: tainted by ZFS]
(full output at: 
https://gist.github.com/x-zvf/128d45d028230438b8777c40759fa997):


[drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* 
wait_for_completion_timeout timeout!
------------[ cut here ]------------
WARNING: CPU: 15 PID: 3064 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/link/hwss/link_hwss_dpia.c:49 
update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
Modules linked in: hid_logitech_hidpp hid_logitech_dj snd_seq_midi 
snd_seq_midi_event uvcvideo videobuf2_vmalloc uvc videobuf2_memops 
snd_usb_audio videobuf2_v4l2 videobuf2_common snd_usbmidi_lib snd_ump 
videodev snd_rawmidi mc cdc_ether usbnet mii uas usb_storage ccm 
snd_seq_dummy rfcomm snd_hrtimer snd_seq snd_seq_device tun ip6t_REJECT 
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_multiport xt_cgroup xt_mark 
xt_owner xt_tcpudp ip6table_raw iptable_raw ip6table_mangle 
iptable_mangle ip6table_nat iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c crc32c_generic ip6table_filter 
ip6_tables iptable_filter uhid cmac algif_hash algif_skcipher af_alg 
bnep vfat fat amd_atl intel_rapl_msr intel_rapl_common snd_sof_amd_acp70 
snd_sof_amd_acp63 snd_soc_acpi_amd_match snd_sof_amd_vangogh 
snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci 
snd_sof_xtensa_dsp snd_sof mt7921e snd_sof_utils mt7921_common 
snd_pci_ps mt792x_lib snd_hda_codec_realtek snd_amd_sdw_acpi 
soundwire_amd kvm_amd
  mt76_connac_lib snd_hda_codec_generic soundwire_generic_allocation 
snd_hda_scodec_component snd_hda_codec_hdmi mousedev mt76 soundwire_bus 
snd_hda_intel kvm snd_soc_core snd_intel_dspcfg irqbypass 
snd_intel_sdw_acpi mac80211 snd_compress ac97_bus crct10dif_pclmul 
hid_sensor_als snd_pcm_dmaengine snd_hda_codec crc32_pclmul 
hid_sensor_trigger crc32c_intel snd_rpl_pci_acp6x 
industrialio_triggered_buffer snd_acp_pci polyval_clmulni kfifo_buf 
snd_hda_core snd_acp_legacy_common polyval_generic libarc4 
hid_sensor_iio_common industrialio ghash_clmulni_intel leds_cros_ec 
cros_ec_sysfs cros_ec_hwmon cros_kbd_led_backlight cros_charge_control 
led_class_multicolor gpio_cros_ec cros_ec_chardev cros_ec_debugfs 
sha512_ssse3 snd_hwdep snd_pci_acp6x hid_multitouch joydev spd5118 
hid_sensor_hub cros_ec_dev sha256_ssse3 snd_pcm btusb cfg80211 
sha1_ssse3 btrtl aesni_intel snd_pci_acp5x btintel snd_timer 
snd_rn_pci_acp3x sp5100_tco gf128mul ucsi_acpi crypto_simd btbcm 
snd_acp_config snd amd_pmf typec_ucsi cryptd snd_soc_acpi
  i2c_piix4 btmtk bluetooth rapl wmi_bmof pcspkr typec k10temp 
thunderbolt amdtee soundcore ccp snd_pci_acp3x i2c_smbus rfkill roles 
cros_ec_lpcs i2c_hid_acpi amd_sfh cros_ec platform_profile i2c_hid tee 
amd_pmc mac_hid i2c_dev crypto_user dm_mod loop nfnetlink bpf_preload 
ip_tables x_tables hid_generic usbhid amdgpu zfs(POE) crc16 amdxcp 
spl(OE) i2c_algo_bit drm_ttm_helper ttm serio_raw drm_exec atkbd 
gpu_sched libps2 vivaldi_fmap drm_suballoc_helper nvme drm_buddy i8042 
drm_display_helper nvme_core video serio cec nvme_auth wmi
CPU: 15 UID: 1000 PID: 3064 Comm: kwin_wayland Tainted: P  OE      
6.12.60-1-lts #1 9b11292f14ae477e878a6bb6a5b5efc27ccf021d
Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, 
BIOS 03.16 07/25/2025
RIP: 0010:update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
Code: d0 0f 1f 00 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 1a 48 83 
c4 10 5b 5d 41 5c 41 5d e9 10 ec e3 d9 31 db e9 6f ff ff ff <0f> 0b eb 
8a e8 05 09 c3 d9 0f 1f 44 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffd26fe3473248 EFLAGS: 00010282
RAX: 00000000ffffffff RBX: 0000000000000025 RCX: 0000000000001140
RDX: 00000000ffffffff RSI: ffffd26fe34731f0 RDI: ffff8bb78c7bb608
RBP: ffff8bb7982c3b88 R08: 00000000ffffffff R09: 0000000000001100
R10: ffffd27000ef9900 R11: ffff8bb78c7bb400 R12: ffff8bb7982ed600
R13: ffff8bb7982c3800 R14: ffff8bb984e402a8 R15: ffff8bb7982c38c8
FS:  000073883c086b80(0000) GS:ffff8bc51e180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002020005ba004 CR3: 000000014396e000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
  <TASK>
  ? link_set_dpms_on+0x7a5/0xc70 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  link_set_dpms_on+0x806/0xc70 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  dce110_apply_single_controller_ctx_to_hw+0x300/0x480 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  dce110_apply_ctx_to_hw+0x24c/0x2e0 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  ? dcn10_setup_stereo+0x160/0x170 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  dc_commit_state_no_check+0x63d/0xeb0 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  dc_commit_streams+0x296/0x490 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? schedule_timeout+0x133/0x170
  amdgpu_dm_atomic_commit_tail+0x6a1/0x3a10 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? psi_task_switch+0x113/0x2a0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? schedule+0x27/0xf0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? schedule_timeout+0x133/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? dma_fence_default_wait+0x8b/0x230
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? wait_for_completion_timeout+0x12e/0x180
  commit_tail+0xae/0x140
  drm_atomic_helper_commit+0x13c/0x180
  drm_atomic_commit+0xa6/0xe0
  ? __pfx___drm_printfn_info+0x10/0x10
  drm_mode_atomic_ioctl+0xa60/0xcd0
  ? sock_poll+0x51/0x110
  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
  drm_ioctl_kernel+0xad/0x100
  drm_ioctl+0x286/0x500
  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 
d75f7e51e39957084964278ab74da83065554c01]
  __x64_sys_ioctl+0x91/0xd0
  do_syscall_64+0x7b/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __x64_sys_ppoll+0xf8/0x180
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? syscall_exit_to_user_mode+0x37/0x1c0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x87/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x87/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x87/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x87/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_syscall_64+0x87/0x190
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? irqentry_exit_to_user_mode+0x2c/0x1b0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x738842d9b70d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 
00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 
00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007ffe3c7ed230 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000634abd49c210 RCX: 0000738842d9b70d
RDX: 00007ffe3c7ed320 RSI: 00000000c03864bc RDI: 0000000000000013
RBP: 00007ffe3c7ed280 R08: 0000634abc4049bc R09: 0000634abce43e80
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3c7ed320
R13: 00000000c03864bc R14: 0000000000000013 R15: 0000634abc404840
  </TASK>
---[ end trace 0000000000000000 ]---


regards,
~ Peter




