Return-Path: <stable+bounces-141558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EB8AAB467
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5538B17FFF5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5536343190;
	Tue,  6 May 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auQMDRXG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BE2F0B95;
	Mon,  5 May 2025 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486694; cv=none; b=pQ5Ivdk7W6AQLawgRIEMU6kBmrqix9hoS67LrUPvl0wyVryPakn/AM65TT31c8L5tjvBKIbKnpa+ngDDTG4jORcQPEz2xwnQ7y2ByJINC1wkslOC1aBGWN+YqinqAnuTA5tN5av/YgDkcfvhMZoik1mKu7lPXWORZ9sKbPPQzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486694; c=relaxed/simple;
	bh=pRU+ZlluUtiVBahzR3qY/4fwlWskxPfojj3aByJYiUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCan4MP8YmGqfGHELKb2jo+27/vAKnFoSoEE+Gf1GiNq2FJZVP4lqRt+tnOrdNjhe/g+GqUeh0GgO7Px93mVf84+fhvEsFQnr8Rz2xA/5jdVvBSLeuEtPELB+imBXbSGcUoSIyfeOaqdZsWG8n9ksfjzdB0y2HXsFMb8srsYHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auQMDRXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F9C4CEF1;
	Mon,  5 May 2025 23:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486694;
	bh=pRU+ZlluUtiVBahzR3qY/4fwlWskxPfojj3aByJYiUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auQMDRXGu/WZDzSxt1+KHmYMJjZORhZwAu8XQtw3gzMDEXXukBSeXaj0TcgBgqyCJ
	 uIXh8QKh1ivay+lzauAKfwVnqUPeqqMROjUQC8u0XfBtObhe8G7C8F/KAJdoTqnmTd
	 cw0Xj9FKCjvd2tl+SsB+8hoqeWsyw6ATU3xqyXvEb4KB24MzzjSZmYCPUq9QwAF1eP
	 2Tdgduft+8D+ZIxSUlQCnewygcz82Pu1+THx1R8Qf0aEgBYjGES9jRMJWMcwYJXHa7
	 9NTYB3mg7PlZ+a19btFrRGdKzGFGr0W0hwJeYKh/4m0kDL+fYBe4/AxJvmYekrIfRL
	 q8FPAfCitrAqg==
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
Subject: [PATCH AUTOSEL 6.1 155/212] ASoC: ops: Enforce platform maximum on initial value
Date: Mon,  5 May 2025 19:05:27 -0400
Message-Id: <20250505230624.2692522-155-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index b4cfc34d00ee6..eff1355cc3df0 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -638,6 +638,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
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
@@ -662,7 +689,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
-			ret = 0;
+			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
 	return ret;
-- 
2.39.5


