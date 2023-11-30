Return-Path: <stable+bounces-3310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091787FF4FF
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E39281707
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16054F94;
	Thu, 30 Nov 2023 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="suBV0b9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D21482CB;
	Thu, 30 Nov 2023 16:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC4AC433C7;
	Thu, 30 Nov 2023 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361505;
	bh=uO6V2ww+c6b6CAmUe7cm7442rxOlBOAE5/zb4BpKMTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suBV0b9NT2gcPzCq8tFqBAa+wzDoDoZUS/u5lWqQzPLo2ZZiyZs3ochedzU7UWgwy
	 QpboqE1dIR1DED30IGGJwwCJDSmXi9IJEaEdTJjyG4d0hVA+u/8epjsuffhgUZFBE3
	 feVfPURzxUNjwBkzPa4Zjv96cqxcKJOCXvwRa9jY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Elder <elder@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/112] net: ipa: fix one GSI register field width
Date: Thu, 30 Nov 2023 16:21:36 +0000
Message-ID: <20231130162141.875592999@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Elder <elder@linaro.org>

[ Upstream commit 37f0205538baf70beb57cdcb6c7d14aa13257926 ]

The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/20231122231708.896632-1-elder@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index d7b81a36d673b..145eb0bd096d6 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -78,7 +78,7 @@ REG_STRIDE_FIELDS(EV_CH_E_CNTXT_0, ev_ch_e_cntxt_0,
 		  0x0001c000 + 0x12000 * GSI_EE_AP, 0x80);
 
 static const u32 reg_ev_ch_e_cntxt_1_fmask[] = {
-	[R_LENGTH]					= GENMASK(19, 0),
+	[R_LENGTH]					= GENMASK(23, 0),
 };
 
 REG_STRIDE_FIELDS(EV_CH_E_CNTXT_1, ev_ch_e_cntxt_1,
-- 
2.42.0




