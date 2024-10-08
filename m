Return-Path: <stable+bounces-81582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A004994757
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7011C24D3B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C31DEFE0;
	Tue,  8 Oct 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0PGcpYq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E21DED79;
	Tue,  8 Oct 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387389; cv=none; b=fWkbCWfpDLfdCVm1+96tA/PRKPQv14awV+ZmbYVvo+bJDMzhDg3DzpDsY4aDjGcBMIURGkuwRo3yDmamLXXbaIPDJSqgIU+hqvMiV1f1BRJtA3GdK94VTCiOcsepyc8zD3J2QclU2lbptTqoKEowsHLLR4EHXbizIe1zVOkbWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387389; c=relaxed/simple;
	bh=tNXsqqFWbMFr3g+ctOdBFLt8QeRqJ7KGw2pmNQ53Cz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YnF/g6bA2u84KzDMGrimH207QgjqgVEuXWEAXe2LrtfxTvytPjz2JLg6paI36fGvtWAXR2AzIm7wkKghDLNHn4Lz0rka+b/4iJ2Q6D6VqWp5uqn/lG7ScFkF17i8Fkh79hN5/qVYgyew3Ct2fMZXc/rtgPhRNfSYJn5GUmXmywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0PGcpYq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so7443683a12.1;
        Tue, 08 Oct 2024 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728387386; x=1728992186; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRvHMUxY4zFz42GUBqqGufyMy0VLstlvaUm3YEpzbjw=;
        b=I0PGcpYq3at0jZCqitGr1W3quaDHbCoerAG7kHDsiIB+yFaaRAHQkF2tMeHyIgrIkk
         nVuhWHB8EnNhjVZCFenh8jHZgjgxM20uCyGXJxdtcv/wveY72q7gBDxVJZVX2euCeBG4
         DCiKKDEZnuXwKGOxAQ7Ap4ujCWui7Knb1UJuj3JxtPGtthIogel9cnNoZnjpBdrm4hoH
         I0wPsUvIfIOZQNz9OHI4YdCrLhw0yjjO80kzuekLWxnNdv3iZO0t313cVNcFKU+V+Vgz
         WWg2ePC7Sw/ZAGotAnnv/VWS9SV/J9tdAYHypTcseMkFm6unFImrjlPnzNufZtp+Cc+i
         d12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387386; x=1728992186;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRvHMUxY4zFz42GUBqqGufyMy0VLstlvaUm3YEpzbjw=;
        b=m7C0duZDudvNKBfFqU80bvzBtCjylrfnQ5VJfW9LDI2lC6Myge3tB7vGF/wR4v3pJz
         NkciHNe5I5jdauSOd9a3TeSAvQF+A0ZRSwABWy/dZ0+ER3gCnEnLhyOQ8Dp8BmsI6qTJ
         ohyMOUTsvAh2JIcXdobKg4c8O271xvtmPluEgVVyohGbhw/qz+s2lC4XJb3sX+FpT+wh
         hYexE2zjGtoGN9Nmujo0Wj8p+iegPORoc6pnK8mamtjPMCOnP9E8FcO0jhCeoTsraUEd
         lwNLImomKyTxcE0GNWoO4Dl3yL+Wwq7rfhIYBwL8/7pIQLDb3LmNlFOH72GvM8f1KEls
         aWRA==
X-Forwarded-Encrypted: i=1; AJvYcCVECjnMPPcvGYDEYkHC0gmB4T7jTxZ7fvvHZR9VgGeWl/XfPx80CnMEpO+zsFZhip9a8C8l6r7LY9mUgn4=@vger.kernel.org, AJvYcCVmPfckk3x/lq8g0N4A6YX90tTQybtSnHicduChnDltgx//HBnHN9RHdNqlsDOgU/zK7ECrrD0PAKuRUe0=@vger.kernel.org, AJvYcCWHN7O6prrL+93E2cGRBBN2uWEITlnP56k+YL1Pkp13z7foug9wyu2YBz/wY4LBznMsReBUzV60@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3TlLe6canZ4CCyUsUcXtd2U/TqL8tocOaIHTafAtO8BCly7T
	dkep1WvIuSEVcSOihnUC+Tmxf0ftHl8KX5zrutGQodvmmtZUfOVs
X-Google-Smtp-Source: AGHT+IHFBZAP0UjOuvIZiyy54gdCEXyBMbpVvwQbpLknYjjq3h4+A4coza4bM8lsTfSDV0XcUPu91A==
X-Received: by 2002:a17:906:4fcc:b0:a99:6791:5449 with SMTP id a640c23a62f3a-a9967915cbbmr258151866b.52.1728387385837;
        Tue, 08 Oct 2024 04:36:25 -0700 (PDT)
Received: from [127.0.1.1] ([2001:67c:2330:2002:af84:a410:1c4f:f793])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99399c6735sm451283366b.9.2024.10.08.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:36:25 -0700 (PDT)
From: Benjamin Bara <bbara93@gmail.com>
Date: Tue, 08 Oct 2024 13:36:14 +0200
Subject: [PATCH v2] ASoC: dapm: avoid container_of() to get component
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-tegra-dapm-v2-1-5e999cb5f0e7@skidata.com>
X-B4-Tracking: v=1; b=H4sIAC0ZBWcC/23MywqDMBCF4VeRWXeKSYvRrnyP4mI0Ex2KF5IgL
 ZJ3b+q6y//A+Q4I7IUDPIoDPO8SZF1y6EsBw0TLyCg2N+hS31VZGow8ekJL24zsmqrpa2cqTZA
 Pm2cn7xN7drknCXH1n9Pe1W/9y+wKFfZs2TT1zZGp2vASS5GuwzpDl1L6AsoaTZKmAAAA
X-Change-ID: 20241007-tegra-dapm-ef969b8f762a
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

From: Benjamin Bara <benjamin.bara@skidata.com>

The current implementation does not work for widgets of DAPMs without
component, as snd_soc_dapm_to_component() requires it. If the widget is
directly owned by the card, e.g. as it is the case for the tegra
implementation, the call leads to UB. Therefore directly access the
component of the widget's DAPM to be able to check if a component is
available.

Fixes: f82eb06a40c8 ("ASoC: tegra: machine: Handle component name prefix")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
Hi!

I handled the new patch as V2 of the initial one, although it has a
different summary. Hope this is fine.
---
Changes in v2:
- fix snd_soc_dapm_widget_name_cmp() instead of reverting commit
- don't pick up R-b of Krzysztof, as different implementation
- Link to v1: https://lore.kernel.org/r/20241007-tegra-dapm-v1-1-bede7983fa76@skidata.com
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9330f1a3f7589dc467c04238830f2009a619a998..c34934c31ffec3970b34b24dcaa0826dfb7d8e86 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2785,10 +2785,10 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_update_dai);
 
 int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s)
 {
-	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
+	struct snd_soc_component *component = widget->dapm->component;
 	const char *wname = widget->name;
 
-	if (component->name_prefix)
+	if (component && component->name_prefix)
 		wname += strlen(component->name_prefix) + 1; /* plus space */
 
 	return strcmp(wname, s);

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241007-tegra-dapm-ef969b8f762a

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>


