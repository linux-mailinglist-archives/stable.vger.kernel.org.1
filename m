Return-Path: <stable+bounces-151719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D0AD0615
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EB517BE33
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4911289E1B;
	Fri,  6 Jun 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YtzRb7v5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8E28B3FA
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224711; cv=none; b=kctRnY0tlt0KrF5dUX6F0Xp4bVwDv/IRbBON4D4dduvnWQZej/SjB+Oven6O/vLRGpdshdNubQO4G/1+M08YSsETaDaAQ+X89oYctPGeAn/u+Ghr9LvjuMYd6O5ktuXn5aSn1juPYVMLz636opoalHA4jB2AX8edUv1nX8AOeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224711; c=relaxed/simple;
	bh=6Npv+iVB4mGRCGs71gegYw1wuikB/KQbuB/fwnSYyVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EYQi9ok6LzNooh+dByhle5nGogSR2E1WBFfofwTzOq7JI8Y94BWYByOyscrFTIvjRIRq3nyVSY4ukxeLanTyqnwAyD1p6b3wX76HX6iOTzR0TQkzuRU1F1LpyMGzofM8OUn1wrQuvLlEK7u/YRAApB64QGy9i0HmuBqTAxH/BmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YtzRb7v5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso2071845f8f.1
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749224706; x=1749829506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eRrKWisAlqCaTq6ESMFuJF+EV06jSu5T0YzNA5KckA=;
        b=YtzRb7v5UwSrujsV4XgJkblyWhX6ARC54W+d+3ufml/MulmA2Bg6POzpsL8RCFHuFF
         sqewyKkg7vfl3Bz677x939Iv/AjLj1Pfeczj4fZWDOQlbSSiDq1oFWOuv1Las7791T0s
         qBYa8MwYG+Hz/BTGHiWqDwg76YE2JEidXxU2jUKtcvTZ6qASqHN1P01aGKshncs++0o/
         bSKTG+hwpuOokxM0i+ywIKb0WKAbKFVnX9utWtORqfU13n1GeoF6UW+StVoG4F5MKbUM
         VSqONx8+ORyUcbrzTvxWdUwMHJZ4/IlMpHudT1yR5w+67LsDIsDq/K9MdTDHF2TcmxLw
         BReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749224706; x=1749829506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eRrKWisAlqCaTq6ESMFuJF+EV06jSu5T0YzNA5KckA=;
        b=R2upIJT/aAJ2Th3XsdOsU96lvtSupJuEHdNIu2rZm3h9MdgWZi7Vo0NZ+jYCW/VXEa
         S9B7wF8CC8ml/yO3U8lNnz31BInLHUUuQ3LxWvyVYI7+CfH5xpBnytAfuiwhrzKVukSF
         2hgbZj3nKh5giM9rw2+9aeiFwLTiP3FRzvdJTFI2wPopYHLeYcH3Ga+h66Vm4C16BsYY
         oxYsHl4KA1sMkOddWLsiB1wHF2/xzMN+X19fqMiwVfKifJQntsIneHziVfVWW+GUncK3
         lYcJ7KnuTsL+pNvfkFgTTIxaxJ7bEwTDjddQB7U3wMsxBIci4PgFSwqyavhsZzcmAKj9
         fBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXctMWcQek7sj8TCoRKf9s8AdRnsVqU4KpMHRNEYKJ1J1HDavc5cRXBSDMJ9Lomeblaxw21rZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5IGHlojYj/mLXm4ncWhrm6A5Wb//dkbwpWfMzoKE6ecdRtqS
	u/oQ6mZTFBUIq0pqfFpXnff8O5sNN6YOLbTw3GN6r0g2yCScGjm+jucJSi+6+RNfzwo=
