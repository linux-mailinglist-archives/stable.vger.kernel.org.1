Return-Path: <stable+bounces-166301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6735B19929
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477D13A514F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B91C84B2;
	Mon,  4 Aug 2025 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCnZIh20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7051D555;
	Mon,  4 Aug 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267888; cv=none; b=fESCX4UI6HU1sV21DBV5hZUSpDUOIRiIpblIQOMoyP3u12qnRE9eY/aH2I7IKAzQhyxvBpJGrT/1b2gRaeGx5ZlODHpM2Wt5RYOMlV3byRWSVuO0pPGmCvy2nTIjuL5Ld8tJXT+HqFLgRu5UMc8Mre9FZS713xwbGkQO+4q3fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267888; c=relaxed/simple;
	bh=KWPNJKE5dnN6l7VRkUtFK9t8ZbrmAtnGOgARaLUgZdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6AudmZYaDYQmqmY2LvGH9yi8sBncXM60YmwO/3h5Cq9BTBP4hyd0Qg+RiNe5JkaMABl4BKn61GKAADxspfgKtvHmRapJlbxovLBhoJlHwRcs99uKyTE8c10kRAUBahRVz8BYANlhF54XSDUon1DwDeXHC3jyQkd8CJg/gcP9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCnZIh20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA6C4CEEB;
	Mon,  4 Aug 2025 00:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267888;
	bh=KWPNJKE5dnN6l7VRkUtFK9t8ZbrmAtnGOgARaLUgZdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCnZIh20P0oXFzg2s3Kj/GT869bOxtyHztl8gngh1c7qXMXzsDut+jZZR6kb7bkWn
	 CnBErbVLf2FqBlfFhGFo2zTJJc7xow/MiFNuzFlgJQ5SdOJeOhzZXy8rX+cnDGsm9R
	 ImyHQ99oQDM6K60A4sSedsOKddZvo5EFVO0OhF8VELy3Ak4Udj/LcGhd+msD6rDrvP
	 8QN1N3LlPLLk2/HKh3a3g20CVv0K2wJzkr/mlVYcUL5mrAyA5B+AbnSxGbLDkiQ1UO
	 Ipl3wWi755HoFYuwaGoCANwS4ixdpiMBo/nuEPjB9Fb+HGa8F/awMfIKM1imYUw6i3
	 zpV3WPjLZfbqw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Joakim Zhang <joakim.zhang@cixtech.com>,
	Sasha Levin <sashal@kernel.org>,
	vulab@iscas.ac.cn,
	linux@treblig.org,
	thorsten.blum@linux.dev,
	Julia.Lawall@inria.fr
Subject: [PATCH AUTOSEL 6.1 36/51] ALSA: hda: Disable jack polling at shutdown
Date: Sun,  3 Aug 2025 20:36:28 -0400
Message-Id: <20250804003643.3625204-36-sashal@kernel.org>
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

[ Upstream commit 1adcbdf54f76e1004bdf71df4eb1888c26e7ad06 ]

Although the jack polling is canceled at shutdown in
snd_hda_codec_shutdown(), it might be still re-triggered when the work
is being processed at cancel_delayed_work_sync() call.  This may
result in the unexpected hardware access that should have been already
disabled.

For assuring to stop the jack polling, clear codec->jackpoll_interval
at shutdown.

Reported-by: Joakim Zhang <joakim.zhang@cixtech.com>
Closes: https://lore.kernel.org/20250619020844.2974160-4-joakim.zhang@cixtech.com
Tested-by: Joakim Zhang <joakim.zhang@cixtech.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250623131437.10670-2-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Fix Analysis

The commit fixes a **race condition** during codec shutdown where jack
polling work could be re-triggered even after attempting to cancel it.
This is evident from the commit message: "it might be still re-triggered
when the work is being processed at cancel_delayed_work_sync() call."

The race condition occurs because:
1. `cancel_delayed_work_sync()` waits for the current work to complete
2. While waiting, if the work function (`hda_jackpoll_work`) is
   executing, it checks `codec->jackpoll_interval` at line 635 of the
   original code
3. If `jackpoll_interval` is still non-zero, the work reschedules itself
   with `schedule_delayed_work(&codec->jackpoll_work,
   codec->jackpoll_interval)` at line 641
4. This creates a situation where hardware access occurs after shutdown
   has supposedly completed

## Code Change Analysis

The fix is **minimal and surgical** - just one line added:
```c
codec->jackpoll_interval = 0; /* don't poll any longer */
```

This is placed **before** the `cancel_delayed_work_sync()` call,
ensuring that even if the work function is currently running, it won't
reschedule itself because the interval check at the beginning of
`hda_jackpoll_work()` will fail.

## Impact Assessment

1. **User-visible bug**: Yes - unexpected hardware access during
   shutdown can cause system hangs, crashes, or hardware-related issues
2. **Fix size**: Extremely small - single line addition
3. **Risk assessment**: Very low - setting a value to 0 before canceling
   work is a safe operation
4. **Subsystem criticality**: ALSA HD-Audio is widely used, but this
   specific fix is in the shutdown path
5. **Testing**: The commit has been tested by the reporter (Joakim
   Zhang)

## Stable Tree Criteria

This commit meets stable tree requirements:
- Fixes a real bug (race condition causing unexpected hardware access)
- Minimal change (1 line)
- Clear fix with obvious correctness
- No new features or architectural changes
- Only affects the shutdown path, limiting scope
- Has been tested by the bug reporter

The fix prevents potential system instability during shutdown, making it
an important candidate for stable backporting.

 sound/pci/hda/hda_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 94b3732e6cb2..aef60044cb8a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3040,6 +3040,7 @@ void snd_hda_codec_shutdown(struct hda_codec *codec)
 	if (!codec->core.registered)
 		return;
 
+	codec->jackpoll_interval = 0; /* don't poll any longer */
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 	list_for_each_entry(cpcm, &codec->pcm_list_head, list)
 		snd_pcm_suspend_all(cpcm->pcm);
-- 
2.39.5


