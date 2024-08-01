Return-Path: <stable+bounces-64992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F24943D54
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009871C216C3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416261A4866;
	Thu,  1 Aug 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx4HaioJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB01C4630;
	Thu,  1 Aug 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471872; cv=none; b=Ah5bjScAIt1FEJY/IcnOfXFrHIcJchunIzojWLvhIicUMF8ePTVyk8zZj9v0k30mA0t4LeecVcgOl5de9vANU5e3nmrHV/FSDi7vUT1m9M6l8gKEPAxJSKu41kmm0fKPaujauluVKy9CnLJh7d6Ol1JkP0gbwSBWtIJcHz3VOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471872; c=relaxed/simple;
	bh=rBIERfZuo3k4sMYDo5jAH7EmUxizoU1twJtJjoHUsG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0udD2MtZIWygl52z8nJrFN0oWXVkcLegWvkRhoSDNUbYmb5jj6BHuhNllNs05WbNlO3Jp+SCRSNGdMNZQeAcm905A2Q72xW72V2z71qauQurY2mxx//E5vKfOI8/JPRl1SDUFM1xJfs/YYvZ5Ja4AwglDZAXeDV/VhLblNdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx4HaioJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D27EC32786;
	Thu,  1 Aug 2024 00:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471871;
	bh=rBIERfZuo3k4sMYDo5jAH7EmUxizoU1twJtJjoHUsG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wx4HaioJJ4/vgVcV0Kfr+YE212gtraH+ioOoG6TdMKlCtXfjfUsXTnrzhX0wWCQ9O
	 v+LVQD9MOqPqORRRVc2RrfQk5aPVNnHDD/jfcssJovLz57+MZOrkd6IXIuAIxEe66Y
	 OyFVFGdRYXB0Dqob2/8T73p/qVe8bok9hjhcdA5Z/A35lZekwsyEpLBF333pNZFxyy
	 gYar+Fk1jqgXYKK+la7Yq1MZobZAiAqoZxFYpEszC9i6PyK+2NqtKeNgU0CLyafzib
	 fWGN9daCxW9MD6S9o0cxztFUMqnUq0Ko0bP/zjriYuifMljnBRPPh2B45lJiiRGcVf
	 Hg9wqhqTl2iXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 46/83] drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ
Date: Wed, 31 Jul 2024 20:18:01 -0400
Message-ID: <20240801002107.3934037-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 162e48cb1d84c2c966b649b8ac5c9d4f75f6d44f ]

Make sure the connector is fully initialized before signalling any
HPD events via drm_kms_helper_hotplug_event(), otherwise this may
lead to NULL pointer dereference.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240531203333.277476-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index d941c3a0e6113..7fd4a5fe03edf 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2034,7 +2034,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
-- 
2.43.0


