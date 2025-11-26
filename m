Return-Path: <stable+bounces-197021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2A3C8A1FD
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531C74E5710
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7056B81;
	Wed, 26 Nov 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJOpe7nU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A0137C52
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165716; cv=none; b=uG7o7VYdIENfic/+sEdEX3IqendHyW049tchP1hASfj0dXM4l0GCPCYqAXx7WCx8VWoJ3IMwhMELYbncm/X9OhnAVXZDmaWmEA4qAvg7RVVw4jhxV2SPdN4ZzRrqP+fQyFN6nZP4BAVS30Y4RJ2pjcovvnwQ5onfjv1g19YVjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165716; c=relaxed/simple;
	bh=/N1yQaP0StdUG0iTdpvPhiNr39u+E8m0LrixdASsDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Id0+NeYWOG+jDRV9HIyDGcwcPiEmJ0pqME86TNaJExv/jGY7hYGX2o9fxZdUj2QfPpvderJOMUO67SSrEkO3hM4DtDwcm4dXPdLe5X4gppHyMUGkyI7dQF8VU83WFq6te44iJkOf5hKQvSHRFyQAqHCwhAdxFRnlS3LzAKnpnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJOpe7nU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so64799285e9.3
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764165713; x=1764770513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWI068vPYLSXZ5RCwTG2CH0PZ4pNstxIHxCa8vD/TIk=;
        b=VJOpe7nUeWHWEFRlhUfUJeDIV9ecyW/OJFr8plx5WnorA1Z+RJnETHNJMGnuTpfJLg
         Lm702rN8m13p8XZqMM/AypQ3P76o+tKCqpc8nWJYm1EgGutuNvWVk+uuPj+o6mQc9fPx
         GeC8VlwJoc5ieDZe2XRg38plou7KKTkBXv/j/NOPSorA1uO2qASm8jHbVyWl3b+l6KFm
         rKf6kgkjkfjOWFfiU3PTQDQad6ia7Aq1KQdPLJwWAisUhQ8No6k70UsKu+pt5RgsBOjY
         dIijn2CL1sKkLwVGYzG/zb5FDPgX53ORXVpvO8fCq/qdJ5QAVluqU5CYRbd4H8E5Uzq3
         eurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764165713; x=1764770513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWI068vPYLSXZ5RCwTG2CH0PZ4pNstxIHxCa8vD/TIk=;
        b=GL/N96xUMXpNhTUGpQgkCtb6tJNYG8Sz9iAfMLT0ecReGgnc0tezRrmg8gvmOwUC/D
         6MyE3373yaTZk9UtGNU5F41I2CgJeLvs/CB83WSGr8l8xahRe4HYV58apK07GGxuf3Nz
         e/zJQ98a3TqdCS7mEc0mVSx2RBmnZg3O0UW21cG9nf/LJbNH2DmSM6weaGZpb+FrkSPU
         Mk/1jKu2A0pnuMqGsNtWrRIXzYgptw0QUFRSDFxQq7D+COG2Y4C80nrrMkVancnuCYdX
         w6RRIZsVLZ95mMjM3S1i188sUvDiWWp6k/jVaIVEs+QM2E/fsNfZCWzvfT8qyqHUPUNn
         9YfA==
X-Forwarded-Encrypted: i=1; AJvYcCUK3zkew2FCRhl/reJupV0gxemAOoAo9cRc8BORFI1G9/t7awnhXbLOWTExpgebYr5hshYTmiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXxxC+Rx5Ey5DlkIW8vRFt1qGAeJswOLdS9nH2iVckF540iob
	f3lzM6Xils+Kjv5H0kzHZAzzTcE2pl8T8XekdWLkSdNizLSv2Ps2n+s0
X-Gm-Gg: ASbGnctivSE9R6TuJIoWVEvjqnjhwngSp1vFCuj270SSM041vWgp8AJSW4ZMwYB8XOl
	TzjwdQW0n9EmsNitLnEbSscylrWcuqUM91RPebQVyvB4QgpGaPVuWp2nhVxIJbcbPkytG9XMUtU
	murJuYtmS8FpBQXa7u3Go7znTvoJ8XKTxq3PlE2SE4WnGLS12gFfNo3v6xgXB4PExDsaVu+EFYn
	p40UWf459sZdZgWJ8P+qP5eS7RfFJBClxzOEaFoV4FXKeOiiIDrcWuxXrThu34C4rex6TZmMcpb
	gqcXKPbun6scfRR3zQyzeT6vFwlsMxHwkGdqcGWqFVdi/2tkyau9dhrka2zAq+irzW2OZGSRM6B
	MuJ5P1LHR/VuTJmELabc5Q6yHTbUQ1/frXb5C8wTMBGjSXs+ofNeLoUqW/EgG9OgIta2IWsd87o
	ZH6VH+TrZBp4stWbQpvR0RgTJkoGJqHkTF8d6ho+2M5/88/wKUxntGoVGOjsJm1UUGXuxMLHpbE
	CwhuCBu4+HV0zHoF4ODkto=
X-Google-Smtp-Source: AGHT+IFzSn+vJCoVouAYGcpvzgFcmoMn1o28RCuRXQI35098v7LfOQ48EpWiC41admPbMKt9BZI5yQ==
X-Received: by 2002:a05:600c:8b16:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-477c115dc85mr167384395e9.32.1764165712461;
        Wed, 26 Nov 2025 06:01:52 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm46720265e9.5.2025.11.26.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:01:51 -0800 (PST)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	stable@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v2] phy: fsl-imx8mq-usb: fix typec orientation switch when built as module
Date: Wed, 26 Nov 2025 15:01:33 +0100
Message-ID: <20251126140136.1202241-1-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the PHY only registers the typec orientation switch when it
is built in. If the typec driver is built as a module, the switch
registration is skipped due to the preprocessor condition, causing
orientation detection to fail.

With commit
45fe729be9a6 ("usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n")
the preprocessor condition is not needed anymore and the orientation
switch is correctly registered for both built-in and module builds.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Suggested-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
v2: Drop the preprocessor condition after a better suggestion.
    Reviewed-by Neil tag not added as patch is different
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b94f242420fc..72e8aff38b92 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -124,8 +124,6 @@ struct imx8mq_usb_phy {
 static void tca_blk_orientation_set(struct tca_blk *tca,
 				enum typec_orientation orientation);
 
-#ifdef CONFIG_TYPEC
-
 static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
 				enum typec_orientation orientation)
 {
@@ -173,18 +171,6 @@ static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
 	typec_switch_unregister(sw);
 }
 
-#else
-
-static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device *pdev,
-			struct imx8mq_usb_phy *imx_phy)
-{
-	return NULL;
-}
-
-static void tca_blk_put_typec_switch(struct typec_switch_dev *sw) {}
-
-#endif /* CONFIG_TYPEC */
-
 static void tca_blk_orientation_set(struct tca_blk *tca,
 				enum typec_orientation orientation)
 {
-- 
2.43.0


