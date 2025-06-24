Return-Path: <stable+bounces-158296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61597AE5B3D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71D07B125A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE877233733;
	Tue, 24 Jun 2025 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjNwCkZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA94225761;
	Tue, 24 Jun 2025 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738382; cv=none; b=LR949ztv/Cd4HChFRrArGhM5Kkr3RJkxAlbPiT27XDiS+WbV1316tT0hNYdQRTN2iRnUYbOZlMZJO7/+DC8T0cCHQM3PmCS+08Ozv+y5od3VEuljLmkdvDd5rFxZxXrx6QRBNvko4nj0oW+fzTic69iohGmr9OrbGlCyGnj2B3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738382; c=relaxed/simple;
	bh=Sa1RNcVCjeFw1niI6sFM6ShZPoeKSMttqK24sFhyvQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbVHzGcguJgBtYlvwvBET/1WlJDHs59HLTCJ79PwqGS2wXLJ8dfqCDRsUBQVQSy+UVc/5oB0Sow+Bwc4F1QNMaGjXl7H5ceFKPQ8/cGIiYGMAI2PI+5clkhFfyliFgjWKYj8N12wYULaUK5S9YGdH4jzbiTPnahtOTx+++vjZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjNwCkZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB30C4CEE3;
	Tue, 24 Jun 2025 04:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738382;
	bh=Sa1RNcVCjeFw1niI6sFM6ShZPoeKSMttqK24sFhyvQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjNwCkZOrz4Nnmc3374JXFzSo48wvhXWxr+0/Gj5VL74wm6+XqAb4PA6q6Z3b42o1
	 Q927oF666F9iz+AK2DvVLg9ECeyG2/L+Mvs8tKG1GXqm3lgPEHVPSNvSn5BIyaH0rF
	 I3WfO6bnjJ90KcsyvkscKvzVJaDKkgHiTdHwj5gaMAHDdk2+Up8wW+PEjq4AMrXEaq
	 Dc/8Ck2DUYxSJ+yOe/11artrcREe8cRXEW6aHFAInrFxJ8UXOujQVjsVGHUHMUl+ZJ
	 40SXPfKCsCocrCUam+ePhzU9RAfqgeVbuLLtKHOeabpAAiGfLPg79wGBIVAP54spI/
	 el4NRMzBB0kbA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz
Subject: [PATCH AUTOSEL 5.15 02/11] ALSA: sb: Don't allow changing the DMA mode during operations
Date: Tue, 24 Jun 2025 00:12:50 -0400
Message-Id: <20250624041259.84940-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041259.84940-1-sashal@kernel.org>
References: <20250624041259.84940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ed29e073ba93f2d52832804cabdd831d5d357d33 ]

When a PCM stream is already running, one shouldn't change the DMA
mode via kcontrol, which may screw up the hardware.  Return -EBUSY
instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218185
Link: https://patch.msgid.link/20250610064322.26787-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Key Reasons for Backporting:

1. **Critical Bug Fix for Race Condition**: The commit fixes a race
   condition where changing DMA mode via kcontrol while PCM streams are
   running can corrupt hardware state. Looking at the code:
   - The `chip->mode` field tracks active playback/capture operations
     using `SB_MODE_PLAYBACK` and `SB_MODE_CAPTURE` flags
   - The DMA mode control (`force_mode16`) affects how DMA transfers are
     configured
   - Changing this while streams are active can cause hardware
     inconsistencies

2. **Clear User-Visible Bug**: The commit references Bugzilla #218185,
   indicating this is a real user-reported issue that affects system
   stability and audio functionality.

3. **Minimal and Contained Fix**: The change is extremely small and
   focused:
  ```c
  +       if (chip->mode & (SB_MODE_PLAYBACK | SB_MODE_CAPTURE))
  +               return -EBUSY;
  ```
  It simply adds a check to prevent mode changes during active
  operations, returning -EBUSY to userspace.

4. **No Architectural Changes**: This is a straightforward defensive
   check that doesn't alter any core functionality or introduce new
   features. It only prevents an invalid operation.

5. **Low Risk of Regression**: The fix:
   - Only affects the SB16 sound driver
   - Only changes behavior when someone tries to modify DMA mode during
     active streaming
   - Returns a standard error code (-EBUSY) that applications should
     already handle
   - Doesn't affect normal audio operations

6. **Follows Stable Kernel Rules**: This perfectly matches stable kernel
   criteria:
   - Fixes a real bug that affects users
   - Obviously correct with no subtleties
   - Small change (2 lines of actual code)
   - Already tested in mainline
   - No new features added

## Technical Analysis:

From examining the code flow:
- During `snd_sb16_playback_open()` and `snd_sb16_capture_open()`, the
  driver sets `chip->mode` flags
- These flags remain set until `snd_sb16_playback_close()` and
  `snd_sb16_capture_close()` clear them
- The `force_mode16` setting affects DMA channel selection throughout
  the driver
- Without this fix, userspace can change `force_mode16` while DMA
  operations are active, potentially causing:
  - DMA channel mismatches
  - Audio corruption
  - System instability

This is similar to the first example commit that was backported, which
also prevented operations during inappropriate states (DMA
synchronization during PAUSE state).

 sound/isa/sb/sb16_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index a9b87e159b2d1..5efbd0a41312b 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -703,6 +703,9 @@ static int snd_sb16_dma_control_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	unsigned char nval, oval;
 	int change;
 	
+	if (chip->mode & (SB_MODE_PLAYBACK | SB_MODE_CAPTURE))
+		return -EBUSY;
+
 	nval = ucontrol->value.enumerated.item[0];
 	if (nval > 2)
 		return -EINVAL;
-- 
2.39.5


