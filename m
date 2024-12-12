Return-Path: <stable+bounces-102791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85399EF4CD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF2E189F0A9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A622A7E2;
	Thu, 12 Dec 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEllXCPU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496223589E;
	Thu, 12 Dec 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022504; cv=none; b=rMzPl9mnPqXFPQUik0ldvHQ5OyqIf5LApSvQaYfV/KH/CfP/vFXowR20zzZF9UH8ierp0ktgmX6NzXieIL3p73utRzRpMcrqtQSLCSXWBX9igBglRUhGtBt8IjqYPOOV1ydcEdS1XTxHYoICINh4w2IV5192C6CV8QdeErqGEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022504; c=relaxed/simple;
	bh=PxeAQ3vaqJVox4ZsMgrJFktBs7IJChlyr/XJB01rdAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZeDldHrraL9WogGlHAN0FkOxOofnGPrUZIs+hAYVlWTYFWsQIRHb5FY3hW5XnXlUt3qHBdTg6kfdRaJSH16XzOIMHt2KH+fpfAAOQ7E6hf0aX6YuKgq6+1AagnGiFYRELdMnFuCMOoX4IRME7ohILd+v5i4G/Jnw/p7pIUIBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEllXCPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2453C4CECE;
	Thu, 12 Dec 2024 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022504;
	bh=PxeAQ3vaqJVox4ZsMgrJFktBs7IJChlyr/XJB01rdAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEllXCPUaebxhDkzuQbRXk0+pxUb1uwtnqEjHIQPE1m281kNBbDQ3MS35N0ARXzvl
	 QFPTNHIHaRkrV3GBwsth9VqPmdr7CW/pjft4kONW6YWbQeWGOeTizMQtlaUG2R4b0D
	 faVQr9p0tU3VzdYqD9wIQIHkyQCLcwLh8vqd4eKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Can <yuancan@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 218/565] cpufreq: loongson2: Unregister platform_driver on failure
Date: Thu, 12 Dec 2024 15:56:53 +0100
Message-ID: <20241212144320.108890673@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit 5f856d71ccdf89b4bac0ff70ebb0bb582e7f7f18 ]

When cpufreq_register_driver() returns error, the cpufreq_init() returns
without unregister platform_driver, fix by add missing
platform_driver_unregister() when cpufreq_register_driver() failed.

Fixes: f8ede0f700f5 ("MIPS: Loongson 2F: Add CPU frequency scaling support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index afc59b292153d..63cae4037deb1 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -154,7 +154,9 @@ static int __init cpufreq_init(void)
 
 	ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
 
-	if (!ret && !nowait) {
+	if (ret) {
+		platform_driver_unregister(&platform_driver);
+	} else if (!nowait) {
 		saved_cpu_wait = cpu_wait;
 		cpu_wait = loongson2_cpu_wait;
 	}
-- 
2.43.0




