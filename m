Return-Path: <stable+bounces-51756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873C907173
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BED71F25B22
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B09A4A07;
	Thu, 13 Jun 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+arEH4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAE1EEF8;
	Thu, 13 Jun 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282221; cv=none; b=XKQPaUkV7WRewJmsiW1BtCf4WMOK9htjzWqhYN1GVWoW/JT2E+V/wx0hVa1D5+Yi1c+EXTEmQFgiXFGuN+nZfweZAgsgHUqDfrVe8dI3x8VfuLoD7Pipyn3pVvKLTwHZ6DMypbpSjJH9s4OkBpLsZTeOTpYrlRlYyYvuvIrqdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282221; c=relaxed/simple;
	bh=4aDKwESArYrT+rzHDXYtRCWjfwdKNl7re+KuaVxHu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjKMHuXO1UdxllhhrtsaANMPVgGyyYSxtg2mR5EzSPrTQK9RGQm+bFzJFyIZ4HtRLpsi0VWbY+PeD5Acf2VdHU34LQKuwVkJkYGthg4O3hsn5B3Ty9KCttmKaeQdoSZM+29VK6TDY2CJge1kXKTnQBAZ8IPiOcWBySdXpsMPU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+arEH4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D7C2BBFC;
	Thu, 13 Jun 2024 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282220;
	bh=4aDKwESArYrT+rzHDXYtRCWjfwdKNl7re+KuaVxHu9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+arEH4L+uxA1C/qNnAly0yqvV4e3ac0O+awKZvWFZk8Bj/lJZqlhfQMP26D+ZPKp
	 c9CoeFGXiql3UBUHl3KRrbw44cN/X6WZ+0RxLlCZzUqrtbUrpuNJ896w+fLEpgpQbB
	 2LAZ+ZyfwZiEZoSFWTeyQeqJEBKEW/AOY9cGfIlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 203/402] iio: pressure: dps310: support negative temperature values
Date: Thu, 13 Jun 2024 13:32:40 +0200
Message-ID: <20240613113310.066606754@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>

[ Upstream commit 9dd6b32e76ff714308964cd9ec91466a343dcb8b ]

The current implementation interprets negative values returned from
`dps310_calculate_temp` as error codes.
This has a side effect that when negative temperature values are
calculated, they are interpreted as error.

Fix this by using the return value only for error handling and passing a
pointer for the value.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Link: https://lore.kernel.org/r/20240415105030.1161770-2-thomas.haemmerle@leica-geosystems.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/dps310.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1b6b9530f1662..7fdc7a0147f0e 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -730,7 +730,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
@@ -746,7 +746,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -768,11 +770,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
-		if (rc < 0)
+		rc = dps310_calculate_temp(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.43.0




