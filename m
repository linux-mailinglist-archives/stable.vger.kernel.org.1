Return-Path: <stable+bounces-139002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11BAA3D90
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD7E1683A8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE428F202;
	Tue, 29 Apr 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxz/vdUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B926277013;
	Tue, 29 Apr 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970696; cv=none; b=WmVYLWSBHyIG/c1+2hYuBSmWeUwIi701H11UnOCHrD7sbaT3RatfAniOJEsFhowAhxs2C5J7B5RHrX2XYivkJGH/Njt/MJEF35KsUcyZOcyKZsEDUtiGL202nB0okqsTsXIfZdkl3Z+hXGahJdE7LkfUOXXXzGKLQGH9FCad59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970696; c=relaxed/simple;
	bh=0xZ76QH3HflUWPp/0rUpNJVO9Oo2L/GfiD6E8Ga85rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VO5plCecWHKh04FePuRLwLXcIBmvTPLLqdF6haCqnL7I3Kifw79sLeol/QhrJI5irYroViIlRyOolCVyk19P7aiY1hSxaYPxNgZ+V3rkHMQEhoIlUbwwMKkgEb3dSaC398s5nrJM8Js8S0Z9mEFmfoqerMnRTyHaTITiXb/XsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxz/vdUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7ECC4CEED;
	Tue, 29 Apr 2025 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970696;
	bh=0xZ76QH3HflUWPp/0rUpNJVO9Oo2L/GfiD6E8Ga85rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zxz/vdUr66+5jw48OI9XtR4WKjGTPIQ8QmYo5VMgokQsFmngGZ3L15f8acR5sHNI/
	 pEtLM7+TUhZmA7249Dx6uyatv1ZOWKDNKOKicIfKT3i2awAjWkeKuZspZiAFMKDhtC
	 FmnSNLHN42NAmD0gAZgU7YaThyFtk4ngLSyGxdmXW/euqAlTLbg7KTy4cnmYiOJI+V
	 d5+r6XNTFaaHERtBh+TjbOrFNQDy+bkL/BlJ8gxUYiySJ8B1Gr2TVfDy9n9Jux0C3q
	 3abAwTVFWyvk6lzw1BhYbvhv+Vzm33Gx37IB200HZZEFegwsEWTFxImUZ2MgwfrjPw
	 u53miqNNgJosw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.12 07/37] nvmem: core: update raw_len if the bit reading is required
Date: Tue, 29 Apr 2025 19:50:52 -0400
Message-Id: <20250429235122.537321-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 6786484223d5705bf7f919c1e5055d478ebeec32 ]

If NVMEM cell uses bit offset or specifies bit truncation, update
raw_len manually (following the cell->bytes update), ensuring that the
NVMEM access is still word-aligned.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-11-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3671d156c7c33..d1869e6de3844 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -581,9 +581,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->nbits = info->nbits;
 	cell->np = info->np;
 
-	if (cell->nbits)
+	if (cell->nbits) {
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
 					   BITS_PER_BYTE);
+		cell->raw_len = ALIGN(cell->bytes, nvmem->word_size);
+	}
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
-- 
2.39.5


