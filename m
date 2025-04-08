Return-Path: <stable+bounces-129228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51018A7FED6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75D53BF816
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0D26659C;
	Tue,  8 Apr 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmjSthYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAA374C4;
	Tue,  8 Apr 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110465; cv=none; b=tfltiIoD62yaEgk/ToEhIrhOGeUL6adQUF/OQuCKt6shNnnZQnuNbjvQ85bJySglKV06mqcGNaqU43JRP32xnRvJx8/lRTOd9qjGfRwn4R1QyMtwCZEpEFFeCPmKVlyZeRWfdCKskYUK4kfX7mYvdRcaIqqJSXdcd3fh/L2MR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110465; c=relaxed/simple;
	bh=KkP5lMb001YxOBwW7MC00kvkUyxe7YTy2CRBvr704xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi8lxAuLffd2VeR7MSJOk/jKEmN6Ze9aQKS33FCUcvdRQfFImujXQerRYnu6fMMj5BL0b+Sw/DPV3UMiZ/y2BoA3rkHsjKUwirCy4qHtnpRm255+gGIocaX3+a6lKW+xBgu1bAEEyp8N+wtgtKVbTcsKe/2fOGdKoZO9tZzBe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmjSthYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44140C4CEE5;
	Tue,  8 Apr 2025 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110463;
	bh=KkP5lMb001YxOBwW7MC00kvkUyxe7YTy2CRBvr704xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmjSthYRq3y+mY2B3XqryOp0JEJPxFZ5QhGnw0QPtFSm46ARpztRFfu2y7yveq4zw
	 LEBuqNBTuPcW6xnbLAbBr5T6wJoKSSxigmIpKARVGDDHhVNnZCU4xa49/dWedJgFyd
	 qonM68KFTHsVUlLVztvpv3npME8WING6AiDH1eBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 072/731] ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible
Date: Tue,  8 Apr 2025 12:39:29 +0200
Message-ID: <20250408104915.946341937@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayesh Choudhary <j-choudhary@ti.com>

[ Upstream commit 45ff65e30deb919604e68faed156ad96ce7474d9 ]

For 'ti,j7200-cpb-audio' compatible, there is support for only one PLL for
48k. For 11025, 22050, 44100 and 88200 sampling rates, due to absence of
J721E_CLK_PARENT_44100, we get EINVAL while running any audio application.
Add support for these rates by using the 48k parent clock and adjusting
the clock for these rates later in j721e_configure_refclk.

Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Link: https://patch.msgid.link/20250318113524.57100-1-j-choudhary@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/j721e-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index d9d1e021f5b2e..0f96cc45578d8 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -182,6 +182,8 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 		clk_id = J721E_CLK_PARENT_48000;
 	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_44100])
 		clk_id = J721E_CLK_PARENT_44100;
+	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_48000])
+		clk_id = J721E_CLK_PARENT_48000;
 	else
 		return ret;
 
-- 
2.39.5




