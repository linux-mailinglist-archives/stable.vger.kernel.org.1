Return-Path: <stable+bounces-88385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D39B25BE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C481F21C36
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406418E36D;
	Mon, 28 Oct 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xce0v7ZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10118FC65;
	Mon, 28 Oct 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097211; cv=none; b=bPKuB9qSiO6G1NP78DI42Am2heEaGi4FDm6Z5qujQtsyFHxhrFNKWZqlvo7pQGPe3oC5dBBxDwV8vKP7Cq+yMi9g+lw6krVnL34xaUQlrI86PwkciyzhdFkviGZe0cJeeBKspqQUVPc/unykOZKR+oZz2JnAQQZ/81JALDG2rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097211; c=relaxed/simple;
	bh=1JqpSEZ1ORkaXXiBiDF/pKTasEFvm3efo2NMw2S2sag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbNcvgnpWUI/AHCLO3S0IrQFOqHgKBW3SFXoVF7OlbNyO7lgM6BdtQFezWY6hKa3UZkUceW/x98lJyeVCn3me76CHjaUB6XaNsDmhShxPrp+7H3qTZLGCSUxvfIt1bEJEz/NBUUrOcpLraeMfdy2SJ3N7cXEpZDc2ZiUt/naTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xce0v7ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D11C4CEEA;
	Mon, 28 Oct 2024 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097210;
	bh=1JqpSEZ1ORkaXXiBiDF/pKTasEFvm3efo2NMw2S2sag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xce0v7ZZ6FXHFGUew+6txGwISoCH2Xr5Tt2GSSlOVK7N/F+OsERjRVjtpmd/ep0LI
	 cIBR0ANOIxEw1U0bhdPsAuL63WdEWGd6LrCoXRbfvc5isc4oIVxqssk1MC75oLUlPD
	 1VA+0+iF7bkJxexnZ2g+kKsoqkI25zLN6ntQtm7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Marek <jonathan@marek.ca>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/137] drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation
Date: Mon, 28 Oct 2024 07:24:21 +0100
Message-ID: <20241028062259.396962435@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 358b762400bd94db2a14a72dfcef74c7da6bd845 ]

When (mode->clock * 1000) is larger than (1<<31), int to unsigned long
conversion will sign extend the int to 64 bits and the pclk_rate value
will be incorrect.

Fix this by making the result of the multiplication unsigned.

Note that above (1<<32) would still be broken and require more changes, but
its unlikely anyone will need that anytime soon.

Fixes: c4d8cfe516dc ("drm/msm/dsi: add implementation for helper functions")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/618434/
Link: https://lore.kernel.org/r/20241007050157.26855-2-jonathan@marek.ca
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 034ad810fd653..88843505d89c9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -576,7 +576,7 @@ static unsigned long dsi_get_pclk_rate(struct msm_dsi_host *msm_host, bool is_bo
 	struct drm_display_mode *mode = msm_host->mode;
 	unsigned long pclk_rate;
 
-	pclk_rate = mode->clock * 1000;
+	pclk_rate = mode->clock * 1000u;
 
 	/*
 	 * For bonded DSI mode, the current DRM mode has the complete width of the
-- 
2.43.0




