Return-Path: <stable+bounces-177930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB66B46892
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9321BC24B5
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4A22D4F6;
	Sat,  6 Sep 2025 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXH4Lx/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A922A808
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128762; cv=none; b=Y+wyvcPOSXFvf9IW9F1IpqhRwvdWV84Spf9u9RBxaNSg0tRmwDgaOSYmYXpAakMlS1oTylg4SipBAuLKjc93uqGbRSJhSpfuDU+Ye3WocrYA9SSA8WLfg+l8tkDu+87QI84kMUwqW8REBYfVGG9J5XCXKwZateMvpCrYEv27xEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128762; c=relaxed/simple;
	bh=dXJiIGrq/ptTU1vRT0DlA+ARrE1wHyd6qBh4NVm0lV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVJwpIsWosUgJVmGpPqJpf7ysjZYEN3ARaoBZ7WBb8/S2uBern3W7JDJI+VcIAXKgQnaK6iGfLXVR3+/YlviDaawejLlmVAzFG60uUardQxc2w6WfXJlbd7safjZojNrXpR3u+BrQAe0C4Tzq+jwKHT+ljR98XE7XDYPS/zUwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXH4Lx/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEAC4CEF1;
	Sat,  6 Sep 2025 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757128762;
	bh=dXJiIGrq/ptTU1vRT0DlA+ARrE1wHyd6qBh4NVm0lV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXH4Lx/j2kb+csSd42d2O3ww5V4V8/BI5ckeuATAToO80TmhQoOBs+FeAppYcCMxH
	 0NbLWXdyMFA9sSXg0opIZHY5Q9LSu/sOomO2pIiQXq4qH8SdqFhaEcG+zeHnUsJISg
	 RqCbzzYleOeZyhaYfk1laUxWu3lpzUYy2rT+SSzSu8vbYQ4eAqJiHb1vVhW4RJ+KkM
	 eujPcSb4wh0EfhwWMTaZpn295UmdFGBg8mM9wiQ1Yn6+eu8pw30EQ3630yWVz3yyMY
	 mNBwVTuQEHiTP0pdPGJ0K7Cq3fAC7LtK0g/bh0JdGn3lmk8Kc9R2xd3TT9WObwC0p6
	 aa3vxVFkqP6EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri,  5 Sep 2025 23:19:20 -0400
Message-ID: <20250906031920.3688316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051217-escapable-droplet-9559@gregkh>
References: <2025051217-escapable-droplet-9559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit f063a28002e3350088b4577c5640882bf4ea17ea ]

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/opt3001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index ff01fc9fc0b2a..b2bf928bd4cd3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -692,8 +692,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -730,7 +731,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
-- 
2.50.1


