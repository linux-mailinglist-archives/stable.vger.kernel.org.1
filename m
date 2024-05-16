Return-Path: <stable+bounces-45348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7F8C7ED1
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 01:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D437282E3A
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FF3B78B;
	Thu, 16 May 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJxeRdtz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6A38382;
	Thu, 16 May 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900527; cv=none; b=H028+EDHbK625heQRZb1QirYdeSY9b8WcqQmoFy1Xb+kolrbjrllN02k9NyVSjCoLL9/Ov30Ni6FQK1Pzb7JHwAehyiryp2jwhrSB4/5ccqxFd2RvUB/MYsVppdkvy2jhrSAsRp8vsLcrHhgKv9314l0jWoOugytCpD1OEo5PZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900527; c=relaxed/simple;
	bh=L/r+/jSr7lZ1Um5u8jIULrtQvjAXq8IPrhDlnfrhdWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZTDLqiv4SL8mJKaLZh4hpRK2iAoApi85wa01qHCLpbcq9Hr8oH4C3DaPZC22hPUGo2/4KHWo0oOVAzUs/KhtsjS/CCTh/z3QJkAgSycrrqBRcqr8c72R5CiE6J94YZPCcslIcpBYQGjp+7/B1W96y8lsxpJpommC+OC842key4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJxeRdtz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43e4020db92so440111cf.0;
        Thu, 16 May 2024 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900524; x=1716505324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bul2ptxRqfIw2xpa+3EaGbCt68B5fdbbN1CJpCg6Z3U=;
        b=iJxeRdtzzOT1bgiBMVrHzY7s/mmq1xdOQYuZFU/55sRUGvwV82MHWMi+eVmdh2lbSg
         uDTOjTDqWwsZcQACsq0EQEovVaRe97Y9g1BUPjMJKylFzgNiTtQkcOkM8qIeebEQ328N
         bza1BwErJJUS9+WiI14BjEKswt6TJfK0QA18GL2EhMiTbM9rGuRg5Jgxm8kY/Ot5PvkI
         xJwG6hKstlVP6mSJ3d3OdJ4e/b1uYudnlWU2xJ94wgGe8j1FcDecVHKLi3VtsSYj7QRA
         C1ZhWL0smDdekRmOvOFKib5axXwkIvgTDjlvkTxRRNcEZ3SLbI5gbqD+aUUCOoivY4pY
         x10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900524; x=1716505324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bul2ptxRqfIw2xpa+3EaGbCt68B5fdbbN1CJpCg6Z3U=;
        b=dlnCzLCDOe8hb9bqq1T9CEItED1tqvmmHSdde7YEcnW9boixJOlRAzJfgwSUxvDx10
         tDpuSrsVixnLVPa99EP/McmR+yLsUudJprW2hkDDpaISj0asTXKs8PAk3pnXhSn21Hho
         BhFyeYWnUONLX/JQ2MfBi/0G4LkHqPiT0GTt/VGuTgikHITqaLE+R1ZDRrekTkYrRRph
         bnMlWC1XcuxbMgTtCF5GnroeEtNxWZXXID36Hgw/M3Llexy4HqYTGj6M+BYXsIq6ZZ8X
         O/xMdkuPlHmrWME9RtvF8hIDZ8ChP64PKYU5ajY+ATRpauMO9Sv8ko4i518SD1/wdB7Y
         mGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0dFO94YMKMYiFXEp4JEX7rHNSwsJXESfdaRdiWmCXRuSTx7K1UtsfwCYYVCE8zvn0fpJZ7caG7lRq49/rx2djOiw2EFx4/7A8tJ5VBdrzpbzzezU0eTRYQnJeCGf+dhJhO7ym
X-Gm-Message-State: AOJu0Yzr4jYoIk7W5LC1MxRJUXnRA6ngMM1TtTgAMbVpkvUXDcGFAdun
	5b0G9DhXPYm6e0DOp0AGq4HhDaTzQUMpdgfaJwVjqY5SfjlTTbCWuZxkwQ==
X-Google-Smtp-Source: AGHT+IHtwBQkDVz0O6uzqf+K7Tcs3695RC5RkoZN3QbVy3+n6sQ+v/7oaS72WpO/c+FwMd/bzl4hGA==
X-Received: by 2002:ac8:71cd:0:b0:43e:607:f4d3 with SMTP id d75a77b69052e-43e0607f638mr153120191cf.48.1715900523735;
        Thu, 16 May 2024 16:02:03 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e251233c6sm47154851cf.84.2024.05.16.16.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:02:03 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH stable 5.4 1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 16 May 2024 16:01:49 -0700
Message-Id: <20240516230151.1031190-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516230151.1031190-1-opendmb@gmail.com>
References: <20240516230151.1031190-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d85cf67a339685beae1d0aee27b7f61da95455be ]

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
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 56fad34461f7..d0b59d1f6c73 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -269,6 +269,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work
 	 */
 	if (priv->ext_phy) {
+		mutex_lock(&phydev->lock);
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg |= id_mode_dis;
 		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
@@ -276,6 +277,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		else
 			reg |= RGMII_MODE_EN;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+		mutex_unlock(&phydev->lock);
 	}
 
 	if (init)
-- 
2.34.1


