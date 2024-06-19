Return-Path: <stable+bounces-54253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8C90ED5E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388801C21F78
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B2144D3E;
	Wed, 19 Jun 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2EX9ajG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075A4315F;
	Wed, 19 Jun 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803034; cv=none; b=Ufr3l3pfu2QJXlOUkRajVPLCNI+JVxukJFN7cG1Rsnvlg624oUie6y6SsMcZq/qn0Ap8F5kaRtSEZfBrajbuC2E9Mc0tQn+vxd9GnwfrZIQSm1MQpKCpQy7xR9MLBv3eYz5J2vtntH9cY43dzGnCac+VhLE5MyPjjkCK/SXA6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803034; c=relaxed/simple;
	bh=2gT78EgSgpbPr7v3VVdEPBs1BLD4AcI6bjYpK60TSVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/40W92KmmUH6nLYUOuAt66LuT4NEytwzLiYq0SKYOc83RXkp1OwI2vAes5/s8CjIbDg6LllWwzSd4yE9tTIxpP4BnbAtXJmVVze6uqY6gIsLNaOxpDoWruNSvLYhZNbeWcp5PvOzDS4T4J/IfKLqRdPUxoDEMzM0KuJU6oVWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2EX9ajG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B379EC2BBFC;
	Wed, 19 Jun 2024 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803034;
	bh=2gT78EgSgpbPr7v3VVdEPBs1BLD4AcI6bjYpK60TSVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2EX9ajG1xmpebTWoQaTOaL5wNa4xO5l8qewEnaEe4M/W4N3tORjxkIWfav4T9aOA
	 LVcK4bxID9RqpoxHvn/wkGYpyUMGOzScm3Rg9L1XTZkUuOJTjk/8nj7zjVwjNpUDfI
	 lUFgj2rdfl13bkw3En/9J8wMMi0nWjJW/ZL3m7FI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 130/281] gpio: tqmx86: fix typo in Kconfig label
Date: Wed, 19 Jun 2024 14:54:49 +0200
Message-ID: <20240619125614.846712987@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregor Herburger <gregor.herburger@tq-group.com>

[ Upstream commit 8c219e52ca4d9a67cd6a7074e91bf29b55edc075 ]

Fix description for GPIO_TQMX86 from QTMX86 to TQMx86.

Fixes: b868db94a6a7 ("gpio: tqmx86: Add GPIO from for this IO controller")
Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/e0e38c9944ad6d281d9a662a45d289b88edc808e.1717063994.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b50d0b4708497..cbfcfefdb5da1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1549,7 +1549,7 @@ config GPIO_TPS68470
 	  are "output only" GPIOs.
 
 config GPIO_TQMX86
-	tristate "TQ-Systems QTMX86 GPIO"
+	tristate "TQ-Systems TQMx86 GPIO"
 	depends on MFD_TQMX86 || COMPILE_TEST
 	depends on HAS_IOPORT_MAP
 	select GPIOLIB_IRQCHIP
-- 
2.43.0




