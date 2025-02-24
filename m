Return-Path: <stable+bounces-119010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F139A423B8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D42419C1F33
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684318BC36;
	Mon, 24 Feb 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emolc6aG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822B1519A5;
	Mon, 24 Feb 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408014; cv=none; b=lwfzG4eFOvggm/fhXqhCSz0OUh9Jsu++97flFRvxsmOkvN5gdPDLZaLqfp/Pumd+xRjM9SpXGEv0h4X9CZqRDYeVH2CuFOrNhCaMab8dtGNtA0eOV45qJiKz96QBvQtEit07n/g9i6Fp1W5MHCw6jWGsMA76eQV/zOjAAzkSOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408014; c=relaxed/simple;
	bh=+Kk9DdLWwmc2WxKe53hrUsgCBIEJO1zNbe3mOPu4LNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl07A22vZy6I+ov53jenVH99PvVT8txtdGEGIDEPVVC9XRBqM3auslzSO725wdtWbi+1x0Yqh670kVrG2Ry1Z6E6D94l99cXIUQ90y+rxSyFo2vwd/O9p3Vp6pWJlLB3wyy5PqsvxWVpOdPttJLpdPe07/Fz/uvJVqnoFHo9X1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=emolc6aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69089C4CED6;
	Mon, 24 Feb 2025 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408013;
	bh=+Kk9DdLWwmc2WxKe53hrUsgCBIEJO1zNbe3mOPu4LNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emolc6aGNpkVCMtKvjxWMafV6Lt37fhH740Dhhcex7nxYT8bKS2aVtf1Rp6B8FsZD
	 OBPc75bxkZ/5eAE2wDtRPagxtijzi0TblAHRi30FG74zVwfh2O5ea6i9bxTGI26MmF
	 GSYWbBfHMgmfiP1ug/5PluAcrzKWnYtSu/NwAfXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Child <nnac123@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 075/140] ibmvnic: Return error code on TX scrq flush fail
Date: Mon, 24 Feb 2025 15:34:34 +0100
Message-ID: <20250224142605.956212818@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 5cb431dcf8048572e9ffc6c30cdbd8832cbe502d ]

In ibmvnic_xmit() if ibmvnic_tx_scrq_flush() returns H_CLOSED then
it will inform upper level networking functions to disable tx
queues. H_CLOSED signals that the connection with the vnic server is
down and a transport event is expected to recover the device.

Previously, ibmvnic_tx_scrq_flush() was hard-coded to return success.
Therefore, the queues would remain active until ibmvnic_cleanup() is
called within do_reset().

The problem is that do_reset() depends on the RTNL lock. If several
ibmvnic devices are resetting then there can be a long wait time until
the last device can grab the lock. During this time the tx/rx queues
still appear active to upper level functions.

FYI, we do make a call to netif_carrier_off() outside the RTNL lock but
its calls to dev_deactivate() are also dependent on the RTNL lock.

As a result, large amounts of retransmissions were observed in a short
period of time, eventually leading to ETIMEOUT. This was specifically
seen with HNV devices, likely because of even more RTNL dependencies.

Therefore, ensure the return code of ibmvnic_tx_scrq_flush() is
propagated to the xmit function to allow for an earlier (and lock-less)
response to a transport event.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Link: https://lore.kernel.org/r/20240416164128.387920-1-nnac123@linux.ibm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: bdf5d13aa05e ("ibmvnic: Don't reference skb after sending to VIOS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 61685c3053ad7..e1e4dc81ad309 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2371,7 +2371,7 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
 		ibmvnic_tx_scrq_clean_buffer(adapter, tx_scrq);
 	else
 		ind_bufp->index = 0;
-	return 0;
+	return rc;
 }
 
 static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -2424,7 +2424,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
@@ -2439,8 +2441,10 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		dev_kfree_skb_any(skb);
 		tx_send_failed++;
 		tx_dropped++;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
 		ret = NETDEV_TX_OK;
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
-- 
2.39.5




