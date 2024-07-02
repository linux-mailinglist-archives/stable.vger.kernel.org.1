Return-Path: <stable+bounces-56824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9AE92461F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEB728892D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A91BD50C;
	Tue,  2 Jul 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyDOWyUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6230863D;
	Tue,  2 Jul 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941484; cv=none; b=LhSwaO+M4z28oEqIycwhlQfmxSuOe3zEQBwmVKkJEALERuiQUCWMj8n1MKi0JH/apu6dIyH2aWuRaGe2Aug0Z2l9Kthq3ugbTtTNTblIt920DeqtBWKY/JTagT6ub0TSzxw2rNno+rVCvdPwQi9LG/PPBn1hsRg27vcyHNU8ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941484; c=relaxed/simple;
	bh=IjRn5ZBNAhMajk+lnvkZiWyLDX83Mr1n1GjiJGx05o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hriXfN/u8f2q6lukHcK973Ay1AMQLy6VhBxEeEYsKBeoy7dFNTY7uEacoeDVnvZsdugsMh6ELBlhgbW+qQSSAAcoLExNnFhVX+gyaQiBpK5QTs79qSK1FvUD/86kJhl1PV69mY65fwttKfPRvEqxsnsOrvwWT/ALE2XPcCF2Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyDOWyUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5473C116B1;
	Tue,  2 Jul 2024 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941484;
	bh=IjRn5ZBNAhMajk+lnvkZiWyLDX83Mr1n1GjiJGx05o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyDOWyUrOZUUe30QcGQwtGo0HEaoWL7lNtbMmscNv/UEdRMrqtLVRs9dka04kykt5
	 cR+wFF0Gp3l4vDGrzapu2UAorVW4Cw3yLhxtFu5l5CV/xn+By+M9smo6pxtwbDvtuK
	 A1tH1zQxxdqTKKufYWGVWR/nqvd46vXk1Eqj99Xs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 078/128] iio: chemical: bme680: Fix pressure value output
Date: Tue,  2 Jul 2024 19:04:39 +0200
Message-ID: <20240702170229.178632727@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasileios Amoiridis <vassilisamir@gmail.com>

commit ae1f7b93b52095be6776d0f34957b4f35dda44d9 upstream.

The IIO standard units are measured in kPa while the driver
is using hPa.

Apart from checking the userspace value itself, it is mentioned also
in the Bosch API [1] that the pressure value is in Pascal.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L742

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240606212313.207550-2-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/bme680_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -678,7 +678,7 @@ static int bme680_read_press(struct bme6
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 



