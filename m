Return-Path: <stable+bounces-148323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E0AC95F0
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 21:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3414A5D6E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BD278751;
	Fri, 30 May 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M06mhSDs"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6A27781E
	for <stable@vger.kernel.org>; Fri, 30 May 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632182; cv=none; b=fzflIZi8HgKWLQO4qz/6MW9c6o2fkeUBm46ZMh50EYZMUlxQKponVmn9dCVGNZ6Y/zJqwcMXoRYI9PY47+fTi8B/sxyexPVz2i6LA9FyvP5oSx66b6LjnlwPvNrPv0300fp7cBTizMc9H1vnZZYzRAOwJBogj7e4nds9ztBz+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632182; c=relaxed/simple;
	bh=mmKuVFxj8oqDXK1GzynYJ/mE/RkhpPA1TeCN5uhdhNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t61FhP+UDBtW0NGAl+AqpIjQgCanOrALx53Z3ioQ0jDVWNGPW07udS8q+PjhUC539+r+PbnboPRQtDcxMNLKeO8p66flalmlQdShztLJ/CiCFaAKtoAx0bu/VLr/42ruWAJHH0yvrQIxn3Y+F+SN8AqlZ1+5NQpq/A4LI85eFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M06mhSDs; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4067bab37a1so798036b6e.1
        for <stable@vger.kernel.org>; Fri, 30 May 2025 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748632178; x=1749236978; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKywJqFiyg7r14emOGTrcjfC7+0Rn2Ebhf4hG1BR+LI=;
        b=M06mhSDs1u6Wk4AtDncjwKAN4ycLMJxoiehKzD6mW0rSwplXdoAAs206daNahwAEEj
         1t618zdrAzk4dXPnRCK1nX6HvABI/aM2DMIsFH5IKKppFrERMg1xMDhoDZfaSm5WgHJZ
         PnAQ9VZ5KIKaj/5lqvJ8+yGNYMazHH18LnWr4FXYjHol98RiF2wVWEGzA+F3WdXd6FSW
         vosPw6gqVNGSYBIOPbWM0SfMSg62Rrh0sewxl3DHWVCtKl462+NNksQpOfoAii4hdXKK
         hkwh3AgASls9rNaV64qHlWXy9H76iN/5XZsCTm5zQJF0gOpvk/ISGc8RSnF5BvT1N2T9
         Naew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748632178; x=1749236978;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKywJqFiyg7r14emOGTrcjfC7+0Rn2Ebhf4hG1BR+LI=;
        b=eqdaSM9fljYqmiP+Ic5+1+Sg+UsYvbUB4Tg0Cn9+X/woZ4Eh3DpQKGjdYlRrs+BwiU
         fbc+UB90wdDmH3FOvM/OrJAMSVePAYHaUjJiuD8+/Npfi2/b01ZwkSrZOVtbMDZrk6gB
         jzuFl5rZ6bmkS1axkd29mPhYYHFhrkSmyu52SVIgaZLiw8PULQFuAfhLGwk9asrx9H/e
         7QUZdMRQ3iqstkgxJGSQMwj+ZzGedN3KAoIac3CFNSINboOunoONo/l3fHUuLZ++3OCV
         Cc3oUrWbAtMAR/zUWbf6q/MtOQjMrpXvN6DujtCHJwNkt3tEFSwcyWgL5st2E6Za4/3U
         0tSg==
X-Forwarded-Encrypted: i=1; AJvYcCXvUUEazEHYeNnoZr+4xVrhX6Op1DCcDlVUKj0aV9ss+McbuQW+BpbhJ1NeCDb/P5rmm3QZLsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSp+Z/RKAqJv3IdA+4thzuD+gcwQWIaCoDv2YRCdojoxxZiheo
	pFIwJJDufzbb7E3rAYSzdunPyXmw7eXIO6Pt+FuY4SM1el2GH8bRJbYyGsJrk8yf/80=
