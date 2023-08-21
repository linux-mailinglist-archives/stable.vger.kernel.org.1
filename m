Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B486782F06
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjHUREu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbjHUREt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 13:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E557ED
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04CAA63FB4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 17:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B0FC433C7;
        Mon, 21 Aug 2023 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692637486;
        bh=Z5DEQJqLIh301TKO5reDwNz4yhOa4GaPn9FxY4W61ZA=;
        h=Subject:To:Cc:From:Date:From;
        b=oYyv+RA1M/LvEv3RX8BnuGMiIPmBtHIaeIKak8KqCskEd+WTeUHEI6ZZ2Ll/f4x5c
         fskEVIoczV3ln0Vx22Yy1L8P/1c+h9OumyNyzDlvnmPc2tG59VcU+zGXen1H/mK1T3
         mccKyje5Rv+6wwN1unlnw4r7/OOgq0E6b3BwQvVM=
Subject: FAILED: patch "[PATCH] drm/i915: fix display probe for IVB Q and IVB D GT2 server" failed to apply to 6.4-stable tree
To:     jani.nikula@intel.com, andrzej.hajda@intel.com,
        luciano.coelho@intel.com, matthew.d.roper@intel.com,
        rodrigo.vivi@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 19:04:43 +0200
Message-ID: <2023082143-rummage-chasing-3ff3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 423ffe62c06ae241ad460f4629dddb9dcf55e060
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082143-rummage-chasing-3ff3@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 423ffe62c06ae241ad460f4629dddb9dcf55e060 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 4 Aug 2023 11:45:59 +0300
Subject: [PATCH] drm/i915: fix display probe for IVB Q and IVB D GT2 server

The current display probe is unable to differentiate between IVB Q and
IVB D GT2 server, as they both have the same device id, but different
subvendor and subdevice. This leads to the latter being misidentified as
the former, and should just end up not having a display. However, the no
display case returns a NULL as the display device info, and promptly
oopses.

As the IVB Q case is rare, and we're anyway moving towards GMD ID,
handle the identification requiring subvendor and subdevice as a special
case first, instead of unnecessarily growing the intel_display_ids[]
array with subvendor and subdevice.

[    5.425298] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    5.426059] #PF: supervisor read access in kernel mode
[    5.426810] #PF: error_code(0x0000) - not-present page
[    5.427570] PGD 0 P4D 0
[    5.428285] Oops: 0000 [#1] PREEMPT SMP PTI
[    5.429035] CPU: 0 PID: 137 Comm: (udev-worker) Not tainted 6.4.0-1-amd64 #1  Debian 6.4.4-1
[    5.429759] Hardware name: HP HP Z220 SFF Workstation/HP Z220 SFF Workstation, BIOS 4.19-218-gb184e6e0a1 02/02/2023
[    5.430485] RIP: 0010:intel_device_info_driver_create+0xf1/0x120 [i915]
[    5.431338] Code: 48 8b 97 80 1b 00 00 89 8f c0 1b 00 00 48 89 b7 b0 1b 00 00 48 89 97 b8 1b 00 00 0f b7 fd e8 76 e8 14 00 48 89 83 50 1b 00 00 <48> 8b 08 48 89 8b c4 1b 00 00 48 8b 48 08 48 89 8b cc 1b 00 00 8b
[    5.432920] RSP: 0018:ffffb8254044fb98 EFLAGS: 00010206
[    5.433707] RAX: 0000000000000000 RBX: ffff923076e80000 RCX: 0000000000000000
[    5.434494] RDX: 0000000000000260 RSI: 0000000100001000 RDI: 000000000000016a
[    5.435277] RBP: 000000000000016a R08: ffffb8254044fb00 R09: 0000000000000000
[    5.436055] R10: ffff922d02761de8 R11: 00657361656c6572 R12: ffffffffc0e5d140
[    5.436867] R13: ffff922d00b720d0 R14: 0000000076e80000 R15: ffff923078c0cae8
[    5.437646] FS:  00007febd19a18c0(0000) GS:ffff92307c000000(0000) knlGS:0000000000000000
[    5.438434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.439218] CR2: 0000000000000000 CR3: 000000010256e002 CR4: 00000000001706f0
[    5.440009] Call Trace:
[    5.440824]  <TASK>
[    5.441611]  ? __die+0x23/0x70
[    5.442394]  ? page_fault_oops+0x17d/0x4c0
[    5.443173]  ? exc_page_fault+0x7f/0x180
[    5.443949]  ? asm_exc_page_fault+0x26/0x30
[    5.444756]  ? intel_device_info_driver_create+0xf1/0x120 [i915]
[    5.445652]  ? intel_device_info_driver_create+0xea/0x120 [i915]
[    5.446545]  i915_driver_probe+0x7f/0xb60 [i915]
[    5.447431]  ? drm_privacy_screen_get+0x15c/0x1a0 [drm]
[    5.448240]  local_pci_probe+0x45/0xa0
[    5.449013]  pci_device_probe+0xc7/0x240
[    5.449748]  really_probe+0x19e/0x3e0
[    5.450464]  ? __pfx___driver_attach+0x10/0x10
[    5.451172]  __driver_probe_device+0x78/0x160
[    5.451870]  driver_probe_device+0x1f/0x90
[    5.452601]  __driver_attach+0xd2/0x1c0
[    5.453293]  bus_for_each_dev+0x88/0xd0
[    5.453989]  bus_add_driver+0x116/0x220
[    5.454672]  driver_register+0x59/0x100
[    5.455336]  i915_init+0x25/0xc0 [i915]
[    5.456104]  ? __pfx_i915_init+0x10/0x10 [i915]
[    5.456882]  do_one_initcall+0x5d/0x240
[    5.457511]  do_init_module+0x60/0x250
[    5.458126]  __do_sys_finit_module+0xac/0x120
[    5.458721]  do_syscall_64+0x60/0xc0
[    5.459314]  ? syscall_exit_to_user_mode+0x1b/0x40
[    5.459897]  ? do_syscall_64+0x6c/0xc0
[    5.460510]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    5.461082] RIP: 0033:0x7febd20b0eb9
[    5.461648] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2f 1f 0d 00 f7 d8 64 89 01 48
[    5.462905] RSP: 002b:00007fffabb1ba78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    5.463554] RAX: ffffffffffffffda RBX: 0000561e6304f410 RCX: 00007febd20b0eb9
[    5.464201] RDX: 0000000000000000 RSI: 00007febd2244f0d RDI: 0000000000000015
[    5.464869] RBP: 00007febd2244f0d R08: 0000000000000000 R09: 000000000000000a
[    5.465512] R10: 0000000000000015 R11: 0000000000000246 R12: 0000000000020000
[    5.466124] R13: 0000000000000000 R14: 0000561e63032b60 R15: 000000000000000a
[    5.466700]  </TASK>
[    5.467271] Modules linked in: i915(+) drm_buddy video crc32_pclmul sr_mod hid_generic wmi crc32c_intel i2c_algo_bit sd_mod cdrom drm_display_helper cec usbhid rc_core ghash_clmulni_intel hid sha512_ssse3 ttm sha512_generic xhci_pci ehci_pci xhci_hcd ehci_hcd nvme ahci drm_kms_helper nvme_core libahci t10_pi libata psmouse aesni_intel scsi_mod crypto_simd i2c_i801 scsi_common crc64_rocksoft_generic cryptd i2c_smbus drm lpc_ich crc64_rocksoft crc_t10dif e1000e usbcore crct10dif_generic usb_common crct10dif_pclmul crc64 crct10dif_common button
[    5.469750] CR2: 0000000000000000
[    5.470364] ---[ end trace 0000000000000000 ]---
[    5.470971] RIP: 0010:intel_device_info_driver_create+0xf1/0x120 [i915]
[    5.471699] Code: 48 8b 97 80 1b 00 00 89 8f c0 1b 00 00 48 89 b7 b0 1b 00 00 48 89 97 b8 1b 00 00 0f b7 fd e8 76 e8 14 00 48 89 83 50 1b 00 00 <48> 8b 08 48 89 8b c4 1b 00 00 48 8b 48 08 48 89 8b cc 1b 00 00 8b
[    5.473034] RSP: 0018:ffffb8254044fb98 EFLAGS: 00010206
[    5.473698] RAX: 0000000000000000 RBX: ffff923076e80000 RCX: 0000000000000000
[    5.474371] RDX: 0000000000000260 RSI: 0000000100001000 RDI: 000000000000016a
[    5.475045] RBP: 000000000000016a R08: ffffb8254044fb00 R09: 0000000000000000
[    5.475725] R10: ffff922d02761de8 R11: 00657361656c6572 R12: ffffffffc0e5d140
[    5.476405] R13: ffff922d00b720d0 R14: 0000000076e80000 R15: ffff923078c0cae8
[    5.477124] FS:  00007febd19a18c0(0000) GS:ffff92307c000000(0000) knlGS:0000000000000000
[    5.477811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.478499] CR2: 0000000000000000 CR3: 000000010256e002 CR4: 00000000001706f0

