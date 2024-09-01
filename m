Return-Path: <stable+bounces-71720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC415967775
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F3281FFE
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FF183CA4;
	Sun,  1 Sep 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zNFXiT8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274944C97;
	Sun,  1 Sep 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207593; cv=none; b=IOtFc+DwXGBIQBlHkIQk0IQtKXUUT4YBsqfPY+qxfiNEDXcq6kpcUgAuTpiQ6f0QOLFmOG/zSQ5XSwoPf2Jm3awPXjxJeJWuMfF4nCQrT2DniWLXdL4agjrNt45dsaL0eeUOmLNqpxpqKGldt5qv2mdPQEEQGkQvJbWKdB2q4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207593; c=relaxed/simple;
	bh=VFxXGwZ/3jwwPO0NuuoAtoFAQ5MamrL+jx9JMziM05U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueoreZh5yU3RVMVV8fPoX/2XCTO/ZMsRhZC1ETsl4NNl3f6+Nbd4qFNNi2Fr8WqNx44L9zbRRYpjEfiaVB3f4MHM+Y3jhitl3LsmgUP5wT/o/960p3Si5AncXyPxLXxqiJEhMFaEDQzR3SKB04jNK6tBXENBq6AeCnFLYT4TKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zNFXiT8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66302C4CEC3;
	Sun,  1 Sep 2024 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207592;
	bh=VFxXGwZ/3jwwPO0NuuoAtoFAQ5MamrL+jx9JMziM05U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zNFXiT8Jy7OqER682Ze++11Y6DNhr3ZmDwI0wG9el7S2s5b9pzy+eKgHLvMmAsJeO
	 Os7yiFxsoWF2YEIwEsnVEv5dMvmFoy5te56VHzaP86w73AMoYOfGTn7VeSlTu93PUk
	 UNXY8MMbTPZuiWF+mFcpgfEMnaOhJ+gFFsAsE0Yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/98] i2c: riic: avoid potential division by zero
Date: Sun,  1 Sep 2024 18:15:49 +0200
Message-ID: <20240901160804.415568423@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 7890fce6201aed46d3576e3d641f9ee5c1f0e16f ]

Value comes from DT, so it could be 0. Unlikely, but could be.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index e6f351c92c02d..82ffa8eecec8d 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -315,7 +315,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	 * frequency with only 62 clock ticks max (31 high, 31 low).
 	 * Aim for a duty of 60% LOW, 40% HIGH.
 	 */
-	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz);
+	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz ?: 1);
 
 	for (cks = 0; cks < 7; cks++) {
 		/*
-- 
2.43.0




