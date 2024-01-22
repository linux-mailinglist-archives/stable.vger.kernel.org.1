Return-Path: <stable+bounces-13642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CA837D39
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F892920F2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA347A53;
	Tue, 23 Jan 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUSvTEkd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A223DB;
	Tue, 23 Jan 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969850; cv=none; b=SHyuEuwPc207RubtfVB25/pGu9Dn6o0+tDuPbPZNQmspmKS5TrWjdD2y/EpVh8q5moQoVACHSpuNkbDSLaP1NEnutSt9Mk7Mo6+reCKLX/GRA+kLT4tNB9pJYxmKgYXvM9TpiSkLD8uG5SXuPheQ0H8/gJq261VLkySb+64aj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969850; c=relaxed/simple;
	bh=POcDwr0ZC+5Tus/tHxZb7l1PdVXit0IEuan//9IsNxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjLf27syo6nZ0sS3qH9yrpF8bk9HLT8S+i/z11PVPCtgmJW7VYwCpppovR+bEOyZBVIBUSIHv4pnC/CFQOLAvxYWe3Rz0CRHgCcOCkhy1ZsY7NOg9UpitHu9c6PmJj1ZgY2SY+srh1WXYQlk4tcuFO+aFlcqtePOxhA2bwZBiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUSvTEkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B380C43390;
	Tue, 23 Jan 2024 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969849;
	bh=POcDwr0ZC+5Tus/tHxZb7l1PdVXit0IEuan//9IsNxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUSvTEkdy100mL3NppGnAn9MOFRkxcPJ4uVOMBE4rTjL3sDZv/nJ68rhnvhlzcWEo
	 +f1Ru5WOsBBugtHHHbJDvzucOqaFw+ufZMuxs2miCaI+mDg1h+tahARmn+5A2eoFL+
	 r6KLw2BQ/60BGn5UUOtlhH3BUX1uimn17nXoDtpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dang Huynh <danct12@riseup.net>,
	Nikita Travkin <nikita@trvn.ru>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 486/641] leds: aw2013: Select missing dependency REGMAP_I2C
Date: Mon, 22 Jan 2024 15:56:30 -0800
Message-ID: <20240122235833.293945364@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dang Huynh <danct12@riseup.net>

[ Upstream commit 75469bb0537ad2ab0fc1fb6e534a79cfc03f3b3f ]

The AW2013 driver uses devm_regmap_init_i2c, so REGMAP_I2C needs to
be selected.

Otherwise build process may fail with:
  ld: drivers/leds/leds-aw2013.o: in function `aw2013_probe':
    leds-aw2013.c:345: undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Dang Huynh <danct12@riseup.net>
Acked-by: Nikita Travkin <nikita@trvn.ru>
Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Link: https://lore.kernel.org/r/20231103114203.1108922-1-danct12@riseup.net
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6292fddcc55c..a3a9ac5b5338 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -110,6 +110,7 @@ config LEDS_AW200XX
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
+	select REGMAP_I2C
 	help
 	  This option enables support for the AW2013 3-channel
 	  LED driver.
-- 
2.43.0




