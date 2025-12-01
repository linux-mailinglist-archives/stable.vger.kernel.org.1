Return-Path: <stable+bounces-197779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C421C96F52
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C8C3A6401
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF22FE58E;
	Mon,  1 Dec 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jM7WcwXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665182E6100;
	Mon,  1 Dec 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588504; cv=none; b=AHPK1IECpfSSzhejllGpMShq1mIU4zeKUi4ZC9IpUaRU2crpEn7VY/7PsLiBq8XHu1LDo7Uqdp4vjqMmr+4Sj7hhaNyUpKI1tVI6P5eqyXD+nbh74+oYHZRkUhplljWLvGfXo5XChRB+yrnpTCa/4GrEG25JJi8xOeGux0B51kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588504; c=relaxed/simple;
	bh=oN/EhsgFhdZ7ENeeUP2o5aIOa38HRUnKs3XAslMQkWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hM1EB1eXEIKeM99lqsCN1P3xmc2DIxGhv+VNkpCqJY/JBwsIzhFGcn5305uS14+C4gZCfr0GyN30HMCR8795h/RfPpNvow8tuyoslcBV09wFJuSsVfAMP1+KEFL0n5S6pkH+vIr0UAwbBm5go6SdKyp2lo/Ye1GM6+tSWGZmPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jM7WcwXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC51C4CEF1;
	Mon,  1 Dec 2025 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588504;
	bh=oN/EhsgFhdZ7ENeeUP2o5aIOa38HRUnKs3XAslMQkWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jM7WcwXTuBpLRW3qVzyKsgHmzVf+3I06GFCttc1UMivxG/itJTjBaSV3w47fmuQlc
	 1j4rRr9G47UlsI0NU30fcw69p/mjFwDEQyqdzcwUMFTvLa3IzuvIg7s6opbSg+hUmq
	 xn7TcBgl21uhceYxsgwg6ynYvySfRxzENr4fjbXM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 071/187] mips: lantiq: xway: sysctrl: rename stp clock
Date: Mon,  1 Dec 2025 12:22:59 +0100
Message-ID: <20251201112243.801600804@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit b0d04fe6a633ada2c7bc1b5ddd011cbd85961868 ]

Bindig requires a node name matching ‘^gpio@[0-9a-f]+$’. This patch
changes the clock name from “stp” to “gpio”.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/lantiq/xway/sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 6c2d9779ac727..e52dfd4bad573 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -459,7 +459,7 @@ void __init ltq_soc_init(void)
 	/* add our generic xway clocks */
 	clkdev_add_pmu("10000000.fpi", NULL, 0, 0, PMU_FPI);
 	clkdev_add_pmu("1e100a00.gptu", NULL, 1, 0, PMU_GPT);
-	clkdev_add_pmu("1e100bb0.stp", NULL, 1, 0, PMU_STP);
+	clkdev_add_pmu("1e100bb0.gpio", NULL, 1, 0, PMU_STP);
 	clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
 	clkdev_add_pmu("1e104100.dma", NULL, 1, 0, PMU_DMA);
 	clkdev_add_pmu("1e100800.spi", NULL, 1, 0, PMU_SPI);
-- 
2.51.0




