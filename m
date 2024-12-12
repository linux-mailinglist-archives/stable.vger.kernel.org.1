Return-Path: <stable+bounces-101865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC49EEEED
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795F528F9F4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BE236935;
	Thu, 12 Dec 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvaQa3Nk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074023692F;
	Thu, 12 Dec 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019082; cv=none; b=AWGM7K6FA3H97k/J558XqWo3HIxYcsrewGl6pMC/C4TrsXaQHDjkWnZKKyJmOCvCMsJ9k4W/ow+ZVKQwdx7HEj+ZxYGgAXqJfKQ+GKbM4KDeruqXLxVDef5efAg1FfppVXYhPcNbWb/EpG8rzQ4EKkE3Lh9sKmKnHE7yAwrR1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019082; c=relaxed/simple;
	bh=N5MvH0QH45/zXlmUWUdnaDU1z7n1N2fCJIbONkKVPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqcD9lgohZyKD3fOHDGsOq3H+2SqzJdpOknSppFCAdldByXHanZMFlRzlKpAruSTYUG9LyA5KTaLXpQX3m7BtFmj1vEgYDRqhTVomIEwJFz71PSZv40wzS27OsnNtKLcMwdaKk9W2UuR2dets4jhzPBZmt2gp5EWZeNdoaHbSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvaQa3Nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503E4C4CECE;
	Thu, 12 Dec 2024 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019081;
	bh=N5MvH0QH45/zXlmUWUdnaDU1z7n1N2fCJIbONkKVPiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvaQa3NkaSICUNpWO0BaJOBzHAFp014gPBeLDlhrlCMfYDZ3HXMZWe4NE/kJvuehL
	 KP6v3u9wHmIeX/+361MNV/8YBcTmcWTElh4NJpEw6LqS+PJSqZsVSf+zfdPTwuFjom
	 BFV4SFvuX4uO2THmK92DeYYKwmY5AeJFnnjwDTAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Zekun <zhangzekun11@huawei.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/772] pmdomain: ti-sci: Add missing of_node_put() for args.np
Date: Thu, 12 Dec 2024 15:50:57 +0100
Message-ID: <20241212144354.550028790@linuxfoundation.org>
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

From: Zhang Zekun <zhangzekun11@huawei.com>

[ Upstream commit afc2331ef81657493c074592c409dac7c3cb8ccc ]

of_parse_phandle_with_args() needs to call of_node_put() to decrement
the refcount of args.np. So, Add the missing of_node_put() in the loop.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Message-ID: <20241024030442.119506-2-zhangzekun11@huawei.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index 17984a7bffba5..b21b152ed5d0f 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -165,6 +165,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -192,7 +193,10 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pm_genpd_init(&pd->pd, NULL, true);
 
 				list_add(&pd->node, &pd_provider->pd_list);
+			} else {
+				of_node_put(args.np);
 			}
+
 			index++;
 		}
 	}
-- 
2.43.0




