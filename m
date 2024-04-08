Return-Path: <stable+bounces-37140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A959C89C37F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64892283B9E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2BD126F2C;
	Mon,  8 Apr 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQfPGwmX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AD7D09F;
	Mon,  8 Apr 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583364; cv=none; b=lZmtP7NrUN5In77yN1HcH/3G/QzjHtP2OVMdOvwkkKcfmmKJc3dB1fyNbNdwS6clomq5TB0cQUrXF2H+vFQyU5VD2FbwknVUtr/aTHtKx5O7BBhRNu0YIMBXw6d8oiEs7YhEInuhHTfPpDSo9mFUsNQw9WF7gX4Zx5xU+8Ikt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583364; c=relaxed/simple;
	bh=7j8y1FivxC/F/+W/jMUbxSviluFhnl2BayQQsa4DEvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOexylpo6V/daeZ96GfPlPRxQwDiHDyQ3ioI/1eaqqWQuDBqB3OH+bzUlXQyHdBCovxalmU6VXtemjEwMZA3ZR4XmwtBvt5h3KXPIoK2hl87hvjzJTDBFzWTMbb9yUlPlpd5IzYmYp9zhpmzbuvKGzoJo/HB8P0i7fCf2bKKEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQfPGwmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6720FC433C7;
	Mon,  8 Apr 2024 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583363;
	bh=7j8y1FivxC/F/+W/jMUbxSviluFhnl2BayQQsa4DEvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQfPGwmXQkuDoS3xzKIY9/r+pRRoBvhesIqwfF5/4xHwnMdA0rNE7vbecGoeoM7fF
	 FyyRe2R1id2CmT7RJFMqAMCxT/PeTdyXbn2XkC8hAYtIsIghHS9NSGm8kh16/MoYEm
	 eLjg9oHyitzk6UuZYSPURgwUzFtGV0ZQAUOP2Gck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 146/273] ASoC: cs42l43: Correct extraction of data pointer in suspend/resume
Date: Mon,  8 Apr 2024 14:57:01 +0200
Message-ID: <20240408125313.821692997@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 56ebbd19c2989f7450341f581e2724a149d0f08e ]

The current code is pulling the wrong pointer causing it to disable the
wrong IRQ. Correct the code to pull the correct cs42l43 core data
pointer.

Fixes: 64353af49fec ("ASoC: cs42l43: Add system suspend ops to disable IRQ")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://msgid.link/r/20240326105434.852907-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index a97ccb512deba..a24b52c9dda6b 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2338,7 +2338,8 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 
 static int cs42l43_codec_suspend(struct device *dev)
 {
-	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	struct cs42l43 *cs42l43 = priv->core;
 
 	disable_irq(cs42l43->irq);
 
@@ -2347,7 +2348,8 @@ static int cs42l43_codec_suspend(struct device *dev)
 
 static int cs42l43_codec_suspend_noirq(struct device *dev)
 {
-	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	struct cs42l43 *cs42l43 = priv->core;
 
 	enable_irq(cs42l43->irq);
 
@@ -2356,7 +2358,8 @@ static int cs42l43_codec_suspend_noirq(struct device *dev)
 
 static int cs42l43_codec_resume(struct device *dev)
 {
-	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	struct cs42l43 *cs42l43 = priv->core;
 
 	enable_irq(cs42l43->irq);
 
@@ -2365,7 +2368,8 @@ static int cs42l43_codec_resume(struct device *dev)
 
 static int cs42l43_codec_resume_noirq(struct device *dev)
 {
-	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	struct cs42l43 *cs42l43 = priv->core;
 
 	disable_irq(cs42l43->irq);
 
-- 
2.43.0




