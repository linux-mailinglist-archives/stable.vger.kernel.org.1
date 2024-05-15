Return-Path: <stable+bounces-45136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE998C6224
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494161F22488
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895A482C3;
	Wed, 15 May 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SmgL9IFq"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC342AAD;
	Wed, 15 May 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759545; cv=none; b=VFitBySnrJdp5Z/HItbjwYODDmvkU0HKM2uSmaNDJBcTQgZBwJYMb/8gorfrrQcw6KtKILoIZ2HpfMYas33+z/TikXrYdKGvLOP0pJIv5pvEK4BoQW97RD5nPr0Emm8nl0fL4R/m9Pc45aQngXS7P6gX5VhSWpWlBBt//JI6lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759545; c=relaxed/simple;
	bh=EseU8l9i6FsdcgIhuNlxtMXNzYYXWc+xZzlPU9p9RDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dw+x1fR5L4OGXAjfsmY8tp7NK6mISF4FmQD23iqwcmxW6sZQZbcbOxTvvVw4KtXk2+Gp7OU+EAdKVdHZf6gU9ZIyltlwLSuA6Wwk7c7yRel3JbjBW3p7ByQi8HmcZImoAWBv8R4Pvro+ftVMhE0bvEr9dmHu1osXO7j5vrwD1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SmgL9IFq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2f16930128d11efb92737409a0e9459-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+Kk+4ccaigRSqLMLy3uDs3B3e9ohN0+aD87eOWCOx5o=;
	b=SmgL9IFq2Ru43vBV3kmX/sDe/qXSzHH8X6hknfXWr0a1+8WLEs0BRbGCCE1GP32Yvs/HlDboT5q4IJy79/NTU/oxe3J54EE3LBn/YMS6SQW/DqnmCGHIf8YE1K1MHpoa7n1EQvRglaRq7MdXAKcxgeS9ZQG95zihT50AGG9LM+Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4ac413ad-28e7-4a18-815d-eae2a2a796df,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5a3a1dfc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2f16930128d11efb92737409a0e9459-20240515
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 410055962; Wed, 15 May 2024 15:37:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 15:37:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 15:37:13 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: yenchia.chen <yenchia.chen@mediatek.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Eric Dumazet <edumazet@google.com>, Sasha Levin
	<sashal@kernel.org>, Simon Horman <horms@kernel.org>, Pedro Tammela
	<pctammela@mojatatu.com>, Zhengchao Shao <shaozhengchao@huawei.com>, Ryosuke
 Yasuoka <ryasuoka@redhat.com>, Thomas Graf <tgraf@suug.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5.15 0/2] netlink, fix issues caught by syzbot
Date: Wed, 15 May 2024 15:36:36 +0800
Message-ID: <20240515073644.32503-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: "yenchia.chen" <yenchia.chen@mediatek.com>

Hi,

We think 5.15.y could pick these commits.

Below is the mainline commit:

netlink: annotate lockless accesses to nlk->max_recvmsg_len
[ Upstream commit a1865f2e7d10dde00d35a2122b38d2e469ae67ed ]

netlink: annotate data-races around sk->sk_err
[ Upstream commit d0f95894fda7d4f895b29c1097f92d7fee278cb2 ]

Eric Dumazet (2):
  netlink: annotate lockless accesses to nlk->max_recvmsg_len
  netlink: annotate data-races around sk->sk_err

 net/netlink/af_netlink.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.18.0


