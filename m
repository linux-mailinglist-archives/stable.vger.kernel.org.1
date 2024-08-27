Return-Path: <stable+bounces-70912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA39610A5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA428168A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BAB1C5793;
	Tue, 27 Aug 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWBVjnPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092A1C3F19;
	Tue, 27 Aug 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771476; cv=none; b=QomI77B+KnxbuA0atEk8cCYEtAWP5ruSAvxAMtZGKilrpk5usAnxcO7rnGI7nSo/390lcDw63A42GgoLy1DdFgrwl8icf/IBeEYELE7ZZIxzC/WEAAkxmWK6prUuhPdPd1X3vTb7qDpx5zJtooBsNauimmhfadQVKibjEOh8lu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771476; c=relaxed/simple;
	bh=UX2ow45SWD55L8hVvXK+LEfckR1xm5R4l3dlpiBDsi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYctcG51fZTnYQe95buzrSQ/MM4ZgPXfoWT2NTffRgiUSoNoMDM5ou2qXtcqq0KolRooFQQGvpC2WXrkAK77RiuTxtOeuOsOO8gW2M+rzgw5xZWiAnS+bV8+ESuoV9b0Gs74epS8Gt3ekNHV25NaCRTU4EwMNdOMdBiQh+j4vDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWBVjnPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE09C4DDF2;
	Tue, 27 Aug 2024 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771476;
	bh=UX2ow45SWD55L8hVvXK+LEfckR1xm5R4l3dlpiBDsi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWBVjnPiEL36axWEmyUh8On/Xv5SdAxN4Wx42OCkDj/VysRFXzgFEwhBVxECFLnRD
	 YT3iHgLZy+ZSvsRHY07bBUbQ5oIqY0+nG82eLHhFmN89oB3IgmWE/1QP3cSnFwW99A
	 1wagKmHrx6V2QdvZq0RAiZIDpmKwHjNu40EeuAEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 168/273] bonding: fix bond_ipsec_offload_ok return type
Date: Tue, 27 Aug 2024 16:38:12 +0200
Message-ID: <20240827143839.801874401@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit fc59b9a5f7201b9f7272944596113a82cc7773d5 ]

Fix the return type which should be bool.

Fixes: 955b785ec6b3 ("bonding: fix suspicious RCU usage in bond_ipsec_offload_ok()")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2ed0da0684906..2370da4632149 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -599,34 +599,28 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	struct net_device *real_dev;
 	struct slave *curr_active;
 	struct bonding *bond;
-	int err;
+	bool ok = false;
 
 	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
 	curr_active = rcu_dereference(bond->curr_active_slave);
 	real_dev = curr_active->dev;
 
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		goto out;
-	}
 
-	if (!xs->xso.real_dev) {
-		err = false;
+	if (!xs->xso.real_dev)
 		goto out;
-	}
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
-	    netif_is_bond_master(real_dev)) {
-		err = false;
+	    netif_is_bond_master(real_dev))
 		goto out;
-	}
 
-	err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
+	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
 out:
 	rcu_read_unlock();
-	return err;
+	return ok;
 }
 
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
-- 
2.43.0




