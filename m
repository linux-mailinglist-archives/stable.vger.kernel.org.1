Return-Path: <stable+bounces-14740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95E83825E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9921C24E9B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDA5B20E;
	Tue, 23 Jan 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdmIU3B/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AF5A7B8;
	Tue, 23 Jan 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974335; cv=none; b=SBFe4eJGuzPaTehQ9IXuYOuUsIiF+chrRNSqmNS3qbCiG158Y4Vn0jsdKxoECCPSQtACJ3d+yoNO+XBF6CsXDVotnzR+8o77KNMyUsjccEN+K1kwS7NgA2MaQvI5tF0Z9u3gSSV8+pIbDF4BLPhuvzyynKs2Pn/NxOJlq79+W2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974335; c=relaxed/simple;
	bh=zYeArFZBZ3bSCaMvuRu9P4VvKnEo+8DONmRGslT1YFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWIZipbCDWoyslFKL6LHrAXDGV2/ldhmdfMcxi7ZK2GBc83rUC1F9cvFLSGWWve0mtE5Lz2naf/wRoSJan+im0K7MAbKMQdvLPuFNP3P0yO7osZ8lpqB4NPkJhY/2dGWcBA+1WBRFKJjUO4uGkeZ2PUeZDmjHRjtpX6EWNKscWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdmIU3B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4690AC433C7;
	Tue, 23 Jan 2024 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974335;
	bh=zYeArFZBZ3bSCaMvuRu9P4VvKnEo+8DONmRGslT1YFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdmIU3B/o6ZH8XfwWfgi8PzutzY1hRCSObB2GCUIfCw8+vLzkrxzF5x0AhQ5VYxan
	 lULw7ohpQ3iKBsxpIxQp8lk9MIF/D+Y2rp9sohcvfHDBL2TPoaxZ0V+2e6HkuhzTyQ
	 wC3VhI3HEUh6UawoBk6I+wyTzx6pW3kFUgF5mgZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 180/374] drm/panel-elida-kd35t133: hold panel in reset for unprepare
Date: Mon, 22 Jan 2024 15:57:16 -0800
Message-ID: <20240122235750.899598763@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit 03c5b2a5f6c39fe4e090346536cf1c14ee18b61e ]

For devices like the Anbernic RG351M and RG351P the panel is wired to
an always on regulator. When the device suspends and wakes up, there
are some slight artifacts on the screen that go away over time. If
instead we hold the panel in reset status after it is unprepared,
this does not happen.

Fixes: 5b6603360c12 ("drm/panel: add panel driver for Elida KD35T133 panels")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Link: https://lore.kernel.org/r/20231117194405.1386265-3-macroalpha82@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231117194405.1386265-3-macroalpha82@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 80227617a4d6..ccb7d521f30a 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -112,6 +112,8 @@ static int kd35t133_unprepare(struct drm_panel *panel)
 		return ret;
 	}
 
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vdd);
 
-- 
2.43.0




