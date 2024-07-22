Return-Path: <stable+bounces-60677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233E938D71
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D580B219E9
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1616CD00;
	Mon, 22 Jul 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XjjwGUsn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF016C695;
	Mon, 22 Jul 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643975; cv=none; b=sA/EHcyICyCFgE+Cy8csVrGXHw47Ov47Vn6XnTMWoU1C27K9FIRbPuFVXUqM0bKzRt6XkIqSkaBwZQlNIOy1bRs+tMr+8XGhwPRX10xW47LTIAiqLyFuCOkS0/yWFF50mqIsX+iHMhqPJPT0vDovsncWncDNAxgoOyLH+bQAkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643975; c=relaxed/simple;
	bh=0l8O3M4kP3eoaMG4z05pJZgheO9kWmWMulcubFD+vNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMH8Enc3Y7fYKsOsZ7+vwcKaWNDPb62DRCgWXZXATO2jOu1FVXfPRenKFHEiGis8BYeXUWa/7RL0/XUuU9dMPIoGX0+LnRNLC4ac5K4esIq7VdugLUkb3zwGV43waFtMICAKh0nCPi7cLS8iV2x1NyEbQLv5fx40qI5y2r24gME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XjjwGUsn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M6AUpP030632;
	Mon, 22 Jul 2024 05:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ra314kbOhsrM/Q5p+Z/Ul8wHRE5K03gY7xfgRvtL9kc=; b=
	XjjwGUsnxx0rOWFXcKmS5wCgyGAO6oKBBT0+x5TOVsPmaOwdYO/liBdQB2/ws1Zv
	BiM4niZ75dcfRhkCxAHw7vj8fnlsAwj9AJsz3YdwD8aph134JbKLoMUK40SxybFN
	Dy723X1GJ0BBnxztv588wDt01S/RBkUstJTMcazoK5KPhCl3bofPLfP/Vamlzjoh
	2QFuNtmc45cJu2l+qgwr54hiv9YHlzX635JnZBnUZPrrxJOaKWSGi5xaYCWvTcYz
	G0lGPwf20qLoJHOL4EuMAf0KzQt7GW46VK5f2MrfAoPFb3XsakV7eVQ2KJZk+eCj
	FqJSPQ8ocF0ZQBku8xcU4Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40gamx1mh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:26:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 11:26:00 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 22 Jul 2024 11:26:00 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6F4A8820247;
	Mon, 22 Jul 2024 10:26:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <stable@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-6.10 1/2] ASoC: cs35l56: Use header defines for Speaker Volume control definition
Date: Mon, 22 Jul 2024 11:25:59 +0100
Message-ID: <20240722102600.37931-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722102600.37931-1-rf@opensource.cirrus.com>
References: <20240722102600.37931-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0RrkAHuE1XvBnW674rwWaFzKEJiRlDxV
X-Proofpoint-ORIG-GUID: 0RrkAHuE1XvBnW674rwWaFzKEJiRlDxV
X-Proofpoint-Spam-Reason: safe

[ Upstream commit c66995ae403073212f5ba60d2079003866c6e130 ]
Please apply to 6.10

The "Speaker Volume" control was being defined using four hardcoded magic
numbers. There are #defines in the cs35l56.h header for these numbers, so
change the code to use the defined constants.

Backport Note:
Identical to upstream commit. This was originally thought to be only a
cosmetic issue (the user can simply reduce the volume) but for some complex
audio topologies with SOF Audio DSP + CS42L43 + multiple CS35L56 it has
turned out to be not obvious to the user what the problem actually is and
what to do to fix it. As support for these topologies went into 6.10 we
would like this commit to be backported into 6.10.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20240703095517.208077-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 758dfdf9d3ea..7f2f2f8c13fa 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -196,7 +196,11 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
 	SOC_SINGLE_S_EXT_TLV("Speaker Volume",
 			     CS35L56_MAIN_RENDER_USER_VOLUME,
-			     6, -400, 400, 9, 0,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MIN,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MAX,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT,
+			     0,
 			     cs35l56_dspwait_get_volsw,
 			     cs35l56_dspwait_put_volsw,
 			     vol_tlv),
-- 
2.39.2


