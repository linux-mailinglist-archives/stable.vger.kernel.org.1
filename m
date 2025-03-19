Return-Path: <stable+bounces-125532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E6A69165
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B633A46472D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C702222D1;
	Wed, 19 Mar 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMyAVOy3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0B1DF267;
	Wed, 19 Mar 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395256; cv=none; b=W6P7wI0LyOdc7AP9Ofz6+SbgRj0shKAzoxFYMU88f2zyC2PrErZ5nn0OTWFYR/CK7lB8oeguq8pF+8nCb9lz0rlYj7V/Jn3qx8zDLlkEZDcXdwjh7sT/QMAGI3jpC5KGvG9pTOQAoGWrnO93yD2AibU+shxEiZElmHjxjxlK2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395256; c=relaxed/simple;
	bh=8iUjaN5o3KQPNKPXB4+l/EhsBK2bDOoLM60Hnw7eOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4zmaCF48wFPreGDPFJMV8ylJq5dHywV7LONnysJ3HCfhPfYVdj7qzLIULUO1aTtqOU2DnWRBbb2xg8R1VN+33Uf6uwJjXBbLrGyio8/qXV32s2HKlZWRTgz/YRkxHRlq4XKLtwQsHStZJFr9e/s+khBKMcMRRDyCcTt7HVBvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMyAVOy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3234CC4CEE4;
	Wed, 19 Mar 2025 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395256;
	bh=8iUjaN5o3KQPNKPXB4+l/EhsBK2bDOoLM60Hnw7eOQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMyAVOy34i46ZNULJMuRZ3akVJc5wzrkuyfWWtsgnfg8FiTRjoY94TUEvANZHFaTg
	 /wfVnhgnN6MhNg9YBkUO/BTI/nYoegvY2NYix2nR7N9dgTGCEVeuXBb/BIplNcvyGv
	 o6Q4jFQb3mEWzlDAmeHQUZ6ySV/D/FQYvRUTktUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 139/166] ASoC: ops: Consistently treat platform_max as control value
Date: Wed, 19 Mar 2025 07:31:50 -0700
Message-ID: <20250319143023.785526316@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 0eba2a7e858907a746ba69cd002eb9eb4dbd7bf3 ]

This reverts commit 9bdd10d57a88 ("ASoC: ops: Shift tested values in
snd_soc_put_volsw() by +min"), and makes some additional related
updates.

There are two ways the platform_max could be interpreted; the maximum
register value, or the maximum value the control can be set to. The
patch moved from treating the value as a control value to a register
one. When the patch was applied it was technically correct as
snd_soc_limit_volume() also used the register interpretation. However,
even then most of the other usages treated platform_max as a
control value, and snd_soc_limit_volume() has since been updated to
also do so in commit fb9ad24485087 ("ASoC: ops: add correct range
check for limiting volume"). That patch however, missed updating
snd_soc_put_volsw() back to the control interpretation, and fixing
snd_soc_info_volsw_range(). The control interpretation makes more
sense as limiting is typically done from the machine driver, so it is
appropriate to use the customer facing representation rather than the
internal codec representation. Update all the code to consistently use
this interpretation of platform_max.

Finally, also add some comments to the soc_mixer_control struct to
hopefully avoid further patches switching between the two approaches.

Fixes: fb9ad24485087 ("ASoC: ops: add correct range check for limiting volume")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250228151456.3703342-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h |  5 ++++-
 sound/soc/soc-ops.c | 15 +++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c1acc46529b9d..1f99c29aebdfe 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1184,7 +1184,10 @@ void snd_soc_close_delayed_work(struct snd_soc_pcm_runtime *rtd);
 
 /* mixer control */
 struct soc_mixer_control {
-	int min, max, platform_max;
+	/* Minimum and maximum specified as written to the hardware */
+	int min, max;
+	/* Limited maximum value specified as presented through the control */
+	int platform_max;
 	int reg, rreg;
 	unsigned int shift, rshift;
 	unsigned int sign_bit;
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index b27e89ff6a167..b4cfc34d00ee6 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -336,7 +336,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < 0)
 		return -EINVAL;
 	val = ucontrol->value.integer.value[0];
-	if (mc->platform_max && ((int)val + min) > mc->platform_max)
+	if (mc->platform_max && val > mc->platform_max)
 		return -EINVAL;
 	if (val > max - min)
 		return -EINVAL;
@@ -349,7 +349,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		if (ucontrol->value.integer.value[1] < 0)
 			return -EINVAL;
 		val2 = ucontrol->value.integer.value[1];
-		if (mc->platform_max && ((int)val2 + min) > mc->platform_max)
+		if (mc->platform_max && val2 > mc->platform_max)
 			return -EINVAL;
 		if (val2 > max - min)
 			return -EINVAL;
@@ -502,17 +502,16 @@ int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int platform_max;
-	int min = mc->min;
+	int max;
 
-	if (!mc->platform_max)
-		mc->platform_max = mc->max;
-	platform_max = mc->platform_max;
+	max = mc->max - mc->min;
+	if (mc->platform_max && mc->platform_max < max)
+		max = mc->platform_max;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = platform_max - min;
+	uinfo->value.integer.max = max;
 
 	return 0;
 }
-- 
2.39.5




