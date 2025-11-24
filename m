Return-Path: <stable+bounces-196668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AEC7FB9A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0512A4E46A6
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB022FB977;
	Mon, 24 Nov 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hASAdPmG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181582F7465
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977830; cv=none; b=eek+erx3cyHAwgPEQ+PH8UHYM3H0bZA3TfWMtywJklnCh47ZH1xP5NY7Ysye6F8GcMP4l6nBDqWESQbdMQ+z+yHuI4amAMEPZ1tyuI6tuCdtzuyqFp/Td6i/XrCTDlX2YCoqZ6OFae9YGYp4dxlfaZkBWAjdYfkM1CIx0BYF3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977830; c=relaxed/simple;
	bh=LnM3LOBKv3J1a/AItxebFeDH9yPOhm+/Li8DOR8PcFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1t3f+F2gLcx+QznOhPaYz9ZfYp425MuwUeImSwm12zlZuaJJhpLxxc5mGyyUZRKVUXGMeyINmIL91eIPV1EwHUFFguxwyyIxYBoMWXKeVIWhtgmz0mm8lIp+XTLl2CvGAgRgOnYoPiInN0CTM0PLXQ9R8IyrypIqqoBpQLCZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hASAdPmG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so552769066b.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763977826; x=1764582626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DekikVpLnsKsiER1THEE6pO3XdOQLJ+lM0HCKbOyV8=;
        b=hASAdPmG1UKHb26KS+Y9bV+Ecd92T1Xh+cH/VGtpZZ+QwbSl11M+6x01NvtumSUQp4
         aXid49vnCBcsTKih2tMnl5JZJjOFczestLMYaOAZjO6qZMDIKgRWoZA1A3hKVPjui1nI
         c3kETsWa8KPL8yZEu8ZSnWxO5Gtx5nSXrNWt15yxkvCylpeIzy6lQnzehRQ7vgGRB3nN
         4ZU7BwbH1GtHdPDvUmVjHtRis0Rp0NtXMpnwiAl92graEBsIER+8uBOgpFMP799qLIRN
         AKE09iznBUErDApVoqMXV7CeWoABR/sYglWS+LCqjeW7fK0zcm9AH5rAFOQoB1xp38FR
         +zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763977826; x=1764582626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DekikVpLnsKsiER1THEE6pO3XdOQLJ+lM0HCKbOyV8=;
        b=UNhACQ2j4yoZrbHgVPo9JXO/NUmR1wVLWiH1gw81rg9rtT7vvSLXflyMKleb4eiYSU
         aYqZNyNxVZwf8bd1mcNz408+PdpEgWmQrUfF5ew/7qTJ1P1XRP1Lvld6CTADWRo0grbQ
         PEBpICLC03lHFs2L7YLbGaTVsj+YahfosK461CZv4jp/uMFVYYR85aaMHfnQeP4ja/Xc
         HZp94O60kQjwBzbasOHY/I9bxzK3gjQ+P3WlouEutg9/CaL0jZAqKKAxAgdyTpwHa2rR
         E9z7niLNmpK2KogINKLqRidR5bVJoh3UJObY4esefQld/yIMWl6P7JQYXPrg+Fhvoa+7
         tsWA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+U+ZssjEfJaseQVm1WmkdeH2lhz7AZy1Yxt1SluzRC2WkKxrxpUNYz+0vaPbbaq8XYAKZVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/6H+T8z86g8xXONm5L9XcNNDgT6i/TnomdVzxmBp7p9oOyYF
	x00rB4nn3QuDRsHF+D7tqP37YmFymYAZFZyUGvNdMC1ZIJROJzxiATaU
X-Gm-Gg: ASbGncsbjls4KVvtiOUDTfTwIhlCDeUBJRxa1WNL7zz1WsW7QTGVOuBPTvfFFVfLm24
	kR0EI0pC6KB2+HSejkps8cX/KHx8riBElJCyymn02XNE3m9oQWf57q2Nu8ms3BwmcPb8bq3vmrf
	qGr2au/7JIJUz/evOcu9xhrykU0F9Es3ua1N1eyC+P3QwFXgrNV9dUzP6c7OwgWwBtFRwYW4Mgd
	W6zuk/ZcfVTBsnG+0BG4vPqS6N7gmM50JTl8ecd08Uov9LcsIZrqZMrNnkC+hRQyLLgn98ojEwB
	jZfsXbVjSko8pw1EXNCnNKZ8zXOKYeZ5nvGLT0k+0Dx95qdRjdxdIUOIHHqDlQbanDDbpa7hxJ3
	KHki9/olu2fpMLbpMRckx7yyt0ofl11ttN4AodTGDGIoTdTdx5aLlhigGHzQM5eeIkxfLj6/Chh
	i+CTuUeMfRFaCjYgX/Db1I0lI2u29ZlHWIIxehSC+LPXrFAfkhGBsvDzlYZCidaFd3c2jwifwI/
	ZMbDCDXIY0qZ767sSPkCok=
X-Google-Smtp-Source: AGHT+IEL8+nySp0VAycSYHZn+I7GwxBVv/UyrBmMEYYVlEgpR7XzCQyUy/x/1//vDbu/fyhX+j6fpQ==
X-Received: by 2002:a17:907:7f19:b0:b73:6534:5984 with SMTP id a640c23a62f3a-b767158cd57mr999143066b.16.1763977826184;
        Mon, 24 Nov 2025 01:50:26 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5e0sm1309608566b.1.2025.11.24.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:50:25 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH v1] phy: fsl-imx8mq-usb: fix typec orientation switch when built as module
Date: Mon, 24 Nov 2025 10:50:04 +0100
Message-ID: <20251124095006.588735-1-fra.schnyder@gmail.com>
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

This patch replaces the preprocessor condition so that the orientation
switch is correctly registered for both built-in and module builds.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b94f242420fc..d498a6b7234b 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -124,7 +124,7 @@ struct imx8mq_usb_phy {
 static void tca_blk_orientation_set(struct tca_blk *tca,
 				enum typec_orientation orientation);
 
-#ifdef CONFIG_TYPEC
+#if IS_ENABLED(CONFIG_TYPEC)
 
 static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
 				enum typec_orientation orientation)
-- 
2.43.0