X-Gm-Gg: ASbGncutHt172VDdMwfxufOfjONlZu8VhryFl2SIbFcjQZUSLqLLyDpqtkSly1LVY9f
	cEfmcbbu5+vtXwgfjZswQQCGd6b+G8Gvog+j6EybuRRhwZs3eYrC6MzmYpSwxg/FM/Eak/KeVXY
	tf4UihVHUygfWAWolw0vJwhFDcBOiWv0f4fKEdBsdSFL1qmTjG+EDMS5u6/01lz7NNIBzuzKoHA
	IRDQfDyWRLU6YNU7qjNipxAvL9yTMaKQlIFqlzLOvgIRjYrVqUS7+43WLfj67pFLEEaoXF8sh1a
	BAGPA2SXsR0VpedTy2mzEHztCHy4lILJVgMHKCHqGSNuSFYra81YhnC1Gg==
X-Google-Smtp-Source: AGHT+IG2eOOSL4CmrMiEEHmGHU6etf8ecnV/PntypowdZ73FJy+NqJszGddVLgOSimMPTDEpqX0ZMQ==
X-Received: by 2002:a05:6808:2e45:b0:406:59f3:7389 with SMTP id 5614622812f47-40679674013mr2897329b6e.7.1748632178153;
        Fri, 30 May 2025 12:09:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40678ce830fsm487852b6e.31.2025.05.30.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 12:09:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 30 May 2025 14:09:29 -0500
Subject: [PATCH] iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v1-1-ce8f7cb4d663@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGgCOmgC/x2NwQqDQBBDf0Xm3IHpymrpr5QiO+6ouWjZpUUQ/
 72Dh5A8CMlB1Qqs0rM5qNgPFdvqcL81NC5pnY2RnSlIiBJbYWDjlEcXOO248oTdve+kG/Rbh2K
 zK2WegqpGabM+lHzxU8yr19vrfZ5/X1JdtX0AAAA=
X-Change-ID: 20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-f2bbb503db8b
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Guillaume Stols <gstols@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=mmKuVFxj8oqDXK1GzynYJ/mE/RkhpPA1TeCN5uhdhNs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoOgJq82QL1VEg0ESXWFXdFQRxKkobZRI4WmDxS
 9bg005lQqSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaDoCagAKCRDCzCAB/wGP
 wNtHB/4+wOAZwxHF6O8cFex05SJkEQ5yszuH2MFbRbYJYjEoSUEQNVWlW7h7gCEoL5rcZbN4oAR
 5SU+nGOwVbg3EENkYXEcIaPMpN7Q3rSs1Ml/sNJhgv/OSL7PeMfmDKPZ6FD+tp8ZdkBa3zFXh+t
 ejbjrepIm/nDIa50mbMBuwr3Mgtj+bapx0hFCZRumu9AZy04swCIMoIJ6BiAQWPaukqj0ZKejjf
 bG2zOvNp/qSkXHnRVaaThgX/LQGkdIQDx7zLyzz/5YXNGOkWRJRj8Wx5LimnNyT66z7Z/N1n4Z2
 GXORO5nt2YpWth/6QkJxrOmfsMAcPuxDCpnTv6x625yeyBiW
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Mask the value read before returning it. The value read over the
parallel bus via the AXI ADC IP block contains both the address and
the data, but callers expect val to only contain the data.

Cc: stable@vger.kernel.org
Fixes: 79c47485e438 ("iio: adc: adi-axi-adc: add support for AD7606 register writing")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/adi-axi-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index cf942c043457ccea49207c3900153ee371b3774f..d4759a98b4062bc25ea088e3868806e82db03e8d 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -457,6 +457,9 @@ static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
 	axi_adc_raw_write(back, addr);
 	axi_adc_raw_read(back, val);
 
+	/* Register value is 8 bits. Remove address bits. */
+	*val &= 0xFF;
+
 	/* Write 0x0 on the bus to get back to ADC mode */
 	axi_adc_raw_write(back, 0);
 

---
base-commit: 7cdfbc0113d087348b8e65dd79276d0f57b89a10
change-id: 20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-f2bbb503db8b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


