Return-Path: <stable+bounces-59716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FD932B69
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAAF1C220AF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1FD19A86F;
	Tue, 16 Jul 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="py/hJmzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF83F9E8;
	Tue, 16 Jul 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144690; cv=none; b=ZXf+dA2hUl2uGzlSSoD7H06ip97FVO0dAv4jbYAls9npPMjsBZXHtCQ23i87T+L3I2dj68NiMlBA7TXvX5sr/dknarO4jwEp9qPnU8T4wpxFgjx35xuBVu2WzPc7oRyPLq1Fc/mSot2SPZj8lUKCnuHLDGt6P2c/ILGvFt7mDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144690; c=relaxed/simple;
	bh=jdsI6Wdo5+l5A3yBROlrF7lIwXr7xBl3rVT4xeaUn8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As1gYGg6Ribm5juNI8YsesWLqwLb5vno6bbpg/+JW6OySKEyNLITnu2no+XBh1feP3G6iLBBew+iV17gYAQRKKoeQaLYc/bzbkpdUKxhv/5F3E3MshMdOc0mIr1BBs2ZVNqOXvAlEBdfMBZE26Do0/zlTeq2v/q9/bWlbN+19+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=py/hJmzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7295FC116B1;
	Tue, 16 Jul 2024 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144689;
	bh=jdsI6Wdo5+l5A3yBROlrF7lIwXr7xBl3rVT4xeaUn8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py/hJmzxJ7uyr91bU1gtE+TNEmJYgFT0G9OQoyJLIHS8FcTIZK9FWaoW/1Dxa2rvX
	 vO2anjZT4QvJW82j2x2KnijB973Se1hL/mRoVwaFjVcqxKSL2ZoM3xnVz801yFkwwy
	 y3WAbbYvXc2FcOG0IsFNyplu2VnQ9jCCdAmy2d0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10 075/108] net: ks8851: Fix potential TX stall after interface reopen
Date: Tue, 16 Jul 2024 17:31:30 +0200
Message-ID: <20240716152748.861230746@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit 7a99afef17af66c276c1d6e6f4dbcac223eaf6ac upstream.

The amount of TX space in the hardware buffer is tracked in the tx_space
variable. The initial value is currently only set during driver probing.

After closing the interface and reopening it the tx_space variable has
the last value it had before close. If it is smaller than the size of
the first send packet after reopeing the interface the queue will be
stopped. The queue is woken up after receiving a TX interrupt but this
will never happen since we did not send anything.

This commit moves the initialization of the tx_space variable to the
ks8851_net_open function right before starting the TX queue. Also query
the value from the hardware instead of using a hard coded value.

Only the SPI chip variant is affected by this issue because only this
driver variant actually depends on the tx_space variable in the xmit
function.

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20240709195845.9089-1-rwahl@gmx.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/micrel/ks8851_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -501,6 +501,7 @@ static int ks8851_net_open(struct net_de
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
 	ks->queued_len = 0;
+	ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
@@ -1057,7 +1058,6 @@ int ks8851_probe_common(struct net_devic
 	int ret;
 
 	ks->netdev = netdev;
-	ks->tx_space = 6144;
 
 	gpio = of_get_named_gpio_flags(dev->of_node, "reset-gpios", 0, NULL);
 	if (gpio == -EPROBE_DEFER)



