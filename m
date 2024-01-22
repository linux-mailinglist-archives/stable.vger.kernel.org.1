Return-Path: <stable+bounces-14253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77E83802E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377261F2C6FA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6048651B1;
	Tue, 23 Jan 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZY4MkPkO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F864CEB;
	Tue, 23 Jan 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971575; cv=none; b=N6Slq5OYVYSSdA/A1RrrhABlyrvhdeEeH9ZsLeTmgyB4MJ4SgT+/ZDkM9ODm4LTayWCqU6O3ylqs7bhQwr36m9ArgG0v6SpBfTw/1NFV0/vrvFRnzEP3d6Q5MSkFkGgoOIEwmDHTrsCx2qx0Gpg3GZl4eBYelH3i4TTwonWSUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971575; c=relaxed/simple;
	bh=Ddf4KDBrFpMbVYhMdZ4M/3/M3aguFQqt06+4mj6dRM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8sdEWEHgLi3jeZYjqIljEtmstTKIvKXWrwrLZ8ewqCgmpI2MDAXCl+oftMlkV0uy8kRycSaC/O6pj8gN9TBUooVXa8ky238hFS5qW8wecvtGeZQrE7KbpexyQUHn8cfmEliEwca6xNV+tOS3ZLe0FDuliHLRr/3nV1G8OA6mIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZY4MkPkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35779C433C7;
	Tue, 23 Jan 2024 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971575;
	bh=Ddf4KDBrFpMbVYhMdZ4M/3/M3aguFQqt06+4mj6dRM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY4MkPkOl38U1wVo1rcokmbbeZLyH6xCyBOE8gXUBKXQDcUczThESTjkd+HVOwBy0
	 bxg8n6ws/OfVNNhlmvzHdKpuEsXVJ5OM1ThmkdxBHQKZTJcjybh7w5Omix1RXquKTr
	 QKbA/p9EywwJPb4Zw8zNKpZbPu8u2CnDrCnEcG1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 179/286] clk: zynqmp: make bestdiv unsigned
Date: Mon, 22 Jan 2024 15:58:05 -0800
Message-ID: <20240122235739.054167190@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

[ Upstream commit d3954b51b475c4848179cd90b24ac73684cdc76b ]

Divisor is always positive make it u32 *.
Also the arguments passed are currently of u32 pointers.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Link: https://lore.kernel.org/r/20220818113153.14431-1-shubhrajyoti.datta@amd.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 1fe15be1fb61 ("drivers: clk: zynqmp: update divider round rate logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/zynqmp/divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 66da02b83d39..57bf381f630d 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -112,7 +112,7 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 static void zynqmp_get_divider2_val(struct clk_hw *hw,
 				    unsigned long rate,
 				    struct zynqmp_clk_divider *divider,
-				    int *bestdiv)
+				    u32 *bestdiv)
 {
 	int div1;
 	int div2;
-- 
2.43.0




