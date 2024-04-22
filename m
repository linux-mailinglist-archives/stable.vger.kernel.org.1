Return-Path: <stable+bounces-40373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8018ACA09
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D95C1F214FF
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC312BF3D;
	Mon, 22 Apr 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TmcG7W6J"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206294317E;
	Mon, 22 Apr 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779809; cv=none; b=NOqfYIiijzS2mqlXuNWs9uPj/4kkjcyPRlA3Hpznm3EHUw+k+Grvz+QPzxn+hB2/OKx5PethBrfqThYLMUaKQSev2f95AAvkF346Va+SEQII4PpkZ3fbktnXeXudZ0SmAylzXWEB0jaDaeQmArfjYvD9/AwPM7Vxef0BDJyqIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779809; c=relaxed/simple;
	bh=eNk6omhT37u0Q+7V1LqG73Z4K3ERzS3bFwr8A76Fprs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bnERQuHJa9kmAmkTVhJP9eAGA2PhnD0bcoAsmViELEscOX3ceBZQNotOikrHxom3VX81YUl+N0r/85HMhhIHV5/MjmS41GazMaxIfjQjeiOTxb7rtXyNmfklns5cvLL8nUbv8Vfuh8dWFe84s4uTG9qvthm6SZbJywKv1xMWgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TmcG7W6J; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=CcNWeEi9rXMPdmwrRAxfGz9P09R/++2ugruQ0jzzzP4=;
	t=1713779807; x=1714211807; b=TmcG7W6JshuM2EG4ZHSx+mAauPRIQZffJG/azywd5Peb9dG
	S+0vU0BY/ygshtrutcBpEezxQV6BuHTg5Bbq1uU03qUO6z2A/4QLMO7Mb5ULMuRlG0kRHk0bqEn20
	Uq1TMfWbL0x86ABeot0ymtgLqOlsxAFwgnhNxYorpFqEBHrEyZbLaQfdhsFX0UcwccmgRXiEexA4l
	rAjhu5fzbsH8vJ2zjLMVuhOGP0Pt1os9I86HbIxN6s3xRq8BAXbRxfvqo5kI+U1QjJoDn0xhRRzka
	4b901H4tDiLxYcSbZpQoKS+j1uGsLAaKn+L7MkbrY+WhlDH84eQnJTUrgYCBKZQw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ryqPk-0003hO-EL; Mon, 22 Apr 2024 11:56:44 +0200
Message-ID: <1de62bb7-93bb-478e-8af4-ba9abf5ae330@leemhuis.info>
Date: Mon, 22 Apr 2024 11:56:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, =?UTF-8?Q?Jeremy_Lain=C3=A9?=
 <jeremy.laine@m4x.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713779807;e2ea92c7;
X-HE-SMSGID: 1ryqPk-0003hO-EL

Hi stable team (and Bluetooth maintainers), I noticed a regression
report about a BT problem in 6.1.y:

On 21.04.24 15:54, Jeremy Lainé wrote:
> 
> After upgrading my kernel to Debian's latest version (6.1.85), I
> started encountering systematic kernel BUGs at boot, making the
> bluetooth stack unusable. I initially reported this to Debian's bug
> tracker:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1069301
> 
> .. but have since confirmed that this is reproducible with vanilla
> kernels, including the latest 6.1.y version (6.1.87).
> 
> I tried various kernel versions (straight from kernel.org) to pinpoint
> when the problem started occurring and the resultats are:

Jeremy later wrote:
> # first bad commit: [6083089ab00631617f9eac678df3ab050a9d837a]
> Bluetooth: hci_conn: Consolidate code for aborting connections
https://lore.kernel.org/all/8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de/

That's a13f316e90fdb1 ("Bluetooth: hci_conn: Consolidate code for
aborting connections") [v6.6-rc1, v6.1.83 (6083089ab00631)]

FWIW, there is a fix for the mainline commit under review:
https://lore.kernel.org/all/20240411151929.403263-1-kovalev@altlinux.org/

