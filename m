Return-Path: <stable+bounces-54907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C81913B0C
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499841C20C51
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AD2185E7A;
	Sun, 23 Jun 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJhWGD1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670C185E6D;
	Sun, 23 Jun 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150269; cv=none; b=gxln4mOrRHEY6rC+KsnsVgyK1qgX0gr3rfvcSWC4uR1HORzjlAaybdLsSrSMGnVqaQpDIdbyABLRgD/W3P7QsUJlC9YwQVBg+rvUsiMqNtd8NON1otvG8/jYVqT95gepLvz7lyDD/fptPpZqr06CfwFcpJa5rdB3dxu0u1adz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150269; c=relaxed/simple;
	bh=2VViG7Ljb3t8VZRFZHT3YXOFyq8TksW57NNk5hqXajk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qglx4wSR742AhUT2+BhoPjOcsyXp2d9G6ULgDvSxOBv0wweHqmw0gnJdIip5FKlZ2H8XvxVyFoilzJEGgMUzGjOQjwkY0vvp3G5d6RBE3ZihLnJq6nUrsuZwr0dvjNeb2XrGLbHMjp08tS+iYEUCgIf/6IROwOrz+oflONcbYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJhWGD1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34680C32781;
	Sun, 23 Jun 2024 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150269;
	bh=2VViG7Ljb3t8VZRFZHT3YXOFyq8TksW57NNk5hqXajk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJhWGD1xtFS3JoQZHj1qPIdUbbl0i4oGly7NqtnG3ZgWqFR6KaUU5L0dXI7U0ehG2
	 EHjItsmYd2VsEoNUEtCp6Xq9mpm1KR43uBdSSEr96S2gUPeXBLRvejP7gsT0VJibqN
	 9Pdra4S50lH4EUqWVrDW7F0eI/lNDE+sWszeGNb1Rc8BNWurPR2v6891KZMs8H7Pak
	 2mp2LIAougvYN1gy1Pi0rFIlvpKjkgr8Qb+aZNsCkWttMtMvo4YlUiboV1Whld3F6k
	 PYcjeiyTWJ2iAF67hIiggX6o05HlazOF5TJv+02YOOaU3UFGVUyLTS4JfclCgT4fRU
	 ap5AC/w67wLDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	krzk@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 14/21] drm/exynos: dp: drop driver owner initialization
Date: Sun, 23 Jun 2024 09:43:47 -0400
Message-ID: <20240623134405.809025-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 1f3512cdf8299f9edaea9046d53ea324a7730bab ]

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index f48c4343f4690..3e6d4c6aa877e 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -285,7 +285,6 @@ struct platform_driver dp_driver = {
 	.remove_new	= exynos_dp_remove,
 	.driver		= {
 		.name	= "exynos-dp",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&exynos_dp_pm_ops),
 		.of_match_table = exynos_dp_match,
 	},
-- 
2.43.0


