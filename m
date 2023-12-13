Return-Path: <stable+bounces-5674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306380D5E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B376228239A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512955102F;
	Mon, 11 Dec 2023 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNHpAlb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A75101A;
	Mon, 11 Dec 2023 18:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6BAC433C8;
	Mon, 11 Dec 2023 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319361;
	bh=BNTTcyXE09BIJ+z1AKEACqEi3TFoIcT8W7mffZZwWKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNHpAlb3AIV2ZCl9sjKOs0RNPKkZ1gRgyu8xB1TaUpt5wLh5RIrmD4APTYbHw1vpt
	 ewmB01TSEntZ10i6eIqDBploZYBOxJU2MHuoYAVOy+4YXLNgjSBMALxBACrhzq6J2n
	 hiX5Vs5rLN1VbZne4M7Bn3IVbfv+pyHb11Meinek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/244] iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero
Date: Mon, 11 Dec 2023 19:19:00 +0100
Message-ID: <20231211182047.944620100@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit a206d9959f5ccd0fb2d54a997c993947ae0e881c ]

In __iavf_set_coalesce, the driver checks both ec->rx_coalesce_usecs and
ec->tx_coalesce_usecs for validity. It does this via a chain if if/else-if
blocks. If every single branch of the series of if statements exited, this
would be fine. However, the rx_coalesce_usecs is checked against zero to
print an informative message if use_adaptive_rx_coalesce is enabled. If
this check is true, it short circuits the entire chain of statements,
preventing validation of the tx_coalesce_usecs field.

Indeed, since commit e792779e6b63 ("iavf: Prevent changing static ITR
values if adaptive moderation is on") the iavf driver actually rejects any
change to the tx_coalesce_usecs or rx_coalesce_usecs when
use_adaptive_tx_coalesce or use_adaptive_rx_coalesce is enabled, making
this checking a bit redundant.

Fix this error by removing the unnecessary and redundant checks for
use_adaptive_rx_coalesce and use_adaptive_tx_coalesce. Since zero is a
valid value, and since the tx_coalesce_usecs and rx_coalesce_usecs fields
are already unsigned, remove the minimum value check. This allows assigning
an ITR value ranging from 0-8160 as described by the printed message.

Fixes: 65e87c0398f5 ("i40evf: support queue-specific settings for interrupt moderation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 12 ++----------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h    |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 90397293525f7..1b412754aa422 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -829,18 +829,10 @@ static int __iavf_set_coalesce(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	if (ec->rx_coalesce_usecs == 0) {
-		if (ec->use_adaptive_rx_coalesce)
-			netif_info(adapter, drv, netdev, "rx-usecs=0, need to disable adaptive-rx for a complete disable\n");
-	} else if ((ec->rx_coalesce_usecs < IAVF_MIN_ITR) ||
-		   (ec->rx_coalesce_usecs > IAVF_MAX_ITR)) {
+	if (ec->rx_coalesce_usecs > IAVF_MAX_ITR) {
 		netif_info(adapter, drv, netdev, "Invalid value, rx-usecs range is 0-8160\n");
 		return -EINVAL;
-	} else if (ec->tx_coalesce_usecs == 0) {
-		if (ec->use_adaptive_tx_coalesce)
-			netif_info(adapter, drv, netdev, "tx-usecs=0, need to disable adaptive-tx for a complete disable\n");
-	} else if ((ec->tx_coalesce_usecs < IAVF_MIN_ITR) ||
-		   (ec->tx_coalesce_usecs > IAVF_MAX_ITR)) {
+	} else if (ec->tx_coalesce_usecs > IAVF_MAX_ITR) {
 		netif_info(adapter, drv, netdev, "Invalid value, tx-usecs range is 0-8160\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 7e6ee32d19b69..10ba36602c0c1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -15,7 +15,6 @@
  */
 #define IAVF_ITR_DYNAMIC	0x8000	/* use top bit as a flag */
 #define IAVF_ITR_MASK		0x1FFE	/* mask for ITR register value */
-#define IAVF_MIN_ITR		     2	/* reg uses 2 usec resolution */
 #define IAVF_ITR_100K		    10	/* all values below must be even */
 #define IAVF_ITR_50K		    20
 #define IAVF_ITR_20K		    50
-- 
2.42.0




