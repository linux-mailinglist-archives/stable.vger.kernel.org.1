Return-Path: <stable+bounces-163636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED8B0CF78
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0397A16A3
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 02:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C141F5EA;
	Tue, 22 Jul 2025 02:01:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C9EC5
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149699; cv=none; b=tnjCbAflZKt+1JBwHpmmNaq2W/Bq5vlJF7BwJY5LIqvaqS3i+sfSuj9lv2doxG7ubn5z2OvVNRR8iczlDUoTfMHY2k7uMqDHSt2zsOxbzNDA/m+9/KWvFLc9mGNJHjbg3sdaMjmKz52npKY9V1tSJ9JGX+/8Kfpd9RrdGJCRvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149699; c=relaxed/simple;
	bh=zeYek1NLujcNW52qrd5UqFeGhquqDZYxXvNufOcVdS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2xKubLn8O8QYSOt/wYTSIEO7DreGYlBe6u2uem8rUhqLRFghSrOXwdKU2p4YOijJUKUJtC+A8fGlPZuzRQA7Zqj5TL4VZn+QBDHUyek17NsunikTEziuSAdp9ouhTasf9ob05IQpVR3V3DWhXMlSvHrQ+9inqDryM4VTbVPEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1753149656t03b02ddf
X-QQ-Originating-IP: h1w8yyNbmbeZGe5YLwAaYPRWAblqX9R5wZv/H3t1OyY=
Received: from w-MS-7E16.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 10:00:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12195864377310123750
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] net: libwx: fix multicast packets received count
Date: Tue, 22 Jul 2025 10:00:37 +0800
Message-ID: <DCAB16D0A9C714C3+20250722020037.3406-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025072137-disarm-donator-b329@gregkh>
References: <2025072137-disarm-donator-b329@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OUC5DGN0mB584uTFybPzBu5z6WeW8Zftv1rQaglIgp3F49OosbsNE2U3
	geIfui/tWee+Cg0gYxLN7tbmaUy6Rmxc+PhLycJrfjMJEKfRZ9/dacm5n1k6m3sCn8DC6zZ
	A6iRMct+1gvgoARlDv7riBZRzyQRut4P/fiPj3DWyCwPLrnnzwaB1CVgztLOldBZK3gI6u9
	hx0yKq4HYEvUO7imU3pxNoipzTwaxnWJzmg5222CUY2Fnk1G/G8rXh/mDaSxXNvAKLeBb1S
	DR6CONDoaZOnno5rg1CZHzwz+6JcbUzcTGLrlKkTxcgiiIkKwLKOywHokPWA/OX2cidJEYT
	OtjHsZZXyyHXrVb984SQk/Kq6NbrQ26/XXJGDp53XFHXLTRO4AlVpCJNlypPn43ev/vZw19
	QaJ7nPwk3LiMmBWhYq3WnnDYSH6TTHnbcNAsmCmP0sEenPVr4FBfQXXwXJ96ckoUi6SXOzq
	RY+HCaqdiyJJJSbe+i/e/RzXie9mp+QJd69EJMQfjQCfYY3zv4bqi30gE1Q/PHewncyPjZN
	nRvw3xG/uD0FZMej9s7TDse3I/Tze0kOzF8BbS9jtFI0OpUs+zk3+DuNDZTTHTlts6jnnFM
	CEb8ZI2Bv0J+sbzquffkWyvw4I+DrN6gyLF6okcJj/1UmPnm3kEkjU8Kr2aDfQZUBaxaEuA
	yqr/BHD7MV3T6jhZIi03y6P+vN2JPVvPD8MUfe/zdJ4INjMGCfyjcuZ9dnSCKaTznyoP7DW
	JALnslLPugkO2yVEEcdanlTKojYUz1TcJyzQwJf6RwwH22HUZXsTa/2/OeR8+EZ/Zr/sx9A
	Wno2/MaVyED92UIeHklfdjIcdutMLdGQhfG+FjegzxHLfb4LfT6HL5HuWKtTm01cLkkMeGv
	75s0YBlpcWWLbKu4GYxtuD6o4fOuh/e4f+gceoFkjEnRZZXGvBXFP5/NFc8GeHI7khF/IWs
	Y4pELT8VdhLr7K+1yWalf913XSHVoeROFQPjDZCFbd5xcdjW8SoKTdmfWXRgitGlEgEmUg4
	DP3G87dpAXspjHyhnM
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Multicast good packets received by PF rings that pass ethternet MAC
address filtering are counted for rtnl_link_stats64.multicast. The
counter is not cleared on read. Fix the duplicate counting on updating
statistics.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index deaf670c160e..ac5957d31674 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2356,6 +2356,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
-- 
2.25.1


