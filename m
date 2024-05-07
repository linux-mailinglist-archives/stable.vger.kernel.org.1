Return-Path: <stable+bounces-43333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7E8BF1CF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0A4282FBF
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EEA8624E;
	Tue,  7 May 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEVKT9wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430E86242;
	Tue,  7 May 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123437; cv=none; b=UsElZzRtIAWWxXxcktHIGTQus/grcgNZJr6emS8mwjevjWecAAR/vdrnh78LZL8x6DEMBNnnrHUDbFaAVP5aEj2b/BfpG822uhnJ2D7QoDSwt2jc5mdfLq9FPMKY0lswGco/SoxDVOHHL9i/xn12sBPDt6O7loJHyqeJB/s+FuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123437; c=relaxed/simple;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVjZoyj+W1UbXzpP9j+dsx4O9t9QromLFGZJ5ZxvgzRt7VDEcC648nv2uXZ7lmxjkbrapogc4gbV8lvOGJ+mDYHw49TSlqB+TJZClPyLwXfjSkzziznO3Fy9sp58PXw84/L1wNBqn44cjYr8wsprLXEoqDpIRKHhov8aGHRfuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEVKT9wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BF7C2BBFC;
	Tue,  7 May 2024 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123437;
	bh=5035YfqJvmdZ7+1bWo3KgAUQmy86nDyJRs/SDTLghno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEVKT9wor0upiM3ixseS/8XLj54HCNXafdGW6DpTU0LATfonN0+XOqpD56mjDU2Mi
	 g1LEnwCU3dGzyOjVOAPr2+QZVFk+BMNMb5oQfNHKvAbeqmo8yVE2ZMBQTmI95srYVN
	 IqHRvAUBOzLgNw32bETN09Fa8J5uw+QiQ83P+F14meGnPPzGHf3DUqdJdww4TbsOk9
	 jiLqvktg6n28WqmLXxzWcJAfuOjQPVnK39+6BdN5LrGdqpaFQ7QB3KkPRFgi/Uo/u9
	 6/ctcp5TXacS8CkEvl9LDJVqgF3V92vjs4fFBfUwqCldmRk5U7IAIseswrqqT0Ph0g
	 Q0kogtulXmqkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 02/43] regulator: irq_helpers: duplicate IRQ name
Date: Tue,  7 May 2024 19:09:23 -0400
Message-ID: <20240507231033.393285-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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


