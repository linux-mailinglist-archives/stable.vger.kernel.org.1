Return-Path: <stable+bounces-174719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C54B36548
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50114564F49
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153920CCCA;
	Tue, 26 Aug 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zmV8MJI2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE481ADFFE;
	Tue, 26 Aug 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215136; cv=none; b=h0Jjwl3/xNVm4RHvheAkDqBw2+177dDkiSpCih7IyDUVXVqbBD4php7UFNZDzs2nSsmsPMGSZs+ep+MCZ0Yf5VFja6eVVGt+hMl0sU2CXcU+FsN/2+U0ImC37uF/4vRdLbwDiK5GlG2Cahq2nwj4sp9ySGoEY5mosawMmfcnfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215136; c=relaxed/simple;
	bh=zdWAc5yeIqOcMwiu1d3hcfaK+HJbKEzorYUUJC4fUXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwaijs9MaSe5oF67rqB7kzBSh75e4ddY2hnfcsnCY5pSFoGKrqjKefW7uSVUzLFt+z7LQ/KZftSnyQIDlvaZ1/XagZ0s+Xicq7PPOceRS1+yO7cH7BJLwD5RiSjkTqACrxFOQqDca0ZkAjYCSYhaszfy1eNaC7fPnjKChT1oB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zmV8MJI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F83C4CEF1;
	Tue, 26 Aug 2025 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215136;
	bh=zdWAc5yeIqOcMwiu1d3hcfaK+HJbKEzorYUUJC4fUXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zmV8MJI2EuuJcIsPhBIkmWqGAdm4cV4cJi4bF5sxEMpCtkiendeD3gIqtFAd7iJYe
	 e1yEWm0PY8XfFphp3nDuRm0OV3eexNStN4JoUx0C0u0G3aKfIfnjVL4q20TX5a9lJb
	 brnSXbUHYVJEP2M+TJ1/gXDGhFvkRlDt7gJsAb8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6.1 401/482] drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
Date: Tue, 26 Aug 2025 13:10:54 +0200
Message-ID: <20250826110940.733379107@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

commit 10507478468f165ea681605d133991ed05cdff62 upstream.

For later VBIOS versions, the fractional feedback divider is
calculated as the remainder of dividing the feedback divider by
a factor, which is set to 1000000. For reference, see:
- calculate_fb_and_fractional_fb_divider
- calc_pll_max_vco_construct

However, in case of old VBIOS versions that have
set_pixel_clock_v3, they only have 1 byte available for the
fractional feedback divider, and it's expected to be set to the
remainder from dividing the feedback divider by 10.
For reference see the legacy display code:
- amdgpu_pll_compute
- amdgpu_atombios_crtc_program_pll

This commit fixes set_pixel_clock_v3 by dividing the fractional
feedback divider passed to the function by 100000.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 027e7acc7e17802ebf28e1edb88a404836ad50d6)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3
 	allocation.sPCLKInput.usFbDiv =
 			cpu_to_le16((uint16_t)bp_params->feedback_divider);
 	allocation.sPCLKInput.ucFracFbDiv =
-			(uint8_t)bp_params->fractional_feedback_divider;
+			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
 	allocation.sPCLKInput.ucPostDiv =
 			(uint8_t)bp_params->pixel_clock_post_divider;
 



