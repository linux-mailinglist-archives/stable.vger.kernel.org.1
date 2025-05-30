Return-Path: <stable+bounces-148204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27915AC8E60
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17223AE961
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025E241689;
	Fri, 30 May 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV1GbB1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1724166F;
	Fri, 30 May 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608790; cv=none; b=mAtBVhXka/3fOT8J4Wt91oV1ieSB9RhAlzoPPqNqsIs6jMIf/EapriaYKWNsG8WkooJPCT81fHdAs2C9ue3Y8MbEXvxTMebYjEbgbvlaF3Y/47v2sxX+5smfJ6u9xP3/aS5d2FSGXsarDC6H6ATtzHQNIHprJOM0MFvIIHJTPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608790; c=relaxed/simple;
	bh=6iH0CzUKeg3sM7kVPqS4VamrSXZlCtGCM06ywwwLXk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZ7Sr3YTcWK/HXO28O5gOqG83Mr+pXLxYkdz33tLbdoeK5JsEyTPGSSAXzP4X5FMBhBgBFCzHmztcjJktnZxIaYTkiojnT+j6jSwmt02ut8q8AO09qvFwvJmZ+O826rmbqFCFVGJRStsKiReKGNL/KXdRzzx36GPzslp7TWvLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV1GbB1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429BBC4CEEA;
	Fri, 30 May 2025 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608790;
	bh=6iH0CzUKeg3sM7kVPqS4VamrSXZlCtGCM06ywwwLXk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FV1GbB1Bzy1j45SyjBDmtE1vG0AzAjhejlZn5tmqW99ZgvGG/QsGXFjprq6I1NSMR
	 EXL42EcnnbNFP1fvM0KbaoLKr7NstCku+cUJikd0pgnsq2R5DuwExm39A/JZhNYxWx
	 rEbqAtZeItM5ufdcXkW8whwmfPNlKtBe/oYV0FtRINz/oIv/I8YKCClieaX1OauAg9
	 S2HBU51Zgu0ot2rnJUcv9iOeB2xW52RCpFUELDemwJ7fN7Qy8m/3JopMzLi+yP/poQ
	 qlNG0d+o/wzqWckQ/2pBSZGTe/n8CTX6q2oTATkIWujwoYLdddb8UlTXDNqzc6Inx/
	 ZWjFT+l4I+ITA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: I Hsin Cheng <richard120310@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 12/28] ASoC: intel/sdw_utils: Assign initial value in asoc_sdw_rt_amp_spk_rtd_init()
Date: Fri, 30 May 2025 08:39:18 -0400
Message-Id: <20250530123934.2574748-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123934.2574748-1-sashal@kernel.org>
References: <20250530123934.2574748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: I Hsin Cheng <richard120310@gmail.com>

[ Upstream commit 5fb3878216aece471af030b33a9fbef3babd8617 ]

Initialize "ret" with "-EINVAL" to handle cases where "strstr()" for
"codec_dai->component->name_prefix" doesn't find "-1" nor "-2". In that
case "name_prefix" is invalid because for current implementation it's
expected to have either "-1" or "-2" in it. (Maybe "-3", "-4" and so on
in the future.)

Link: https://scan5.scan.coverity.com/#/project-view/36179/10063?selectedIssue=1627120
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
Link: https://patch.msgid.link/20250505185423.680608-1-richard120310@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the codebase context, I can now
provide a comprehensive assessment: **YES** This commit should be
backported to stable kernel trees. ## Extensive Analysis ### Nature of
the Bug The commit addresses a classic uninitialized variable bug in
`asoc_sdw_rt_amp_spk_rtd_init()` in
`sound/soc/sdw_utils/soc_sdw_rt_amp.c`. The function declares `int ret;`
but only conditionally assigns values to it within a loop: ```c
for_each_rtd_codec_dais(rtd, i, codec_dai) { if
(strstr(codec_dai->component->name_prefix, "-1")) ret =
snd_soc_dapm_add_routes(&card->dapm, rt_amp_map, 2); else if
(strstr(codec_dai->component->name_prefix, "-2")) ret =
snd_soc_dapm_add_routes(&card->dapm, rt_amp_map + 2, 2); } return ret;
``` ### When the Bug Manifests The bug occurs when: 1.
`codec_dai->component->name_prefix` doesn't contain "-1" OR "-2" 2. Both
`strstr()` calls return NULL, causing neither branch to execute 3. The
function returns an uninitialized `ret` value, leading to unpredictable
behavior ### Historical Context From the git blame analysis, this bug
was introduced in commit `84e0a19adb73d` (May 9, 2024) by Bard Liao when
adding a dai parameter to rtd_init callbacks. The commit changed the
variable name from `dai` to `codec_dai` to avoid conflicts, but failed
to initialize `ret` properly for the edge case. ### Code Analysis The
fix is simple and correct: - **Before**: `int ret;` (uninitialized) -
**After**: `int ret = -EINVAL;` (initialized with appropriate error
code) The `-EINVAL` choice is appropriate because: 1. If name_prefix
lacks "-1" or "-2", it indicates an invalid configuration for current
implementation 2. The commit message explicitly states this expectation
3. `-EINVAL` is the standard Linux kernel error for invalid arguments
### Static Analysis Context The commit message references Coverity scan
ID 1627120, indicating this was caught by static analysis tools. This is
a legitimate bug that could cause: - Random return values leading to
unpredictable behavior - Potential system instability in audio subsystem
- Difficult-to-debug intermittent failures ### Backport Suitability
Analysis **✅ Meets Stable Tree Criteria:** 1. **Important Bug Fix**:
Fixes a real bug that can cause unpredictable behavior in the audio
subsystem 2. **Small and Contained**: Single line change, minimal risk
of introducing regressions 3. **No Side Effects**: Only affects the
error path when name_prefix is invalid 4. **No Architectural Changes**:
Pure bug fix with no design changes 5. **Subsystem Confined**: Limited
to ASoC Intel SDW utils subsystem 6. **Clear Benefit**: Prevents
undefined behavior and ensures deterministic error handling **Risk
Assessment**: **VERY LOW** - Single line initialization change - Only
affects error/edge case paths - No functional logic changes - Well-
understood fix pattern **Impact**: **MODERATE** - Affects Intel
SoundWire audio configurations - Could prevent audio system failures on
affected hardware - Improves system reliability and debuggability ###
Comparison with Similar Commits The provided examples show that simple
NULL check additions (Similar Commit #1) and small contained bug fixes
are consistently marked as "YES" for backporting. This commit follows
the same pattern - it's a small, contained fix for a legitimate bug with
minimal risk. This commit exemplifies the ideal stable tree candidate:
it fixes a real bug, is minimal in scope, has no risk of regression, and
improves system reliability.

 sound/soc/sdw_utils/soc_sdw_rt_amp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt_amp.c b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
index 0538c252ba69b..83c2368170cb5 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
@@ -190,7 +190,7 @@ int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 	const struct snd_soc_dapm_route *rt_amp_map;
 	char codec_name[CODEC_NAME_SIZE];
 	struct snd_soc_dai *codec_dai;
-	int ret;
+	int ret = -EINVAL;
 	int i;
 
 	rt_amp_map = get_codec_name_and_route(dai, codec_name);
-- 
2.39.5


