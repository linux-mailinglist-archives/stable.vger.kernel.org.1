Return-Path: <stable+bounces-76944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6826C983B15
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED241F22885
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D83BA41;
	Tue, 24 Sep 2024 02:09:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EE946C;
	Tue, 24 Sep 2024 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727143772; cv=none; b=J/q7rdx25HLwOeIs7AZuK+M448MCjel37bquU9Bofh3T5t9LKxdIqgbF1VTR35uqj3zxWUwgPic/wYqPPNuUbgTc9do7NkyU4KasYU+QNzkdQ0Q87rE4C69Gq9UiWwjHl7mhX42Hs7iYYYyZRR7VPmSbsayTb9dkgCMmJQCyuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727143772; c=relaxed/simple;
	bh=tSUVLDZbqnTrIf7U438NlgQ8b3IXpdPGHFMZ47OVw7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIIQnIxGwR5kNILd1pqyLktF2fo2dWX0x5PC0Qj+lBVhNK8gJzvRW6YRvbw/LTIAKTjfpQ220/JiAtT3ydeOmq+F6QeEo4TGbTIrbLm4UBAcy7sCKjstSG5ZBl2V+s9CqQbUux8Ao00PLhaoQvPE1IFnLz586ar+iCVDIclAf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp90t1727143653tgppiz91
X-QQ-Originating-IP: lDvefJhWyiwCpRbT3XAhDl4I21nTEfeNDd1nsEch1qU=
Received: from wxdbg.localdomain.com ( [60.186.242.192])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Sep 2024 10:07:15 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2214229136661899324
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pcs: xpcs: fix the wrong register that was written back
Date: Tue, 24 Sep 2024 10:28:57 +0800
Message-Id: <20240924022857.865422-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The value is read from the register TXGBE_RX_GEN_CTL3, and it should be
written back to TXGBE_RX_GEN_CTL3 when it changes some fields.

Cc: stable@vger.kernel.org
Fixes: f629acc6f210 ("net: pcs: xpcs: support to switch mode for Wangxun NICs")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs-wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index 19c75886f070..5f5cd3596cb8 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -109,7 +109,7 @@ static void txgbe_pma_config_1g(struct dw_xpcs *xpcs)
 	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0);
 	val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
 	val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
-	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL3, val);
 
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x20);
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0x46);
-- 
2.27.0


