Return-Path: <stable+bounces-101882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C524C9EEF1D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9092D286A1D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211EE2210DA;
	Thu, 12 Dec 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOJzv8AG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EF23FD16;
	Thu, 12 Dec 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019139; cv=none; b=WcdRwqoZEql021aVUpBhsrMp4iiuTIs7OkPakyEukTczCztWHRyMJPEtnBP+SGCJOlwdRKjSfL9yTQdC03X11dyRsMuuBm2P92ZAT3BUc8pOLLnE89ww/hD7qnUBuAypaUQei7v6sPaAMjbWrfYDEfoVGHjWPcvXiL5upEb4QEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019139; c=relaxed/simple;
	bh=sNI/TMVxTnJdMyn3vTSvf73Sbk4Db11j0FSnTge/V+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FanKsd7PjEllNdTHJuJwRoC6FiIh4owiZ+/DRRlMCrzx4VX05Er5NWx8ZrFQ8oLsL6W53NZtQC9jlQNoazR4KlpEVvwdC7UpLG3iAyNYKHVvUqfwWNBZBVfk9W8eXh7LcOLDGUGjOt9KcwP7LbKqRzpHKRudZpSLTsFn/rCzguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOJzv8AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F38C4CECE;
	Thu, 12 Dec 2024 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019139;
	bh=sNI/TMVxTnJdMyn3vTSvf73Sbk4Db11j0FSnTge/V+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOJzv8AGyNE8nhCVeYCODcZcv9nY9xlbU9F8h3afBukxHLrqXGu1CfRxH/qzZBhBa
	 +QkYJzgm0TNMHGgB3U3QrslR64QY7OzXfI+YJETLlDKe3KfohiVB+K0B6Z6sLllX4t
	 fpPYbXtR2lRQFP4JpZcFLyEFOwu1wkeEaQBTrVG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 098/772] soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
Date: Thu, 12 Dec 2024 15:50:43 +0100
Message-ID: <20241212144353.988702244@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 78261cb08f06c93d362cab5c5034bf5899bc7552 ]

This loop is supposed to break if the frequency returned from
clk_round_rate() is the same as on the previous iteration.  However,
that check doesn't make sense on the first iteration through the loop.
It leads to reading before the start of these->clk_perf_tbl[] array.

Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/8cd12678-f44a-4b16-a579-c8f11175ee8c@stanley.mountain
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index a0ceeede450f1..d18309d3d0401 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -597,7 +597,8 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 
 	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
 		freq = clk_round_rate(se->clk, freq + 1);
-		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
+		if (freq <= 0 ||
+		    (i > 0 && freq == se->clk_perf_tbl[i - 1]))
 			break;
 		se->clk_perf_tbl[i] = freq;
 	}
-- 
2.43.0