But it is likely unrelated, as Jeremy later also wrote:
> I'm now running 6.9-rc5 and have not been able to reproduce the issue,
https://lore.kernel.org/all/CADRbXaA2yFjMo=_8_ZTubPbrrmWH9yx+aG5pUadnk395koonXg@mail.gmail.com/

Makes me wonder if 6.1.y is missing some other change a13f316e90fdb1
depends on.

Ciao, Thorsten

> I have included a trace below, and full system details are available
> in the Debian bug listed above. Can you suggest any other tests I can
> perform to help diagnose the origin of the problem?
> 
> [   22.660847] list_del corruption, ffff94d9f6302000->prev is
> LIST_POISON2 (dead000000000122)
> [   22.660887] ------------[ cut here ]------------
> [   22.660890] kernel BUG at lib/list_debug.c:56!
> [   22.660907] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   22.660917] CPU: 10 PID: 139 Comm: kworker/u25:0 Not tainted
> 6.1.0-20-amd64 #1  Debian 6.1.85-1
> [   22.660929] Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.19.1 03/14/2024
> [   22.660936] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> [   22.661128] RIP: 0010:__list_del_entry_valid.cold+0x4b/0x6f
> [   22.661147] Code: fe ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 48 18 7a
> 9f e8 14 a1 fe ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 10 18 7a 9f e8 00
> a1 fe ff <0f> 0b 48 89 fe 48 c7 c7 d8 17 7a 9f e8 ef a0 fe ff 0f 0b 48
> 89 fe
> [   22.661156] RSP: 0000:ffffae0e406efde0 EFLAGS: 00010246
> [   22.661164] RAX: 000000000000004e RBX: ffff94d9f6302000 RCX: 0000000000000027
> [   22.661172] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff94dfaf8a03a0
> [   22.661177] RBP: ffff94d859392000 R08: 0000000000000000 R09: ffffae0e406efc78
> [   22.661182] R10: 0000000000000003 R11: ffffffff9fed4448 R12: ffff94d859392000
> [   22.661187] R13: ffff94d859392770 R14: ffff94d858cb9800 R15: dead000000000100
> [   22.661194] FS:  0000000000000000(0000) GS:ffff94dfaf880000(0000)
> knlGS:0000000000000000
> [   22.661202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.661208] CR2: 00007f423c024038 CR3: 0000000799c04000 CR4: 0000000000750ee0
> [   22.661214] PKRU: 55555554
> [   22.661218] Call Trace:
> [   22.661225]  <TASK>
> [   22.661232]  ? __die_body.cold+0x1a/0x1f
> [   22.661246]  ? die+0x2a/0x50
> [   22.661257]  ? do_trap+0xc5/0x110
> [   22.661268]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661279]  ? do_error_trap+0x6a/0x90
> [   22.661289]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661298]  ? exc_invalid_op+0x4c/0x60
> [   22.661307]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661316]  ? asm_exc_invalid_op+0x16/0x20
> [   22.661328]  ? __list_del_entry_valid.cold+0x4b/0x6f
> [   22.661337]  hci_conn_del+0x136/0x3e0 [bluetooth]
> [   22.661466]  hci_abort_conn_sync+0xaa/0x230 [bluetooth]
> [   22.661632]  ? abort_conn_sync+0x3d/0x70 [bluetooth]
> [   22.661751]  hci_cmd_sync_work+0x9f/0x150 [bluetooth]
> [   22.661915]  process_one_work+0x1c4/0x380
> [   22.661929]  worker_thread+0x4d/0x380
> [   22.661940]  ? rescuer_thread+0x3a0/0x3a0
> [   22.661950]  kthread+0xd7/0x100
> [   22.661959]  ? kthread_complete_and_exit+0x20/0x20
> [   22.661969]  ret_from_fork+0x1f/0x30
> [   22.661984]  </TASK>
> [   22.661987] Modules linked in: ctr ccm nft_chain_nat xt_MASQUERADE
> nf_nat nf_conntrack_netlink br_netfilter bridge stp llc xfrm_user
> xfrm_algo nvme_fabrics rfcomm snd_seq_dummy snd_hrtimer snd_seq
> snd_seq_device cmac algif_hash algif_skcipher af_alg snd_ctl_led
> snd_soc_sof_sdw snd_soc_intel_hda_dsp_common snd_sof_probes
> snd_soc_intel_sof_maxim_common snd_soc_rt715_sdca snd_soc_rt1316_sdw
> regmap_sdw_mbq snd_hda_codec_hdmi regmap_sdw overlay ip6t_REJECT
> nf_reject_ipv6 xt_hl ip6_tables ip6t_rt ipt_REJECT nf_reject_ipv4
> xt_LOG qrtr nf_log_syslog nft_limit bnep ipmi_devintf ipmi_msghandler
> xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c nfnetlink
> binfmt_misc nls_ascii nls_cp437 vfat fat x86_pkg_temp_thermal
> intel_powerclamp coretemp snd_soc_dmic snd_sof_pci_intel_tgl
> snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation
> soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
> snd_sof snd_sof_utils
> [   22.662122]  snd_soc_hdac_hda snd_hda_ext_core
> snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core kvm_intel
> snd_compress btusb soundwire_bus btrtl kvm btbcm snd_hda_intel btintel
> snd_intel_dspcfg btmtk dell_laptop snd_intel_sdw_acpi irqbypass
> ledtrig_audio bluetooth snd_hda_codec i915 snd_hda_core rapl mei_hdcp
> intel_rapl_msr snd_hwdep processor_thermal_device_pci dell_wmi joydev
> hid_sensor_als intel_cstate jitterentropy_rng processor_thermal_device
> snd_pcm hid_sensor_trigger processor_thermal_rfim dell_smbios
> ucsi_acpi dcdbas hid_sensor_iio_common processor_thermal_mbox
> drm_buddy intel_uncore iwlmvm pcspkr drbg iTCO_wdt typec_ucsi
> dell_wmi_sysman snd_timer industrialio_triggered_buffer
> drm_display_helper processor_thermal_rapl mei_me dell_wmi_descriptor
> firmware_attributes_class kfifo_buf wmi_bmof ansi_cprng intel_pmc_bxt
> cec snd roles intel_rapl_common ecdh_generic iTCO_vendor_support
> int3403_thermal watchdog ecc industrialio mei soundcore typec
> int3400_thermal rc_core mac80211
> [   22.662253]  int340x_thermal_zone intel_pmc_core button intel_hid
> acpi_thermal_rel sparse_keymap ttm acpi_pad acpi_tad drm_kms_helper
> libarc4 igen6_edac i2c_algo_bit ac evdev hid_multitouch serio_raw
> iwlwifi cfg80211 rfkill msr parport_pc ppdev lp drm parport fuse loop
> efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16
> mbcache jbd2 crc32c_generic usbhid hid_sensor_custom hid_sensor_hub
> dm_crypt dm_mod intel_ishtp_hid nvme nvme_core t10_pi
> crc64_rocksoft_generic crc64_rocksoft crc_t10dif crct10dif_generic
> crc64 ahci libahci crct10dif_pclmul crct10dif_common libata
> crc32_pclmul crc32c_intel scsi_mod spi_pxa2xx_platform
> ghash_clmulni_intel dw_dmac hid_generic sha512_ssse3 scsi_common
> dw_dmac_core xhci_pci sha512_generic sha256_ssse3 xhci_hcd sha1_ssse3
> usbcore i2c_hid_acpi intel_lpss_pci aesni_intel video intel_ish_ipc
> i2c_i801 i2c_hid intel_lpss psmouse thunderbolt crypto_simd cryptd
> i2c_smbus vmd intel_ishtp usb_common idma64 hid battery wmi
> [   22.662422] ---[ end trace 0000000000000000 ]---
> 
> Cheers,
> 
> Jeremy


#regzbot ^introduced 6083089ab0063
#regzbot title Bluetooth kernel BUG with Intel AX211
#regzbot duplicate:
https://lore.kernel.org/all/8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de/
#regzbot ignore-activit

