Return-Path: <stable+bounces-147252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005DAC56E2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E35A4A67BE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D727FD64;
	Tue, 27 May 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yW1Eibxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1F26F449;
	Tue, 27 May 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366762; cv=none; b=KNNiXxI9G8d1UIH5lwtYONFbawO9QF45Oqw+UlxRBD7NRIdUo1S2AYmXtf97RwytYeOWX1csAeVU8EMi2mY6DbAYGmSfGKGXt2Dnp6dSdfO4eRrRwiTdtoR56cq3njXOFbcyduXCq1NcOjB1pOXK+znX7Jd/+r1jsnHcOOHch+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366762; c=relaxed/simple;
	bh=SiSs4sHYfPM9D5P/wpsBl0N6LcI8Y/Xj80mBEnXSsqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUIgMM89/RjBywTozWDnILrJEyRNWHjMJr0i3lNdHzRKgmtnxD1NyGtFJIBd9U6HsDoiDXYtWwfiqLP+KC3UfW2dP+ByyYWf5iGz4ZcKOwTOEf6EPMm16fhg1mJ0tjzatv6JhJjD4TNA0mkj2ClDe+emgUT748/wKS69NTL85u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yW1Eibxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0145FC4CEE9;
	Tue, 27 May 2025 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366762;
	bh=SiSs4sHYfPM9D5P/wpsBl0N6LcI8Y/Xj80mBEnXSsqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yW1Eibxj8Ob3WRvRGRPXy3emDWXZYrTZeso42Lsi/JtnYiCVwatpsWrayXvfBulD+
	 Fzv/QHp42Zw7U8E0/Vy1XI/5LEvsKMXHHbvtrkEar7RARB0GllzwD1MVpRAhSPpTFu
	 TfraztFYI1789mK1s/f7oER50PzNMbalbQcRkJ8U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 171/783] spi: spi-mux: Fix coverity issue, unchecked return value
Date: Tue, 27 May 2025 18:19:28 +0200
Message-ID: <20250527162520.130565928@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Perez Gonzalez <sperezglz@gmail.com>

[ Upstream commit 5a5fc308418aca275a898d638bc38c093d101855 ]

The return value of spi_setup() is not captured within
spi_mux_select() and it is assumed to be always success.

CID: 1638374

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Link: https://patch.msgid.link/20250316054651.13242-1-sperezglz@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index c02c4204442f5..0eb35c4e3987e 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,9 +68,7 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	spi_setup(priv->spi);
-
-	return 0;
+	return spi_setup(priv->spi);
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.39.5




