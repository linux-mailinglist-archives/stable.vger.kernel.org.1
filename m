Return-Path: <stable+bounces-106621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F19FF174
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65AC16236D
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991619DF4C;
	Tue, 31 Dec 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="mscJvldd"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA26EB7D;
	Tue, 31 Dec 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735672233; cv=none; b=QtebLzgZ7223WkK7ArFHwMWQhP8w2lJJK5bJ9/kNADjqVoSKFVcmg34dHszz0kdMeYlIiLzpWfj5Nr5rPQsPUIsiR4XIbuAiezAV+SVDQLx4qm6w48MyfWZi3eHvoj3wz8v6ebx0VIoQDLCuo43c2EHkVBNlKXbbuV1HD2ZHRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735672233; c=relaxed/simple;
	bh=6mdb9kq54IORXSv1q+kP5CuZi3zo4YtFIMdHWe23cFM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkiQ3QQ1qfWXxuFL8wcuTVIHnituNmjyrmkLGqVW3EsLbaeQeqS4A9L8Rmgryn9yt4G6OoB7w0E6fLVoYZ5YHSrw5bBsUiOrleGwUW8cL8ovEJKRk7UZBHdZ/6/FHhujOXzGEZFQJcTr3YBnObs4oP6J6o+TdOT3ni9Zhn/UW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=mscJvldd; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 31 Dec 2024 20:10:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1735672229;
	bh=6mdb9kq54IORXSv1q+kP5CuZi3zo4YtFIMdHWe23cFM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=mscJvldd5R680uzFp0w2l/WPFM7GIcff2C3u9IR0t7jarhZ0AIUxgJXx9zT2PCvI3
	 uKJ228xdzahlaoJlRzomUVXSgt/k0WWlEwzSPfSw9LK0BPb2JCHzcTEsKq7fWvGvm0
	 PmXkl76fGVw79wWP8+vp47WkWspepqntawCW1d+gXFpljN+siqhy53gyGE2+5PHkPe
	 7sRn4x2AeWbYqrlwxRZl9TLADT0EvCtOfknm8cUIaux7E0rEH81jBPe5OyaRWowHr4
	 XnKbvqfgJQvVgQIM2CEMEnShSxkJwTZS+RsPpF+yYFe/wBNjF6lpi7FC2U53a/pLJH
	 CQs485qX4kprQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
Message-ID: <20241231191028.GD17604@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241230154218.044787220@linuxfoundation.org>
 <20241231094242.GC17604@pc21.mareichelt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241231094242.GC17604@pc21.mareichelt.com>

* Markus Reichelt <lkt+2023@mareichelt.com> wrote:

> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > This is the start of the stable review cycle for the 6.12.8 release.
> > There are 114 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> > Anything received after that time might be too late.
>=20
> Hi Greg
>=20
> 6.12.8-rc1 compiles, boots and runs here on x86_64
> (AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

heads up, there seems to be something wrong with -rc1

on the lappy (Vivobook Go E1504FA) I got this:

[Tue Dec 31 19:47:55 2024] ------------[ cut here ]------------
[Tue Dec 31 19:47:55 2024] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_jo=
b_work [gpu_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_device_delay_e=
nable_gfx_off [amdgpu]
[Tue Dec 31 19:47:55 2024] WARNING: CPU: 5 PID: 1734 at kernel/workqueue.c:=
3704 check_flush_dependency+0xfa/0x110
[Tue Dec 31 19:47:55 2024] Modules linked in: 8021q garp mrp stp llc qrtr a=
lgif_hash algif_skcipher af_alg cmac bnep ipv6 zram uvcvideo uvc videobuf2_=
vmalloc videobuf2_memops videobuf2_v4l2 btusb videobuf2_common btrtl btinte=
l btbcm videodev btmtk bluetooth mc usbhid joydev intel_rapl_msr snd_soc_ac=
p6x_mach snd_soc_dmic snd_acp6x_pdm_dma snd_ctl_led amdgpu snd_sof_amd_reno=
ir snd_sof_amd_acp snd_sof_pci snd_hda_codec_realtek snd_sof_xtensa_dsp snd=
_hda_codec_generic snd_hda_scodec_component snd_sof snd_sof_utils snd_hda_c=
odec_hdmi hid_multitouch hid_generic snd_soc_core amdxcp amd_atl drm_exec r=
tw88_8821ce snd_compress snd_hda_intel gpu_sched rtw88_8821c intel_rapl_com=
mon snd_pcm_dmaengine drm_buddy snd_intel_dspcfg rtw88_pci drm_suballoc_hel=
per snd_intel_sdw_acpi snd_hda_codec drm_ttm_helper asus_nb_wmi edac_mce_am=
d ac97_bus snd_hda_core ttm rtw88_core asus_wmi crct10dif_pclmul crc32_pclm=
ul sparse_keymap evdev wmi_bmof platform_profile mac80211 drm_display_helpe=
r snd_hwdep snd_pci_acp6x i2c_hid_acpi ghash_clmulni_intel sha512_ssse3
[Tue Dec 31 19:47:55 2024]  i2c_hid snd_pcm sha256_ssse3 drm_kms_helper hid=
 sha1_ssse3 cfg80211 snd_timer snd_pci_acp5x xhci_pci snd_rn_pci_acp3x drm =
rapl serio_raw agpgart snd snd_acp_config i2c_algo_bit rfkill snd_soc_acpi =
xhci_hcd mfd_core snd_pci_acp3x soundcore i2c_piix4 k10temp i2c_smbus i2c_d=
esignware_platform tpm_crb tiny_power_button tpm_tis video ccp tpm_tis_core=
 button i2c_designware_core i2c_core amd_pmc wmi loop(O) efivarfs
[Tue Dec 31 19:47:55 2024] CPU: 5 UID: 0 PID: 1734 Comm: kworker/u32:6 Tain=
ted: G           O       6.12.8-rc1-jg71 #1
[Tue Dec 31 19:47:55 2024] Tainted: [O]=3DOOT_MODULE
[Tue Dec 31 19:47:55 2024] Hardware name: ASUSTeK COMPUTER INC. Vivobook Go=
 E1504FA_E1504FA/E1504FA, BIOS E1504FA.309 12/26/2023
[Tue Dec 31 19:47:55 2024] Workqueue: sdma0 drm_sched_run_job_work [gpu_sch=
ed]
[Tue Dec 31 19:47:55 2024] RIP: 0010:check_flush_dependency+0xfa/0x110
[Tue Dec 31 19:47:55 2024] Code: ff ff 49 8b 55 18 48 8d 8b c0 00 00 00 49 =
89 e8 48 81 c6 c0 00 00 00 48 c7 c7 50 96 e9 92 c6 05 90 35 3d 02 01 e8 66 =
ab fd ff <0f> 0b e9 21 ff ff ff 80 3d 7e 35 3d 02 00 75 96 e9 4d ff ff ff 90
[Tue Dec 31 19:47:55 2024] RSP: 0018:ffffbf038050bc88 EFLAGS: 00010086
[Tue Dec 31 19:47:55 2024] RAX: 0000000000000000 RBX: ffff9d9040050c00 RCX:=
 0000000000000000
[Tue Dec 31 19:47:55 2024] RDX: 0000000000000003 RSI: ffffffff92ea9253 RDI:=
 00000000ffffffff
[Tue Dec 31 19:47:55 2024] RBP: ffffffffc0e8cb00 R08: 0000000000000000 R09:=
 ffffbf038050bb20
[Tue Dec 31 19:47:55 2024] R10: ffffbf038050bb18 R11: ffff9d934e3fffe8 R12:=
 ffff9d9048ef4ec0
[Tue Dec 31 19:47:55 2024] R13: ffff9d9043e0d3c0 R14: 0000000000000001 R15:=
 ffff9d934e733ac0
[Tue Dec 31 19:47:55 2024] FS:  0000000000000000(0000) GS:ffff9d934e880000(=
0000) knlGS:0000000000000000
[Tue Dec 31 19:47:55 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Tue Dec 31 19:47:55 2024] CR2: 00007f0e70000020 CR3: 00000003ff244000 CR4:=
 0000000000350ef0
[Tue Dec 31 19:47:55 2024] Call Trace:
[Tue Dec 31 19:47:55 2024]  <TASK>
[Tue Dec 31 19:47:55 2024]  ? __warn+0x84/0x130
[Tue Dec 31 19:47:55 2024]  ? check_flush_dependency+0xfa/0x110
[Tue Dec 31 19:47:55 2024]  ? report_bug+0x1c3/0x1d0
[Tue Dec 31 19:47:55 2024]  ? srso_return_thunk+0x5/0x5f
[Tue Dec 31 19:47:55 2024]  ? prb_read_valid+0x17/0x20
[Tue Dec 31 19:47:55 2024]  ? handle_bug+0x53/0x90
[Tue Dec 31 19:47:55 2024]  ? exc_invalid_op+0x14/0x70
[Tue Dec 31 19:47:55 2024]  ? asm_exc_invalid_op+0x16/0x20
[Tue Dec 31 19:47:55 2024]  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10=
/0x10 [amdgpu]
[Tue Dec 31 19:47:55 2024]  ? check_flush_dependency+0xfa/0x110
[Tue Dec 31 19:47:55 2024]  ? check_flush_dependency+0xfa/0x110
[Tue Dec 31 19:47:55 2024]  __flush_work+0x20a/0x2a0
[Tue Dec 31 19:47:55 2024]  ? srso_return_thunk+0x5/0x5f
[Tue Dec 31 19:47:55 2024]  ? try_to_grab_pending+0xb0/0x1b0
[Tue Dec 31 19:47:55 2024]  ? srso_return_thunk+0x5/0x5f
[Tue Dec 31 19:47:55 2024]  ? __cancel_work+0x39/0x110
[Tue Dec 31 19:47:55 2024]  ? __remove_hrtimer+0x39/0x90
[Tue Dec 31 19:47:55 2024]  cancel_delayed_work_sync+0x62/0x80
[Tue Dec 31 19:47:55 2024]  amdgpu_gfx_off_ctrl+0xa9/0x120 [amdgpu]
[Tue Dec 31 19:47:55 2024]  amdgpu_ring_alloc+0x44/0x60 [amdgpu]
[Tue Dec 31 19:47:55 2024]  amdgpu_ib_schedule+0xe3/0x7b0 [amdgpu]
[Tue Dec 31 19:47:55 2024]  amdgpu_job_run+0x93/0x1f0 [amdgpu]
[Tue Dec 31 19:47:55 2024]  drm_sched_run_job_work+0x23a/0x3c0 [gpu_sched]
[Tue Dec 31 19:47:55 2024]  process_one_work+0x170/0x380
[Tue Dec 31 19:47:55 2024]  worker_thread+0x294/0x3b0
[Tue Dec 31 19:47:55 2024]  ? __pfx_worker_thread+0x10/0x10
[Tue Dec 31 19:47:55 2024]  kthread+0xdd/0x110
[Tue Dec 31 19:47:55 2024]  ? __pfx_kthread+0x10/0x10
[Tue Dec 31 19:47:55 2024]  ret_from_fork+0x30/0x50
[Tue Dec 31 19:47:55 2024]  ? __pfx_kthread+0x10/0x10
[Tue Dec 31 19:47:55 2024]  ret_from_fork_asm+0x1a/0x30
[Tue Dec 31 19:47:55 2024]  </TASK>
[Tue Dec 31 19:47:55 2024] ---[ end trace 0000000000000000 ]---

This doesn't happen with 6.12.7 - I tried reproducing it w/o the OOT module=
 (loop) by booting once without it, to no avail.
hm. Can't do so today, but will check this in more detail eventually.

