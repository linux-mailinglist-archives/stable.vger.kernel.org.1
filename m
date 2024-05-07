Return-Path: <stable+bounces-43281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188898BF14D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A072856C9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0084FAF;
	Tue,  7 May 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOvChpfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512787F492;
	Tue,  7 May 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123285; cv=none; b=FQrpEcbGR2rFsIFmmmq7cgOzgGYZnGSMzz8huT0kXWpPOcMUR88JUf5+iGY95YY3GVQVUqqIP1yqJf+pNGd8jr63NYf9gR7mzRpIT0uI5h4Skot8K0x5K926TkuS7EM6wOlTIMTkXPCYexQOJGezW5RmD8N+P+7eu6R7RXJK8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123285; c=relaxed/simple;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu4Bnk6eJM4yUX48Rh1QpXTrU2Kjzjgc1+acJ+Yn4jtfMuijYh22zU6nTq93M5rhKhN+z3ly7l9W0F0CNqSXWEJ0Fjl6JH7yPl7AEm1k+l+0TYmPAaoIKyvhKUI9G6jby3ffvo6jQfUpMJVPtB5+TYqDA/A36v+k4T8VGyVPyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOvChpfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABEAC4AF67;
	Tue,  7 May 2024 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123284;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOvChpfRcBuxliPkkZhg3dVDQOi80zqXLiXdljl8o4clqVcyu8qk6fkoTJgVDXo7j
	 3TLfUqoNr67pRWV4V/mrbiw9koDsD9toxk98TjDOanV+Eba8VSyctbML6184vonb7S
	 zXmFwDDzjIjlxFf0Evposfpr6EUDWYkSDR7TZ9wOOaSRkOY/ZhpfNWkKNT7dbfDAFk
	 tMTpwNcjPpdZEwuBtrKnFSKqEMSp7/1T4WCyvSd4y3YVEVlaTy0gYm//otlmwJhU/6
	 3uNTWMcMeDGA77fgafBbt485eczVl0GvA5IgudkVWQkyHoBqKTvK7vaKYj1U/pLMjE
	 ubpA+LdnFwqUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.8 02/52] regulator: irq_helpers: duplicate IRQ name
Date: Tue,  7 May 2024 19:06:28 -0400
Message-ID: <20240507230800.392128-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


