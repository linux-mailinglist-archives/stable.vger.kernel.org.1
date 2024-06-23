Return-Path: <stable+bounces-54926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4438913B42
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131541C20CF9
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832C1946A6;
	Sun, 23 Jun 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwuB7TXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1719415A;
	Sun, 23 Jun 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150308; cv=none; b=tcchQHHc/C0Layv/kruaJAdbAz01HG6muP++GtF74QbBRTJGCI6Fgg/5wcFCTMdLaqFtwpNLAoBq+ayaxNR1RA2QtxPGdApKJ5wfnXmQpz7zVe96zu4Rj1l0jx5ZiUmdWF4xQGvQphTLB4JOkcFzzsFv5iDDke6lhnEFAbmvuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150308; c=relaxed/simple;
	bh=e2nUYJcqOmmveWyyVEjm37yY43tInovyngLChMBlzxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzT9Z40D52TlsMmCK6NCDbLMwT9zKSgvWD2ummtIbwcEyhTmM8h/Tf4f8S29bRAwTe570lww1Xy6PIRHZtegC+wav1Fm59So0ucHadhA8U6xp6mReMrUzR8nCcgnM0EcfGnEYV0Brlah2WEnbRI1DSHoQVxEnPHtNCuct2OezoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwuB7TXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A5C2BD10;
	Sun, 23 Jun 2024 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150308;
	bh=e2nUYJcqOmmveWyyVEjm37yY43tInovyngLChMBlzxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwuB7TXTo7YsLtj6eD3P2F2R9JBEY38oJEV6l4e4EF9xvx0BohQeuHLaaw2n1SFvG
	 xmHMBwpAnBNg8cKRDEs4oSbwcmWFdy9rHesKQXDU5SBTUaWwqfFKU3J67inTmzDQis
	 hro/i+xzKre55ffavLdmfW+B+sY4c55Onw1sZw2BClWxBH0u7vtWL6R5uDLzTaqhZm
	 YIZ/WzNxpDo5diSW5j75RHnJBfM3xDCTOAugYzcj30K6ZkcQ/qmWgabzIvor3KNm/U
	 //y9WIEr1AfVmcYP45YMwd2noCMoJv5RnmL20OMzFiAukBIW0oFTgyQNUg4Q69hULb
	 jUY2nHEwSSRPw==
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
Subject: [PATCH AUTOSEL 6.6 12/16] drm/exynos: dp: drop driver owner initialization
Date: Sun, 23 Jun 2024 09:44:41 -0400
Message-ID: <20240623134448.809470-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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
index 3404ec1367fb9..71ee824c4140b 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -288,7 +288,6 @@ struct platform_driver dp_driver = {
 	.remove		= exynos_dp_remove,
 	.driver		= {
 		.name	= "exynos-dp",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&exynos_dp_pm_ops),
 		.of_match_table = exynos_dp_match,
 	},
-- 
2.43.0


