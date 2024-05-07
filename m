Return-Path: <stable+bounces-43334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8D8BF1D1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C311C23567
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CC1487CB;
	Tue,  7 May 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0KHw/2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612121369A6;
	Tue,  7 May 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123439; cv=none; b=YMxdfrg5kGvr9reFgRk9TsddRSmGDp/qW1gAmqBNUEO36bzFdDl6AAqlM5CgYF1eVNvw9p2PBjfmwcgsVAPZu42RgbUzNpzwu+LZbjEhnIJVA+A0Jx/woJnmHBzJrFd5idoEPrph5hOg8XXLoSCXtOWktMs8Pv5ZS0Ya+qVGzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123439; c=relaxed/simple;
	bh=R4A3Jb9aZLMRVk1H1aorfEqnyalruYt56W9sJFqjOhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6+Y4BHz9lD6EP/zzb94ZxrzcnamrTS1dMy8ECdROPm8tu+nOrJCpwOtwKBy8lvAkIhefdjTNCgIkzeWHNgKaUQSX9PbkkhAAq88J8Kcbprzt5QnObnwguz5EQIHZmGWxlZGtymXdlj59Bfc3xQEvQGDpW/0NKokuDaXoRWmT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0KHw/2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D4C4DDE5;
	Tue,  7 May 2024 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123439;
	bh=R4A3Jb9aZLMRVk1H1aorfEqnyalruYt56W9sJFqjOhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0KHw/2LVbdoNLEHXA4KYd7f7hnIRbeVueZ7T+AjfGhs1TdaIv4DdjCo96Hwnwnjr
	 jg8XctyWzcEGH4UxuoKLbk8GypEHAySq25J8/4OezBaAO3alBsh1gENfRScFlr5Qmc
	 +3GsHk+1rodkxrtrVCXolz5fUsYKKw4Fx2VPDqAMA1mKDTfyloxmnLtS2zWyIafo8o
	 OSUfWhMyhL/mJQ4j7ec8B04wEG5sb5HDsCRDFUz5cOUu+72QxWCGTDdRlyVRpJ3073
	 4fv1RGEkBJI1valR2jHmEpYsyswBjizNLo+qYtCqg+fBwUBnlKfx6R2ydggj3FXjap
	 SRHGUWV37r+Bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/43] ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
Date: Tue,  7 May 2024 19:09:24 -0400
Message-ID: <20240507231033.393285-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 73580ec607dfe125b140ed30c7c0a074db78c558 ]

Adds calls to disable regmap cache-only after a successful return from
cs35l56_wait_for_firmware_boot().

This is to prepare for a change in the shared ASoC module that will
leave regmap in cache-only mode after cs35l56_system_reset(). This is
to prevent register accesses going to the hardware while it is
rebooting.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240408101803.43183-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l56_hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 27848d6469636..05b1412868fc0 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -603,6 +603,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			goto err_powered_up;
+
+		regcache_cache_only(cs35l56->base.regmap, false);
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
@@ -942,6 +944,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 	if (ret)
 		goto err;
 
+	regcache_cache_only(cs35l56->base.regmap, false);
+
 	ret = cs35l56_set_patch(&cs35l56->base);
 	if (ret)
 		goto err;
-- 
2.43.0


