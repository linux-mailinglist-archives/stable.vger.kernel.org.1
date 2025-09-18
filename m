Return-Path: <stable+bounces-166300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E3B198E3
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4862B176ADD
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE951F4634;
	Mon,  4 Aug 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZPORWZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1A2A1AA;
	Mon,  4 Aug 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267886; cv=none; b=K8fnfRoPNrjQpSR959auoDLIvuY6l37KHBgnJZQjfxKyLysJ8LiO17aPsQWtOemEHoR/5iKsKUCLyZPwcH5gXYdGaNStltqbXuapsdvi1wIKyTOSDTvCy/wQIaHxhrpkdynspAbA8q1P+NSmrB5tgT68I6+3bsPUF4701pOXbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267886; c=relaxed/simple;
	bh=xg7x0LkZ0+s0ebzVC2lLQbf7NJ2JiALaJl2hAnriv+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4yNvCnDJLHVzKdNDYhupkTuyEOn4Qh/GHJzTYfz/0WQHf1ws1f56AryQob1TSVoLPViWR1XBxDus+f0urWgZ79vqMMMdLmKBUVliB6Z5lbmPs6e/Pyuj9WNom8bwVdW0pXvf18hltueg5nAerROGRUYIh7qjwyMW1y7eP/vnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZPORWZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48867C4CEF0;
	Mon,  4 Aug 2025 00:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267885;
	bh=xg7x0LkZ0+s0ebzVC2lLQbf7NJ2JiALaJl2hAnriv+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZPORWZfYhoOSpuITaHOX+riC1YYRjBXSXbo7VgaS+8Xhodn3sqf9Ne+C4j0jNT5F
	 njAXwlcAiqJdfFHbJE6XEFRH4f2kCFZLm1qvRmxwxh4E5zCY382EkTVMMnUrglyLfM
	 yrVbBdnTsUg4hkCtrCIQ7iU6o5yV2sHYDBhKN9bGp3p9o7xJpwz8wW7s2/tLuPORSj
	 hPBvNMKsowOpeSN7D4QYya0VfFohZb2sCnCp0lwQmlKfWEVJs376ThQgoJQ4S0C20W
	 sOe6D97k9VAJbujIWfZCq2PL3be/ZRmCN6oxuDQJrw6++GaTK138JNAHvITSXvao+K
	 X+OJcGT52QUfw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Joakim Zhang <joakim.zhang@cixtech.com>,
	Sasha Levin <sashal@kernel.org>,
	Julia.Lawall@inria.fr,
	vulab@iscas.ac.cn,
	thorsten.blum@linux.dev,
	linux@treblig.org
Subject: [PATCH AUTOSEL 6.1 35/51] ALSA: hda: Handle the jack polling always via a work
Date: Sun,  3 Aug 2025 20:36:27 -0400
Message-Id: <20250804003643.3625204-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003643.3625204-1-sashal@kernel.org>
References: <20250804003643.3625204-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.147
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5f7e54b23e4d253eff3b10b12d6fa92d28d7dddc ]

We used to call directly hda_jackpoll_work() from a couple of places
for updating the jack and notify to user-space, but this makes rather
the code flow fragile.  Namely, because of those direct calls,
hda_jackpoll_work() uses snd_hda_power_up_pm() and *_down_pm() calls
instead of the standard snd_hda_power_up() and *_down() calls.  The
latter pair assures the runtime PM resume sync, so it can avoid the
race against the PM callbacks gracefully, while the former pair may
continue if called concurrently, hence it may race (by design).

In this patch, we change the call pattern of hda_jackpoll_work(); now
all callers are replaced with the standard snd_hda_jack_report_sync()
and the additional schedule_delayed_work().

Since hda_jackpoll_work() is called only from the associated work,
it's always outside the PM code path, and we can safely use
snd_hda_power_up() and *_down() there instead.  This allows us to
remove the racy check of power-state in hda_jackpoll_work(), as well
as the tricky cancel_delayed_work() and rescheduling at
hda_codec_runtime_suspend().

Reported-by: Joakim Zhang <joakim.zhang@cixtech.com>
Closes: https://lore.kernel.org/20250619020844.2974160-1-joakim.zhang@cixtech.com
Tested-by: Joakim Zhang <joakim.zhang@cixtech.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250623131437.10670-4-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Key Reasons for Backporting:

### 1. **Fixes a Real Race Condition Bug**
The commit addresses a race condition in the HDA (High Definition Audio)
jack polling mechanism. The race occurs because:
- Direct calls to `hda_jackpoll_work()` used `snd_hda_power_up_pm()`
  instead of `snd_hda_power_up()`
- The `*_pm()` variants don't provide runtime PM resume synchronization
- This allows concurrent execution and races with PM callbacks

### 2. **Bug Reported and Tested by Users**
- Reported-by: Joakim Zhang with a specific bug report
- Tested-by: Joakim Zhang confirming the fix works
- This indicates real-world impact on users

