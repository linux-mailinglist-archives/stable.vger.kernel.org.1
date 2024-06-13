Return-Path: <stable+bounces-51410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F893906FD3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A41B26359
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE1145B0F;
	Thu, 13 Jun 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zbqn+Sz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1953145B10;
	Thu, 13 Jun 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281217; cv=none; b=g6OXVqEcnXITpQlJSNKjGqzaMXo6cPjUMivK3Bq77MiSzBTyoyu5z3cjwtpOQ/KPN00gxKvQdwtakIBmPv62qIoYUzXgRjYqbOVN7Ac82FpVtsrMWFm1RT0sECd5oXDgizUBsjJnrSBU6rt6c3uyFOtPTaeAFawxGmH7AkKr2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281217; c=relaxed/simple;
	bh=nqiXJ7BoNTSKZWE4Y5zeCftIbl7w7y+BDquE+eNxAas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVM7l3H9o5LhBZk6VfVMO102NVZUz1GevaE5B3UEBUqetbOef6Rlen3qvLxbuRI0k5QxxjD1ALL603eTTJAeFcmM4YIIS0vXntVZloRNVvJZfqrhlTBTQ4YyZx5+C2is0ESWKcBbShXwsnN9iTIIMpBRLmDtb4nvpOe6mvTHUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zbqn+Sz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC34C2BBFC;
	Thu, 13 Jun 2024 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281216;
	bh=nqiXJ7BoNTSKZWE4Y5zeCftIbl7w7y+BDquE+eNxAas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zbqn+Sz5Nl4FCOVUcznY5KTbh0wrJwrkQMGFQZdcouDhKCz117lrimgsRJTdcDTA6
	 l+L4xvW3CRyfQO2G7pFhHugTIK2fTyY5XlyjgoOKIWn70xDkmO3AEexkNGxzgPuqh3
	 vkH2Ea9EWKPVOYtpqHgivV3XCnq+sdjakVnodmHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 180/317] extcon: max8997: select IRQ_DOMAIN instead of depending on it
Date: Thu, 13 Jun 2024 13:33:18 +0200
Message-ID: <20240613113254.522224167@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit b1781d0a1458070d40134e4f3412ec9d70099bec ]

IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
it directly thru "make *config", so drivers should select it instead
of depending on it if they need it.
Relying on it being set for a dependency is risky.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change EXTCON_MAX8997's use of "depends on" for
IRQ_DOMAIN to "select".

Link: https://lore.kernel.org/lkml/20240213060028.9744-1-rdunlap@infradead.org/
Fixes: dca1a71e4108 ("extcon: Add support irq domain for MAX8997 muic")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aac507bff135c..09485803280ef 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -121,7 +121,8 @@ config EXTCON_MAX77843
 
 config EXTCON_MAX8997
 	tristate "Maxim MAX8997 EXTCON Support"
-	depends on MFD_MAX8997 && IRQ_DOMAIN
+	depends on MFD_MAX8997
+	select IRQ_DOMAIN
 	help
 	  If you say yes here you get support for the MUIC device of
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
-- 
2.43.0




