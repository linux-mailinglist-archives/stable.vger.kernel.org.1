Return-Path: <stable+bounces-200259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5BCAAD03
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 20:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72808302533D
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DF2D948A;
	Sat,  6 Dec 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="XY0bA0Xp"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F32D47E8;
	Sat,  6 Dec 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050314; cv=none; b=G27fd1+8OeqS1Nmg4qNwEBfNwNT24J0a7UxWb6/dZBXFDfO5X5YHKiGA5cDESa2ywJseWScO2Memg5eCnhD8uILRraeG6RKYcO61wF82HOWbo34bxcgShnelVA9BvE2/WJ4yI+Opd2SCie+Vr6tDWnA8AxibNp+g5fcjBwP/ZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050314; c=relaxed/simple;
	bh=FTrBCyfqDBEsjEjcAz6bo8YApO6xaBl7D0QY7b7BKag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvJTRMwQGh/3mg0RPsgKU6aGVHHvrcOUjJ/gKinPmd6f7b1B+W57vUp9lxG3aGWrFd8SGUFMHsbk6/7Vj+XwMgeJcVji6odbSowysUs3psW6CcW0cj26X2V4KQZvesdFnk35L0cqUtMXq9L08vC4yhHhXzPf8pK5XB/hS8aoPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=XY0bA0Xp; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08F0B28515E;
	Sat,  6 Dec 2025 20:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1765049928; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Cwllb3bLUf192JLNRbDuLArgEnvmfsJIhvqnHs2xnfQ=;
	b=XY0bA0XpTDOfALq78kFnaa5k9v4BYf0WP1LpO9UJ40XhZO4zIQQzD7f+2/lfga7gMtQ033
	fHvP0lTxs61cDsSinoKDfJXsyAR87SanjKvm1I4ZRwuUI09F9u5tqY3oGfWmx1f4GNEPTX
	/0Oa0lXHFDzhFOZ+pqL8G5FVWWOxEk70SvlPM9LyAdwN0p1FD6V0PH57bNWIEzc/Blnfmd
	GXC+S1VApJm8AHloIDyfkJBmbgqfq7jIR3HzJo38bMjXr3ITZrjLYxGBdTOlRNNP3mOFUX
	s7ToipHMGGb2SQMAZVwXXCD1FPjjEXaNziJtke8rVa0CTfkY+zrlSE54Lr2Sog==
From: Eric Naim <dnaim@cachyos.org>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Eric Naim <dnaim@cachyos.org>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs35l41: Always return 0 when a subsystem ID is found
Date: Sun,  7 Dec 2025 03:38:12 +0800
Message-ID: <20251206193813.56955-1-dnaim@cachyos.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When trying to get the system name in the _HID path, after successfully
retrieving the subsystem ID the return value isn't set to 0 but instead
still kept at -ENODATA, leading to a false negative:

[   12.382507] cs35l41 spi-VLV1776:00: Subsystem ID: VLV1776
[   12.382521] cs35l41 spi-VLV1776:00: probe with driver cs35l41 failed with error -61

Always return 0 when a subsystem ID is found to mitigate these false
negatives.

Link: https://github.com/CachyOS/CachyOS-Handheld/issues/83
Fixes: 46c8b4d2a693 ("ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Eric Naim <dnaim@cachyos.org>
---
 sound/soc/codecs/cs35l41.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 173d7c59b725..5001a546a3e7 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1188,13 +1188,14 @@ static int cs35l41_get_system_name(struct cs35l41_private *cs35l41)
 		}
 	}
 
-err:
 	if (sub) {
 		cs35l41->dsp.system_name = sub;
 		dev_info(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
-	} else
-		dev_warn(cs35l41->dev, "Subsystem ID not found\n");
+		return 0;
+	}
 
+err:
+	dev_warn(cs35l41->dev, "Subsystem ID not found\n");
 	return ret;
 }
 
-- 
2.52.0


