Return-Path: <stable+bounces-161386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4AAFE007
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D77A53C8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778D26C385;
	Wed,  9 Jul 2025 06:39:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228026B741;
	Wed,  9 Jul 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043181; cv=none; b=vE3UuTAzDwUPuarcufst936tRA+moL+IgVdK5pqQXJ1N4nGw0j1RpxKJ1CoB8ckvhpcVtO8lu3koXkLSab5VCleCd/BCp2iTp3bQ4FfnQ3dtOq2Nx75EBWJ+Yjar00QyHJlNk3LydwjD3Ir4EPIO6MU/XGyFA+jGfsY5E5sOulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043181; c=relaxed/simple;
	bh=3oahoAo7FjSC0pAG+QrYitvHYwtUea3t4pZh78HWJzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STVAUaV2cnaVhduawDAQpIz7Q+oSp5boA/duFXzcezAzxjjNUbMJii/PKEActg9198kGiv5L7VtYA5W89uA+12+du9duEtWQDBSVIq8433H6Fuot0wVmoBg8eS5tjfTf/9x2mkFAMQILA6DFgU7uSDxw/YvAMO5s2pjG9xZJoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1752042923t3f441c29
X-QQ-Originating-IP: Zrxlycv697GEyfLvfuDGGtICH4RgBnOU4orXfizMo9Y=
Received: from w-MS-7E16.trustnetic.com ( [36.20.45.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Jul 2025 14:35:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11727281486852275373
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: libwx: fix multicast packets received count
Date: Wed,  9 Jul 2025 14:35:12 +0800
Message-ID: <FD180EC06F384721+20250709063512.3343-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMB3uNxca02mwiZtLNrdY1AS7aMa4xvUnxRcjH+BojA5dJuv/HdjgCr0
	FAKkhL9HAhHmFqPQJu33zY5G6tAYWOJVa+BtFCKOJyWMmA7dTMnc7zSy0flDRLsQ2B86+FT
	gr6KZp6GEvtuVZERGvMlSceD5Z/BaWcHcVqtOojvXHfUTxdh5rJ8h9qcXRAhbYIUSFTTgUw
	UNioFlnnjPGauAtid3ziZimlmqUxTQ7P/94OSYg0qYmzspWpKQN03WLhH8tJI9ZD4GvSYxh
	VtzQI6hmYT1Dyg0ROhdusAXErd6D0Bg6j4jiGdm/Px0aKMS0kZ3I00bgQqRlo8Mhg0ghrUM
	XvacRB7vBry+1LTQo/4jCHI+GaNshh2P9qAuzwjkBchvmHED5d/PNMElAiLo3HvsQNjio70
	BGUeZZ/Cu2zwCLh/9IrnHFp+/z+3WdKEuJQzqdi1gT0Dfzt57t8BIkUa9u3DO5u8parhA/+
	YZyUv5JVpAK4rGfgVWlvHB1nKl/0RbwZoMgIQnp/I1tmdTFjPhMVlG32E15+XAM3GdxNg0q
	BFYKaDAPAIj8b5HhpPdnj4Q9lY5zW/akE5HpLi7Tj3ZttyVbsASg2xEU9/EW4baa7vHwEZV
	GEaMENOiIqIbMOS/dYLa+Z6kB/XqgzlFIvqijs5FVqpxB2Ut8nYpiClH2b9NkLAqdQhaT3f
	+A6YU40WdTlW5VTmV2M9L0urgD+++APtFH5J1dTDg6zOXI3CXfguUIjAxztBQP0MCmlQYdW
	ghSKdmbvXgXQiDVi68wMsAtVVrbPAG7HbYY6L2bjemW4VbheYZHnonbi4yPkqLc52nrnfR6
	8pFnylR10uNqRET1fd3RQ+oc0qn8qKHNbJCDRBwcjUHbzf5D3zkmx97y0nj2tSIUE7jfAlB
	LcIxHVtTEkk2W3AEq3gyAPmbxa78aUM1zVheRm6RueHQwhy2hvW0K3iNcrUA2kQ/TRkelbP
	ve6q3I5WG5ULPe/wPd4ssSRjYTcrLxEPjzyaaM+nFY6W3YMCvPGehwAqNumgQI+CMnK7SZB
	Fi1PA4QIRTy0NaAzXzCv6CxLjDpcw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Multicast good packets received by PF rings that pass ethternet MAC
address filtering are counted for rtnl_link_stats64.multicast. The
counter is not cleared on read. Fix the duplicate counting on updating
statistics.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 0f4be72116b8..a9519997286b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2778,6 +2778,7 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	hwstats->qmprc = 0;
 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
 	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
-- 
2.48.1


