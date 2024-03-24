Return-Path: <stable+bounces-30425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A9888B31
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6721C27DED
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245AC1870C5;
	Sun, 24 Mar 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUn1P19X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9A232100;
	Sun, 24 Mar 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322255; cv=none; b=tejRvNNPMAWxAPqtftH3Ei+5U2zqFI87apcTY/TmjPvCJxDyqBqneeKgLkLJjw+qEgQatATW1jp3feWVgJbpJkE8NmbweuHQ9In1KtrWavWt78/IpT2fWdDNjs7egSMMA1mfRwL9wqLK2igN8k8arlWWwXOrogLoRvBqC96Jwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322255; c=relaxed/simple;
	bh=DS5lot1vYCmQzRCygYpF7aAEvwtMwRa6NZjimRwr/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAu547nKFa1OhDF/dub9crwgC8itEurhCgzcwyaU6lMSid+xHM5LcO5fcLLH6+l3Rwvka8/AXi51v8re6Zv3q4s5JdsEEU1CCVIImYFBHDAgpuu9a06xkV3AX1ieyZQCtTftQPS+/fnFXE8lmTcE5GMMzWZ/q6HS5lqxWVbHdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUn1P19X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEB0C433F1;
	Sun, 24 Mar 2024 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322254;
	bh=DS5lot1vYCmQzRCygYpF7aAEvwtMwRa6NZjimRwr/5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUn1P19X7ZLmLxS7WCVfvPPMxhjurH21ntekoZgl51KMwjHSzcHQaRjZPqaKNt4SF
	 XlcdwdIjsSa38VPrpOGxXB9UTrl+HVhO2KFOFx2WzJwBQG0DlXXEinMMQAannD5hY6
	 frkbYwiwuTn5a9s3jsKBo7iYwSz6B0LAxcgq9IdrxEsaLG8Ia+LmNKndg7HnIaOlfR
	 YOdHkvVyOTUaXothcPaANJzX9qr1xq6YxG6fHps5pMxDLFcEKjLSsSeBU3c7Zc0jz/
	 WViJZac5QKYMOLWLe+lN3IFdCZW057oMp/phsKHU7lvGOgTkzXGDwUR0AH6mWxmE08
	 WoWYhFjoYcj3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 336/451] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 19:10:12 -0400
Message-ID: <20240324231207.1351418-337-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit 6969d0a2ba1adc9ba6a49b9805f24080896c255c ]

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mutex before destroying.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20231214173614.2820929-2-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 0b52fc9097c6e..3c05958578a1c 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -397,6 +397,7 @@ static int aw2013_probe(struct i2c_client *client)
 	regulator_disable(chip->vcc_regulator);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.43.0


