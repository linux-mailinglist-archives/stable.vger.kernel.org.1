Return-Path: <stable+bounces-43401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7C8BF273
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FE283FC7
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC113A24C;
	Tue,  7 May 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoP+dvam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C44133420;
	Tue,  7 May 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123615; cv=none; b=CeunDSs4kw3Oj5M5IXe0vZLYSQhT73d3yB3VR8lPxO9oQJrBZHi+7sjnzml+MKta1J3oJZWnxwT8/GcqB/laQIDIvbd3YGKCaWlwZ41tM2sDZ+Ztr7UMHmrS88R5DzYj30jISkyQeIS3IiCJA84Kc4dLq4IBRQJ5WDGdeyoHzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123615; c=relaxed/simple;
	bh=tOSD6YwehjScKGRVBf+sJXz0JkEtbWdrQrffexrQUL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g82Lt8E25uFmt/e/LksahDVqjACqGgdPeVsWst2jZuDqW/BxU7EXQUNEC8KGlbJBJHuel8dlloDsFM/LXkDuqu3tl4sS3yPbHJwXqjXMET9GPLQ4o/w3VfRK3VPPd5FTw9wm5uygDPve4SvpAKZSyE+hrJo05xxXoSSI7rh8N4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoP+dvam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4AC4AF17;
	Tue,  7 May 2024 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123615;
	bh=tOSD6YwehjScKGRVBf+sJXz0JkEtbWdrQrffexrQUL0=;
	h=From:To:Cc:Subject:Date:From;
	b=aoP+dvam+lFnkxnm6a7LiTu2+pH7KxkSJJdibHdVRsD8bTG/mJSCRufBs6FuZ3lim
	 4SP9lgt4CrxvjalQEBaeQSMRJe88usOX80Xe4koovuFMTemYUzfHTcqUBZqKQLLrjm
	 CtF9Y++Lofa/hY6xVsZ0HoF5Nr6WBTuoV89qxdumwbbUFwkq1ubOB8/93bWiR6cT0Y
	 Np+6SjUkMpJaUL5XwfOQgFMzLJnrT0rKeqy3uLoB9LqYuRYqHo4jQ7ViLHR0Rwxujk
	 ey95aORHFcR9SadDB7/qGwY5Qq43useIGlsx4q1XCrVy2iTTlJrJU8DpmmeDJIGDOq
	 IoKULUKhHDvNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.15 01/15] regulator: irq_helpers: duplicate IRQ name
Date: Tue,  7 May 2024 19:13:10 -0400
Message-ID: <20240507231333.394765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 5227644355750..a44a0b30a6516 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -350,6 +350,9 @@ void *regulator_irq_helper(struct device *dev,
 
 	h->irq = irq;
 	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
 
 	ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
-- 
2.43.0


