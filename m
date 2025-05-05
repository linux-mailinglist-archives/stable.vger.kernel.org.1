Return-Path: <stable+bounces-141022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BAAAAAD85
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B303BF522
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10A3EE100;
	Mon,  5 May 2025 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5unbVOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34C3B3BD1;
	Mon,  5 May 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487258; cv=none; b=YFgm78+IwmoGeEXPhhs3c68YtoqH9EEsXfQ65NSGi9mVG8UITlThdoDnkF45AqgI1lGb4HatJa4PZf/azQm4CKo3bWb/HRhzYdWeWBJ1FYQ3prw4LpA/OP6oE4f7YSHUmRZlAGzXP3fL8GCeomIVu72rWI4i9gy7cx98/kUkfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487258; c=relaxed/simple;
	bh=m3GOE7pkABwHmGt6r0SNtfqZR6YJGUdR5VFVmEjHz8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4YyAWWoh5wJtFyOBxccABDOCIoZ/4ucvc6hejU8yIKIgOctEJxPwf0Mkg0xZ1FV2e3MSykazu1ZwjUBIUt9h9x3t21hlBUg28DXDvAZXIEYcNMoEiTvc7axQXDgw+NpYyMuWDKTR5Vv4TuVwOu6K89f6nKJmX1AmV2P+NO5i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5unbVOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B6C4CEEE;
	Mon,  5 May 2025 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487257;
	bh=m3GOE7pkABwHmGt6r0SNtfqZR6YJGUdR5VFVmEjHz8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5unbVOq6jT2tKeT/Sj+A4VRdWzm5/eM3ugsa83bnhBrzyxi/sQp6HqKCf6GPw31g
	 KQncyRaN2xvJ9N5EDg4SIqPVyUQfjQzNFyJCn7qXr0IFTHUtf5ueBSI0hcwLxcz1qc
	 OGKP55RZpCMdUP7msg0nNM8LbIRrSyHob0nNnW3JmzPTedlegPgRI+5LEhGnPZXrNo
	 1XEJCRTVfz9Ypm0H1G0mL/ng1lVfhY90O28PBHttVTaxXYAWIPBZNGCcHCFuOTBJ5o
	 St0S2b4KM8lEjYMNye+PvCRzsnP1ZS4EGUhRT3753s5eP5tmthUR5TSJW9YGEr5U46
	 jthv0Rz2wiXbA==
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
Subject: [PATCH AUTOSEL 5.10 084/114] ASoC: ops: Enforce platform maximum on initial value
Date: Mon,  5 May 2025 19:17:47 -0400
Message-Id: <20250505231817.2697367-84-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index a83cd8d8a9633..55f7c7999330a 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -615,6 +615,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
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
@@ -640,7 +667,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
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


