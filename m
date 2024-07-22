Return-Path: <stable+bounces-60676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44810938D6F
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991FA2866E3
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5316C6B2;
	Mon, 22 Jul 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NuPROmPI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F6149DF4;
	Mon, 22 Jul 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643974; cv=none; b=XBDNhfntS0nUhNWk/SSkZkAyyLfAfr0GkDzs9aKCibVgCOVTgYDt2pGApaH+o/pzW92fu1ziv035kk09NPq46D1E0q9gkVNxAx9/Q0yeUj51gwJdMBV6kBRdMLTVo9Epj87+dro2mgLs+Q2ppozg/n55xoxlp1l1lnLf6xDHAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643974; c=relaxed/simple;
	bh=6gdU2fmMO6+JPa+BiXzX0RbGUv4MbfaoUPguX4GuUbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unCaMDvoAUaQqFoNXwZcaYA5dM49MJWwp2cBcgK8azxvd3//rzXbBKXtUlrBgkhx/ochRHnKx1dnWdKKApXjpYS9jo3WhdVyHBZqmx3Ea8O3obw1WIb80bSezaJo8ZaII4AIxTf4EgeV3gZlYdXak78Gl78ThSzq0E/hC7U52QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NuPROmPI; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M5A0s2002661;
	Mon, 22 Jul 2024 05:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zoiEcBfFoEgPlNbPS6G/rOEgVbzOOa72EhD7b8AV0HM=; b=
	NuPROmPIzS5r/knNX2tOKztmTtBC3RCC8V0G/JxsiaYW6znhr84oXDc+mIjNzEp5
	CqLg1sBTeB3jBxBQuOkQ5cfdTh/q6BWksulDxzBdJcZV/RqZV1cLhBSGdPA3tdlw
	AnLiJEobbKdX4IrQIR1JU75MR0SEuRZtS3xJ3RxqZRN5p37CDEIN++ttR2EFPtCw
	DqS5SISBafOJ7lExWTW6hft8dAT/7seDWVBMsUkKj7tBhDE9pWAXb7yNtisdGkwb
	yGi/aahzBSo0TQwKR1ix/W+3/l85Dmk6xKunAwCBKvZpvj6uEwSL1lpPEpLhU4T4
	uuKBSpVnyEyE8ZbSvIy2lQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40g9nj1n5j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:26:02 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 11:26:00 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 22 Jul 2024 11:26:00 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 752D182024B;
	Mon, 22 Jul 2024 10:26:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <stable@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-6.10 2/2] ASoC: cs35l56: Limit Speaker Volume to +12dB maximum
Date: Mon, 22 Jul 2024 11:26:00 +0100
Message-ID: <20240722102600.37931-3-rf@opensource.cirrus.com>
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
X-Proofpoint-GUID: uGiP9Yo0JC-j2A6scPWUyaoS8f9o2EDb
X-Proofpoint-ORIG-GUID: uGiP9Yo0JC-j2A6scPWUyaoS8f9o2EDb
X-Proofpoint-Spam-Reason: safe

[ Upstream commit 244389bd42870640c4b5ef672a360da329b579ed ]

Change CS35L56_MAIN_RENDER_USER_VOLUME_MAX to 48, to limit the maximum
value of the Speaker Volume control to +12dB. The minimum value is
unchanged so that the default 0dB has the same integer control value.

The original maximum of 400 (+100dB) was the largest value that can be
mathematically handled by the DSP. The actual maximum amplification is
+12dB.

Backport Note:
Identical to upstream commit. This was originally thought to be only a
cosmetic issue (the user can simply reduce the volume) but for some complex
audio topologies with SOF Audio DSP + CS42L43 + multiple CS35L56 it has 
turned out to be not obvious to the user what the problem actually is and
what to do to fix it. As support for these topologies went into 6.10 we
would like this commit to be backported into 6.10.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20240703095517.208077-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 1a3c6f66f620..dc627ebf01df 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -209,7 +209,7 @@
 
 /* CS35L56_MAIN_RENDER_USER_VOLUME */
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MIN		-400
-#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		400
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		48
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MASK		0x0000FFC0
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT		6
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT		9
-- 
2.39.2