Fixes: 69d439818fe5 ("drm/i915/display: Make display responsible for probing its own IP")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8991
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804084600.1005818-1-jani.nikula@intel.com
(cherry picked from commit 1435188307d128671f677eb908e165666dd83652)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index f0ee9bcf661d..b0c6a2a86f2f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -662,10 +662,24 @@ static const struct intel_display_device_info xe_lpdp_display = {
 		BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
 };
 
+/*
+ * Separate detection for no display cases to keep the display id array simple.
+ *
+ * IVB Q requires subvendor and subdevice matching to differentiate from IVB D
+ * GT2 server.
+ */
+static bool has_no_display(struct pci_dev *pdev)
+{
+	static const struct pci_device_id ids[] = {
+		INTEL_IVB_Q_IDS(0),
+		{}
+	};
+
+	return pci_match_id(ids, pdev);
+}
+
 #undef INTEL_VGA_DEVICE
-#undef INTEL_QUANTA_VGA_DEVICE
 #define INTEL_VGA_DEVICE(id, info) { id, info }
-#define INTEL_QUANTA_VGA_DEVICE(info) { 0x16a, info }
 
 static const struct {
 	u32 devid;
@@ -690,7 +704,6 @@ static const struct {
 	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
 	INTEL_SNB_D_IDS(&snb_display),
 	INTEL_SNB_M_IDS(&snb_display),
-	INTEL_IVB_Q_IDS(NULL),		/* must be first IVB in list */
 	INTEL_IVB_M_IDS(&ivb_display),
 	INTEL_IVB_D_IDS(&ivb_display),
 	INTEL_HSW_IDS(&hsw_display),
@@ -775,6 +788,11 @@ intel_display_device_probe(struct drm_i915_private *i915, bool has_gmdid,
 	if (has_gmdid)
 		return probe_gmdid_display(i915, gmdid_ver, gmdid_rel, gmdid_step);
 
+	if (has_no_display(pdev)) {
+		drm_dbg_kms(&i915->drm, "Device doesn't have display\n");
+		return &no_display;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(intel_display_ids); i++) {
 		if (intel_display_ids[i].devid == pdev->device)
 			return intel_display_ids[i].info;

