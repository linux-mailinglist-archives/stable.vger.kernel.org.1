Return-Path: <stable+bounces-185814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DFBDE9B8
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88863505563
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455F32E732;
	Wed, 15 Oct 2025 12:59:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B332A3D4;
	Wed, 15 Oct 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533145; cv=none; b=chfVrdiVIgjdEQOPsnHUe8uhS6msieCO6/BvTs5C6n2k5kfQFuz3oeB1oJh6QObVqNbF9z95ZwEzJiZemG9E/TqKtH8b9vdCHzU6Y0e4+ekgKsYaJEd9duKMRGsCQ7ZdXw+FVcIZSDDzbuIkPKtD3eBesFVylIrarHvvE/RlW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533145; c=relaxed/simple;
	bh=LMiYRhgZHOP+mwtrGlv8QTxTj4mdlaijPU+p0jN/mB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XidkacYi/zRH5BnDhjvyZ+p6lth/dQVwkYmhPyg0zzy0TypGvu+NWTTUmCX7K5/kw7eL47X+PV2nwvJBQo68yiQkA84JuimAH82br9pCLa824t6do/KK+DV3Ns6uWhqWP+/8efBfN6BUaU/FVrHkCLB85ifMf3MHzjx44D80rNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1760533112t14fd5e73
X-QQ-Originating-IP: 6IdzTds0RD0Og7V7u2LMIS9m1q6hyWPEx/VhNS48VgQ=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 20:58:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 206157979263438292
EX-QQ-RecipientCnt: 14
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] net: bonding: update the slave array for broadcast mode
Date: Wed, 15 Oct 2025 20:58:08 +0800
Message-Id: <20251015125808.53728-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MAMW4dxoxFytM1FsTajTbMSEjoW+HzEwyn7pkJrCvel5xJ5ybaQ2I+1T
	nNKs89HahHP5Iyg5Qh+w/uAoTnX234SUWuC3D1jmpLILsJGnA6YyFbUa81V9poo+Tot8cF3
	s+6k3Uqdxy8db5I0u9628VxCisWEWGvLZs0m7ctQgtBAq728GG9tGvdZ1GP7kvIYIQEYp3/
	AXQ8tIfKdV/4XqDzY5umEkBEzlja2x6qQMgidaJQEmr4kLVUXkNJPQtBEFHxrwrF2etiv4v
	KgzeEdoyCOv29AkpGH2R3hWY3U7eYBtKOeVNHnFjx0lTqlcJYclic1WZtJoo5jU26gICSqp
	Drj6EkgkcpHIaTxeMhZHqtsc1LNX9fSk5RFy1CQ3SSgVmNPcYLZJReLeTV+O6Tcy7zGbAHZ
	E0ONlWo9930iTz/PWOH89PA4TKhySi1UzZfN9niEJ3f5gWMIjXOxvgxzdhU4Da9AfolrsuY
	WCY+0pIR4bTyVD6G/MXEBCfUyKqXy6fA9EtcImdR6E1gDODrGRp3mBtPgdRVIrMLcln4hoj
	FX56rqdq8YIZuRtqtGBGTQIGa0wJjK0o1l4Fr8iWs4hQMLZ9PojCHAF3ydb7q0YS2WgCOeC
	ONYT0PHnNQxD/Nr63oG25NEpVAph9geKoUvq28K6CzYAa9Pt9yFRF6NkYJNcOLjiWtNXEJU
	jn1ZIW7igeOH6y1XgN1nMW9ZgA76ZDY4oL1IjdyVyWHgAHnm18HgZNU1K70Sgly1WxDFfcq
	uJlffgiLWGGU92uTwqGqriSy+DtTFoQRuJYonKNm+vXWUHv3a924Qg+Sl3ZVWNXKd8PZglX
	WXh3ku714PXakLLq0DJrqUhmOcU9hfFvlaf8bYxi7P3Hk/alyk2pPyFM3EtX2xU186ya85G
	82+wfX2PvFOMEKEJxO1k9x6MJD/fUGayxQsreWAGbSb52xDaVWcqffLLaSN1TY8WBFVkYYY
	0QltrJXLOixwRh9U55X47zsUKC0ZL0SVYO9PEkUFRvxEfig==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
Before this commit, on the broadcast mode, all devices were traversed using the
bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
Therefore, we need to update the slave array when enslave or release salve.

Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17c7542be6a5..2d6883296e32 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, NULL);
 
 	if (!slave_dev->netdev_ops->ndo_bpf ||
@@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	bond_upper_dev_unlink(bond, slave);
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, slave);
 
 	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
-- 
2.34.1


