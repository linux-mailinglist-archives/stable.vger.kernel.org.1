Return-Path: <stable+bounces-24710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33F8695EC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F811F2C122
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD313B798;
	Tue, 27 Feb 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TF8UMXzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4C13B7AB;
	Tue, 27 Feb 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042776; cv=none; b=fuQ/F9iJB8GaeawNW7pxD2RrtjE0ZJ1EkqY8eC0XmozRyaYwNVwhv5C2Uu9eoIUw/WMBQM33jMTgr90tpVIvR4TZ1D5igJh04kuBawNu4LFCcHXJK+kFM0DMLQ6gxURfQn5UzMH8v7Opd9oc+oQOnzAfz+WEH54M0bMZtf8PL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042776; c=relaxed/simple;
	bh=xVnFJZSaC7ph63TLaJSsZCQYeiYQY2xVA1NeZ/BK9vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coNde7TUZ8Y25vYdQvn4RZ3ws9oCgtjXEkI5eiWDGm/bBlNJSX5UbRDa8vYu6npq6hLrk5PKSfmGs4h4vbzkrp0sVRn9tht+kwVjMPz8CbRYW+Xeq3ijQ234dQWiC3kheHuBbdFlQLYVAMBdNT3usr5UsJ3trCOfV9KzyEQWhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TF8UMXzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD593C433F1;
	Tue, 27 Feb 2024 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042776;
	bh=xVnFJZSaC7ph63TLaJSsZCQYeiYQY2xVA1NeZ/BK9vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TF8UMXzU/uBte6eMvibHN9jWGI2CPpP1qDd33U/Aw6hbbEwGproB8aKmQHXJfbOhf
	 UgbR/S5cP/xpVpfPK3QvcKi3si66HTgyApTBPPw3MAyGiaKVTJEiHnNjHeoQ0wFddR
	 Z2LrmBHFAFEV8AjHlNweGjFh1its0D/aZj1xw1Ok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/245] clk: imx: avoid memory leak
Date: Tue, 27 Feb 2024 14:25:04 +0100
Message-ID: <20240227131619.002730554@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit f4419db4086e8c31821da14140e81498516a3c75 ]

In case imx_register_uart_clocks return early, the imx_uart_clocks
memory will be no freed. So execute kfree always to avoid memory leak.

Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230104110032.1220721-2-peng.fan@oss.nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 7cc669934253a..d4cf0c7045ab2 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -201,9 +201,10 @@ static int __init imx_clk_disable_uart(void)
 			clk_disable_unprepare(imx_uart_clocks[i]);
 			clk_put(imx_uart_clocks[i]);
 		}
-		kfree(imx_uart_clocks);
 	}
 
+	kfree(imx_uart_clocks);
+
 	return 0;
 }
 late_initcall_sync(imx_clk_disable_uart);
-- 
2.43.0




