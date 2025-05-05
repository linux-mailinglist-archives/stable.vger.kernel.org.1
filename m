Return-Path: <stable+bounces-140011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535EAAA3FB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BA77A264C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005922F73BA;
	Mon,  5 May 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK09r7Cj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AD2F73B4;
	Mon,  5 May 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483911; cv=none; b=YnFQ1+vZAwwBBXw88gZ9tl7HMbgFEsYcK0sMIIR9atdKPQAx2ujxqG/9+vl3Gfjvm640qOQhLFuQ/ijMGLebICmVrNL7UiX+TJwjcNdweulRdVpoG8LDdfU9XQFuX509bd5WSjXGe9xdWVTVh6HVA2tBgzrwaDjU0myEJ8K9POI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483911; c=relaxed/simple;
	bh=cCrEAMogMpgyxQQnR4HUoIsCd8QZ/yNP4hYC4KY1i9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIirOk6iBTEcK0vaQ3RQrKeQP1MZLz4MyWCuPBJ7yX9kvpU0LR6AXCIatVzdbDDGYwQL0vRw/6kylshGP87DmrckWDFr4RRN0FxaoniMgjr9XPIYwqsS8kLfO60nk+2a/w02ryjWmTq7CuAyGyIMsiAYpQWsq+RXFgD1OkxgJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK09r7Cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B44C4CEF1;
	Mon,  5 May 2025 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483911;
	bh=cCrEAMogMpgyxQQnR4HUoIsCd8QZ/yNP4hYC4KY1i9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KK09r7CjM/kYf+cpgROSYp43XKP5V9UREJadx68uMVtfDi5362haaY6Hu4e51UdDh
	 9pkMOrxteSQ5+wEH442znQ2nR5wAgGvOg3M2uXDGbh2H9Zt8DaAwppc4ej/pLWR0Uz
	 MQHOZ08acVj9WpdMqMjt9S0ppn+urUB0JRwUQbkDeaTLzj+X12dWOFFfDcvPJ8e3Cp
	 yiGNN7AZu4RwbgqvES0Q7JTcznsmOLQWBzmUVqrbpyx/ix0bbjLVq0xd0Cw3IKAkhL
	 D6/W0xTPlFMcKSWQFGeojT6sEM67bpSCqWE3jugHdurQzb5F+vr/nLsqJHo00Qj98D
	 gCzWSv8k6CnQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 264/642] dpll: Add an assertion to check freq_supported_num
Date: Mon,  5 May 2025 18:08:00 -0400
Message-Id: <20250505221419.2672473-264-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 39e912a959c19338855b768eaaee2917d7841f71 ]

Since the driver is broken in the case that src->freq_supported is not
NULL but src->freq_supported_num is 0, add an assertion for it.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Link: https://patch.msgid.link/20250228150210.34404-1-jiashengjiangcool@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 1877201d1aa9f..20bdc52f63a50 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -443,8 +443,11 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 			     struct dpll_pin_properties *dst)
 {
+	if (WARN_ON(src->freq_supported && !src->freq_supported_num))
+		return -EINVAL;
+
 	memcpy(dst, src, sizeof(*dst));
-	if (src->freq_supported && src->freq_supported_num) {
+	if (src->freq_supported) {
 		size_t freq_size = src->freq_supported_num *
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
-- 
2.39.5


