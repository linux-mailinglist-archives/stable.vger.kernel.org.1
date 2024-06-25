Return-Path: <stable+bounces-55542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2827916416
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D49FB21719
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83914AD38;
	Tue, 25 Jun 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3sX9yTP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF414AD19;
	Tue, 25 Jun 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309209; cv=none; b=ayjG/JX1+ckZWjXay9ScjdGQe+IoRCtU1l/8mg+lwtmtJ8oWOhU2d3yNsjRrsxO+lQ1Q4uJbEA3Gl1arpDp5fk5NXfP6IStKstWdLnc1Q6TnC31v2YiribyzbFzWSlzC9EVTtepj/f11H7VQzxBMgJ7Jun6cExk+jKt6XS2RA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309209; c=relaxed/simple;
	bh=PEDcvKFkDC8eCilyQ7KZjApV4ZyRxJo1Z7GsvunmHKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkKXLLOJ9JZqm/eScpZHBuWniJ1LmNNvLXUKOpQ9zOHo3xtIuifoKS9qdPKKUXJNFmn4lufp2qUFTSgPYyFfNYo/OqsKS1QNoAG61lMlhDI8633Tm4w9J0xtX4nmYqMY6lCh5JXXunYtgLaFzfD9T0EW1FamlIvA3OeA441epZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3sX9yTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5059EC32789;
	Tue, 25 Jun 2024 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309209;
	bh=PEDcvKFkDC8eCilyQ7KZjApV4ZyRxJo1Z7GsvunmHKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3sX9yTPrXWZCw9+U33maBU8M2v++R4OT/kaXMF3mHBg7AW2FfQaFKvpfpJeRwTJK
	 fBsMqPPQFes5ZZP9LE2uK2VtzUxBb7nFNUclLjzKUyvKs/udPHmvWjD+lnJNPbGjdS
	 NmEnSqr2j4iTsVSMsb5S1Wbew/8r/iDLeWC5i1k4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Panis <jpanis@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 115/192] thermal/drivers/mediatek/lvts_thermal: Return error in case of invalid efuse data
Date: Tue, 25 Jun 2024 11:33:07 +0200
Message-ID: <20240625085541.587775376@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Panis <jpanis@baylibre.com>

[ Upstream commit 72cacd06e47d86d89b0e7179fbc9eb3a0f39cd93 ]

This patch prevents from registering thermal entries and letting the
driver misbehave if efuse data is invalid. A device is not properly
calibrated if the golden temperature is zero.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a4e56017dda3f..666f440b66631 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -700,7 +700,11 @@ static int lvts_golden_temp_init(struct device *dev, u32 *value)
 
 	gt = (*value) >> 24;
 
-	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+	/* A zero value for gt means that device has invalid efuse data */
+	if (!gt)
+		return -ENODATA;
+
+	if (gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	coeff_b = golden_temp * 500 + LVTS_COEFF_B;
-- 
2.43.0




