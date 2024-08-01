Return-Path: <stable+bounces-64891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB130943BBF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CAF282798
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA315148FF0;
	Thu,  1 Aug 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXAQEkJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37D149C42;
	Thu,  1 Aug 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471310; cv=none; b=gPxX3+XTB9YAC9zPoBh8QpTQEt0idqgzpguJuNTY2UtjKaMPWQgWwOI1BOEW8H95JTwFlny07cUNVg3Rnnxu24e/brYgwWXZStYgOAqjoH5HO21QrRgCWFxwAt1/STVi0jJct9R6JxmneyindbjdQX0WIPonIlE6AlkcnLbCWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471310; c=relaxed/simple;
	bh=fT+DufGfvPNVO/oTNu6ZcpvepwwnEFNtyq6TQYm4QfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D73q9b1HCEsqIIaebxMC2ac0GODVc4/O/sKWl+uWmTOGcFYgf0Yd4SiaBf3jj0Bq8VNN2bHK2y1Y96s9EcME1ueJIQ7Y9HNx389k4let40a2pRwlFL7sPYKhX/lEp2Hx9rgtpXDnnspRSuWdR8z6NMdQn/o2YT9XMJpvZ103YqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXAQEkJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF95C4AF0F;
	Thu,  1 Aug 2024 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471310;
	bh=fT+DufGfvPNVO/oTNu6ZcpvepwwnEFNtyq6TQYm4QfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UXAQEkJtmVlm1D3EJ6PibXn2m33eosIxUbtSelA0hHPlhs7lh+CAdRzhHZy37aZv9
	 dFSORX+C4TdweDGhPdVre2yModbLRs+Tvnwz6q4L/VOufbbP1e/D6eWp8OQcRprpzI
	 blhMu7Q6kSeesCDlf3r8U8FT9jB3wSlV2nRdrBjgsrwHaLvTKludPs+8bQ1u1n3mSz
	 i2ikLIWCIHG7XK7+3/0vkW8PXqL1QYpJID7r+Cy7pHz//4nphfTOB+W12Imm2c8gtE
	 igbhI9SisoTCSQoNgTwW34sOXA3SM3Cup1kPfsOxrYYfnL+weY8wGlXZoaX2VA2ks9
	 rthb+S2cVmfYg==
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
Subject: [PATCH AUTOSEL 6.10 066/121] drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ
Date: Wed, 31 Jul 2024 20:00:04 -0400
Message-ID: <20240801000834.3930818-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 166f9a3e9622d..332f0aa50fee4 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2135,7 +2135,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
-- 
2.43.0


