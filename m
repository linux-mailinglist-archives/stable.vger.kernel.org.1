Return-Path: <stable+bounces-189185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FEC0411A
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 04:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505103A522E
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2677224AEB;
	Fri, 24 Oct 2025 02:00:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9D223702
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271243; cv=none; b=Tz9qq5WzyAglI4UCJUT72ZpGVMYb6cS8i/7+x3DHEkI1Tfy3J38XimfltyVGupMYjOF12vdKOE+cTEIlz4dCGus6M+02FeJiJLMyyeam77RcfJ0bsRH6Fc551fQKIJ8pYAuzm1C2Q7cGNzdvkuk13ax5SnbHr/8whd9uZkTgJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271243; c=relaxed/simple;
	bh=+qNuCq7mYYjTGzPi2PPGi0x9pmgCWYWsfIJYggjwFm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cVUi9TtHrh0idTuecszciQkmp1OwejKn1XPIrN7VlURX8Ff9c2hdqUz/nEqscQ6UBG+7ug4N7SIkCkpG0GKb1ZGKtXgzoxpAB1LL4w2lqMw7MUJirRHM2RX0Ky9uxGYjtqlPKppNLjQjJjEVftu9DCtUqh7yQlZieP3qk+6NxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 4B25323383;
	Fri, 24 Oct 2025 05:00:37 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kovalev@altlinux.org
Subject: [PATCH 5.15.y] net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
Date: Fri, 24 Oct 2025 05:00:36 +0300
Message-Id: <20251024020036.252395-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

commit 030ce919e114a111e83b7976ecb3597cefd33f26 upstream.

The stmmac platform drivers that do not open-code the clk_ptp_rate value
after having retrieved the default one from the device-tree can end up
with 0 in clk_ptp_rate (as clk_get_rate can return 0). It will
eventually propagate up to PTP initialization when bringing up the
interface, leading to a divide by 0:

 Division by zero in kernel.
 CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.30-00001-g48313bd5768a #22
 Hardware name: STM32 (Device Tree Support)
 Call trace:
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x6c/0x8c
  dump_stack_lvl from Ldiv0_64+0x8/0x18
  Ldiv0_64 from stmmac_init_tstamp_counter+0x190/0x1a4
  stmmac_init_tstamp_counter from stmmac_hw_setup+0xc1c/0x111c
  stmmac_hw_setup from __stmmac_open+0x18c/0x434
  __stmmac_open from stmmac_open+0x3c/0xbc
  stmmac_open from __dev_open+0xf4/0x1ac
  __dev_open from __dev_change_flags+0x1cc/0x224
  __dev_change_flags from dev_change_flags+0x24/0x60
  dev_change_flags from ip_auto_config+0x2e8/0x11a0
  ip_auto_config from do_one_initcall+0x84/0x33c
  do_one_initcall from kernel_init_freeable+0x1b8/0x214
  kernel_init_freeable from kernel_init+0x24/0x140
  kernel_init from ret_from_fork+0x14/0x28
 Exception stack(0xe0815fb0 to 0xe0815ff8)

Prevent this division by 0 by adding an explicit check and error log
about the actual issue. While at it, remove the same check from
stmmac_ptp_register, which then becomes duplicate

Fixes: 19d857c9038e ("stmmac: Fix calculations for ptp counters when clock input = 50Mhz.")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20250529-stmmac_tstamp_div-v4-1-d73340a794d5@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kovalev: bp to fix CVE-2025-38126 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 21cc8cd9e023..468aeedf22eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -522,7 +522,7 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 static inline u32 stmmac_cdc_adjust(struct stmmac_priv *priv)
 {
 	/* Correct the clk domain crossing(CDC) error */
-	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
+	if (priv->plat->has_gmac4)
 		return (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 	return 0;
 }
@@ -848,6 +848,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
+	if (!priv->plat->clk_ptp_rate) {
+		netdev_err(priv->dev, "Invalid PTP clock rate");
+		return -EINVAL;
+	}
+
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
-- 
2.50.1


