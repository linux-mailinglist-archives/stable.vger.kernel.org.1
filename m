Return-Path: <stable+bounces-189039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D242BFE3E2
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 23:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D018D18854D2
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FD3019A3;
	Wed, 22 Oct 2025 21:05:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B92FBDFB
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167141; cv=none; b=uY1DpeiJFQvp/cdUYAdB5aOAbdeNxkAWTp8u/BZLQ+JvrLSGIcYwey0Waa7AOwtjwvknJMxMaQ9FNCBmT4EHAXG6sl48IRmW+Hv5kXgs7VqHbXTj1hMpyWW5nljDpvOwee/Efd/F/JShYJWzEcpAAUWoeeKn3EbLZQ2KLBs/WPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167141; c=relaxed/simple;
	bh=WBCJ7orEy4MfZpWWSDKqTIuPevQjbHrcIciGV6+/3PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GoLW2BcshqRuQKeuxemzb69N30VA0KPvSZQjU0+2jOgiujRbMgFWxJSUsqgPrsmXWzr+XQyHhZUhTRnbTBxHnUQu49kmJkueUumyNEklCBp6pHu64hJnISj8T6kTsabplirUJjlrNYDq4Mr6kSKLQk4rPp96Q41KjaBDgQYoh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 9760D23373;
	Thu, 23 Oct 2025 00:05:27 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15] cpufreq: davinci: Fix clk use after free
Date: Thu, 23 Oct 2025 00:05:26 +0300
Message-Id: <20251022210526.214875-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5d8f384a9b4fc50f6a18405f1c08e5a87a77b5b3 ]

The remove function first frees the clks and only then calls
cpufreq_unregister_driver(). If one of the cpufreq callbacks is called
just before cpufreq_unregister_driver() is run, the freed clks might be
used.

Fixes: 6601b8030de3 ("davinci: add generic CPUFreq driver for DaVinci")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit a5f024d0e6f91e05c816ad4ee8837173369dd5cb)
[ kovalev: bp to fix CVE-2023-53544 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 91f477a6cbc4..62380f05aec8 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -133,12 +133,14 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
 
 static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
 {
+	cpufreq_unregister_driver(&davinci_driver);
+
 	clk_put(cpufreq.armclk);
 
 	if (cpufreq.asyncclk)
 		clk_put(cpufreq.asyncclk);
 
-	return cpufreq_unregister_driver(&davinci_driver);
+	return 0;
 }
 
 static struct platform_driver davinci_cpufreq_driver = {
-- 
2.50.1


