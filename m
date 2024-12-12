Return-Path: <stable+bounces-102907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A19EF400
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB50B290748
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11973222D7F;
	Thu, 12 Dec 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGaF0H/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F113792B;
	Thu, 12 Dec 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022943; cv=none; b=ieJCDS/0mDt72R0btTlCSG/V0gwRynXb6sPLzSAHSmjCO/+zgkFqGgiEJXBmBWpFp9Q9RMLgJVGjfZD4GS7sBATfBX7jst/9Yx6rinjUG2d+f0NCgcRQh1fX7c3WqBdyk7wfPkPAcbTLh/dU4H+kA47r5R5Kg3FQqDgFW+JRi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022943; c=relaxed/simple;
	bh=gVm0TGtWALYlTWx9uf7Uucd2O4ZRXDbQS7R/PQtOax8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESovNyLy1SM8VySBYpjnOIcqqShcDk2ltiLDPVJtn2CCQs3o40kmxoatY5SLRiQbMRFNjQEnyHDVD8nrvDZGmL9Y+3jbDUEXJitkNDXfOEO9jlmioAoqsArr7dpyam3/mDiir8GRHVJo3UEK8Jru9G+5obY/IVRNzI0Rprn+Ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGaF0H/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30127C4CED0;
	Thu, 12 Dec 2024 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022943;
	bh=gVm0TGtWALYlTWx9uf7Uucd2O4ZRXDbQS7R/PQtOax8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGaF0H/SyQflyMvRHM5x7eOevlE1ZINWA7lAqAvo/XKuGBYE15L22RhlS8vyGRrXx
	 tdiap6XL126QnTvgBHSo3crHbOz+IzPWtkv8mYzuU4hdd9Lk5sG9t+/KG/Q0LePHTJ
	 p4nr7bzF9LjAaxKXIekYp8iBocyrJcO+8skX9BeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 375/565] ASoC: fsl_micfil: fix the naming style for mask definition
Date: Thu, 12 Dec 2024 15:59:30 +0100
Message-ID: <20241212144326.447978230@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

commit 101b096bc2549618f18bc08ae3a0e364b3c8fff1 upstream.

Remove the _SHIFT for the mask definition.

Fixes: 17f2142bae4b ("ASoC: fsl_micfil: use GENMASK to define register bit fields")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/r/1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_micfil.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -75,9 +75,9 @@
 #define MICFIL_FIFO_STAT_FIFOX_UNDER(ch)	BIT((ch) + 8)
 
 /* MICFIL HWVAD0 Control 1 Register -- REG_MICFIL_VAD0_CTRL1*/
-#define MICFIL_VAD0_CTRL1_CHSEL_SHIFT	GENMASK(26, 24)
-#define MICFIL_VAD0_CTRL1_CICOSR_SHIFT	GENMASK(19, 16)
-#define MICFIL_VAD0_CTRL1_INITT_SHIFT	GENMASK(12, 8)
+#define MICFIL_VAD0_CTRL1_CHSEL		GENMASK(26, 24)
+#define MICFIL_VAD0_CTRL1_CICOSR	GENMASK(19, 16)
+#define MICFIL_VAD0_CTRL1_INITT		GENMASK(12, 8)
 #define MICFIL_VAD0_CTRL1_ST10		BIT(4)
 #define MICFIL_VAD0_CTRL1_ERIE		BIT(3)
 #define MICFIL_VAD0_CTRL1_IE		BIT(2)
@@ -107,7 +107,7 @@
 
 /* MICFIL HWVAD0 Zero-Crossing Detector - REG_MICFIL_VAD0_ZCD */
 #define MICFIL_VAD0_ZCD_ZCDTH		GENMASK(25, 16)
-#define MICFIL_VAD0_ZCD_ZCDADJ_SHIFT	GENMASK(11, 8)
+#define MICFIL_VAD0_ZCD_ZCDADJ		GENMASK(11, 8)
 #define MICFIL_VAD0_ZCD_ZCDAND		BIT(4)
 #define MICFIL_VAD0_ZCD_ZCDAUT		BIT(2)
 #define MICFIL_VAD0_ZCD_ZCDEN		BIT(0)



