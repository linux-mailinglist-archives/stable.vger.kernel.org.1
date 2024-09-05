Return-Path: <stable+bounces-73299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038D96D436
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190831C22EE1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671C192D73;
	Thu,  5 Sep 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPxr+EDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AA155730;
	Thu,  5 Sep 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529781; cv=none; b=Nv/JXFl9+IpTJimPK6EZWJ9IbMkuZ5keKshVD/vxuUmK7znaokEbomqkINaBIvWCGf6/es5J3r/EljKfVEkKcCpmU7RM3gjVdD1TsGGKw8Uuygj8qsKdTM4jqi4Qbp5p+iDNDgCeGNJXk2LRyyNygNoqUdWMPd3N7SfOyOcwOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529781; c=relaxed/simple;
	bh=zwnbHnKVCgMIeuwdSgkXdjeIE9F15vCVUnVZn/bwLj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQjbHIxLx87y+QBZdLsfrxUVEZXMafGMvstRE7KOojb2I16QCI1PSVQ7d6mXeGm5lcdqM12Hg/vqFynD8BMdLWkBQZSc3tTRveSftY3qOul2tTiJ0uQH08t31wftnk+IdY6reJWyL+80nlLyjqa4FsewZzTZvtUp3tfX+F49rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPxr+EDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABD9C4CEC3;
	Thu,  5 Sep 2024 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529781;
	bh=zwnbHnKVCgMIeuwdSgkXdjeIE9F15vCVUnVZn/bwLj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPxr+EDy3Kmshl7RyIoRgk4arPDKoKyHwy+EQ8HiL7/+mazVgFi7IB6dsZf9+5b9U
	 DZSt2UrmoQApQFZym/VGoi0YcUKLRoSrkMJZ5UTLc5gwxgeMHCdzrgViFYJjtztZXI
	 sQQi/KfbgdOaXsEkUKhozkrokBPq7mFKplEd3dwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 141/184] regmap: spi: Fix potential off-by-one when calculating reserved size
Date: Thu,  5 Sep 2024 11:40:54 +0200
Message-ID: <20240905093737.837312965@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit d4ea1d504d2701ba04412f98dc00d45a104c52ab ]

If we ever meet a hardware that uses weird register bits and padding,
we may end up in off-by-one error since x/8 + y/8 might not be equal
to (x + y)/8 in some cases.

bits    pad   x/8+y/8 (x+y)/8
4..7    0..3    0       0 // x + y from 4 up to 7
4..7    4..7    0       1 // x + y from 8 up to 11
4..7    8..11   1       1 // x + y from 12 up to 15
8..15   0..7    1       1 // x + y from 8 up to 15
8..15   8..15   2       2 // x + y from 16 up to 23

Fix this by using (x+y)/8.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://msgid.link/r/20240605205315.19132-1-andy.shevchenko@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 094cf2a2ca3c..14b1d88997cb 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -122,8 +122,7 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 			return ERR_PTR(-ENOMEM);
 
 		max_msg_size = spi_max_message_size(spi);
-		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
-				 + config->pad_bits / BITS_PER_BYTE;
+		reg_reserve_size = (config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 		if (max_size + reg_reserve_size > max_msg_size)
 			max_size -= reg_reserve_size;
 
-- 
2.43.0




