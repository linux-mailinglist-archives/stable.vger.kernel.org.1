Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9772C223
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbjFLLDH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbjFLLCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F692618E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9037624B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF99CC433D2;
        Mon, 12 Jun 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567011;
        bh=AvOYZyKuKyVMk19DnAkmmyrG01E4xSeb1CM1NCyElRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+zm1LcO3Z9YEIEpulRVdIlQx9dZR3P6CgAKI1UZKuxxEHX9KkZ6q79yKLB//nE9l
         JSFX6BsFjh2ZWQVbmMEcqGByHbmSTQBV42kG0K6rsXED3LONGhbKafBVMKqD4RnqWa
         oLUZ4iW4WYNyfg9qM6RzwlkHTJA/NslZX8gRN+do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafael=20=C3=81vila=20de=20Esp=C3=ADndola?= 
        <rafael@espindo.la>, Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.3 088/160] drm/amd: Disallow s0ix without BIOS support again
Date:   Mon, 12 Jun 2023 12:27:00 +0200
Message-ID: <20230612101719.043775452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 30c3d3b70aba2464ee8c91025e91428f92464077 upstream.

commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showed
improvements to power consumption over suspend when s0ix wasn't enabled in
BIOS and the system didn't support S3.

This patch however was misguided because the reason the system didn't
support S3 was because SMT was disabled in OEM BIOS setup.
This prevented the BIOS from allowing S3.

Also allowing GPUs to use the s2idle path actually causes problems if
they're invoked on systems that may not support s2idle in the platform
firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fails
for any reason, which could lead to unexpected flows.

The original commit also fixed a problem during resume from suspend to idle
without hardware support, but this is no longer necessary with commit
ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")

Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
to make it match the expected behavior again.

Cc: Rafael Ávila de Espíndola <rafael@espindo.la>
Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L1060
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct a
 	 * S0ix even though the system is suspending to idle, so return false
 	 * in that case.
 	 */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
+		return false;
+	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
 	dev_warn_once(adev->dev,
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
-#endif /* CONFIG_AMD_PMC */
+	return false;
+#else
 	return true;
+#endif /* CONFIG_AMD_PMC */
 }
 
 #endif /* CONFIG_SUSPEND */


