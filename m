Return-Path: <stable+bounces-139735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E746DAA9C5D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD6D7AA52D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A3264A6D;
	Mon,  5 May 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bxj4lsxj"
X-Original-To: stable@vger.kernel.org
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E5140E30
	for <stable@vger.kernel.org>; Mon,  5 May 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472820; cv=none; b=M/kJx3TbrUGdaDbKBDJRlZhn0i4cq9LDSHHEm4r4uWdZJnlXIb1nQw1OoYH2zy+UTqjSJeKUghHr1uyidyTaBGbFISYrqNo76afbuisaxHDbWjV3wOGguOkijna5by1lgoGXZ87rYmJxQXBTiZQrioegzDVfEVKRVj4bprXRa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472820; c=relaxed/simple;
	bh=hC6crYyF77cykBd4JSHA1fPVMSH0fhlHiDFeSZQbXec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ImbltbNg2YibKlYqBbU5TETAFYXjQMVM7SxqJ8fPN5KwRUc8zkjC5kcdoBp24L0+UjkhsfrYiVM96BxNkA7r5kfBNIF9UzSzmRmwRMfTEz3WLI8SgKr5DufChVRFo+pGleBRYTVMIccTcSF08cWHmQt6jlQeF/kwxjFFotew/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bxj4lsxj; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746472814; x=1746732014;
	bh=6EsJW6Qm/StXGBZEGhNHvMHoG3NUrgaJ0lB7XuysflA=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=bxj4lsxjrMBixPMqX+JIAjgpEVQIsxQ4PSk0pDTSXE+45GguO9z5zWPfr2nB6l6eR
	 9GrcAyrDBW+J/8EMhOJqo4JeBnoUd5vP8Ym+BJK8FsbMI+atQKOp8uQQ/MOaD6PYl9
	 Oa9FrQpl+LcC6WlUta+oGNTLzGJUatvb8hx9t+4arrNahMW496fR6IfoPI72DgpBWX
	 UlF9g6HYIVeKZVHdZgVsr/IfCKdSqvi2Gisv2lLtuOe2Gk/148Po4bZwBOelxcDwzL
	 MauFfTD8m6THLnSHjxBa61HVfNcT7RwJ3pjfh7xbofdaQzPo45GJ1WBAMJ2/vPYKgf
	 V+udwypJEDhpg==
X-Pm-Submission-Id: 4ZrrvX1kWvz44y
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v4 0/2] iio: accel: fxls8962af: Fix temperature readings
Date: Mon, 05 May 2025 21:20:06 +0200
Message-Id: <20250505-fxls-v4-0-a38652e21738@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYPGWgC/2XMQQ7CIBCF4as0rMUM0KHqynsYF0iHlkRbA4bUN
 L27tOmi6o5H5vtHFil4iuxUjCxQ8tH3XR7lrmC2NV1D3Nd5MwkSAUFwN9wjV1CRU7WuQSPLp89
 Azg9L5nLNu/Xx1Yf3Uk1i/v0JJMHzC0vQwkAFx+O5IdP5YW/7B5sLSW6VXJXkwEkYp9EJY7T9U
 2qrcFUqq4PFUtwcSMBvNU3TB8NILXYFAQAA
X-Change-ID: 20250501-fxls-307ef3d6d065
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Add the correct scale to get temperature in mili degree Celcius.
Add sign component to temperature scan element.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v4:
- Blindly Copy/Pasted  Andy's comment. Use the correct MILLIDEGREE_PER_DEGREE
- Link to v3: https://lore.kernel.org/r/20250505-fxls-v3-0-8c541bf0205c@geanix.com

Changes in v3:
- Dropping define infavor of inline scale value
- Added using constants from units.h
- Tweaked commit msg to make it more assertive
- Link to v2: https://lore.kernel.org/r/20250502-fxls-v2-0-e1af65f1aa6c@geanix.com

Changes in v2:
- Correct offset is applied before scaling component 
- Added sign component to temperature scan element
- Link to v1: https://lore.kernel.org/r/20250501-fxls-v1-1-f54061a07099@geanix.com

---
Sean Nyekjaer (2):
      iio: accel: fxls8962af: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature scan element sign

 drivers/iio/accel/fxls8962af-core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250501-fxls-307ef3d6d065

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


