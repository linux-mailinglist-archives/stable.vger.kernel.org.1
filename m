Return-Path: <stable+bounces-177936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95818B468AD
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5177C3AEAF1
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0A4C9D;
	Sat,  6 Sep 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPWQREZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7CF510
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757130316; cv=none; b=ARihKuBhHz7e6t1jpMkcyBAXiaObxafsAGu/K8b52vUpUzhbJfxdxHknTyg1RLWPJoColoddTdI8ztor5gYwDVupPQk255QIScqJlJS1CZINIQhgHmv8rxo7ixbaZ7CNzmmfwRc1ry7thr1GAW4kbIcrGrAb5t0IS96JNEfgxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757130316; c=relaxed/simple;
	bh=ru2XICsAG1SauqGPkRcWSp2lcAHnUrg9f8prNsib0Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTshxCv8pxUV0kd18NTSnCkOxzIo3CX8essrR/ZF5PBmqm5j3WmN9eothBRXNtWzmT2aZ/+ycxaZ0QxO/3FuCv8hMDHdcV5fSNnoEgwjVHCbOHA0IEIeSA5zeN+0BiwZ63d5Jv7S3igUxQ97xr3UhSnjA8Gt011nTG7098urjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPWQREZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F5C4CEF1;
	Sat,  6 Sep 2025 03:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757130314;
	bh=ru2XICsAG1SauqGPkRcWSp2lcAHnUrg9f8prNsib0Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPWQREZ4u+yYkX1MyWNGmx/je8wdPTELnP2UMDCiH7Rv9K4GsqJkacQog+obmUhaZ
	 3u4VFEHL/rmH80NvemCWP3BfmRKCwxIxjgbtUKKvUAlbwSoece5rKwaiXZZOlN1MB+
	 o9nQzwSL2wu9kPsa0w/MATuz0I4JbC3NBmr8cxgwKVawPcc+1Qmf+2qQosmEL7mu72
	 9LSYaINKKhRvhhdfTyE5ky38gfrIi6/o89nf697bigT+XNmp53767hMEMVFtI3MFcv
	 FzzfEOf52gn2psSIc3sAUq75CtQad12po/bafNUQcfXxmLxxa5h0v7QJwWyGz14/Tn
	 zm7BOcQH87l7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri,  5 Sep 2025 23:45:11 -0400
Message-ID: <20250906034511.3693987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051218-shield-neuron-a082@gregkh>
References: <2025051218-shield-neuron-a082@gregkh>
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
index 088779f723f7d..924fe985e0c6a 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -691,8 +691,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -729,7 +730,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
-- 
2.50.1


