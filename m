Return-Path: <stable+bounces-102180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F229EF080
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CA9292AE9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780C2288EA;
	Thu, 12 Dec 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dax7vTf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86354222D74;
	Thu, 12 Dec 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020276; cv=none; b=U2fHhrraYmCoRfnx7yFrxpnIAxzMmmtgFNZ6jYMClZVmEwWTw2XcMzOzy/88/qeRq99p7A8bEiIMHcPxCJa4Hzu5Ez6xEDbmFVJj+FQWJo/awf/eGrlX18D3bxLcfExT0cBlLbt+Lpli/v5o8rpMzGAvj6m1RYUx8HU1HEZ/Kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020276; c=relaxed/simple;
	bh=EtOUdIP31eZu1ixrjaC3xp5VuGy/z+9h76CbkksSQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWB5xjorM+6UoeKF+Lt8CgTitfEW/TA9jnoGnHbvIrFJQenUwnx/BXHBhrU/BUA5RxpGDajL4fUkr7yNMNIaCkvaOOR/KYZhrrpbEm+PwubO78E3as/8gGOc3M1Kcbmm1FGoT+QCgVOrZukeytbXte+glopFu684VdCI8jmhWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dax7vTf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF8C4CECE;
	Thu, 12 Dec 2024 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020276;
	bh=EtOUdIP31eZu1ixrjaC3xp5VuGy/z+9h76CbkksSQIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dax7vTf7Z93W0PyqSUMYojLs3s+xmSqQYq4BnTGcOzEXfuYQLwiAqvrD+JwsheQcS
	 h/RJiTo9pFCOrJI1xoYPtb+K/YoYvA3peqjppETYGnZbi7xWiIfcA++96F2nYz9ACP
	 cTKXK9CFbh/FJwMxfPICLQYZ9yMZQbtKwHyf6iC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.1 394/772] cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()
Date: Thu, 12 Dec 2024 15:55:39 +0100
Message-ID: <20241212144406.194425869@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 172bf5ed04cb6c9e66d58de003938ed5c8756570 upstream.

mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
em_create_perf_table(), the later zero check for power is not invalid
as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
the 'policy' is not found. So return -EINVAL to fix it.

Cc: stable@vger.kernel.org
Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -62,7 +62,7 @@ mtk_cpufreq_get_cpu_power(struct device
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
 	if (!policy)
-		return 0;
+		return -EINVAL;
 
 	data = policy->driver_data;
 



