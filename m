Return-Path: <stable+bounces-186396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C4BE960E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D94C335BE1A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715A3370FB;
	Fri, 17 Oct 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DISOHp+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253B337114;
	Fri, 17 Oct 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713122; cv=none; b=GFwjVs31aGH0LWW5JPvjpe+zLqMNTsf2MNnbsMkosNGK8bIf0RIOCYb70OW883TQLdQLliCsVZcgQH97ZwB5jOmf5Kxdp3QiqTs3cmfFJG9MXTAJmxz7/Rlgm8A15eEGCMVc2xKvyKW/+rXIWTmgeTN+xfxp0GunX4gqUwbZbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713122; c=relaxed/simple;
	bh=hmdmdGWbCCCmmSCPSJl7WvU0FSDmRWPLTjVjYGMyUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsnHETDG+1gfjsfaFqi84R2ZP31YF1Im8WxoSIB6UbZ2Vn/TWk5MQqK44ZZYYZIe4Q6H+0IH3QiBeJ5dgyrw/dkJV8JShIhjKJVKOxs830/Jk7+BUskN3DbTROuZu5WEwYwvdZ2u4zTLXSv0nN8tZW1nukisp6CchjJo36fb33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DISOHp+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C726C4CEE7;
	Fri, 17 Oct 2025 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713122;
	bh=hmdmdGWbCCCmmSCPSJl7WvU0FSDmRWPLTjVjYGMyUYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DISOHp+unhNVfwuLJybtNEfkUGqKIFTH0U8Nzc4fc0K6SsVhcUnF6gw9frcMua1DY
	 f2Y8yuxWjRCFmYBsLJW/vjjqdMCOQZ2Wp+asilhtNSQ31MEFkViyb7kjT39SKOumor
	 DbJTSMQrZ2C7RKIHnfpBVzPx+pHBIKSbe6opICJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/168] clk: tegra: do not overallocate memory for bpmp clocks
Date: Fri, 17 Oct 2025 16:51:41 +0200
Message-ID: <20251017145129.836622970@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 49ef6491106209c595476fc122c3922dfd03253f ]

struct tegra_bpmp::clocks is a pointer to a dynamically allocated array
of pointers to 'struct tegra_bpmp_clk'.

But the size of the allocated area is calculated like it is an array
containing actual 'struct tegra_bpmp_clk' objects - it's not true, there
are just pointers.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 2db12b15c6f3 ("clk: tegra: Register clocks from root to leaf")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 39241662a412a..3bc56a3c6b240 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -603,7 +603,7 @@ static int tegra_bpmp_register_clocks(struct tegra_bpmp *bpmp,
 
 	bpmp->num_clocks = count;
 
-	bpmp->clocks = devm_kcalloc(bpmp->dev, count, sizeof(struct tegra_bpmp_clk), GFP_KERNEL);
+	bpmp->clocks = devm_kcalloc(bpmp->dev, count, sizeof(*bpmp->clocks), GFP_KERNEL);
 	if (!bpmp->clocks)
 		return -ENOMEM;
 
-- 
2.51.0




