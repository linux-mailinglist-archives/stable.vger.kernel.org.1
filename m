Return-Path: <stable+bounces-101965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6BD9EEFEA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF91171248
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009B22EA19;
	Thu, 12 Dec 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jV4OaAoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8722EA12;
	Thu, 12 Dec 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019450; cv=none; b=hyXPkRbno29cQnYWBFyf6ApTpu3njjBjW+W3zx3Dux26vtIK40w5vE6u3Wj6vdKrVKAb0zYibzEtn93xAV9pq8Gmb6QABEFL8mnECxbs+9gmyo6R+Zd069tnF092d6kMn3RV4MWWrVv2b0Rzh4TdUruHR2IX3US7aPz7K099l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019450; c=relaxed/simple;
	bh=04HrMAW91GGpl4Lj8Qw3nEPtElggqwyhUZMKVJ6xvp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CutTJeXgJvU97NQawe7kbabY1n7fmfV83VbBCwo7Mu4vg1LadZ9giXnMXuyj8EjCuqhIabD1lFJZVCqjtVCfddqcLOisDaU3LbDVhciPboGU0JYmlLDQT1+W2S7rCv71Gylr6+BYN8Xu8IapyH/q4jOvu2DxbCgF2Ag5aC56XKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jV4OaAoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D45C4CED0;
	Thu, 12 Dec 2024 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019449;
	bh=04HrMAW91GGpl4Lj8Qw3nEPtElggqwyhUZMKVJ6xvp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jV4OaAoH4moCqNYCsGK3zF2YElrRU0wSCfWJjVrpJj10WSPPUCCzAufjMa0pSblwT
	 uwTpKVeEXfPca3CYlKzrYFHdwgOnD+tLifkISQ439hsvSGshb93iWtanUW5rxCDbpL
	 aGSI9MsecDJvXZQJz1bVB64z1uEoU0xNJbUeAd0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Can <yuancan@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 210/772] cpufreq: loongson2: Unregister platform_driver on failure
Date: Thu, 12 Dec 2024 15:52:35 +0100
Message-ID: <20241212144358.600909333@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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




