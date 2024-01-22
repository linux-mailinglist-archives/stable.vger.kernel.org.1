Return-Path: <stable+bounces-14413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D98380D4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385D71F2A0D4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269113473F;
	Tue, 23 Jan 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qib9CSSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099813473B;
	Tue, 23 Jan 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971915; cv=none; b=WA4xZuHDTO2SfgIo434sBPfXtrDfaIwWt3+KpE98GzWrivVXgYd8eGWItP7hP70IMOBaKFHH7mbAa/MeZKyvIQK4cIbmaR4hloizSM75Cxh0ixz1yj0173kpxvGya9VeUZjvUYVUzW5cEWlnlgD+15DjxoGnosVTt8fVfR+PTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971915; c=relaxed/simple;
	bh=xr2N/XGqr0cfE8i3ReC/Q2yvlmK+uZjQCpH5lTHVl0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+gH5msGWY70MnVtHAG1pdoFkRvE7jzMgOepykNmEvnDS2Ub38aZb1TDkpRgkzQBSL7uqfHmeZWXuoVzOy3ORUMG8IqO0oTJApYhhZfTM/QoJ8y5PUsHWtKlwt+3uzW2YnnwLdGBZ66DR3tIIezQuVul4kVERZ/KqvDGtlbDdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qib9CSSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210BFC433C7;
	Tue, 23 Jan 2024 01:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971915;
	bh=xr2N/XGqr0cfE8i3ReC/Q2yvlmK+uZjQCpH5lTHVl0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qib9CSSDB/5MzHkqnI8mxcG5T1rM8YGwULe5f55Bea+5Tdn4x/iKXj3AVWemFTH9T
	 3/8m+f86naRrM8D9+cFeiwVMqw70V4dBTm6d/DNrsuu8MF22eXtCzBxzJVx1vU4ks4
	 QTziPanQOcUijmDATyit/FfMe1AgnHDhphj/Wdgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 262/286] serial: imx: Correct clock error message in function probe()
Date: Mon, 22 Jan 2024 15:59:28 -0800
Message-ID: <20240122235742.128788302@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

[ Upstream commit 3e189470cad27d41a3a9dc02649f965b7ed1c90f ]

Correct the clock error message by changing the clock name.

Fixes: 1e512d45332b ("serial: imx: add error messages when .probe fails")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231224093209.2612-1-cniedermaier@dh-electronics.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8bb7d5b5de9d..6e49928bb864 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2346,7 +2346,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* For register access, we only need to enable the ipg clock. */
 	ret = clk_prepare_enable(sport->clk_ipg);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable per clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0




