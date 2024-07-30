Return-Path: <stable+bounces-63016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8B9416B4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FCC1F22CF5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0B187FF9;
	Tue, 30 Jul 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fm/qRhqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080198BE8;
	Tue, 30 Jul 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355384; cv=none; b=olpIdZRb8r3FgG0wfR8jpa8im/9WZy2Kc7FB8RfVaBDRn1WwRuQVGZxE4jNba2NC8lx9yLvuvigBY1hdpAfXz7DGSys0xOA1x+9siLfpODxTk4dRPr76KGl4vhvz+D0VwH/dTEn+7c6f7s7aVYlR51Ab7eO2FaMiZ8IvlJvyulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355384; c=relaxed/simple;
	bh=E945Uvl+ipoywxqUr+WJ/SMkvUe4e3jDMR3RJq4o+LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tacuopKuF9GOal+x7XYtAbW2g0wlfAPe1mLU3uRN+h5bfG8L2mT4w/Eqt4rsK2OuHN5xYExnC4VMaQwN1ZRghs0B3+NHGdaw0ISEUjsB9uWzk1ZMlwlrfJFP6z2Ei0P9GLxjF1u04hmwZmzQTvDr2OA1ExjuFuhgeuZB/mTHFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fm/qRhqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6060AC32782;
	Tue, 30 Jul 2024 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355383;
	bh=E945Uvl+ipoywxqUr+WJ/SMkvUe4e3jDMR3RJq4o+LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm/qRhqEUK+sOU06057mxtSATtTzK+f1GOOHSh8enHBcvu8gjKdF9YgXVUcCERwf1
	 rsPafJ7rozvPF+Ko6cqm3X5DFaPcx/HU+xuP+3mQIsd8oEwZjWBQfwMx2kUkQvrKJO
	 0sZcei8u6TxaqBMIG9bkpkKcQlHycGNnxBoPd42c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 031/809] hwmon: (ltc2991) re-order conditions to fix off by one bug
Date: Tue, 30 Jul 2024 17:38:27 +0200
Message-ID: <20240730151725.883770113@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 99bf7c2eccff82760fa23ce967cc67c8c219c6a6 ]

LTC2991_T_INT_CH_NR is 4.  The st->temp_en[] array has LTC2991_MAX_CHANNEL
(4) elements.  Thus if "channel" is equal to LTC2991_T_INT_CH_NR then we
have read one element beyond the end of the array.  Flip the conditions
around so that we check if "channel" is valid before using it as an array
index.

Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/Zoa9Y_UMY4_ROfhF@stanley.mountain
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ltc2991.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index 06750bb93c236..f74ce9c25bf71 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -225,8 +225,8 @@ static umode_t ltc2991_is_visible(const void *data,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			if (st->temp_en[channel] ||
-			    channel == LTC2991_T_INT_CH_NR)
+			if (channel == LTC2991_T_INT_CH_NR ||
+			    st->temp_en[channel])
 				return 0444;
 			break;
 		}
-- 
2.43.0




