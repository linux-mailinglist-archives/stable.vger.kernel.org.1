Return-Path: <stable+bounces-45345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D626D8C7E79
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C711C21346
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 22:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC6158216;
	Thu, 16 May 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfjRF85m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4D1A2C39
	for <stable@vger.kernel.org>; Thu, 16 May 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897377; cv=none; b=pYD8WNO/TEY/wucPqa3I7YJPr8CW1iRsu05Pa8jriz5w1yNNlJggNtRYy3Nlzu8Msh/z7vWmbfUY5lvPRS2Gwlzr0na5P96QN/cABQyjbJT3BS847MI8ZpZoIuG+wWTWO+s1oB02+GLzObAaRwdv0zr2d7MET9hA45v0K28TlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897377; c=relaxed/simple;
	bh=bcpOr6Pyy4YP3hL2HHZg28CRocFIu2lMhBhB4nY9vlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoo1it/WzAPKHoOMbigtfONPdsPL65TCayvKpAo0aNwEO2cepkCaFgkWNgmMLtrxVbwhZqVat97n2LGLF7MSZDJcf/4c4Q74cYzjiNjtV8hr5NmoxLnUJ4ja6XkXz2a8fFxt8fEScZ03yWPRu/BzSPYJGRMv1mh63a0IzdFj2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfjRF85m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso671921b3a.3
        for <stable@vger.kernel.org>; Thu, 16 May 2024 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715897375; x=1716502175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2ZBbjVqBgrpqLD5UQ5jXYGY+ZTkBDFd5wMmk2FlgXQ=;
        b=lfjRF85mWWYsRFlLuRn4ua2BVeWsQp0qsHANLXh2FeLbrgE8xcu0RXizbtuiXlyUcr
         iPP03QtQXS996o1EQ/deLZASB7QyiJYfflFARVpXWOABnZrraAxrBNaRXIzN1uVk+X7l
         8o5dOV9NYeUhBAdLcA9/lukYJQPJIEwzPe8e+txaEZ1ef7RvoGBTJ9oJpO9/HnyaVxT4
         9GlkZG8oohymZinoq4iYqKnUdVtiDs158ZAQRzdroL3unh5U0fNS57hYevKT1fcoXGT/
         Sww+WAW6w3N/LUGaLHL1iW4cdnQsfoG45WTNEg+ToOF0XHnCzgsvlvPxGFXCPHI+oToO
         o32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715897375; x=1716502175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2ZBbjVqBgrpqLD5UQ5jXYGY+ZTkBDFd5wMmk2FlgXQ=;
        b=fOT0uAtoj7HJoUuH0BGM70Q+5flbCPsWmntjI2C3meJ32bocuhse6fdpjvaNG8R3Bs
         c/bcAHEEuaM65PoJeJ+QeL5ouf7VWMNVuZ+AlVg+lsx+4TC1SiJ3IaW2zebZci0mDD7g
         2sponb4PUaylobHkuxyCEaxvHSEXAQ5/Csl0DvY8Ip8T629jsrCeKtiSNMMNTQVEyom2
         pqU4Fxraspx8JjAfTRor3bDPxMW1f6FqxKVQpnN7fLBIPqQic/Bj0jAVAvoC55kVlWRW
         tA5vIjieySsGOJ4+ekBqyoIm3Pe0JxN6e4KvIH3MyEjh/E6gOXgY6D9/tUgLgfihLPGN
         I5Vw==
X-Gm-Message-State: AOJu0YytNleSRrCJAe07UTcRjDjepnn3+o9l0F4OxIQqNA75VXYL53pw
	mQc/6L6Sp1YVD4XD/tSojD6X2zffjwvaRbLO4OkRmrbNBzTZFhghkv2/Nw==
X-Google-Smtp-Source: AGHT+IHnEFypovnQnbcPWzofw8HoEE+I5e3Mf9KkswWsAOXUQkL3dWF5452D8vfuVPdA4tWb28hR2g==
X-Received: by 2002:a05:6a20:748f:b0:1ac:d96a:4fd6 with SMTP id adf61e73a8af0-1afde0d54b7mr22234389637.23.1715897375242;
        Thu, 16 May 2024 15:09:35 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a819e7sm13597309b3a.56.2024.05.16.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:09:34 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 16 May 2024 15:09:28 -0700
Message-Id: <20240516220928.458779-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024051347-buddhism-hunting-5c42@gregkh>
References: <2024051347-buddhism-hunting-5c42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EXT_RGMII_OOB_CTRL register can be written from different
contexts. It is predominantly written from the adjust_link
handler which is synchronized by the phydev->lock, but can
also be written from a different context when configuring the
mii in bcmgenet_mii_config().

The chances of contention are quite low, but it is conceivable
that adjust_link could occur during resume when WoL is enabled
so use the phydev->lock synchronizer in bcmgenet_mii_config()
to be sure.

Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit d85cf67a339685beae1d0aee27b7f61da95455be)
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index becc717aad13..7c56f76bad11 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -264,6 +264,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work
 	 */
 	if (priv->ext_phy) {
+		mutex_lock(&phydev->lock);
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~ID_MODE_DIS;
 		reg |= id_mode_dis;
@@ -272,6 +273,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		else
 			reg |= RGMII_MODE_EN;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+		mutex_unlock(&phydev->lock);
 	}
 
 	if (init)
-- 
2.34.1


