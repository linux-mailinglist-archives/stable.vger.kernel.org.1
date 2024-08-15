Return-Path: <stable+bounces-68998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BB9534F6
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7030B2860E2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6124210FB;
	Thu, 15 Aug 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXfMttGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6B14AD0A;
	Thu, 15 Aug 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732336; cv=none; b=Xnb91fpjJL3nBemODoH5dy6efDPQ83Gmn4HYBp81STFw+oLqiSaw2eC0lbRDDqmpZHOuRnEBqb71EHTyD3lnok+f90dgoQ+TFulboyGv+ma3QFCJ5Zf37JWiRkfpsttCq1I4ygEoEDCat2q3VFoMkB4uSbRwIuFcR2Ho4PrNYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732336; c=relaxed/simple;
	bh=vpfazqaSFdSykUdO5J6PIPWRY6DziA0K6HsQal4jIKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdhAgeh9p19MHdFzPgtjV6Rjsj7WiD/RMOUdP3s+AhOYs5FGPC2YB8TIcHJAOnGJ9ZHs6pVD54lrdLggcjyGg7izVpy/st/b9tGuWlTL9oHqxBDF1eCcvXoKuu0rknRqO7NvIu/O69WhzRAgMYqJr9oKLtH3wqy72Tvt8pL3cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXfMttGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4204C32786;
	Thu, 15 Aug 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732336;
	bh=vpfazqaSFdSykUdO5J6PIPWRY6DziA0K6HsQal4jIKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXfMttGW332xyy4BG2meFxjoYTnM9kkI6uCtSzUudpuiHg5EGy5DkyHTF8zdPgP/4
	 vVlYmetD1MkViv+m0Rfpc66PoZaQK66B6beXQQBi+CdwFu4H3fU+a9xx1ThY0k+OHR
	 okmAHVx+gsTWXl5lDPHlBF1VXwWMBGbQtXzSgOdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 117/352] pinctrl: ti: ti-iodelay: Drop if block with always false condition
Date: Thu, 15 Aug 2024 15:23:03 +0200
Message-ID: <20240815131923.776806247@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 88b3f108502bc45e6ebd005702add46759f3f45a ]

ti_iodelay_remove() is only called after ti_iodelay_probe() completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so platform_get_drvdata() won't return NULL.

Simplify by removing the if block with the always false condition.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231009083856.222030-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 9b401f4a7170 ("pinctrl: ti: ti-iodelay: fix possible memory leak when pinctrl_enable() fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index cfb924228d877..60d94c1fc6a6d 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -906,9 +906,6 @@ static int ti_iodelay_remove(struct platform_device *pdev)
 {
 	struct ti_iodelay_device *iod = platform_get_drvdata(pdev);
 
-	if (!iod)
-		return 0;
-
 	if (iod->pctl)
 		pinctrl_unregister(iod->pctl);
 
-- 
2.43.0




