Return-Path: <stable+bounces-76194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B9979CEC
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3A21F23AD2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13613D8B0;
	Mon, 16 Sep 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+Wg3lP0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE038DC7
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475915; cv=none; b=q82y1I15r7Fcgbjl/N8ejjsTPppIraJxplqWrkfXo/0TPrD+kvaxDljIsL0jmdHTfiAGN5GjzPseIPp9v2EFAKFxwMClvfG4Kh4obLdxqnjGY3yYQbHDU/KRK0vZWfaaL3eO/+uHWsot2di5qtkMKrPfQfuI6qAjehJUAxYaFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475915; c=relaxed/simple;
	bh=79td/7LS8Liy6YJBMeaXhzLjSN87BdKKVJSCZaImQv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/hz0i0MSA5OES1uy9cF7If8QiuXkeKOq+ZwsDYhXpxWxjWCuaAEL8KMRocoidzjIq4Gyf1nethYU/F6cFMuGVyfQx3qEyrCtmGOosaihwkpDklOuzw7wtanutYKqSCYd98l1T+mAg2uDbkOTxv9+IQqI6GotiEXFGjngWPiO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+Wg3lP0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726475913; x=1758011913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=79td/7LS8Liy6YJBMeaXhzLjSN87BdKKVJSCZaImQv4=;
  b=C+Wg3lP0VNr/Yy7KfhmEjvumXmxi3Ec97fA85zptsZFAxOa5aoH3+J/Z
   L3LgQBWrf7+m1OfWDfme9f5y9NIQ0UijfaDLnzK2YzftTy4qYQnIJE+KW
   LPvBwgmOVzgQr9xHxgrRs7ETLVcmycxS6cy9EKDGf+W1w8KDCeteQNvyF
   EO5zQzDc6S4xEdyahHEfA/XdromuxXbmePNdqfOcB1HO9kbFq6ehO4pB+
   n1+t22XtTjj0dE+LSPDq79AWoCzNeJvczwIlzMll8wpH6OMn1+rbvbqkW
   Et/f42tiZqPfUf+Csq+0/K/6VUnE6Epi7j5BCub7zEgesnYcrCfrySP27
   w==;
X-CSE-ConnectionGUID: kgpEwiJSQOWvDFLnhccKng==
X-CSE-MsgGUID: 14fRbo2sTQ+qtaNDYrxbGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="35970182"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="35970182"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:38:33 -0700
X-CSE-ConnectionGUID: GoydEx/ZTDqnL2apKwLmgA==
X-CSE-MsgGUID: XzSAn9VpSzaWm6WVi+ImeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69307875"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO [10.245.244.77]) ([10.245.244.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:38:31 -0700
Message-ID: <dc29b0fc-172e-425d-9c50-660f5d4106b9@intel.com>
Date: Mon, 16 Sep 2024 09:38:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org
References: <20240913120023.310565-2-matthew.auld@intel.com>
 <gxnl6ekfxrmyg3slr6x6c5ad26a2ldqokbcuzddgts7z3sqt6c@34dpem3njjde>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <gxnl6ekfxrmyg3slr6x6c5ad26a2ldqokbcuzddgts7z3sqt6c@34dpem3njjde>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/09/2024 23:36, Lucas De Marchi wrote:
