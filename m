Return-Path: <stable+bounces-90314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF789BE7B0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673121F21245
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A01DF254;
	Wed,  6 Nov 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NJnWA48/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A321DED40;
	Wed,  6 Nov 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895406; cv=none; b=ot6xyT31GfAcY9mKFM+yttm0goPT6NYnLPAnZsdhvDtDWPfDVlJtLfOV4T9yqrGxYCq0iBNCCKpMgQDpA42Rt+P40joBtInrIQj3hoVUp3J3rari/cRaxdQDBopvozg1DcPacPHRq7W+dg1q/ac+DXoFTEle9MZLm7wRhkTJNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895406; c=relaxed/simple;
	bh=26tdtrBXsKECzEJJ6LC1k4KcacnOigPkv4hOR4SBzLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkaRV2vkMMFNBiS4T19HqHMZpuKsvAFbjSlpNjBDSJlPI4Evj0VxGeaBuPVIFGj94xWJXKiBGBeOD4V82iM+XV6YUEv18OTBKMH6BNGaXV3YOyTUfM8ELkYei0QEQtUW36rQ2I7u4YSKrrktKMDXWbBTxa3wuM4hUIp19eyNgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NJnWA48/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABD1C4CECD;
	Wed,  6 Nov 2024 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895406;
	bh=26tdtrBXsKECzEJJ6LC1k4KcacnOigPkv4hOR4SBzLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJnWA48/QhrM1hMUO0pSro/geZqS4wR5uHBWmby2VHxpQ7vcwFsQH2zfYzA+Vy3Vy
	 dJYbd3jqYU4zOntn+v8bwy+QNu69mar8Fx9E4yIi7a3/3s/MUBUMr6FPLuGhvKajR0
	 0tbEDhQitosQZt0BoVXSqgkpE7o3vMfn+v9IW9DQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 206/350] clk: rockchip: fix error for unknown clocks
Date: Wed,  6 Nov 2024 13:02:14 +0100
Message-ID: <20241106120326.073006958@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Reichel <sebastian.reichel@collabora.com>

commit 12fd64babaca4dc09d072f63eda76ba44119816a upstream.

There is a clk == NULL check after the switch to check for
unsupported clk types. Since clk is re-assigned in a loop,
this check is useless right now for anything but the first
round. Let's fix this up by assigning clk = NULL in the
loop before the switch statement.

Fixes: a245fecbb806 ("clk: rockchip: add basic infrastructure for clock branches")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[added fixes + stable-cc]
Link: https://lore.kernel.org/r/20240325193609.237182-6-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -444,12 +444,13 @@ void __init rockchip_clk_register_branch
 				      struct rockchip_clk_branch *list,
 				      unsigned int nr_clk)
 {
-	struct clk *clk = NULL;
+	struct clk *clk;
 	unsigned int idx;
 	unsigned long flags;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		flags = list->flags;
+		clk = NULL;
 
 		/* catch simple muxes */
 		switch (list->branch_type) {



