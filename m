Return-Path: <stable+bounces-230393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAIGCuBuxGkZzQQAu9opvQ
	(envelope-from <stable+bounces-230393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:25:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782D832D593
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F09304DF1B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD2396599;
	Wed, 25 Mar 2026 23:24:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CC3537C7;
	Wed, 25 Mar 2026 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.242.207.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481094; cv=none; b=cN3+iZA9vt4GsFwmHILAcIaZt+z6mRhaoQF4S6ZiFwfp3VeoVBSfj65GpzGPNDDjIvY2U5nsvblj7A0VPt8BLyRPpJxx9D5C2FXBWyRrhm7SwHTw904ZgWlleQzdEvujZyGLP/hW8a4IT/yK5kfEjIhOXT/Jhn/t9ybp0MjHVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481094; c=relaxed/simple;
	bh=NXsCcx6F+/LefhViRrYQfu1Iswpc7vzs1cLhaswz/0U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o38rINUbT6fa9SEHcXIVSmkjb/2oC3SIW9dg4Mrd+bm8GhKqEsoLASkriqFN0bFJ8EBNZDwxFA2Co06sDdwbwFlTbgmyWoh2tQtwLc597uj05r76ZTpfgf5WPBIKkiK9alsBImNPx6HZhH8Iokiz8Ntpc5ZFCFWuE4l/tv9F8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net; spf=pass smtp.mailfrom=absolutedigital.net; arc=none smtp.client-ip=50.242.207.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=absolutedigital.net
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
	by luxor.inet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62PNNDgo015545
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 25 Mar 2026 19:23:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by lancer.cnet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62PNNDe2009997
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Mar 2026 19:23:14 -0400
Date: Wed, 25 Mar 2026 19:23:13 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
        jslaby@suse.cz, Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Linux 6.18.19 -- amdgpu bug and a new warning
In-Reply-To: <2026031914-send-embezzle-1648@gregkh>
Message-ID: <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net>
References: <2026031914-send-embezzle-1648@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="118098437-1053259840-1774479888=:7301"
Content-ID: <a8ed69b-2438-288a-e91-eb6b6aed236@absolutedigital.net>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230393-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[absolutedigital.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cp@absolutedigital.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,absolutedigital.net:mid]
X-Rspamd-Queue-Id: 782D832D593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--118098437-1053259840-1774479888=:7301
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-ID: <e04a601b-9a17-a120-87c9-c1c7ab2b053@absolutedigital.net>

Hi,

A commit in 6.18.19 has introduced a bug and a new warning when doing 
amdgpu driver re-binding. In addition to the bug, the last line of the 
output below is a new warning re: the thermal alert

This bug doesn't seem to cause any show-stopping problems, but it is a bug 
and it persists into 6.18.20.

I can do a bisect if needed, but I'm hoping one of our AMD guys can more 
quickly spot what's going on :)


  amdgpu 0000:14:00.0: amdgpu: amdgpu: finishing device.
  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 2773 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xa4/0xc0 [amdgpu]
  Modules linked in: iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_multiport xt_LOG nf_log_syslog xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter ip_tables x_tables bridge stp llc ipv6 nct6775 tun sg pcspkr nct6775_core nct6683 hwmon_vid edac_mce_amd uas usb_storage onboard_usb_dev joydev hid_generic usbhid hid amdgpu tpm_crb amdxcp drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper snd_hda_codec_alc882 snd_hda_codec_realtek_lib ttm drm_exec intel_rapl_msr amd_atl snd_hda_codec_generic drm_suballoc_helper drm_client_lib intel_rapl_common snd_hda_codec_atihdmi snd_hda_codec_hdmi drm_display_helper cec snd_hda_intel rc_core snd_hda_codec kvm_amd snd_hda_core drm_kms_helper ee1004 wmi_bmof r8169 snd_intel_dspcfg realtek snd_intel_sdw_acpi mdio_devres kvm snd_hwdep drm of_mdio snd_pcm agpgart polyval_clmulni i2c_designware_pci fixed_phy ghash_clmulni_intel snd_timer i2c_algo_bit i2c_piix4 fwnode_mdio i2c_designware_core rapl!
  video i2c_smbus i2c_ccgx_ucsi snd
   libphy xhci_pci mfd_core soundcore ccp k10temp i2c_core mdio_bus igc xhci_hcd wmi gpio_amdpt tpm_tis gpio_generic tpm_tis_core evdev loop dm_snapshot dm_bufio vfio_pci vfio_pci_core vfio_iommu_type1 vfio iommufd irqbypass
  CPU: 1 UID: 0 PID: 2773 Comm: bind-device.sh Not tainted 6.18.20 #1 PREEMPT(lazy) 
  Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B550 Taichi, BIOS P2.00 08/05/2021
  RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
  Code: ea 48 8d 14 90 8b 12 85 d2 75 ae 5b b8 ea ff ff ff 5d 41 5c e9 a8 c9 e1 d1 89 ea 48 89 de 4c 89 e7 5b 5d 41 5c e9 9c fd ff ff <0f> 0b b8 ea ff ff ff eb a8 b8 fe ff ff ff eb a1 90 66 66 2e 0f 1f
  RSP: 0018:ffffcf4a8777fce0 EFLAGS: 00010246
  RAX: ffff8c634233a908 RBX: ffff8c6345564008 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffff8c6345564008 RDI: ffff8c6348900000
  RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8c63455648e4
  R10: ffffffffc14935d0 R11: ffff8c6375dd8470 R12: ffff8c6348900000
  R13: ffff8c6345564000 R14: ffff8c6348900000 R15: 0000000000000000
  FS:  00007f0549119740(0000) GS:ffff8c8268c28000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000002d3fa810 CR3: 0000000282aa9000 CR4: 0000000000f50ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   smu_smc_hw_cleanup+0x61/0x490 [amdgpu]
   smu_hw_fini+0xef/0x180 [amdgpu]
   amdgpu_ip_block_hw_fini+0x37/0x41 [amdgpu]
   amdgpu_device_fini_hw+0x20d/0x284 [amdgpu]
   amdgpu_pci_remove+0x48/0x80 [amdgpu]
   pci_device_remove+0x46/0xb0
   device_release_driver_internal+0x19a/0x200
   unbind_store+0xa0/0xb0
   kernfs_fop_write_iter+0x149/0x200
   vfs_write+0x259/0x4b0
   ksys_write+0x6f/0xe0
   do_syscall_64+0x4c/0x1130
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f0548e98bfa
  Code: b8 04 00 00 00 48 8b 15 ec 71 16 00 64 89 02 48 c7 c2 ff ff ff ff 48 83 c4 18 48 89 d0 c3 66 90 49 89 ca 48 8b 44 24 20 0f 05 <48> 63 d0 3d 00 f0 ff ff 77 0c 48 89 d0 48 83 c4 18 c3 0f 1f 40 00
  RSP: 002b:00007ffeeb12b470 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007f0549001780 RCX: 00007f0548e98bfa
  RDX: 000000000000000d RSI: 000000002d3fa810 RDI: 0000000000000001
  RBP: 000000000000000d R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000d
  R13: 000000002d3fa810 R14: 000000002d3fa810 R15: 0000000000000000
   </TASK>
  ---[ end trace 0000000000000000 ]---
  amdgpu 0000:14:00.0: amdgpu: Fail to disable thermal alert!


-- 
Cal Peake
--118098437-1053259840-1774479888=:7301--

