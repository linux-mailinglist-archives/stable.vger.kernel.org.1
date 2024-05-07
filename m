Return-Path: <stable+bounces-43377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC448BF238
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFF428181D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293461384AC;
	Tue,  7 May 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ04dDWa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB511384A1;
	Tue,  7 May 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123555; cv=none; b=n1b6a6qdWeC2mIuKDjSQBiqBn7wwdUAXyqowKXnsjFcosHGnrkMs3U+xHLoWKV7dxmtiFqWpbwOF4KFM0K5ZnZlCjESYQ07sb2dOGYyNiI7NdnA8SIC8IwuCzmXPjuz342jUMTmUj4XdmD0fbW2MdNZUm5W/LKWUW++Ch/IFKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123555; c=relaxed/simple;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPcw2vD7bM4oFfaWHjBXIDBaDyIProRt6WBjlc8LDMZktxbDGfakqAn03k/4EdCnE7zphpW1tPoxYw7AJjEELp45PMDR71bqcF4SenIUEqYTbt9m+xUcX0Y4ox4/7CRIoqZurW2+EHpHl0+acwygEY/+r7+jGDtLlRSrtsvP5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ04dDWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BACC3277B;
	Tue,  7 May 2024 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123555;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZ04dDWa49HyrjCwg23g2sre/41J9q771OEF6J+57KnBmFy2DfO38hgc5zWFU7coj
	 KmIy5vfVBxDVO74611N5iFjajYvHTrZjyIiUTUIoUDBJrtLGt0ZKa8TPOqTI6nlum0
	 n05PffiIJDeyo4SU/qowAW6xlsYzpFTOA8S/qOAxgitIwvVGocsyFv4IjyKdPEksSP
	 2VWSQZDQt4CvD9wSqp6NqPXtnT5iQ1A0Nb1PLHVJyla3LvFCCPXlXdDlEunYLLmpS3
	 nxo9D9kVifL1XdTXC0D39swJ366H/zTro3LPZMH96HGeagofw6BpyNf3AmG/xq5Kjy
	 zgz29RRzziwYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.1 02/25] regulator: irq_helpers: duplicate IRQ name
Date: Tue,  7 May 2024 19:11:49 -0400
Message-ID: <20240507231231.394219-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit 7ab681ddedd4b6dd2b047c74af95221c5f827e1d ]

The regulator IRQ helper requires caller to provide pointer to IRQ name
which is kept in memory by caller. All other data passed to the helper
in the regulator_irq_desc structure is copied. This can cause some
confusion and unnecessary complexity.

Make the regulator_irq_helper() to copy also the provided IRQ name
information so caller can discard the name after the call to
regulator_irq_helper() completes.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://msgid.link/r/ZhJMuUYwaZbBXFGP@drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/irq_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index fe7ae0f3f46af..5ab1a0befe12f 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
 
 	h->irq = irq;
 	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
 
 	ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
-- 
2.43.0


