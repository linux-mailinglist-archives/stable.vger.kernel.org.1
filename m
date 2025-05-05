Return-Path: <stable+bounces-141082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B262DAAADD7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF09E3AFFC4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD19201033;
	Mon,  5 May 2025 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muaEVO8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC683BE7B8;
	Mon,  5 May 2025 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487414; cv=none; b=ktNwe31+KBvcnxc1Ej6XIBvqzm+tQQcVJre1q/HMBhmujh+lqRnedt7/iQj7kdTNXzdDhZ7lI5NvDL6BgLa5kOOJlS0KG6bjrDXuf68ykH3ibrNRiv4cnv6oo/AQZ2B4julX9GuWXftpmQmtBo5l2EpymwHm+cBl4bbu9Po9XOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487414; c=relaxed/simple;
	bh=RL/fE0cafudihVx0Eh4J01BxfViMCvmEGMCBiHmzHEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYPO1lVPHKm4wVhWnOu7CpQaNmOVE8kZvjz7BmzrVQr3h274ipEItKmElWfSgnAf+65rKtck77b51WuwYe9jozuhHV2ku8oQQq4afIcUj47KEmU3LZq2rvby1WF402Ymol+aCZYCWBwuTovjeUSpuJaw0yrc5nHU8I1+KYrIEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muaEVO8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7295AC4CEF2;
	Mon,  5 May 2025 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487413;
	bh=RL/fE0cafudihVx0Eh4J01BxfViMCvmEGMCBiHmzHEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muaEVO8GEhTHwqlIcp48n3VZWV3FNNsCwetkOpyi2uH3O5e44NV6eTGBtbA+GXXEB
	 sBZeJRLuLaSphHrsXYUG21TE2Gu6W6p0ozeijBSBinOrsWCYnf0jem+VyrOJRq1FGa
	 gksOYBVjzTYo7T7fkhCAVa7KHliKgq+Wzk5o4SIGPB5AyKYgzCA0l+E/RtygNdBLlO
	 NgUfmIqLkylzRw/wf46qCpgwrwObbKG7GZB9P0du0TOAHGQglNFGXp+cD75YlyrKbY
	 MTnSkLF7kuDsB8g8Q+XHjPIJg0NXvut1ttWxNkI4/zO6UUbh/S1vXXINlbxFcGHFdA
	 fPjdXwuBVMzlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 57/79] ASoC: ops: Enforce platform maximum on initial value
Date: Mon,  5 May 2025 19:21:29 -0400
Message-Id: <20250505232151.2698893-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Martin Povišer <povik+lin@cutebit.org>

[ Upstream commit 783db6851c1821d8b983ffb12b99c279ff64f2ee ]

Lower the volume if it is violating the platform maximum at its initial
value (i.e. at the time of the 'snd_soc_limit_volume' call).

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
[Cherry picked from the Asahi kernel with fixups -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-volume-limit-v1-1-b98fcf4cdbad@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 08ed973b2d975..a3b1f1c064ddc 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -635,6 +635,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 
+static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+	struct snd_ctl_elem_value uctl;
+	int ret;
+
+	if (!mc->platform_max)
+		return 0;
+
+	ret = kctl->get(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	if (uctl.value.integer.value[0] > mc->platform_max)
+		uctl.value.integer.value[0] = mc->platform_max;
+
+	if (snd_soc_volsw_is_stereo(mc) &&
+	    uctl.value.integer.value[1] > mc->platform_max)
+		uctl.value.integer.value[1] = mc->platform_max;
+
+	ret = kctl->put(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /**
  * snd_soc_limit_volume - Set new limit to an existing volume control.
  *
@@ -667,7 +694,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 		mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max) {
 			mc->platform_max = max;
-			ret = 0;
+			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
 	return ret;
-- 
2.39.5


