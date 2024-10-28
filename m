Return-Path: <stable+bounces-88935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929749B2821
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3135CB20FF5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BA18E368;
	Mon, 28 Oct 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6TwftR5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63902824A3;
	Mon, 28 Oct 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098455; cv=none; b=HzfuUjsvTFB/1Hxw+sgeQGp+nvL4v6ZSacJx9hpc1CYUljAfYa2o/Rfcm5rn+C7lynDgCD7BHd3T0F5T9X+w6QU4wsZeV4ozWuCh6vLvCgRy//JI3DiGF4biy7pgcGleKk4bEkS4D9+uMvMwFPe0RZLbvCwfK+VxvswGCK5BO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098455; c=relaxed/simple;
	bh=mmvsrBpc3QOo9mRCFBsqhn95Kx6CMxjEoDnin5iLriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egNeh0dsZAE7vhVADulmdMlUw5sXtyph/XVcrPYrdkZaQ/oHUsb5kCwKFQDFPjvZoffzujzNaEG5rBS6lHc2dYpEH5j1byUlWMbmlsDutD4m+GvNY7tDvsVTXXk2dYa4/ZOG/SgPMcTeDYYTlVmpAw7sW/YubNcUTlUnQ2pSfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6TwftR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0265DC4CEC3;
	Mon, 28 Oct 2024 06:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098455;
	bh=mmvsrBpc3QOo9mRCFBsqhn95Kx6CMxjEoDnin5iLriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6TwftR5OV42YkQ93UMoI1+GpX/jxIR/MuB/kZA7yk/p+8O+l3D4oBLT6FSDOV6fe
	 xkydpNgGEq/PuqW+H6Mg0NVjTz2KlUR3ZckiYGnZPxF8pskSSujbYsZwx7qhVk9qHa
	 efaMK+JGgewkMJZtMrGmjJq5TBLSzCoBjw97HQW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Rossi <Marc.Rossi@amd.com>,
	Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.11 234/261] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Date: Mon, 28 Oct 2024 07:26:16 +0100
Message-ID: <20241028062317.983568665@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit ba1959f71117b27f3099ee789e0815360b4081dd upstream.

Stuart Hayhurst has found that both at bootup and fullscreen VA-API video
is leading to black screens for around 1 second and kernel WARNING [1] traces
when calling dmub_psr_enable() with Parade 08-01 TCON.

These symptoms all go away with PSR-SU disabled for this TCON, so disable
it for now while DMUB traces [2] from the failure can be analyzed and the failure
state properly root caused.

Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/uploads/a832dd515b571ee171b3e3b566e99a13/dmesg.log [1]
Link: https://gitlab.freedesktop.org/drm/amd/uploads/8f13ff3b00963c833e23e68aa8116959/output.log [2]
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2645
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Link: https://lore.kernel.org/r/20240205211233.2601-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit afb634a6823d8d9db23c5fb04f79c5549349628b)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -841,6 +841,8 @@ bool is_psr_su_specific_panel(struct dc_
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}



