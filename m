Return-Path: <stable+bounces-14816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED568382C1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0288BB2B3A7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3C5EE9D;
	Tue, 23 Jan 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyK96KmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7B5EE82;
	Tue, 23 Jan 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974414; cv=none; b=hSwdKLYitE7kAsqUDav0C8IRt1V3WmTaDu4JEjdN0OtjL3ex1EYej/GLn84ywUyQaIlmFmuoUvsAenWigfw4Vwu6vyU+LRV8E4jfp+BjNmVP9AfrEMHWAO5FE1kcaoj/kWhljWWRNke3UMit1gTKeHvMVA1bfcmcgnAtzixM4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974414; c=relaxed/simple;
	bh=BlcEGkVBDgRVYkeqJorkAlTA92mIMghhXCaoQoBUthc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+cti1J+FHcnqpTX5D/qFWAz3aZzxTiaYC7OfLHpu6JclYdreXoZqKIMJngCMBoMZpR0xKEGl2lE6YnnBe6OHtQ/SQl5F8iwiVphvuCVfYlBqbZDDKldVLLeBrjFn42/w5AeDqGoCfx5MnilVkKXIGNVhzR8cza7YLAwjZqDhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyK96KmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F7BC433C7;
	Tue, 23 Jan 2024 01:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974413;
	bh=BlcEGkVBDgRVYkeqJorkAlTA92mIMghhXCaoQoBUthc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyK96KmF+QWoLriA+jzNbVL7QLrGWOeuG76fLzSr7q9KAmMyNnGYRAcd+zpQhxMHZ
	 OdDoTERfFZgfevwg2ZNuZviq6kCxStteYGyyrPrgWUlX8u9nfuRY9JquG2780EwXLb
	 pVHpMrSon6QlreBRs/zjzi2eIHtiiOZR+5sRQSRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 216/374] clk: zynqmp: make bestdiv unsigned
Date: Mon, 22 Jan 2024 15:57:52 -0800
Message-ID: <20240122235752.161096242@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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
index cb49281f9cf9..9e535d3e1c0c 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -113,7 +113,7 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
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




