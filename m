Return-Path: <stable+bounces-97821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25209E266A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5149BBE59E8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2221F75B9;
	Tue,  3 Dec 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HOYT/V04"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A314A088;
	Tue,  3 Dec 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241843; cv=none; b=ggAvU72EpHv1I2G8ZK57Xq8mcu+kUW/088g7yZ0iPhtszARmAhpT6eNubq1Ki6T2p3LgQgIqa9aQO8Os61F+h9uI9vrIcrtwJ9wjLlaN7MbwEWGzBYqZv75Rr/KlJSLxji1WjXnpuAUF9FdfXA5xos3UDf8Gvkph7MXSk0Cbsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241843; c=relaxed/simple;
	bh=nyLOVgkDbbYxljtSMGz6dbag1MgXm3dcjURmpgIKP9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsQN3t3h3l5nFFs8tXhIFzBV3nXAAFhZoltWCdo8OgSLwyKAgcgB2XunfqkMKm5WJn2Rpa8+tBkBfJSrbUbBXvxwIp6gDPu9gf1sJrFoSohmcZWSjTWj+smSrN+NfkOROwaNCuxxc8ElBUJbSwYVnfDv1syKmaEdHglG1ynPT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HOYT/V04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB93BC4CECF;
	Tue,  3 Dec 2024 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241843;
	bh=nyLOVgkDbbYxljtSMGz6dbag1MgXm3dcjURmpgIKP9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOYT/V04PSF4CpVQohxcI2Jc+j1sqRNtmRVtn6Ll4mhO8KpRCyJ/9JF+xVHblGMzL
	 CGWpZB5Ab2Jno2sUD6mgfrFtrhktDvlc/EHmeuO1X+NoTYCn+ebqJWo8jQG+wmxFUy
	 OMuw+L54IGIvcBqvl4oux7BqC5SyZsc3dQw4UQtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@maxima.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 533/826] hwmon: (tps23861) Fix reporting of negative temperatures
Date: Tue,  3 Dec 2024 15:44:20 +0100
Message-ID: <20241203144804.546001191@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@maxima.ru>

[ Upstream commit de2bf507fabba9c0c678cf5ed54beb546f5ca29a ]

Negative temperatures are reported as large positive temperatures
due to missing sign extension from unsigned int to long. Cast unsigned
raw register values to signed before performing the calculations
to fix the problem.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
Message-ID: <20241121173604.2021-1-m.masimov@maxima.ru>
[groeck: Updated subject and description]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tps23861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index dfcfb09d9f3cd..80fb03f30c302 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -132,7 +132,7 @@ static int tps23861_read_temp(struct tps23861_data *data, long *val)
 	if (err < 0)
 		return err;
 
-	*val = (regval * TEMPERATURE_LSB) - 20000;
+	*val = ((long)regval * TEMPERATURE_LSB) - 20000;
 
 	return 0;
 }
-- 
2.43.0




