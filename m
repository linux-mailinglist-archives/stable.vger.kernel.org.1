Return-Path: <stable+bounces-84484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6299D06A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899E01F23FD1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C01ABEC9;
	Mon, 14 Oct 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKEJz50G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588826296;
	Mon, 14 Oct 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918169; cv=none; b=uFkVkGFYOFxGDax0UzLN0mWeysFPIn7n+AuS9JNoYvEFgQft0WMEg+vFccp2x10HZCkd4p+zeoYeJRm2/2PY3SI3DGo7hewOszgYgAb93d+UDgRo4JFNBezasoTd9XCo3PHbFupQ0Be5jSVAbvsdl9JoCwaZQoniX3Wf/6N2DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918169; c=relaxed/simple;
	bh=U+MDWNszFEN1gwrJRC1aA3k58PHov5ND0Dgcny5zZpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbwDCZtjnonbnJAbSWIETyE/vVtnUxbmQ38/9GuGUufdr8ssrK1We+OygVz8qNsGM6vRSMkJr+YhcmqSuCm0tmy2ETNnOXc9a6qisBXz530C2c97zQH7XjxJhI5hKELlO0Xt6auoJtPRABnGBeOII3TG10jf4mEFjt9PuSIlYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKEJz50G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B784EC4CEC3;
	Mon, 14 Oct 2024 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918169;
	bh=U+MDWNszFEN1gwrJRC1aA3k58PHov5ND0Dgcny5zZpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKEJz50GQCafab1/cHpuJV9KgTSE72tih+nEaxdPJBqa/j76qokR3Am4BZKt/CFjE
	 vjeA751lE2CtVJsS5/TS0INCENzsRxW3gNPibCHudWy53tEnwbj4/elnt/zFTcuspf
	 KHcBqE66c5zNb6WyQmQFHRxHRjRpc64BA3NVn4V4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 243/798] spi: atmel-quadspi: Undo runtime PM changes at driver exit time
Date: Mon, 14 Oct 2024 16:13:17 +0200
Message-ID: <20241014141227.463746959@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 438efb23f9581659495b85f1f6c7d5946200660c ]

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240906023956.1004440-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 1f1aee28b1f79..d96c40e7c8123 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -692,6 +692,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	clk_unprepare(aq->pclk);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
-- 
2.43.0




