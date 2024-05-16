Return-Path: <stable+bounces-45343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A328C7E73
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD4D28311B
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD05158215;
	Thu, 16 May 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHhCGqr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CE1A2C39
	for <stable@vger.kernel.org>; Thu, 16 May 2024 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897160; cv=none; b=UuBJRqed4t9TUyBQP+4daxF1qGUjbg4PeKVN10fScB3PCjie4Xp+oYkVe4DKenF8/uB4W6gUnq95A5nQql2ZV3qmbBvc/t/JWL+ysDM2L/7NfRxltWKUyfyZGvwdmz3AmCtgQHIKFR5GxaF6J2kRNem5Fv/1KSe+qDBr9PGkAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897160; c=relaxed/simple;
	bh=A/dF6Zj601h278iszBYfUCXZE7Ll8Vm/iuOnsW+mMUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNm8G3sfaWzAD10btGxaYJWK5/kqt0FStDkumDgGYZWpOKlQ0e7L67gUVMN/plGmMAh/+XbxkfdEMwuIxsCGU6HvYGnGFBMyjMcFsmf/WWFfa2gKxlH8r1Ri7qaRqVu8otlddAhKtUKcmuu+6uavOMJdNxrO6PBxs0rQwAZUwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHhCGqr4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee42b97b32so204905ad.2
        for <stable@vger.kernel.org>; Thu, 16 May 2024 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715897158; x=1716501958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SviDAAxWsbQRIkyQ8f0ENMGHBO/U2Iq+f6467A0cKPE=;
        b=lHhCGqr43VWdmKGbY7q4q3iQXtbFTHw7SS89U3zevcQ7VH8JRimfcBJiTz2FeyTFgC
         8QXObJ/nfCX6J4Ew8ERlFKGQzkfwlPzl1JwMQt7us93xT5bC1a+9ra0r6xtBjhd6q46k
         RM31gELy1zN1JpuciXG3b7yoGdhUHkggRcVILXEvZCaCxxPeuDd+NW15eMjDIbqdfR6A
         PH8vHEalpXOq2fzJMSbP2OUWx5uyFfkeHeC1wT1fHcmLynhB2fBRZUMKp7BwS+w7783N
         aBZPeqPn8qgv97UIOan88M3SUFofVBaLLSEwcrSFkG+0x8tLLYlC8YoDjMc+4JB+uCAW
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715897158; x=1716501958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SviDAAxWsbQRIkyQ8f0ENMGHBO/U2Iq+f6467A0cKPE=;
        b=wCWn3HFPgf1CfblRS9KbIK2kUGd2tT7wmIcTSNvDA3Gm/dRbMk3gjvk5FPdP+rEakB
         0VCTKUdsecrrkKYVIziZ7LisNgDZlXIce8X9hRBbWsvLEn1C1IPwtHnPd5rfQZUUF39R
         o8RWL0kuIaMxRDGMxB19D01u0DcKQV8wgDs4zElYEHhb5PkvTKE7LZFd3wU8kiWq7MEt
         dUn3W4Q3GiK2D/eVE7hRQhA3BIjE8ixmqWeAo/ZmIELC3YYfFSSFFNgkgWx6XAFh4RnT
         WSdHjVOETvVZ/S0RRlsod+/lHb8hs0mJeXwLLiKrULBvYfWISh9UO+j91M/FvMQQ5QPH
         9ztA==
X-Gm-Message-State: AOJu0YysZMyVKOGarCt9EMc/8C3C2N2iBLzWTd8J4hAJEanj+JGK8jvV
	JpsL4j9rF2++DGTj4Sun4bZc8Xovc8J23z1irXQn0ofTJysAAYjOxuLbcg==
X-Google-Smtp-Source: AGHT+IFhSgMScNO7Z9msAnreh9gO0UyNJmd1XO4Acuo1Wb+5zb0oN1UEZMesHXXnQLDcQb6iOSlXww==
X-Received: by 2002:a17:902:f684:b0:1e3:c9f6:c4b with SMTP id d9443c01a7336-1ef43c0fd23mr248358935ad.10.1715897158130;
        Thu, 16 May 2024 15:05:58 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13692asm144368295ad.252.2024.05.16.15.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:05:57 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 16 May 2024 15:05:33 -0700
Message-Id: <20240516220533.450811-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024051343-casket-astride-c192@gregkh>
References: <2024051343-casket-astride-c192@gregkh>
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
index 51f6c94e919e..6d823c107476 100644
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


