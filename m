Return-Path: <stable+bounces-198126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6CC9C913
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BF99343644
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6312D1F5E;
	Tue,  2 Dec 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejxh1dHb"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A282C11E3
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699226; cv=none; b=CFkKUxWuwCmnv96vK/1NnShF/wZxWrUiVXZcwPD5sEcG/E/+o+M/eEzQcUScUeizA6wtD4yrptdqoI7wmXB9rppUuDeJdGW9wacc2+Oe/TiOr+4v0pSNb6iJuI+nJ2x4+oHFHP12dwn+XbzYCDT7yOfL+vKsUREj8fyrc6cZ9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699226; c=relaxed/simple;
	bh=bdthcyLeDFW7Ku0MwoZu7F1rr9YLEfvT55xqiidmiKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjFLJc2ZxfK9H805zkfqZIH5n2rQovtAcJLzvGocbpbw0PLSs4FzBbfiR6xoZyS5B5nlY2OILvqDqDW2BWSRlaGbPQBW4fHv0+yCyDpRJFbjtcriK0J2cp6yBu7LeZZhGTxFz3z+7jth9mHekiSprhYFVB4axPaVvMjY5Rn4RW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejxh1dHb; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764699212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=viWv9NWMNAydT5kwQiEWz7g+oXce/Xi4AyaKIz18PVU=;
	b=ejxh1dHbIG7kdTsfR12Zf8ncmCgRg1JU1FgJbkPSMzVddtKQJVyI3t8iTNqJSDRe7hi4r8
	8XCM8VxDJJFjKhkaVm/e/eCFPrAKw6A3lMPZljVLhbmXHwa90+dWticbPxgePvg3JSvThB
	imgq6h2Mnw86G9tpQbqxGZbdAXKCPqE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: PAC1934: Fix clamped value in pac1934_reg_snapshot
Date: Tue,  2 Dec 2025 19:13:06 +0100
Message-ID: <20251202181307.510970-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'curr_energy' was never clamped to
PAC_193X_MIN_POWER_ACC or PAC_193X_MAX_POWER_ACC because the return
value of clamp() was not used. Fix this by assigning the clamped value
back to 'curr_energy'.

Cc: stable@vger.kernel.org
Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/iio/adc/pac1934.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 48df16509260..256488d3936b 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -665,7 +665,8 @@ static int pac1934_reg_snapshot(struct pac1934_chip_info *info,
 			/* add the power_acc field */
 			curr_energy += inc;
 
-			clamp(curr_energy, PAC_193X_MIN_POWER_ACC, PAC_193X_MAX_POWER_ACC);
+			curr_energy = clamp(curr_energy, PAC_193X_MIN_POWER_ACC,
+					    PAC_193X_MAX_POWER_ACC);
 
 			reg_data->energy_sec_acc[cnt] = curr_energy;
 		}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