X-Gm-Gg: ASbGncvVbXMc9WOZvPC4pYDV1rqC5PyNEoJyy0TGj4ZsloL2RJg2pQ7Hv0RR9PKTo01
	Op0wFjglfIS64MCV9R0Ny/RkWezvENhEzBViPbd+QzdsEkIiV0HbFYYDdy/fY2MiArkv5e8+D+W
	aRnDDjOlTHj9iC7vTIw48pC8o+QDwEc/tCSZP2CVbm747oY1BHiD3LpyLrCvP+FnNbwQMAN/w8i
	CnR9/NdXvHEj7w48xd/c6+9o9Hx7aUqllabjFlrweZFCydehvzh5Mwb2ZX72Jkff4fqZ1cv64Gj
	s2rq0zp6m4skSkJkPpyDwGh9ilmWcDK2KUSkjPVlvPn7Q6prVn+xN1jfaMKyXMksY9jlL9kHmuF
	JQRQzkkWfyEygJaTxdqCSgMeOoFgL
X-Google-Smtp-Source: AGHT+IHSobbn18Gj4/PsZFFRBQ+vaWtAP7bPkbsPEi8TLhuY9M5KhYA9iiVjF125RMM9+sP6S1EyOQ==
X-Received: by 2002:a05:6000:2dc5:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a53189ea71mr3332123f8f.25.1749224706539;
        Fri, 06 Jun 2025 08:45:06 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a532452d7esm2204941f8f.85.2025.06.06.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:45:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-rtc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.15.y 0/2] rtc: backport support for handling dates before 1970
Date: Fri,  6 Jun 2025 17:44:37 +0200
Message-ID: <cover.1749223334.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=6Npv+iVB4mGRCGs71gegYw1wuikB/KQbuB/fwnSYyVA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoQwzmwmVp5HefOvYACnlYS9dtXgQ/Vnf2oPuHP xftNg+zIJKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaEMM5gAKCRCPgPtYfRL+ Tmd3B/465tvD1rHAca3OOMo/hcI0O8bPhbq7yj/mzxO4GZABJQjrKrrfinj28SSfD/yQ7VTtdqf JqOIJUV2ToVRf6GAfwD8UIIt6bq69ypm0Ke69ZSfvLwNbPaCA5O3zD1ksh5UotsRDmGcf4Fgyi8 2xufPjSJbO4DXQJraUTKCYH3QbY3kB9eZ/XXgjxpizwhQPdkicov1Sh/wKVhRnHjZENutsJzPRd 18o3hpl3MS28zCz1nxZsBG4dDsCSj8iqa+ZlcNu59FjUK2OQS5XXn2CIubQzCinrlM3RbVxvwy5 BehgMswtl9+FbR7+9hn4N3rY9BUGXhad1nbwuDtam4Uku4Vo
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

as described in the commit log of the two commits the rtc-mt6397 driver
relies on these fixes as soon as it should store dates later than
2027-12-31. On one of the patches has a Fixes line, so this submission
is done to ensure that both patches are backported.

The patches sent in reply to this mail are (trivial) backports to
v6.15.1, they should get backported to the older stable kernels, too, to
(somewhat) ensure that in 2028 no surprises happen. `git am` is able to
apply the patches as is to 6.14.y, 6.12.y, 6.6.y, 6.1.y and 5.15.y.

5.10 and 5.4 need an adaption, I didn't look into that yet but can
follow up with backports for these.

The two fixes were accompanied by 3 test updates:

	46351921cbe1 ("rtc: test: Emit the seconds-since-1970 value instead of days-since-1970")
	da62b49830f8 ("rtc: test: Also test time and wday outcome of rtc_time64_to_tm()")
	ccb2dba3c19f ("rtc: test: Test date conversion for dates starting in 1900")

that cover one of the patches. Would you consider it sensible to
backport these, too?

Best regards
Uwe


Alexandre Mergnat (2):
  rtc: Make rtc_time64_to_tm() support dates before 1970
  rtc: Fix offset calculation for .start_secs < 0

 drivers/rtc/class.c |  2 +-
 drivers/rtc/lib.c   | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)


base-commit: 3ef49626da6dd67013fc2cf0a4e4c9e158bb59f7
-- 
2.47.2


