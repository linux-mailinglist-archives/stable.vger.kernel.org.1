Return-Path: <stable+bounces-183404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67252BBD4D4
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1092A3498C2
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70D25B1FC;
	Mon,  6 Oct 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8EqqQnG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4F191F84
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738036; cv=none; b=j7gAc7BJwk21WLYnpt80SLa4jQpakbAWnU/aSxyhhy4mociKDOdAJlLPaDdwjFmBV2uIpSaarMwkjS/Tfi/t6YtuNDfe9dNqYoL0/G7SoCA2Bs7Jl1VPLNEBUz3yAlsdb+6NJC+c1ZPFQSn80+y9Te3R1kSv4ctEEGafY6N9ANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738036; c=relaxed/simple;
	bh=BeDMN8uWVJklyLJj+1L2d060Z8oyIimOZuMRkiyfk5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JpGSoHdQZIdz6LDwf2D+al7YgOKpNYYUU1QfR/16Q+LfmR5Ot2I+ulNuNj9Z+nam+We5apBShL/gzDy5YrmdMdrp8vRNvvJE/IO2V++K4a8W/0H/TUuV1Du1pHrNz0kSONFYeMhtsMDA7DB0DR7l6ErzeNgJgQMLndZiRRKUWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q8EqqQnG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e44f22f15so679538566b.2
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759738033; x=1760342833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qerrj6UX/Z0xW9m5oFGqvhu+d9Lea7yfQjzYQpDbWQ=;
        b=Q8EqqQnGHw2OXBYfLaTWVJdNOT9xt3d34i4puk6Hycq+zg2cwBTRl0NK+1P01Y46cB
         BK7A7FvnHK2J6zKcovlK3DND7OZLXf3UBpGWXtc1vmu4G8y3hTjWPia1hAZBCA4WARS2
         SHHaBJStjAcM+TCVw9Qn0t3jWulHCx3rEjr173r6+lIUUdxnWtqdDguE0senQaBY+h5V
         0D6IKhlLgw864dKilPn00R9ANuIqfN58Yctn24poQ8aEdSHvJ0uGx8nLJpygmAd+wOIr
         WlwCL0PmvXuan6ef9Jxg0x9CF46ImmnyaUdTQZL2RZc/o6NkrCg1PQK+VCWm0KQgn2w0
         g6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738033; x=1760342833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qerrj6UX/Z0xW9m5oFGqvhu+d9Lea7yfQjzYQpDbWQ=;
        b=BB5qv86bsDtxhQzaUpwVAcbm2zSTMamHyONK7peXuoKUoD+o+bNbWSAO7pcDTFrxFF
         aoX73ux2byzkP6W0/EBHSzACwbfYbSMhSG4HW2lWwg902HM3n34EqcsmZeRWrnbz5b4n
         s+6SQj04X57N+shGZPOs56oUasYHgAdYgOG532MZPHoY9c/YgScwEUawa/NSgVOJyyz7
         5zHeIjhvE9pvBwV6fb3/+M7ybzCEBu3pHPPYAo2wXQP5E6V0u+Dn4EeHQuu2how0ozcc
         1Rwexjj1zI14/L7pRkW5XeSBo/cRHZPn8zkDHPJteHc/btxRTnkste9ewqwnCMzBxGjU
         DBAA==
X-Forwarded-Encrypted: i=1; AJvYcCVDe1oRi03JTGkDk0b7eIOv2LXwzZStuXpMCBpb8eFx/qosbfqDj/wRYNjNFIvIeDmjhz0CQY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWtLqPxfXXGBber0VJBnj0S9x3457H9GyBkLzcRGKpk/+zZCY
	CWpEbC+D1cV9trjYsqgf33A7axzEPyMDAkXN//XZxYFflQckVIQg7sg0Cs5sICiqhcI=
X-Gm-Gg: ASbGncuzV/AWVLHKypOO/XuRdiNqkZy/2y2KOwwJon9QfMRiD0YMTa4chX2sKqVUTsE
	WgO/vpJBk9R03DMy5pxf3H8Tj83BcpQn3HfB9ALhJZDdbpzZRsQ4j904HXurTYLtCz0STbRlRjm
	C20JSHEyD7P9yEDMkbFDJqOvP6Hym7CD/AKjBzmlrJgsWUuRNezhNX++WjP2nOicQx0aSU+Gv8Q
	J3+lnr8Biy1oV/DxSkLnS3YY9jkWB3jFinxEDO50lx3BBAKxh12/fQPvGhtgsdRvJvbAqNrFsOu
	1QhjHcnLlpJWDtVIvCbLIzP8YvwM1I4xa246/mUiYkLLiY6v2DSmvpak11bDcdSHszEnSNRIxpW
	+egAdznlyrHz95UDSS1uEXH2RD7rjHMK385VN0yjr7KB+Jgi86kMroK5MUERax9HcX4BitMy9iI
	0ODjErYIJkegoa3ZOVsNPMuKljrNpLZgTe5D8XVULH
X-Google-Smtp-Source: AGHT+IHPnvEx2+1A8spGyxDZCYqGJPXGgpZv7W3X/UPXBelvQzXyrYlDdDiI9fhuch4s1Ysd9y+b0A==
X-Received: by 2002:a17:907:86ab:b0:b47:c1d9:51c9 with SMTP id a640c23a62f3a-b49c3f7d31emr1499754266b.62.1759738033192;
        Mon, 06 Oct 2025 01:07:13 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1073772766b.71.2025.10.06.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 01:07:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 09:07:12 +0100
Subject: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK9442gC/x3MwQqDMAwA0F+RnA00Za2wXxEPbc006Ko0bCjiv
 6/s+C7vAuUirPBsLij8FZUtV1DbQJpDnhhlrAZrrCNjPE5KhvCjEff5xLQuKO8Y1pATo7ccH9x
 5Gp2DOuyFX3L893647x9CN6EgbQAAAA==
X-Change-ID: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
inverse of clk_bulk_prepare_enable() while it should have of course
used clk_bulk_disable_unprepare(). This means incorrect reference
counts to the CMU driver remain.

Update the code accordingly.

Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend with UDC bound (E850+)")
CC: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index a88ba95bdc8f539dd8d908960ee2079905688622..1c8bf80119f11e2cd2f07c829986908c150688ac 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1823,7 +1823,7 @@ static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
 		phy_drd->orientation = orientation;
 	}
 
-	clk_bulk_disable(phy_drd->drv_data->n_clks, phy_drd->clks);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


