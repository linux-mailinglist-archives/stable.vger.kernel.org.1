Return-Path: <stable+bounces-102687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D229EF3FA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE697189A853
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389B222D64;
	Thu, 12 Dec 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPPxx6F5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701902054EF;
	Thu, 12 Dec 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022127; cv=none; b=U+2r/jC17ObXYXf0308iJ1iwucX6KxrfRoiF/xd1qxg0jehY53/YJKwk5BF1z8izPcon1tHkUP+zMgxULCKFR+bT/hmRTgktYFVSzT7pzwR6Y0Keah2ZeNx0YuGP1Vq/N32GsBQKVFE+VG7zlFbN7OQ9emL15MDvduGhAC4Q4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022127; c=relaxed/simple;
	bh=Dj3HYjPZk+PbMfLC1oInOfqz9soFNaxiF/6UzCNIuJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHz4LZKNmzztdG/jGpSMEUwwDc1TrtQqNEbq7Ns+41UFD2cNSwGnSU313esAiNytaNNiRVP26hKkj74qot1VBb5X5T49Csn4GTYvJYgP/+PutlJNK75HVenIvw3/XrPUGTQ1y7VAdXZNa7pt+mszgaNagvLDmR6m3GZ/2wBsOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPPxx6F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411BC4CECE;
	Thu, 12 Dec 2024 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022127;
	bh=Dj3HYjPZk+PbMfLC1oInOfqz9soFNaxiF/6UzCNIuJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPPxx6F5v/Fh8+9ym/+6LOfV3aH+MahndC5Uf4t0KfC2nwpJUI242ooUBkA69LzAS
	 l4Qb3/IX2XqRb/l5AqOokVwvefGoAdEtdAk1LZq5scq4L41xp8BUJqFNjZvfygsoSf
	 HwJJJCJCVC36+CUv/7iEjAFd09WVkEiwES2OXabo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Zekun <zhangzekun11@huawei.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 126/565] pmdomain: ti-sci: Add missing of_node_put() for args.np
Date: Thu, 12 Dec 2024 15:55:21 +0100
Message-ID: <20241212144316.466520533@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

From: Zhang Zekun <zhangzekun11@huawei.com>

[ Upstream commit afc2331ef81657493c074592c409dac7c3cb8ccc ]

of_parse_phandle_with_args() needs to call of_node_put() to decrement
the refcount of args.np. So, Add the missing of_node_put() in the loop.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Message-ID: <20241024030442.119506-2-zhangzekun11@huawei.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index 17984a7bffba5..b21b152ed5d0f 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -165,6 +165,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -192,7 +193,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pm_genpd_init(&pd->pd, NULL, true);
 
 				list_add(&pd->node, &pd_provider->pd_list);
+			} else {
+				of_node_put(args.np);
 			}
+
 			index++;
 		}
 	}
-- 
2.43.0




