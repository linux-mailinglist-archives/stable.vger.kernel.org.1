Return-Path: <stable+bounces-146777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC637AC5483
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5441BA4ECA
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C51A3159;
	Tue, 27 May 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3IE85Ll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622578F32;
	Tue, 27 May 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365276; cv=none; b=JwRtfna1P+lsHyWpBjJ1Hcz3aB7zx92i2YULyuQ6Mzr9S6LB4iAe8QlWcB31Ske4LwPtf8Hluul4sVKdxnJJBB8l9A0BESDq/pX+XZSBUDPFYW/WpkC7LAwV85v0zcCYtdbLL9AvzNwmYIA2thqpajBsrOAVr4woxAlxoZzLuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365276; c=relaxed/simple;
	bh=rM85SsjUgrZCI33oqKiBmm/9edb+Wby4kylt6y8o6g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOZkev89QQUyA7DJSLl30E+SdIHxAHMJjZD3tpZJDGxXejYc1YTmp2uNR3r9HIYXL/TYl66cAFSTPBejJIN+BCRgDYYeKKjuLai1vlnFX6rRiawubB6neckcbMZCGRmAYUCqPX2mZSrPozbBY6XfRHvHP7Q3rCzkRodaSNcbTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3IE85Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E59C4CEE9;
	Tue, 27 May 2025 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365276;
	bh=rM85SsjUgrZCI33oqKiBmm/9edb+Wby4kylt6y8o6g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3IE85LlC/RVmkIeLOUKoy25IXOsdY1vYhjhfO4VaTVB/9CzacbzsND2sVs+NHgxZ
	 y+QHWpQWjgldMPS24k9zuXniqxnd9FwWlUD7hD02Sc9Fed3dtSev7LTfisYlkJfqjp
	 92u6XuVtvnls76PUwEm9V9DKRZp0Ooh7EmYiy8gQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 324/626] wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
Date: Tue, 27 May 2025 18:23:37 +0200
Message-ID: <20250527162458.198236185@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit bdce0574243b43b3bb2064f609c0c326df44c4c6 ]

EHT MU PPDU contains user field of EHT-SIG field with STA-ID that
must match AID subfield in the Associate Response. Add a necessary
setting to prevent these from being inconsistent.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217061235.32031-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 93d760b8b5e35..9346fe082040c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3128,9 +3128,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 |
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
 
-	h2c->w6 = le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+	h2c->w6 = le32_encode_bits(vif->cfg.aid, CCTLINFO_G7_W6_AID12_PAID) |
+		  le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
 				   CCTLINFO_G7_W6_ULDL);
-	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_AID12_PAID | CCTLINFO_G7_W6_ULDL);
 
 	if (rtwsta_link) {
 		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
-- 
2.39.5




