Return-Path: <stable+bounces-132645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF9A887C1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5623A912F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201027B517;
	Mon, 14 Apr 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDum1kyc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3634525392F
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645847; cv=none; b=J7nF6Vs7hvKKyIvVHRJMooOwWtO6silhxQxMl/zgsdCvJZINPLLWSqCW8MMH05Q4wGHcd2TcGL2Ji1hAxGoYI+XfZLkWdzj8cGS8PIzE/M2h1w+yATGgbSo9rtkuuGN+NlE8XgEt+R7oZjNd9wPVD/GL80WkxoWkdPGZk+fJktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645847; c=relaxed/simple;
	bh=Y2R2YkgMI4z5Gdq/9hMDzIFoW0ch3l2+U7PzSeN3pOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mE9MhnQkGi1r18jefQ0sZ7jQRQNLE/zMAcgRsLvF33uvSPFfXVJL+4qfWaels+VNcsbtVW9ZXxGiOgUXN4Jp1XhszMECIwPtLsaCPv6AVzVZ/DVQTfFgwqXSRxUELurD8EepsXrpMVmYjE9/VK5bxWEBWMXSVhjIWd1Vu1cH6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDum1kyc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5e39d1e0eso443520685a.1
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645845; x=1745250645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THkCE1P6uezsB9SiyYtWzI3sCDAsq5Y3PC8P0mjg8FU=;
        b=LDum1kycG41XtxVzJckQvu6fw/8VDe1fIsNXCKzLDtXONRFVwoFf2jGu6hifFZnGzh
         az49LawN67SQgy3nvTgdTYBY9BObDqpyByfNFrRo7urpq5hpdx70it7nartFgMTxHjgZ
         YOFdOUn1fokaR7W+GrQ2EvcMzDkzmKvTXYL0Ij4s+T0Jy7GmRDBYloHhquE2J44stz1K
         wRgCOt1oJZ1E8QC7BWnBJgaStlmTKDVRIxVHUaVRsBX/v3BMZwfDkwGs5B0Ek5sG84Ua
         GjUUMlYOLwHhGfzBlUG6LOUHJNfFPwP80GLeqLQiwJ+YuXQLkrM0AzN+TP655TOWLk5v
         wU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645845; x=1745250645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THkCE1P6uezsB9SiyYtWzI3sCDAsq5Y3PC8P0mjg8FU=;
        b=qlYGvuj3d5eyImUfrNSpv8GwJ9GwSI9Jb1ZSjRing7zV3rJfhjF7shc49uy3kriO6T
         5rFs50mGXBYOJREPMRFXtZDsgW05vyPaabvlZ1GzRRiEXActaAH0VqJK6mxuUp4yIP4C
         I7CXVpKPgQpupeJOgmbOR55bR548znv3Xxf19J27WBg8cJAs2yGMS++W1ZXVLMC8v14N
         PVOM08jPFuRw61X29EyUFGhWwtMnh1bxUSy9uEaMKJZfZdx1mnrUVAYX1N34uyxmMCiB
         1UVYbDBxWipJ3Kq1YhET4Zy366d51ZkWBA1lxUaKgyoUAi2nnq0rWvosVD6WHI0LnwYW
         LLSQ==
X-Gm-Message-State: AOJu0Yyvxbs8OzKD34yyXdjFLEXqrhfOiEwuMWfm7tkpkWpn8wG66j0O
	Yo6phyS5k5tq3zix+KEwg0FhCm7HLR3ZK9aiIERGc8oIPuhQpS9c
X-Gm-Gg: ASbGncu9Svi4hbCwrb6EiCXZAvv4VJifbyRbIlxajqmz29yholkclwvdu1edUxjSuhs
	w3faLWTWP/NYKuGW96AZ9VyjDWEvu6oC84e5ymPjxxCHPre4kCX6KYARsvSHfVDHhwPJtWDuYEM
	A0WGcCf+6EuslhHtWAZDfEAyCJVJgvWZ7qfYaibhp7uWlBiZKr1BoAqRGocp+jc6T9w4T6yqm2B
	msFHHNpxSpOB1FIH/hmtHRCbMOgT148ma3puSuWLk5a0BXdI91tP5tpGtBFnWqBbf0ggPd+YAlS
	1Z3UFpou/4GVwsa2GhQvYvrqogKwIr/12XUIADgfBW4jykPrkAUh8I7PtCoM5LbUI9AlfGDHfBO
	+y4z3D2J8gy2muzVJZT2Xf2thIm6qPg==
X-Google-Smtp-Source: AGHT+IFpMR5TS6sIrxDwvnpWdgRWjNXUv9PNaxg0g3wvv5dnwlccQbPrdkY0nKXi9ehGbIYT61JqmA==
X-Received: by 2002:a05:6214:2a8f:b0:6e8:9e8f:cfb with SMTP id 6a1803df08f44-6f230d8d3e2mr179510476d6.24.1744645844568;
        Mon, 14 Apr 2025 08:50:44 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de9731bcsm85519206d6.43.2025.04.14.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:50:44 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gshahrouzi@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3] iio: adc: Correct conditional logic for store mode
Date: Mon, 14 Apr 2025 11:50:42 -0400
Message-ID: <20250414155042.469737-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mode setting logic in ad7816_store_mode was reversed due to
incorrect handling of the strcmp return value. strcmp returns 0 on
match, so the `if (strcmp(buf, "full"))` block executed when the
input was not "full".

This resulted in "full" setting the mode to AD7816_PD (power-down) and
other inputs setting it to AD7816_FULL.

Fix this by checking it against 0 to correctly check for "full" and
"power-down", mapping them to AD7816_FULL and AD7816_PD respectively.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes since v3:
	- Tag stable@vger.kernel.org instead of an email CC
	- Use the correct version for patch
Changes since v2:
	- Add fixes tag that references commit that introduced the bug.
        - Replace sysfs_streq with strcmp.
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..081b17f498638 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-- 
2.43.0


