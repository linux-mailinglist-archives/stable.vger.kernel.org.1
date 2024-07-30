Return-Path: <stable+bounces-63015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D89416B5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D08EB23EF4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2565187FF2;
	Tue, 30 Jul 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k7ppLE5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998008BE8;
	Tue, 30 Jul 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355380; cv=none; b=bJ05FHJ4buuo4eeFnRgvJlKeQ/pzIDgwzgryJ2iJiQ8iOvccotnBKOo8zMzvk+d3NkjqXs+bUTX8mEYgY86qHL1/QGfDbB6EFtanec4PZcOBCS3OrZgpoxM+/ilDnaU5Jh1n9/HIoce5+iPd4u9LVJIarYV9HdW66r85VewHRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355380; c=relaxed/simple;
	bh=3ZfeE307sbSecmpSDLZ0axuMQ85qwOZsedKHrkbz3AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ovnla5i7LkF0YzHxk4VDzpm9KBM/sQlznrpVM2ykTBzY1a8wqaw71pNcEvvdbvf5z7PI3Jut+lhAGu0xgOkaZQBqxQYUeRzXcvpqM0psWuIfIIvGPr+/jrh0NyXtQZuRe+gzy2GCsE5V5ZS8KwRXTvO6NtIShL84SPmwjXeqxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k7ppLE5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F88C4AF0E;
	Tue, 30 Jul 2024 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355380;
	bh=3ZfeE307sbSecmpSDLZ0axuMQ85qwOZsedKHrkbz3AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7ppLE5J5ywe6RKVNC+bx+CBXW2Km0u+wVE5fzkGp0RxFf32xaIVvZzWJmsDTGZme
	 81zYC+Is5hJRJT8tEl08irHLr5jglAB69un50ch6CaZOKOowAiPi+7175PgJmtETcG
	 rDmfaXUOKKwodr//01OlYjQk3ke9uLIc8z100Ct0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Primoz Fiser <primoz.fiser@norik.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/568] cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
Date: Tue, 30 Jul 2024 17:42:40 +0200
Message-ID: <20240730151641.912926363@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Primoz Fiser <primoz.fiser@norik.com>

[ Upstream commit 101388b8ef1027be72e399beeb97293cce67bb24 ]

Handle deferred probing gracefully by using dev_err_probe() to not
spam console with unnecessary error messages.

Fixes: f88d152dc739 ("cpufreq: ti: Migrate to dev_pm_opp_set_config()")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3c37d78996607..d88ee87b1cd6f 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -418,7 +418,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
 	if (ret < 0) {
-		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
+		dev_err_probe(opp_data->cpu_dev, ret, "Failed to set OPP config\n");
 		goto fail_put_node;
 	}
 
-- 
2.43.0




