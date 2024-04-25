Return-Path: <stable+bounces-41475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AA8B2CFD
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24418B2C397
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD6157492;
	Thu, 25 Apr 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvcXadWh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDB156F34;
	Thu, 25 Apr 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083020; cv=none; b=UlQU5U8HgiqtqwPE1XgoisesUCndbYFNwIW79TwGnum7GtlVcFk67TgAFivTxuRONRo7XL7/qaV8Jh89CCogPMjdIYXtTtmGwCmhrJwPxMiSlpETAphvm+7EF5myBJOwZlZU1/yCLQy7VacoVfldAoWXGjgdFEZ2g/UoxBjMoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083020; c=relaxed/simple;
	bh=1SF70NTHCTRYZByoZHjPlVMIlx5+KlolbViI5fbMAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKcyaGYOsVfam9/WmGlZ0pBmuPxpDvAoh8tzcp2GFfgOSoWuh2NsgOfALrK4BzKDc1YaiXeyO1sP6nP5oqCdP/U00xYov7PeAF6pfdGV/y6OXLUrDLhS8w5fEGRa4zzVnOv+ooVuTQ4J+4KouAmZRF3z83NBVqLOvrfTs3cEq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvcXadWh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so1320671a91.2;
        Thu, 25 Apr 2024 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083018; x=1714687818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=VvcXadWhHGJEe6Sixyqlq102YV3d3uUU9nHcRYqUtLevgex3uK/LjTRKY4qMhaZQ5Z
         qZ4Qnz6B8y9wJ5WAjY6apLIXEUVFiOXz2kesv6PCs1T/TOidrSgSMOYF5quf3A+tpGW7
         bcYeWIRjdA55aZvdyMgwoDOHeUszzfEQxvhu07vN0jY1+ulT+pIxbrcHuuhuZ2dgy5fS
         qHKCFdpDLue4haZQ0rMBomphSYHIsuyCDAr4vEWkGHUsfsGMezupCIlXYa5yRm9L5P2j
         AJuBj/KRXk66ZkFrEAmsJ0NZUyvhXPBpsJThd8ZJx8O88WvfBcTwcyg60SmyJJg83Xt/
         bv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083018; x=1714687818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=sddrUfKxlszhPnVP5XQJJMWUezuG/4Zg6V6RAJ9gPnm5jbN/tBTp5n7w7Qp6Oe35Dj
         uQCqu1VjZ+QZySoPjeask8rawsPz6Tp/igNTr/Oy/K/PrKjO5/W3s0l2UcsUvo5CW/97
         0U2vNhP5AMO04zgKz/ZlYisLn9giY6BhXtJ8sLcfvzo3s2sJ8FWufh0yyMNNXD6kHn7S
         djZXZl7Q/F/yP7PesL8+SksPsUA25TXdqDrLP+HzAkbFji+qVQyCTBaGxvPH1GU5eo4u
         5wn3DvuS6NLXMFtBxCgJ5Ko5J+NNiAOvbj9pKIh2nKc9z2JG+t3oAyNuo7BO8bkto3Zx
         sT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtKJrKjnIPdEG/SWk0738aB37jHFrP8wOphcxjINfsIQbJDcOTU340UiU9CKkUBxA7eeWHNuWk2uCpx+Qbu4mu2/tc9CZO
X-Gm-Message-State: AOJu0Yykqw4ZpDjI14cj3a7/EB6epSqMf/KcbWo4oOwSibu5LKoY5Sxy
	4ZfYqOS6XW9B7tvxWv0JZB0Z5lZwASbUKJ0xhWptAhtVQfy3H2UQ2FGd6Q==
X-Google-Smtp-Source: AGHT+IHlRS1u7K5WU9f7KDrUkw7flbMGd+rwc8wHlXIIYFTOixaANHJOWKGvqQYECG7KwoklSKEODg==
X-Received: by 2002:a17:90a:bd97:b0:2ac:504f:af8b with SMTP id z23-20020a17090abd9700b002ac504faf8bmr909457pjr.36.1714083017786;
        Thu, 25 Apr 2024 15:10:17 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b002a269828bb8sm13394766pjh.40.2024.04.25.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:10:17 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 25 Apr 2024 15:10:05 -0700
Message-Id: <20240425221007.2140041-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425221007.2140041-1-opendmb@gmail.com>
References: <20240425221007.2140041-1-opendmb@gmail.com>
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
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 9ada89355747..86a4aa72b3d4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2017 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -275,6 +275,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work, unconditionally clear the
 	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
@@ -286,6 +287,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			reg |= RGMII_MODE_EN;
 	}
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
-- 
2.34.1


