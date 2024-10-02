Return-Path: <stable+bounces-79081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766198D67C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B584CB213FA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0661D0953;
	Wed,  2 Oct 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHNOhJti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E091D0412;
	Wed,  2 Oct 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876383; cv=none; b=R05HVXjcfdAixQoMpWyDGKTCs/B3sXDiWrSCCUhq3E6ZcqLGsXBEt+2qhPwPk5FAWDGJqy6g6XOGz5gOyyDVXkN02QY++9wlPlGdDjSdy7sbP4iCakPrLkWGpgzXU+RZHZCBBxkYswc+CAWUkkC8TvZ76CjKvg58KqQ0W4hUmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876383; c=relaxed/simple;
	bh=vclUHQRy7G7eu3/Xe8jAPvJt+EzsJiXxn4K3M657WSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6gvFOQsDDEsefysmVUM7LC+m5/5Nww57PdgbRds9TgjOwvp7tIH3GIo7dTMC1Vkgu2ceVDAbP6mv2VfTb0P4cUWG/nF4zs/h4ajVkLuBja17hhK3oE5C/flFFC544KnASuEE3sVAC9BgY0ozlKKR6dH9lymMg+66j78jHSsvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHNOhJti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B38C4CECD;
	Wed,  2 Oct 2024 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876383;
	bh=vclUHQRy7G7eu3/Xe8jAPvJt+EzsJiXxn4K3M657WSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHNOhJtivIjn9dFDPygbTZYx0iR8pfKr6vCUmol6/2sgiHpjZhMhKo5i3ZUILFVkc
	 lGQpW4MqlXoiDn6k5p6u8po+bRV3cASr31vam+q9zEtmIQEfbF/Rj79U4GEy706ndr
	 xzTasebhp4H/881dxHpjZPvfsyR4cCVoIlj5WAbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuntao Liu <liuyuntao12@huawei.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 394/695] clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
Date: Wed,  2 Oct 2024 14:56:32 +0200
Message-ID: <20241002125838.182199326@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuntao Liu <liuyuntao12@huawei.com>

[ Upstream commit 55c312c1b2be6d43e39c280ad6ab4b711e545b89 ]

We need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
fails, so use pm_runtime_resume_and_get() instead. this function
will handle this.

Fixes: dae5448a327ed ("clk: starfive: Add StarFive JH7110 Video-Output clock driver")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
Link: https://lore.kernel.org/r/20240815093853.757487-1-liuyuntao12@huawei.com
Reviewed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/starfive/clk-starfive-jh7110-vout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 53f7af234cc23..aabd0484ac23f 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -145,7 +145,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 
 	/* enable power domain and clocks */
 	pm_runtime_enable(priv->dev);
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0)
 		return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
 
-- 
2.43.0




