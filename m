Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB0707317
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 22:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQUd0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEQUdX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 16:33:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741EAA5F8
        for <stable@vger.kernel.org>; Wed, 17 May 2023 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684355571; x=1715891571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZaocSryMN3S2xGk5idvkXFNRKcVpJQOK/wBC4YdljGA=;
  b=c8g97bzEhflgv5hV0KNGspn/J9ImMM8deFmP5pY9Wbvn+R5mcbNDvUiz
   CjiJebHORYhE8LXB/XmdvqcY/TycygDMdz20i7S59ZXE+Lko+6qYpnVdO
   7N6DJePY3vzJ657oXmYxISBdTWU67bnlvJNdrdqkf2f5XdSTSjlvA2bDq
   wMzrQKnUiDtVK04chyTiqbF9WVVFECQRY+FzxkLzi8VoNIYwVUR9Wfapt
   uldnuq97VJYRqxibp+TsHEDNzEwHQBqOTlDlo9xfp1Q63gFUhVB7/7YT/
   GgPT5kbZeBcExgJ5UerR+wFHCuFFQLL+lgIm0DunnH3ub3uBCmCbJJaEI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380069503"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="380069503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 13:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826088760"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="826088760"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by orsmga004.jf.intel.com with SMTP; 17 May 2023 13:32:43 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 17 May 2023 23:32:42 +0300
Date:   Wed, 17 May 2023 23:32:42 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     =?iso-8859-1?Q?=C9ric?= Brunet <eric.brunet@ens.fr>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: Regression on drm/i915, with bisected commit
Message-ID: <ZGU56n66OAe0DqN3@intel.com>
References: <3236901.44csPzL39Z@skaro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3236901.44csPzL39Z@skaro>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 16, 2023 at 03:04:53PM +0200, Éric Brunet wrote:
> Hello all,
> 
> I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with an Adler 
> Lake intel video card.
> 
> After upgrading to kernel 6.2.13 (as packaged by fedora), I started seeing 
> severe video glitches made of random pixels in a vertical band occupying about 
> 20% of my screen, on the right. The glitches would happen both with X.org and 
> wayland.
> 
> I checked that vanilla 6.2.12 does not have the bug and that both vanilla 
> 6.2.13 and vanilla 6.3.2 do have the bug.
> 
> I bisected the problem to commit e2b789bc3dc34edc87ffb85634967d24ed351acb (it 
> is a one-liner reproduced at the end of this message).
> 
> I checked that vanilla 6.3.2 with this commit reverted does not have the bug.
> 
> I am CC-ing every e-mail appearing in this commit , I hope this is ok, and I 
> apologize if it is not.

Please file a bug at https://gitlab.freedesktop.org/drm/intel/issues/new
boot with "log_buf_len=4M drm.debug=0xe" passed to kernel cmdline, and
attach the resulting dmesg to the bug.

> 
> I have filled a fedora bug report about this, see https://bugzilla.redhat.com/
> show_bug.cgi?id=2203549 . You will find there a small video (made with fedora 
> kernel 2.6.14) demonstrating the issue.
> 
> Some more details:
> 
> % sudo lspci -vk -s 00:02.0
> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-UP3 GT2 [Iris 
> Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
>         DeviceName: Onboard IGD
>         Subsystem: Hewlett-Packard Company Device 896d
>         Flags: bus master, fast devsel, latency 0, IRQ 143
>         Memory at 603c000000 (64-bit, non-prefetchable) [size=16M]
>         Memory at 4000000000 (64-bit, prefetchable) [size=256M]
>         I/O ports at 3000 [size=64]
>         Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
>         Capabilities: [40] Vendor Specific Information: Len=0c <?>
>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [100] Process Address Space ID (PASID)
>         Capabilities: [200] Address Translation Service (ATS)
>         Capabilities: [300] Page Request Interface (PRI)
>         Capabilities: [320] Single Root I/O Virtualization (SR-IOV)
>         Kernel driver in use: i915
>         Kernel modules: i915
> 
> Relevant kernel boot messages: (appart from timestamps, these lines are 
> identical for 6.2.12 and 6.2.14):
> 
> [    2.790043] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    2.790089] i915 0000:00:02.0: [drm] Using Transparent Hugepages
> [    2.790497] i915 0000:00:02.0: vgaarb: changed VGA decodes: 
> olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    2.793812] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/
> adlp_dmc_ver2_16.bin (v2.16)
> [    2.825058] i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_70.bin 
> version 70.5.1
> [    2.825061] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc.bin version 
> 7.9.3
> [    2.842906] i915 0000:00:02.0: [drm] HuC authenticated
> [    2.843778] i915 0000:00:02.0: [drm] GuC submission enabled
> [    2.843779] i915 0000:00:02.0: [drm] GuC SLPC enabled
> [    2.844200] i915 0000:00:02.0: [drm] GuC RC: enabled
> [    2.845010] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected 
> content support initialized
> [    3.964766] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 
> 1
> [    3.968403] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  
> post: no)
> [    3.968981] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/
> PNP0A08:00/LNXVIDEO:00/input/input18
> [    3.977892] fbcon: i915drmfb (fb0) is primary device
> [    3.977899] fbcon: Deferring console take-over
> [    3.977904] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [    4.026120] i915 0000:00:02.0: [drm] Selective fetch area calculation 
> failed in pipe A
> 
> Is there anything else I should provide? I am willing to run some tests, of 
> course.
> 
> Thanks for your help,
> 
> Éric Brunet
> 
> =================================================
> 
> commit e2b789bc3dc34edc87ffb85634967d24ed351acb (HEAD)
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Date:   Wed Mar 29 20:24:33 2023 +0300
> 
>     drm/i915: Fix fast wake AUX sync len
>     
>     commit e1c71f8f918047ce822dc19b42ab1261ed259fd1 upstream.
>     
>     Fast wake should use 8 SYNC pulses for the preamble
>     and 10-16 SYNC pulses for the precharge. Reduce our
>     fast wake SYNC count to match the maximum value.
>     We also use the maximum precharge length for normal
>     AUX transactions.
>     
>     Cc: stable@vger.kernel.org
>     Cc: Jouni Högander <jouni.hogander@intel.com>
>     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/
> 20230329172434.18744-1-ville.syrjala@linux.intel.com
>     Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
>     (cherry picked from commit 605f7c73133341d4b762cbd9a22174cc22d4c38b)
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/
> i915/display/intel_dp_aux.c
> index 664bebdecea7..d5fed2eb66d2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
> @@ -166,7 +166,7 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
>               DP_AUX_CH_CTL_TIME_OUT_MAX |
>               DP_AUX_CH_CTL_RECEIVE_ERROR |
>               (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
> -             DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(32) |
> +             DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(24) |
>               DP_AUX_CH_CTL_SYNC_PULSE_SKL(32);
>  
>         if (intel_tc_port_in_tbt_alt_mode(dig_port))
> 

-- 
Ville Syrjälä
Intel