### 3. **Small and Contained Fix**
The patch statistics show:
- Only 1 file changed: `sound/pci/hda/hda_codec.c`
- 41 lines changed (14 insertions, 27 deletions)
- Net reduction in code complexity
- Changes are localized to jack polling logic

### 4. **Fixes Without Adding Features**
The commit purely fixes the race condition by:
- Removing direct calls to `hda_jackpoll_work()`
- Always scheduling work via `schedule_delayed_work()`
- Switching from `snd_hda_power_up_pm()` to safer `snd_hda_power_up()`
- Removing the racy `cancel_delayed_work_sync()` in suspend path

### 5. **Follows Stable Tree Criteria**
- **Important bug fix**: Race conditions in power management can cause
  system instability
- **Minimal risk**: Changes are well-contained to jack polling logic
- **No architectural changes**: Just refactors the calling pattern
- **Clear improvement**: Removes racy code patterns

### 6. **Critical Subsystem**
The HDA audio subsystem is critical for many systems, and race
conditions in PM paths can lead to:
- Audio device failures after suspend/resume
- Potential system hangs during PM transitions
- Unpredictable behavior in jack detection

### 7. **Simplifies Code**
The fix actually simplifies the code by:
- Removing the complex power state check: `if (!codec->jackpoll_interval
  && snd_hdac_is_power_on(&codec->core))`
- Eliminating the tricky `cancel_delayed_work()` in suspend
- Making the work scheduling pattern consistent

The commit message clearly explains the race condition mechanism and the
fix approach. The change pattern shows careful consideration of PM
synchronization issues, which are notoriously difficult to debug in
production systems. This is exactly the type of bug fix that stable
kernels should include to prevent hard-to-reproduce issues in deployed
systems.

 sound/pci/hda/hda_codec.c | 41 +++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9d7d99b584fe..94b3732e6cb2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -641,24 +641,16 @@ static void hda_jackpoll_work(struct work_struct *work)
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, jackpoll_work.work);
 
-	/* for non-polling trigger: we need nothing if already powered on */
-	if (!codec->jackpoll_interval && snd_hdac_is_power_on(&codec->core))
+	if (!codec->jackpoll_interval)
 		return;
 
 	/* the power-up/down sequence triggers the runtime resume */
-	snd_hda_power_up_pm(codec);
+	snd_hda_power_up(codec);
 	/* update jacks manually if polling is required, too */
-	if (codec->jackpoll_interval) {
-		snd_hda_jack_set_dirty_all(codec);
-		snd_hda_jack_poll_all(codec);
-	}
-	snd_hda_power_down_pm(codec);
-
-	if (!codec->jackpoll_interval)
-		return;
-
-	schedule_delayed_work(&codec->jackpoll_work,
-			      codec->jackpoll_interval);
+	snd_hda_jack_set_dirty_all(codec);
+	snd_hda_jack_poll_all(codec);
+	schedule_delayed_work(&codec->jackpoll_work, codec->jackpoll_interval);
+	snd_hda_power_down(codec);
 }
 
 /* release all pincfg lists */
@@ -2922,12 +2914,12 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		snd_hda_regmap_sync(codec);
 	}
 
-	if (codec->jackpoll_interval)
-		hda_jackpoll_work(&codec->jackpoll_work.work);
-	else
-		snd_hda_jack_report_sync(codec);
+	snd_hda_jack_report_sync(codec);
 	codec->core.dev.power.power_state = PMSG_ON;
 	snd_hdac_leave_pm(&codec->core);
+	if (codec->jackpoll_interval)
+		schedule_delayed_work(&codec->jackpoll_work,
+				      codec->jackpoll_interval);
 }
 
 static int hda_codec_runtime_suspend(struct device *dev)
@@ -2939,8 +2931,6 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (!codec->card)
 		return 0;
 
-	cancel_delayed_work_sync(&codec->jackpoll_work);
-
 	state = hda_call_codec_suspend(codec);
 	if (codec->link_down_at_suspend ||
 	    (codec_has_clkstop(codec) && codec_has_epss(codec) &&
@@ -2948,10 +2938,6 @@ static int hda_codec_runtime_suspend(struct device *dev)
 		snd_hdac_codec_link_down(&codec->core);
 	snd_hda_codec_display_power(codec, false);
 
-	if (codec->bus->jackpoll_in_suspend &&
-		(dev->power.power_state.event != PM_EVENT_SUSPEND))
-		schedule_delayed_work(&codec->jackpoll_work,
-					codec->jackpoll_interval);
 	return 0;
 }
 
@@ -3120,10 +3106,11 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
+	snd_hda_jack_report_sync(codec); /* call at the last init point */
 	if (codec->jackpoll_interval)
-		hda_jackpoll_work(&codec->jackpoll_work.work);
-	else
-		snd_hda_jack_report_sync(codec); /* call at the last init point */
+		schedule_delayed_work(&codec->jackpoll_work,
+				      codec->jackpoll_interval);
+
 	sync_power_up_states(codec);
 	return 0;
 }
-- 
2.39.5


