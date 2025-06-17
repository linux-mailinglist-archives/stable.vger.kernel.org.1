Return-Path: <stable+bounces-152778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA2ADCB00
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6FC3A7A3C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE002DE204;
	Tue, 17 Jun 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLLf0yK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E72DE1E0;
	Tue, 17 Jun 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162917; cv=none; b=a1IwWRqP2ywjYr57cAEIBfVjD8up7YoFHm6T0sH8V8lspSTnSIe2z+4m7MMBrIX2/WLT79TAX0FaQlK4fnJkxSKBxwwD1le4Xr2WmOzFWAA+l70d20Dt5znSPxEW2f3DtkAPTZLD//OD5JqipagsqlFz2qEQ0585nM1mZLXCkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162917; c=relaxed/simple;
	bh=nF4IR7dXogTo7/aRIXSAP4Oixm0np9+lK3Kk4a+lsZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxtUmk6OJPaegseoUkv1bvCidk88nVi8/yStCFP3LVQiYSRlpqtsN855agej/kKofW4LxHJ+HLNR534+6QRTZPdsT1E56W8Rvo2V1Hv+2QNd1EA8OO1ljLG1KClcydh37H/5iSmrFVAGc4vCSftB6UeUk/o+6VMNG9Apu7EJ5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLLf0yK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2BBC4CEEE;
	Tue, 17 Jun 2025 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750162916;
	bh=nF4IR7dXogTo7/aRIXSAP4Oixm0np9+lK3Kk4a+lsZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLLf0yK0p9VRbXjwqR4hObtwC3sLfUcmGF3/VKsBCl4r3xybvHD565jJQjXUdnNos
	 7/JRDI9r1QMTb1eJ9hGuuiDHExxA4+aM/UGkYTGZPSaHgxfdiJkJWPUutB+oOVb6si
	 rnDq9Xufrfe+gMvc/Je2d2jPhUrOotXBFe4J3K6kEj0BQybV8vQTpS2rVNoVf9HnNE
	 xUvK1Swd71ZG6sEi5zWz9t0ek2S00sLuoK54vQNwRm2i7p59q0b+8Y7g/52Hn4c6Yw
	 NDnTNtZu/X2pIb+xzX2rkR1k9lCz7FW3+rNv26QcI+dX17cNecrDXaKyC40S+YVmuH
	 FlOSZeig5F/iQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.15 04/15] ALSA: hda: Ignore unsol events for cards being shut down
Date: Tue, 17 Jun 2025 08:21:34 -0400
Message-Id: <20250617122147.1968355-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122147.1968355-1-sashal@kernel.org>
References: <20250617122147.1968355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.2
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 3f100f524e75586537e337b34d18c8d604b398e7 ]

For the classic snd_hda_intel driver, codec->card and bus->card point to
the exact same thing. When snd_card_diconnect() fires, bus->shutdown is
set thanks to azx_dev_disconnect(). card->shutdown is already set when
that happens but both provide basically the same functionality.

For the DSP snd_soc_avs driver where multiple codecs are located on
multiple cards, bus->shutdown 'shortcut' is not sufficient. One codec
card may be unregistered while other codecs are still operational.
Proper check in form of card->shutdown must be used to verify whether
the codec's card is being shut down.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20250530141309.2943404-1-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Technical Analysis

### Core Problem Being Fixed

The commit addresses a **shutdown race condition** in multi-codec HDA
systems, specifically in DSP/AVS drivers where multiple HDA codecs exist
on the same sound card but with separate bus instances. The change
modifies line 47 in `sound/pci/hda/hda_bind.c`:

**Before:**
```c
if (codec->bus->shutdown)
    return;
```

**After:**
```c
if (codec->card->shutdown || codec->bus->shutdown)
    return;
```

### Why This is a Good Backport Candidate

**1. Bug Fix Nature - Small and Contained**
- This is a clear **bug fix** addressing a specific shutdown race
  condition
- The change is **minimal** (adding one condition check) and **well-
  contained**
- No architectural changes or new features introduced
- Low risk of introducing regressions

**2. Critical Subsystem Impact**
- Affects **HD-audio subsystem** which is critical for audio
  functionality
- Could prevent system crashes or hangs during shutdown in multi-codec
  scenarios
- Improves system stability during shutdown sequences

**3. Technical Correctness**
The fix addresses a **fundamental timing issue**:
- In multi-codec systems, `card->shutdown` is set at the ALSA core level
  during `snd_card_disconnect()`
- `bus->shutdown` is set later at the HDA controller level during
  individual codec shutdown
- **Gap exists** where unsol events could be processed after card
  shutdown but before bus shutdown
- This can cause codec operations on an already-disconnected sound card

**4. Follows Stable Tree Criteria**
- **Important bug fix**: Prevents potential system instability during
  shutdown
- **Minimal risk**: Only adds an additional safety check, doesn't change
  existing logic
- **Well-understood**: The change is straightforward and follows
  existing patterns seen in similar commits
- **Confined to subsystem**: Only affects HDA audio subsystem

**5. Consistency with Similar Backported Commits**
This follows the exact same pattern as the historical commits that were
successfully backported:

- **Similar Commit #1**: Added `bus->shutdown` check to prevent unsol
  events during shutdown - **Backported (YES)**
- **Similar Commit #2**: Added suspend/resume state check to unsol
  handler - **Backported (YES)**
- **Similar Commit #3**: Added jack disconnection during codec unbind -
  **Backported (YES)**
- **Similar Commit #4**: Added bus_probing flag to serialize codec
  registration - **Backported (YES)**

All these commits follow the same pattern: **small, targeted fixes to
prevent race conditions in HDA shutdown/initialization sequences**.

**6. Real-World Impact**
- Affects **DSP/AVS audio systems** which are increasingly common in
  modern hardware
- Without this fix, systems with multiple audio codecs could experience:
  - Kernel oops during shutdown
  - System hangs
  - Audio subsystem corruption
  - Unpredictable behavior during reboot sequences

### Risk Assessment

**Very Low Risk:**
- The change only **adds** a safety check, doesn't remove existing
  functionality
- `card->shutdown` check is used extensively throughout the ALSA
  subsystem already
- Maintains **backward compatibility** completely
- If `card->shutdown` is false, behavior is identical to before
- No changes to data structures, APIs, or functional logic

### Conclusion

This commit represents a **textbook stable backport candidate**: it's a
small, well-understood bug fix that addresses a real stability issue in
a critical subsystem with minimal risk of regression. The pattern
matches multiple previously successful backports in the same subsystem,
and the technical merit is clear.

 sound/pci/hda/hda_bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 9521e5e0e6e6f..fdc8f65c41999 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -44,7 +44,7 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
 	/* ignore unsol events during shutdown */
-	if (codec->bus->shutdown)
+	if (codec->card->shutdown || codec->bus->shutdown)
 		return;
 
 	/* ignore unsol events during system suspend/resume */
-- 
2.39.5


