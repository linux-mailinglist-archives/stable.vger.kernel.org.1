Return-Path: <stable+bounces-177926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE0B46874
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640ECA07AE4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7B111BF;
	Sat,  6 Sep 2025 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5UghbGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE917736
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125840; cv=none; b=ommqralv0ZAR6oz7OeehKzM1a/hgfIjvU6bQYAxS+yewxj6lfYcRKHSf7lUlOjZBXgI+hzKRWTvMEl/SKULLWhhZRjsZuP7rDxCrnM07b/prjsf0edlI9r1K9OtvtoJNoa5NWj+8ov147jONYeCEne3vgDrw5mfHsmMch5ja8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125840; c=relaxed/simple;
	bh=x8O1xCNmeRNJScIhgXVnWQ8ja88+7Chzcjep9pA9gVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB7/QH84Xh0FZZlOftv4XHZV0C3D+iTjF0oFLIhJo/mKsbHOSuSxp3MrptwZKULPRugtfA16kVpfwYnp97N78eCl1zLp34wNtdDPox7gIsPpgZGQm2mfJffjPBRJYAOfnwAdsoe63GuwOXMgi8sIeafAjZubw204HwuQ32RizWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5UghbGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F9DC4CEF1;
	Sat,  6 Sep 2025 02:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757125840;
	bh=x8O1xCNmeRNJScIhgXVnWQ8ja88+7Chzcjep9pA9gVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5UghbGKMkCOzRiDGhTMXb3pMbBa4yu2yz3WEILRuzyen2Zd/b4MM6V4SjI8uIrw1
	 gFkxGGzeLnmXBV0ZDdZ1TGUFnhufT0uSuURiG4zFHC9kJfPtPz3HrVZAX7Fcyk2N26
	 n3RVNDt3ti2cdWPyU7qr70HcDGya+1LsryrLSuaLhyYCgAvJg53sVGH57Do5wUcRVr
	 1OBwh3bM49fCmSqqnkDgPEUFWn6R44fTsgv6milAOUCDN5KiMAM8WHAApAJjfmWB8P
	 p/emBaVxl8pQp4yiv8IaRLnqc0iLqgy5QbBJ+X2uqfqbOOVFDjII75FghVYvnFSrEq
	 v0PvR1QzGqB9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri,  5 Sep 2025 22:30:38 -0400
Message-ID: <20250906023038.3672089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051216-daily-camera-c269@gregkh>
References: <2025051216-daily-camera-c269@gregkh>
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
index 9d1d803af1cb1..2496363dfe43a 100644
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


