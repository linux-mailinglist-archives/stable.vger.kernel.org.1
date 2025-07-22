Return-Path: <stable+bounces-163656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B5B0D1B5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DA546B72
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE461CF7AF;
	Tue, 22 Jul 2025 06:09:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100528FA9F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164599; cv=none; b=CNtaCHBaONCWlhK1oVGBcSaqWy1yk4Hb9vhs4EZ+++M61zoRqmTcVhLlM0V2IgC1rfO23fiqRFnHMIW3JKAQDyphEn/oYvbuF23IM0yw5f9nZcOKkEIG8xoe3U15MHdfAFjc6d8osdZesYrTC9B/O9wifN1iVMqT+zitO0Gj7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164599; c=relaxed/simple;
	bh=yEtBdhWYCRBNwtCEi5gx7vOcERXAsVABjk//PMyEC2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfQI+nukR5zL8J5UutocipPjWrVfhHroLB7Fd8Y6yWqD+4ALzlZafQ7fXp9znvjZCVVO6QQk+0Ewuh0Ab4oBmmplfZuy6t4bL72PNHEIp/ud3+p37+vUh3O4tgGEznDISRssN1/PxgEPPljcjwVfrXyz575Hn+4TN2S59Ezy7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1753164578tc4ffeb52
X-QQ-Originating-IP: Gl0InKnrgqRRODFUKVa+xJI8aC8Yl63sjMQdQw+aRhs=
Received: from w-MS-7E16.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:09:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4513845936350232740
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.15.y] net: libwx: fix multicast packets received count
Date: Tue, 22 Jul 2025 14:09:31 +0800
Message-ID: <29E146077CD96A7C+20250722060931.8347-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025072136-steersman-voicing-574e@gregkh>
References: <2025072136-steersman-voicing-574e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NC2sbZ2AMa4KO+ixEIUZjZ8RpHvmYGz2CBhEqbJAdkwe2T6DT51asqMU
	lxt8EbMAUHX07ZOSg2aJ+s6GpeVUeSOBCLSPCbWFDNC9dS9qEFF1s8UHD3db5Z2xMhYJVr2
	OERe0eqdp77Q2GccfAT/qI6lnncVhl27225n/7i/LhOiQoWrS9KsDsEsGYUqc5t7LpwSMDe
	0ngnGw+gvX6RRlyUVWfcPYhm+fAy44hmq1ysUOmUbCsRI3VLBFgJkCBfNmTkV2p7GQBSOWc
	G5AHg+mCXZXeXMPlErixK7hwKRvFw+2HEWCcpS0ghxlftVKISREFrKhN2onVGDahPYccT3Q
	x/MC8E1sQUPjVuO7gy2e66NNrOxtU0WUlC1Y1HdZKjFn+Zf54fzPSYPlsQ8KGglExk9DalB
	PhtuPHGKrG18WY7vZUxW9JWOA386vny1b0CpFFCOc89O41bqeO7DkKOHlIwlbTKFobWr0nE
	QSiUdH0YutIXmIVt3RlAaLHYnH4c676LZfYlI74heoW2BJ8d53Crv3zAmIIdchIzGx3SjWG
	DdC0vRh0LY49TkJhxRlZqRQbDYXf72UZqoKGsZ06NgiygEGzHAq05Dy2MkOCoDPv1PG/IDC
	uV8M4+VAb/J4K439XMYjPHTI1BUoIEPYsgurdM0wJ45gdFzeKPuhaX6mU43izwQsa5TNKbr
	rdiZZVfiK6tewRci69cJtOkdBrIwGxl6VVpsMNwrSikYofqsFE/S7v1EVKnoUu4qN8hoiYk
	gunQruvkU1U+wBpSlfyEKdXEPUeIwArOYPXZBRRI+3Y9l+JUeW6BhRzRQOj/4ED5zV61w5B
	gfngSKxTfKl2jemoajrpPCEH5Smgh6DetfysoVMtigDHqNXlB/1/gOjijqcN5EtfTeHpaTK
	LGe14bgp/zllKSwNo8RKFyKfDfKrNEFHjiGB7QG3o7GX2nRw+xXN2BNBKHgnI2uHfvrTttJ
	GFr5AO7axT2ZHoOC3b5S1LX0bPAmTWycRSLkH56sejby1lG2XAWaA9RuTBz57mLSKKZKSyp
	R2IvaxoPSscMPclp4dxz7tG1h09z5z4qtkw1WPg8pAmVPvtSBr4MLBsGmK26+sB+PVMYN+o
	YGcPuiwNBnk7VVtkOGA70ndyhHhKaX61TrtUUQ+5iD8iYQgMimoJj7Q3DsHpN6/Tw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

commit 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77 upstream.

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
index 490d34233d38..884986973cde 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2524,6 +2524,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
-- 
2.25.1


