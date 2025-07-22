Return-Path: <stable+bounces-163645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D0B0D0FA
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD986C26AD
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7428C2BD;
	Tue, 22 Jul 2025 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEAlYac3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676362E3716
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160095; cv=none; b=u4McsIJoHXordhDryoH2utZYvCY3aRuY4e+PWY+BNLQ3U3H2JR1PPOrKuaupZvgtMIHEu2IcTAAnPWV9/lBjRH6uDkv7CmnATFRbeqNPwPiSeMSZbOtJ+uMsJOjhImKNTmEtCPi7g/96QOS8xTqTem3vQz9+8sYpA8E5dxUZ42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160095; c=relaxed/simple;
	bh=zr1yMIIkTUhMxbCW/jIhyqaeEgJT0mQC5hXhUZj7bx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwl9Kr9cTMeH0zV0VjDmyxYYUMoNElGumbFP1DZMJqhcVdaSlSOC3HqZfDn+S9MqHokDxP0QKduz53ofxgbbFEe9y3cixPqKXGwnKsouqB8FJDtZxM3FLmkEO0mtAxr4Cc+2sQ5HlzpIEq5B62S6XqogZBQXv8cENCGvoExOhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEAlYac3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9BC4CEF1;
	Tue, 22 Jul 2025 04:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160095;
	bh=zr1yMIIkTUhMxbCW/jIhyqaeEgJT0mQC5hXhUZj7bx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEAlYac3pRYDgPNRV1G6wHSTZ8M1wALaNk4Xeb4aKbJ/1iOpmwTrD5tw9bDNFmv7L
	 ovfihKjpqwPFj+wBx+WwxaQJFD1Rrr94+A3ZqYXVtjNWZu/hI7IXxAMZnHMxNZuzgr
	 rqYXsu0It+z2m/J+4ktd52mTI1kbR5CaK4i+NEBW7i4ONAesUrYPuHH5Ata87ZJ2uG
	 Iv+W1mcGBo7HiMx+7F4F/qmnMD+n1KrszP/BpIexYXZ37GA4nLxmb+8dKgL/8AoU58
	 3k9+FCRopYUgKgSm01CLpVTwQmd4bzGhNTQYji5/BcUGtwFVAt+sUHHhYjCjRKdmRf
	 e1lzHfQxoeQ8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] i2c: omap: Fix an error handling path in omap_i2c_probe()
Date: Tue, 22 Jul 2025 00:54:46 -0400
Message-Id: <20250722045447.893946-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722045447.893946-1-sashal@kernel.org>
References: <2025072119-tragedy-multitude-6649@gregkh>
 <20250722045447.893946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 666c23af755dccca8c25b5d5200ca28153c69a05 ]

If an error occurs after calling mux_state_select(), mux_state_deselect()
should be called as already done in the remove function.

Fixes: b6ef830c60b6 ("i2c: omap: Add support for setting mux")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/998542981b6d2435c057dd8b9fe71743927babab.1749913149.git.christophe.jaillet@wanadoo.fr
Stable-dep-of: a9503a2ecd95 ("i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 488ee9de64108..5fbce75b5128a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1461,13 +1461,13 @@ omap_i2c_probe(struct platform_device *pdev)
 		if (IS_ERR(mux_state)) {
 			r = PTR_ERR(mux_state);
 			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_disable_pm;
+			goto err_put_pm;
 		}
 		omap->mux_state = mux_state;
 		r = mux_state_select(omap->mux_state);
 		if (r) {
 			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_disable_pm;
+			goto err_put_pm;
 		}
 	}
 
@@ -1515,6 +1515,9 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+err_put_pm:
 	pm_runtime_dont_use_autosuspend(omap->dev);
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:
-- 
2.39.5


