Return-Path: <stable+bounces-83616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960F99B925
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091DAB21376
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18813A868;
	Sun, 13 Oct 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKlRD73"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B9288B5;
	Sun, 13 Oct 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728817714; cv=none; b=aCBP+OKycCPpEY2s/UtaB1rfEhiengZwMj8s5aR9ZCaoTi1nJE97bgvurobfyTxubDn0csV8A2Ugp4V6TJLZ5ssoYLNIkgWSDzbLsGhvk/U36gS+sWwLtjnU3tikKHvh79EJDuMl/niv0SXBw7x3XOXt51bl+d3hfqnreV5u2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728817714; c=relaxed/simple;
	bh=/Ct3FGY7j5Fv5z63HvviD2bGOyouMPvYri4nmXi1OT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LIC8mp1v/2jYqET2zcJEOqMupe/jYrVCwQnIaVciXjLhsppu2eRIR1CeFQz1lCy07DWREW6dvCMYlCTaQJ96r9AfQy5OE5D0f7AqvFhVoRpE6Gx0p2UWyXSAyBgTmyliFNWWYEqHVR3vRGZnIdDoDMYqFrrJ7f95a6xTcWnB2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flKlRD73; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so36645665e9.1;
        Sun, 13 Oct 2024 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728817711; x=1729422511; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lO4MDn91uaEGvfavIYEn+tk1h5d1HCRNmemjl9PlHpI=;
        b=flKlRD73KUPoHppicgyoKDtZMTP6VbLgXQtlzepAzHiXESc+TcmVZ2SDtWYxka/qeJ
         wQvRYhXpOnNINfbAPZlyF7XZecflngEDKBa/QiYRp1z+Z/SXoAGyT7NwHz4F+gEDoH+Z
         keqTkkh4jvALmiSRf6anmpdyIYieKTkCA7DwqDkzLigUKRUlVqrrbJEnkYNVwHr/RePU
         KpqHFzoZ5q5pxDnbWwUB8blwkgpHvW1gnSSkVFho7v5a7mesGhOMnned+AF7TdcUC1v3
         hZWEUMx/jciY9jxEACrQro1fGUFCuJVEfhMtzzohDIAupDW5BRq/5VaJedYnVCzDGH3n
         l/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728817711; x=1729422511;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO4MDn91uaEGvfavIYEn+tk1h5d1HCRNmemjl9PlHpI=;
        b=J/2iiR9N+0dr9TVEVhgsu1br+Bj7GjGPb2/EskPghx9RgOTCtOP4QfJnc0WxMFJ3kt
         p5d1AadrY9Cvg0BTTT1pCPs9q1plMnDDvKyvfHWW259CFkg0AIz2d1XFhQfHt5YgvMm0
         qypYDKlcZVZve+B4Vi9W+zVvbtGD8Wddm6bMWG8DeVG19jmrN32NQGTFBBZSd9jjkIlq
         Y+0uasNVN2nBaLcQ4jDoLWnNukcUzymvEvE/WFjJs5QKzIAjXU+ESlxd7ozc2AiYfxOm
         Op14T69JjFvZBztag4ohZzPU363XngismQInrvVZ1Ui3gyCPfCcvdEr6NF59COxMZAoj
         62DA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ztDpr5JTcqed/SJJJGxvhlUorR0QZ1PacXv9EoPM2Jf0/3j+0GoSfnjjdarORYgdfvlQC0FI@vger.kernel.org, AJvYcCXS4QilpvjKIUltb/E7Kl1ZlnXQIwH30gegxmjDehKtIXqGiVjNFmc7MM+njwxdk50TGqlVxneyUlij83E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzSOc9z+7CsR+eNmCwTk2QMNKsd28yJEjODEl4EmgdpiaGTdm
	QoX9WbcibWyRFzpmYN4SdTHEKubcNeM2YRApQDz6P2lW58jDcGXr
X-Google-Smtp-Source: AGHT+IEpt28WqlOtcR7JiEHn62be6MZu+AUL/8FkJVzMqj9pgksgxOIMj1aGELxQfKwtgbaEsgCMfA==
X-Received: by 2002:a05:600c:468b:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-431255db4b1mr61558305e9.13.1728817710963;
        Sun, 13 Oct 2024 04:08:30 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-01f9-6cb5-d67b-9d29.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1f9:6cb5:d67b:9d29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9180f8sm8269238f8f.115.2024.10.13.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 04:08:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 13:08:27 +0200
Subject: [PATCH] soc: imx8m: Fix missing refcount decrement in error path
 for np
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-soc-imx8m-of_node_put-v1-1-515fdb85765d@gmail.com>
X-B4-Tracking: v=1; b=H4sIACqqC2cC/x3MQQqAIBBA0avErBtQy4iuEhFmY80iDa0IorsnL
 d/i/wcSRaYEXfFApIsTB58hywLsavxCyHM2KKFqKWSFKVjk7W43DG70YaZxPw/UqjHStmbStYD
 c7pEc3/+3H973A2Ui6V5nAAAA
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Xiaolei Wang <xiaolei.wang@windriver.com>, 
 Lucas Stach <l.stach@pengutronix.de>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728817709; l=1748;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/Ct3FGY7j5Fv5z63HvviD2bGOyouMPvYri4nmXi1OT0=;
 b=WwBORZEjEFmsgtb2S7roLxpu2+aWUj2PwcFQFtk6exJ2ohyiWfhp9Y2N14NodRpo3feqkB7wm
 fXpaRhtkZ1/AVUdxRQ7TsRMaakqSB2sVzjll/IpvPiS04nOiTyhlDI1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

An error path was introduced without including the required call to
of_node_put() to decrement the node's refcount and avoid leaking memory.
If the call to of_clk_get_by_name() for 'clk' fails, the probe returns
without decrementing the refcount.

Use the automatic cleanup facility to fix the bug and protect the code
against new error paths where the call to of_node_put() might be missing
again.

Cc: stable@vger.kernel.org
Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/imx/soc-imx8m.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index fe111bae38c8..ba8c0bdd60aa 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -99,12 +99,12 @@ static u32 __init imx8mq_soc_revision(void)
 static void __init imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	struct clk *clk;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
 		return;
 
@@ -125,7 +125,6 @@ static void __init imx8mm_soc_uid(void)
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
-	of_node_put(np);
 }
 
 static u32 __init imx8mm_soc_revision(void)

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-soc-imx8m-of_node_put-526a1c8ab540

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


