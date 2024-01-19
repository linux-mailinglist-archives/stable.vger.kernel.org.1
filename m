Return-Path: <stable+bounces-12251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE183255D
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 09:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B241C23BAA
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D711D53B;
	Fri, 19 Jan 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="RQYlo/km"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E3D53E;
	Fri, 19 Jan 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651402; cv=none; b=VrVcF8wR0x+S8EuXiLH4x4GSDG71yuiY4L6iqKyB1CX+61Gd/dtsr9VrvnoxEtNbnJhYmElcv9Xpzjq7pRLcHXn+OUaQ8qS65Xr0FjS2J3Mm5HJnZgtp9uRjgGPCXZLQhXYVqT1LkCJ5Ks1LFePOwaNJ7UiM/Hahf/VOCIaCgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651402; c=relaxed/simple;
	bh=0oCwPoNsmKLIpr2t1p4Hjr8yVMRRpG92q4+h1zMfNek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwPTvwyDDvXZCj+7sV7HZeD2Vd0TXLO6zYWc9E0sLLJ+ZfvX9vkTFqvXQBKuc/KfGJCb4vvlixR4CVTohJmD2rGgj15DAMfiNh2CwZJba6NA5GL77tga81Puc7FORQV6zCFwsVOXLCjNj1VI6kf44u+P3pnq4fW7vn+8K1nhjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=RQYlo/km; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1705651387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kZ44b7hysLq9iTugi8rkv8vLiPXIxMp8DXNRpoizLSs=;
	b=RQYlo/kml3d5GyVYGKodxW+a/HfGcy9bm+WodODZtCdiYzWsXq7/2kHUFl6x1uFhZTvHP7
	ghF4lPZZUHJn0xTUBRqxWFu2QQ7XVP52iWqj46td3Cl57Jpifjswsi0Gz+KUWumhYOea9r
	qE67bsxw838VsX6Ybf6XE1IOK6tW95o=
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Date: Fri, 19 Jan 2024 11:03:07 +0300
Message-Id: <20240119080307.48944-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of an arithmetic expression period_ns * 1000 is subject
to overflow due to a failure to cast operands to a larger data
type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
Cc: <stable@vger.kernel.org> # v5.15+ 
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 V1 -> V2: Oh, good point.  It should be 1000ULL.
 drivers/comedi/drivers/ni_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
index da6826d77e60..acc914903c70 100644
--- a/drivers/comedi/drivers/ni_tio.c
+++ b/drivers/comedi/drivers/ni_tio.c
@@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
 				GI_PRESCALE_X2(counter_dev->variant) |
 				GI_PRESCALE_X8(counter_dev->variant), bits);
 	}
-	counter->clock_period_ps = period_ns * 1000;
+	counter->clock_period_ps = period_ns * 1000ULL;
 	ni_tio_set_sync_mode(counter);
 	return 0;
 }
-- 
2.25.1


