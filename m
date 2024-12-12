Return-Path: <stable+bounces-103764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F79EF998
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9A4189471A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CF22C351;
	Thu, 12 Dec 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dEryqCFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B407223C47;
	Thu, 12 Dec 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025535; cv=none; b=CTpcK/zOhTnIUmZUWMYAoRU+C37GKWLNg9Y/hMNvSpNSWf/RIiQ5sIVqu9mK045bm2BcaFmOdp3whnxz05S55AIhkmo+p37bCZ+io8tUxe+hw29pIAiODulBXLkDVi8yrS3lNgYuyn2jYL38G9v0F210YUt2jLEos89EqmHeyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025535; c=relaxed/simple;
	bh=vXY9ep+2jddOKEQ9wkwNCapNockKP0C4AhW2f005goo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFqXsrxVku7V8twicygiWoLWr0gD90Fp51KxEjGBMTnUhXuH/emiGuPyVIHQ1URvFB5WSDHQ4uRcvpI2++l1Ck13Cdn6ADGATVs7LaF4ZGRw5qbHlo9ZWnEVQYN3lEVWAY6DbAGwAZDdPemqRQSVeeCyOYXp/HqwkzlF5W9XAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dEryqCFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E9C4CECE;
	Thu, 12 Dec 2024 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025535;
	bh=vXY9ep+2jddOKEQ9wkwNCapNockKP0C4AhW2f005goo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEryqCFgwk+nqiYZjvoJtzzyD8XXvE+JAqIeTES6iATBOfgOPSlfU3Z7zJp4nrBwC
	 WgTSp/GV4T6MIExsDDGeVDrG+dlZiETlM2VS6QabqmztDejLfhnew2Hz6K8kmZR/Q2
	 9lAgW2KWh6NIOGqKqZ+1cwTFY+ohXjJMnfvwI6F4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 201/321] ASoC: fsl_micfil: fix the naming style for mask definition
Date: Thu, 12 Dec 2024 16:01:59 +0100
Message-ID: <20241212144237.919771615@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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



