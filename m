Return-Path: <stable+bounces-130785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85280A80675
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962384A6C29
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FD269D08;
	Tue,  8 Apr 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwymMwse"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231E269CE8;
	Tue,  8 Apr 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114644; cv=none; b=a8WGSRweR16MRHDTBGwVyJc+alrO7jYCHqB39s1FQGkzJtlTurZQARj0NKZpbqAoNIDIjV4mFypQP9NcSTXuYILdLSuJdeZcBX5DogA0WhZ+CvGYxcFUZQ+YsDddurnVSfKIUKUYbsHHewwoQlOQn2h8R2Ugk+HzwtLSvVcXOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114644; c=relaxed/simple;
	bh=uW+IDr/8odRU5xLhGs9vcC1/ZXVlsp8/yIcvIpFaX3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMpe8VRY+wZw2jQOfPITHJY1h7Ts2p7n5v7zmeQz2XG3H2VYuRu6ppElcTQexTkakcALtz1leG85s989+3+rfWQaZ1n8UXeyFpd8o0bfg/u9WnR3olLYtK9PJIjhaKIzgGC4fG4CeDf46GVtL1p7hJ815M45aPFyGGiK88rBlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwymMwse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7307AC4CEEA;
	Tue,  8 Apr 2025 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114643;
	bh=uW+IDr/8odRU5xLhGs9vcC1/ZXVlsp8/yIcvIpFaX3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwymMwseyCvQXItfJAUuy378TNZmzU1ZUfRkhV7u+2CR6qosFxypRAQUdwVuR8o7U
	 E7IwNSQKMzZwBuFhdXkfUwS/yQhuafMCWmM6rWDCw68/7tmfYC06iGf6DEwkq3OfgP
	 BzpT/pY1+edcVrBsTUon1hN0An/SovwdVj606g0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Artur Weber <aweber.kernel@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 183/499] power: supply: max77693: Fix wrong conversion of charge input threshold value
Date: Tue,  8 Apr 2025 12:46:35 +0200
Message-ID: <20250408104855.741760840@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artur Weber <aweber.kernel@gmail.com>

[ Upstream commit 30cc7b0d0e9341d419eb7da15fb5c22406dbe499 ]

The charge input threshold voltage register on the MAX77693 PMIC accepts
four values: 0x0 for 4.3v, 0x1 for 4.7v, 0x2 for 4.8v and 0x3 for 4.9v.
Due to an oversight, the driver calculated the values for 4.7v and above
starting from 0x0, rather than from 0x1 ([(4700000 - 4700000) / 100000]
gives 0).

Add 1 to the calculation to ensure that 4.7v is converted to a register
value of 0x1 and that the other two voltages are converted correctly as
well.

Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250316-max77693-charger-input-threshold-fix-v1-1-2b037d0ac722@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max77693_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index cdea35c0d1de1..027d6a539b65a 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -608,7 +608,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4700000:
 	case 4800000:
 	case 4900000:
-		data = (uvolt - 4700000) / 100000;
+		data = ((uvolt - 4700000) / 100000) + 1;
 		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");
-- 
2.39.5




