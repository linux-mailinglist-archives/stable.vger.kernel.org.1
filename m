Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB92705034
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjEPOIB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Tue, 16 May 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEPOIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 10:08:00 -0400
X-Greylist: delayed 3750 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 07:07:57 PDT
Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84271FFB
        for <stable@vger.kernel.org>; Tue, 16 May 2023 07:07:57 -0700 (PDT)
X-ENS-nef-client:   129.199.127.85 ( name = mail.phys.ens.fr )
Received: from mail.phys.ens.fr (mail.phys.ens.fr [129.199.127.85])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 34GD4wZS020651
          ; Tue, 16 May 2023 15:04:59 +0200
Received: from skaro.localnet (agn47-h01-176-151-100-134.dsl.sta.abo.bbox.fr [176.151.100.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.phys.ens.fr (Postfix) with ESMTPSA id C2CB01A108E;
        Tue, 16 May 2023 15:04:53 +0200 (CEST)
From:   =?ISO-8859-1?Q?=C9ric?= Brunet <eric.brunet@ens.fr>
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, ville.syrjala@linux.intel.com,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
Subject: Regression on drm/i915, with bisected commit
Date:   Tue, 16 May 2023 15:04:53 +0200
Message-ID: <3236901.44csPzL39Z@skaro>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Rspamd-Queue-Id: C2CB01A108E
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.56 / 150.00];
         ARC_NA(0.00)[];
         R_SPF_NEUTRAL(0.00)[?all:c];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         HFILTER_HOSTNAME_4(2.50)[agn47-h01-176-151-100-134.dsl.sta.abo.bbox.fr];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         HFILTER_HELO_IP_A(1.00)[skaro.localnet];
         RCPT_COUNT_FIVE(0.00)[6];
         DMARC_NA(0.00)[ens.fr];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[skaro.localnet];
         RBL_BLOCKLISTDE_FAIL(0.00)[134.100.151.176.bl.blocklist.de:query timed out];
         NEURAL_HAM(-0.00)[-0.999,0];
         IP_SCORE(-1.76)[ip: (-0.16), ipnet: 176.128.0.0/10(-4.87), asn: 5410(-3.66), country: FR(-0.09)];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:5410, ipnet:176.128.0.0/10, country:FR];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: mail
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Tue, 16 May 2023 15:04:59 +0200 (CEST)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello all,

I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with an Adler 
Lake intel video card.

After upgrading to kernel 6.2.13 (as packaged by fedora), I started seeing 
severe video glitches made of random pixels in a vertical band occupying about 
20% of my screen, on the right. The glitches would happen both with X.org and 
wayland.

I checked that vanilla 6.2.12 does not have the bug and that both vanilla 
6.2.13 and vanilla 6.3.2 do have the bug.

I bisected the problem to commit e2b789bc3dc34edc87ffb85634967d24ed351acb (it 
is a one-liner reproduced at the end of this message).

I checked that vanilla 6.3.2 with this commit reverted does not have the bug.

I am CC-ing every e-mail appearing in this commit , I hope this is ok, and I 
apologize if it is not.

I have filled a fedora bug report about this, see https://bugzilla.redhat.com/
show_bug.cgi?id=2203549 . You will find there a small video (made with fedora 
kernel 2.6.14) demonstrating the issue.

Some more details:

% sudo lspci -vk -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation Alder Lake-UP3 GT2 [Iris 
Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
        DeviceName: Onboard IGD
        Subsystem: Hewlett-Packard Company Device 896d
        Flags: bus master, fast devsel, latency 0, IRQ 143
        Memory at 603c000000 (64-bit, non-prefetchable) [size=16M]
        Memory at 4000000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 3000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: [40] Vendor Specific Information: Len=0c <?>
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit-
        Capabilities: [d0] Power Management version 2
        Capabilities: [100] Process Address Space ID (PASID)
        Capabilities: [200] Address Translation Service (ATS)
        Capabilities: [300] Page Request Interface (PRI)
        Capabilities: [320] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: i915
        Kernel modules: i915

Relevant kernel boot messages: (appart from timestamps, these lines are 
identical for 6.2.12 and 6.2.14):

[    2.790043] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.790089] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    2.790497] i915 0000:00:02.0: vgaarb: changed VGA decodes: 
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.793812] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/
adlp_dmc_ver2_16.bin (v2.16)
[    2.825058] i915 0000:00:02.0: [drm] GuC firmware i915/adlp_guc_70.bin 
version 70.5.1
[    2.825061] i915 0000:00:02.0: [drm] HuC firmware i915/tgl_huc.bin version 
7.9.3
[    2.842906] i915 0000:00:02.0: [drm] HuC authenticated
[    2.843778] i915 0000:00:02.0: [drm] GuC submission enabled
[    2.843779] i915 0000:00:02.0: [drm] GuC SLPC enabled
[    2.844200] i915 0000:00:02.0: [drm] GuC RC: enabled
[    2.845010] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected 
content support initialized
[    3.964766] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 
1
[    3.968403] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  
post: no)
[    3.968981] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/
PNP0A08:00/LNXVIDEO:00/input/input18
[    3.977892] fbcon: i915drmfb (fb0) is primary device
[    3.977899] fbcon: Deferring console take-over
[    3.977904] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    4.026120] i915 0000:00:02.0: [drm] Selective fetch area calculation 
failed in pipe A

Is there anything else I should provide? I am willing to run some tests, of 
course.

Thanks for your help,

Éric Brunet

=================================================

commit e2b789bc3dc34edc87ffb85634967d24ed351acb (HEAD)
Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
Date:   Wed Mar 29 20:24:33 2023 +0300

    drm/i915: Fix fast wake AUX sync len
    
    commit e1c71f8f918047ce822dc19b42ab1261ed259fd1 upstream.
    
    Fast wake should use 8 SYNC pulses for the preamble
    and 10-16 SYNC pulses for the precharge. Reduce our
    fast wake SYNC count to match the maximum value.
    We also use the maximum precharge length for normal
    AUX transactions.
    
    Cc: stable@vger.kernel.org
    Cc: Jouni Högander <jouni.hogander@intel.com>
    Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/
20230329172434.18744-1-ville.syrjala@linux.intel.com
    Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
    (cherry picked from commit 605f7c73133341d4b762cbd9a22174cc22d4c38b)
    Signed-off-by: Jani Nikula <jani.nikula@intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/
i915/display/intel_dp_aux.c
index 664bebdecea7..d5fed2eb66d2 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -166,7 +166,7 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
              DP_AUX_CH_CTL_TIME_OUT_MAX |
              DP_AUX_CH_CTL_RECEIVE_ERROR |
              (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-             DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(32) |
+             DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(24) |
              DP_AUX_CH_CTL_SYNC_PULSE_SKL(32);
 
        if (intel_tc_port_in_tbt_alt_mode(dig_port))


