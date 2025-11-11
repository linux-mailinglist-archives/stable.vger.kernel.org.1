Return-Path: <stable+bounces-194009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3330C4ACE9
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E34FB9CE
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E0265CA6;
	Tue, 11 Nov 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JduJHZvh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CD2836F;
	Tue, 11 Nov 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824589; cv=none; b=RRYZN3sctUMF8qzI9BXmpBnRU4dJ/RCvlPLYXOOxYQdejg5FJ6UxZZnZO+FTUa5suWYaP5hsYYXzhXKcetsW7xkmNI/nSjvS74ZC0kCTHmVhQT8K4Eumildp+BRj4JBVXXcrWiTKiF/AGeWe0uO4UlQ/pevMhfhpr6cD+DbYwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824589; c=relaxed/simple;
	bh=mHCnM3WRpWWIRB7NsVnzIsYcPMEK0Yszs9wEHK6x590=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgAA9VNIjvVONY2XqU+nyi/z6qoZ5Uxc2VzRHQRvQanmoVpecFuO3ys+LHJlGtZAvlsMI1rjG5t0teoN6r6L5QZg/DVWgCGShIncuvp8jH3SfY4pMmAEm2S3RRUqRX+sk3+WOVdOyvaMgm1lKLg+Lr+/zQPvsO7sExupE6VeQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JduJHZvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F91C4CEFB;
	Tue, 11 Nov 2025 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824589;
	bh=mHCnM3WRpWWIRB7NsVnzIsYcPMEK0Yszs9wEHK6x590=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JduJHZvhbiPY5WlD4xevFkRHLrQG6AOf1LZ3BNgvOQg+12AAQI0PTjDMzRDa/1S7z
	 HYGytbwHE1hEgU3lLAei6Kj215N7LbMwBOmz/U2hB3h4jA5JVX6VGcmeVopkhQKd4j
	 SJFSOkMfWqxaKEJa2x1KzWqEr34NDbT9ysgEPX04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 475/565] clk: clocking-wizard: Fix output clock register offset for Versal platforms
Date: Tue, 11 Nov 2025 09:45:31 +0900
Message-ID: <20251111004537.598460422@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

[ Upstream commit 7c2e86f7b5af93d0e78c16e4359318fe7797671d ]

The output clock register offset used in clk_wzrd_register_output_clocks
was incorrectly referencing 0x3C instead of 0x38, which caused
misconfiguration of output dividers on Versal platforms.

Correcting the off-by-one error ensures proper configuration of output
clocks.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 7a0269bdfbb38..d2142bab5e289 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1153,7 +1153,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 						(&pdev->dev,
 						 clkout_name, clk_name, 0,
 						 clk_wzrd->base,
-						 (WZRD_CLK_CFG_REG(is_versal, 3) + i * 8),
+						 (WZRD_CLK_CFG_REG(is_versal, 2) + i * 8),
 						 WZRD_CLKOUT_DIVIDE_SHIFT,
 						 WZRD_CLKOUT_DIVIDE_WIDTH,
 						 CLK_DIVIDER_ONE_BASED |
-- 
2.51.0




