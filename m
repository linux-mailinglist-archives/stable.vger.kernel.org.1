Return-Path: <stable+bounces-97062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7809E2A3E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A5BA6D8A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D61F7550;
	Tue,  3 Dec 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kWWuGRqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF81F7071;
	Tue,  3 Dec 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239411; cv=none; b=EBpHQrCgQqNUBXCsuCHIQi6b0cCT7JvTtxUM4pfjj8o2SyakYx8BKY27D3J9veVVr6Mp60xDj0HmfvFwbXblfPPtjATBuDrOCenAP+v0cxao43VBijeeIBX/syiYQWrpl9RyuCn8y7sK6l4ZqoKSCKzj9eD4Awei0RuLYQN+Z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239411; c=relaxed/simple;
	bh=mWf0K4SoUsBQOJhMx/GtPalo4rkKOS/i7AHJOivRZug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tX30J/P6TzINxTer7AyTa+I6EbHZCdD2H59iOVQODLM3eG5ZLhr7SqcW5MYNkWkGFEJgz4wMjwxUpOdxQa44CkXv32xhtVPDNHZ5J7XoTGUX5l999SVB3+vX4HGQ4P4mOWhistRFK0zdj9wGWC0mlWUb0YqJv5iPbm7GadDPQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kWWuGRqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78541C4CECF;
	Tue,  3 Dec 2024 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239410;
	bh=mWf0K4SoUsBQOJhMx/GtPalo4rkKOS/i7AHJOivRZug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWWuGRqmfjdq+PC3NYUypZ2JDvUtPuWgu6VfhfEg6eUuXY5H+3wMoVQnkis41+vi+
	 AkCR4lHolHZ6zk9Lic/kWnJ2h3UU7bxk/raFQNGWSBqxpjSDJPJa4RKdH5vKpolyeW
	 WFlhDQKreVXJVJ5eM3FXx6pAa+2tAfIYbOPd5/bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 577/817] net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
Date: Tue,  3 Dec 2024 15:42:29 +0100
Message-ID: <20241203144018.436819937@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 407618d66dba55e7db1278872e8be106808bbe91 ]

On DWMAC3 and later, there's a RX Watchdog interrupt that's used for
interrupt coalescing. It's known to be buggy on some platforms, and
dwmac-socfpga appears to be one of them. Changing the interrupt
coalescing from ethtool doesn't appear to have any effect here.

Without disabling RIWT (Received Interrupt Watchdog Timer, I
believe...), we observe latencies while receiving traffic that amount to
around ~0.4ms. This was discovered with NTP but can be easily reproduced
with a simple ping. Without this patch :

64 bytes from 192.168.5.2: icmp_seq=1 ttl=64 time=0.657 ms

With this patch :

64 bytes from 192.168.5.2: icmp_seq=1 ttl=64 time=0.254 ms

Fixes: 801d233b7302 ("net: stmmac: Add SOCFPGA glue driver")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20241122141256.764578-1-maxime.chevallier@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index fdb4c773ec98a..e897b49aa9e05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -486,6 +486,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	plat_dat->riwt_off = 1;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
 		return ret;
-- 
2.43.0