> On Fri, Sep 13, 2024 at 01:00:24PM GMT, Matthew Auld wrote:
>> Spec says SW is expected to round up to the nearest 128K, if not already
>> aligned for the CC unit view of CCS. We are seeing the assert sometimes
>> pop on BMG to tell us that there is a hole between GSM and CCS, as well
> 
> may you paste the waning here? Just got a random BMG from the pile and
> have some may-be-related warnings showing up. And this patch didn't
> help:
> 
> [ 1109.275389] ------------[ cut here ]------------
> [ 1109.275392] xe 0000:03:00.0: [drm] Assertion `offset == 
> (xe_mmio_read64_2x32(&_Generic(gt, const struct xe_gt * : (const struct 
> xe_tile *)((gt)->tile), struct xe_gt * : (gt)->tile)->mmio, ((const 
> struct xe_reg){ .addr = 0x108100, })) - ccs_size)` failed!
>                 platform: BATTLEMAGE subplatform: 1
>                 graphics: Xe2_LPG / Xe2_HPG 20.01 step A0
>                 media: Xe2_LPM / Xe2_HPM 13.01 step A1
>                 Hole between CCS and GSM.
> [ 1109.275415] WARNING: CPU: 6 PID: 3377 at 
> drivers/gpu/drm/xe/xe_vram.c:188 tile_vram_size+0x26d/0x500 [xe]
> [ 1109.275540] Modules linked in: xe(+) snd_hda_intel mei_gsc_proxy 
> mei_gsc drm_gpuvm i2c_algo_bit drm_ttm_helper ttm gpu_sched 
> drm_suballoc_helper drm_exec drm_display_helper drm_kunit_helpers 
> drm_kms_helper kunit drm_buddy xt_conntrack nft_chain_nat xt_MASQUERADE 
> nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bridge 
> stp llc overla
> y sunrpc binfmt_misc intel_rapl_msr intel_rapl_common 
> intel_uncore_frequency intel_uncore_frequency_common 
> snd_sof_pci_intel_tgl x86_pkg_temp_thermal snd_sof_pci_intel_cnl 
> intel_powerclamp snd_sof_intel_hda_generic snd_sof_pci 
> snd_sof_xtensa_dsp snd_sof_intel_hda_common coretemp snd_soc_hdac_hda 
> cmdlinepart snd_sof_intel_hda snd_sof spi_nor kvm_intel snd_sof_utils 
> mtd snd_soc_acpi_intel_match snd_soc_acpi kvm snd_intel_d
> spcfg snd_hda_codec snd_hwdep snd_sof_intel_hda_mlink rapl wmi_bmof 
> snd_hda_ext_core intel_cstate snd_hda_core snd_soc_core snd_compress 
> snd_pcm snd_timer nls_iso8859_1 snd i2c_i801
> [ 1109.275604]  spi_intel_pci idma64 soundcore i2c_smbus spi_intel 
> mei_pxp mei_hdcp intel_pmc_core input_leds video intel_vsec joydev 
> pmt_telemetry wmi pmt_class acpi_tad acpi_pad mac_hid mei_me mei 
> sch_fq_codel msr drm efi_pstore dm_multipath nfnetlink ip_tables 
> x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq 
> async_xor async_tx raid1 raid0 hid_generic usbhid hid crct10dif_pclmul 
> crc32_pclmul poly
> val_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 
> sha256_ssse3 sha1_ssse3 r8169 realtek pinctrl_alderlake aesni_intel 
> crypto_simd cryptd [last unloaded: xe]
> [ 1109.275651] CPU: 6 UID: 0 PID: 3377 Comm: xe_module_load Kdump: 
> loaded Tainted: G        W          6.11.0-rc7-xe+ #1
> [ 1109.275654] Tainted: [W]=WARN
> [ 1109.275656] Hardware name: ASUS System Product Name/PRIME Z790-P 
> WIFI, BIOS 0812 02/24/2023
> [ 1109.275657] RIP: 0010:tile_vram_size+0x26d/0x500 [xe]
> [ 1109.275753] Code: 55 b0 41 52 8b 4d a8 51 8b 45 b8 48 c7 c1 a0 dc 1d 
> a1 50 4c 8b 5d a0 41 53 44 8b 4d 9c 4c 8b 45 90 48 8b 55 88 e8 83 19 17 
> e0 <0f> 0b 48 83 c4 40 eb 11 49 8d 7d 20 be 00 81 10 00 e8 ed d0 fc ff
> [ 1109.275755] RSP: 0018:ffffc90001a0b418 EFLAGS: 00010282
> [ 1109.275757] RAX: 0000000000000000 RBX: ffffc90001a0b538 RCX: 
> 0000000000000027
> [ 1109.275759] RDX: ffff88885f321a08 RSI: 0000000000000001 RDI: 
> ffff88885f321a00
> [ 1109.275760] RBP: ffffc90001a0b4e0 R08: 0000000000000000 R09: 
> 0000000000000003
> [ 1109.275761] R10: ffffc90001a0b270 R11: ffff88885ebfffe8 R12: 
> 0000000000000001
> [ 1109.275763] R13: 000000027bc40000 R14: ffffffffa1219868 R15: 
> ffff888161660078
> [ 1109.275764] FS:  00007f02bcb28c40(0000) GS:ffff88885f300000(0000) 
> knlGS:0000000000000000
> [ 1109.275766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1109.275767] CR2: 00005606882c0f00 CR3: 00000001307ee000 CR4: 
> 0000000000750ef0
> [ 1109.275769] PKRU: 55555554
> [ 1109.275770] Call Trace:
> [ 1109.275771]  <TASK>
> [ 1109.275773]  ? show_regs+0x64/0x70
> [ 1109.275778]  ? __warn+0x8e/0x1a0
> [ 1109.275783]  ? tile_vram_size+0x26d/0x500 [xe]
> [ 1109.275867]  ? report_bug+0x171/0x1a0
> [ 1109.275872]  ? handle_bug+0x44/0x90
> [ 1109.275876]  ? exc_invalid_op+0x18/0x70
> [ 1109.275879]  ? asm_exc_invalid_op+0x1b/0x20
> [ 1109.275886]  ? tile_vram_size+0x26d/0x500 [xe]
> [ 1109.275965]  ? tile_vram_size+0x26d/0x500 [xe]
> [ 1109.276046]  xe_vram_probe+0xa1/0x860 [xe]
> 
> 
> Is this the one you're talking about? I don't really remember seeing
> this warning before. So maybe we let a regression in?

Yeah, that's one of the warnings that was reported. Nothing has changed 
on KMD side, so seems like just slightly different programming for that 
register on some BMG platforms.

> 
> Lucas De Marchi
> 
>> as popping other asserts with having a vram size with strange alignment,
>> which is likely caused by misaligned offset here.
>>
>> BSpec: 68023
>> Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.10+
>> ---
>> drivers/gpu/drm/xe/xe_vram.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
>> index 7e765b1499b1..8e65cb4cc477 100644
>> --- a/drivers/gpu/drm/xe/xe_vram.c
>> +++ b/drivers/gpu/drm/xe/xe_vram.c
>> @@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt 
>> *gt, u64 tile_size)
>>
>>         offset = offset_hi << 32; /* HW view bits 39:32 */
>>         offset |= offset_lo << 6; /* HW view bits 31:6 */
>> +        offset = round_up(offset, SZ_128K); /* SW must round up to 
>> nearest 128K */
>>         offset *= num_enabled; /* convert to SW view */
>>
>>         /* We don't expect any holes */
>> -- 
>> 2.46.0
>>

