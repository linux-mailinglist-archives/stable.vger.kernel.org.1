Return-Path: <stable+bounces-148565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29062ACA488
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DA71889B44
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CC298CB6;
	Sun,  1 Jun 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4cgecUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3682673B6;
	Sun,  1 Jun 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820817; cv=none; b=bEIQgwtItQIuxKujItXmD0PIyFihbjUfen4vjgD7DJkTZi+sLTxqSVB2a3a84xfHGPij5nWvCaLZckjZ47kpSSSj18/rrpM+n7fzBLXHWuKf6HLh0sdo7qKcU9ChCnbG5fNH8R8oFOKfqwEW9Hv4a4NxK1EBTY+99jbq9maF9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820817; c=relaxed/simple;
	bh=UoMqPF0JODIkz2Nbh672KEMJcLMwggCN1tSMDfpD35E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvhOvI3T898SDGp379xpLZWOUlAr2kq3s5X3xYj9xHKkYX6G78MXvB4sfWGmKRtqwZJ+9cxNMAxHRYcY4IzdG55G026tQ8muqn7U0Od6g7CGj6kHx0AJYW86t0cO7uKWeRDBqCiji8pX3ro1kG6ZXfZ/WCLXNRyaFJlAWi9L9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4cgecUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A829C4CEE7;
	Sun,  1 Jun 2025 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820817;
	bh=UoMqPF0JODIkz2Nbh672KEMJcLMwggCN1tSMDfpD35E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4cgecUEgF1aBZ0qtTlPAfzchRsWix5aMEnhZbpNNC55Fbtpem08j8BTtOPn5sj8/
	 nhaIReBbQdQqQeAQAFs2Cs07Gxl01/hNX/J02Ap9fUxhgUrWsRpSahDONhW2e9H9qu
	 BaA7ecDb/fubNxF7iKjKNyTfD3sBfQfEume9G27FYavKrMdSGB/vhq/XHN65iLYRDm
	 CG0C4maPS3xho+8Qo1U9JSZIYfR5L77kh3GaJpATvy8fP8AreRsg8VrAWM5e25LZLv
	 KNK8m5+Ay/agIuJWtcoAYeFHt/7/Y+BMlxdGc6FQR3n8OS/k+weE1CloBhyG2+e8Zu
	 3GFostwkwpq/A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: I Hsin Cheng <richard120310@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	Vijendar.Mukunda@amd.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 089/102] ASoC: intel/sdw_utils: Assign initial value in asoc_sdw_rt_amp_spk_rtd_init()
Date: Sun,  1 Jun 2025 19:29:21 -0400
Message-Id: <20250601232937.3510379-89-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
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

Based on my comprehensive analysis of this commit, I can now provide my
backport recommendation: **YES** This commit should be backported to
stable kernel trees. Here's my extensive analysis: ## Bug Description
and Analysis The commit fixes a critical bug in the
`asoc_sdw_rt_amp_spk_rtd_init()` function in
`sound/soc/sdw_utils/soc_sdw_rt_amp.c`. The issue is that the `ret`
variable is declared but never initialized, and in certain execution
paths, it may be returned uninitialized. ### Specific Problem Details 1.
**Uninitialized Variable Issue**: The `ret` variable is declared on line
193 but never given an initial value. 2. **Problematic Code Path**: In
the `for_each_rtd_codec_dais()` loop (lines 204-209), `ret` is only
assigned a value if `strstr()` finds either "-1" or "-2" in the
`codec_dai->component->name_prefix`. However, if neither condition is
met, `ret` remains uninitialized. 3. **Return of Garbage Value**: When
the function reaches `return ret;` on line 211, if neither condition in
the loop was satisfied, the function returns an uninitialized value,
which could be any random memory content. ### Why This Is a Serious Bug
1. **Unpredictable Behavior**: The function may return success (0) or
failure (non-zero) randomly depending on stack contents, leading to
inconsistent system behavior. 2. **Audio Subsystem Impact**: The
function is used as an `rtd_init` callback for multiple Realtek audio
amplifier codecs (rt1308, rt1316, rt1318, rt1320) as evidenced by the
codec info list in `soc_sdw_utils.c`. 3. **Error Propagation**: The
return value is checked in `asoc_sdw_rtd_init()` and propagated upward -
a garbage positive value would cause audio initialization to fail
unexpectedly. ### Evidence from Code Analysis The function is called via
the `rtd_init` callback mechanism: ```c if
(codec_info->dais[dai_index].rtd_init) { ret =
codec_info->dais[dai_index].rtd_init(rtd, dai); if (ret) return ret; //
Failure propagated upward } ``` The fix correctly initializes `ret =
-EINVAL` to handle the case where the `name_prefix` doesn't contain the
expected "-1" or "-2" suffixes, which indicates an invalid configuration
that should properly return an error. ### Characteristics Supporting
Backport 1. **Clear Bug Fix**: This is a straightforward bug fix with no
new features or architectural changes. 2. **Minimal Risk**: The change
is one line adding initialization - extremely low risk of introducing
regressions. 3. **Wide Hardware Impact**: Affects multiple Realtek audio
amplifier codecs used in Intel SoundWire configurations. 4. **Stable
Tree Compatible**: Bug was introduced in v6.10 (commit 84e0a19adb73d),
making it applicable to stable kernels from v6.10 onward. 5. **Static
Analysis Found**: The bug was found by Coverity static analysis,
indicating it's a real issue that could manifest in practice. 6. **User
Impact**: Audio hardware initialization failures can significantly
impact user experience, especially on laptops and embedded systems using
these codecs. This commit perfectly fits the stable kernel criteria: it
fixes an important bug, has minimal risk, is contained to a specific
subsystem, and addresses undefined behavior that could cause random
failures in audio hardware initialization.

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


