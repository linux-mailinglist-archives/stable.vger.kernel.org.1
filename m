Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778A7A7E90
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjITMSy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjITMSx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A350D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:18:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C680C433CB;
        Wed, 20 Sep 2023 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212325;
        bh=aTWLT6yOdBcdjfjMuhC3+zGTznnzkJHNA1sNRYjnY/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARmRDBJPCkpwnpJklZ5CHBfs/ym6j7ZLGNt739taGmC1B7KxUlcR8Hyu3Ny4UwOq7
         UsQbrUma15pwL4YsHWCBwyGqe3z/AgwTnStLe0ufW/ejSF5u7NV2CXX79EwS9f9uX4
         dSHkPim5PlxjRW0jPo4hknHbJbO3WqifFSl+Q3Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Simon Horman <horms@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 4.19 233/273] ixgbe: fix timestamp configuration code
Date:   Wed, 20 Sep 2023 13:31:13 +0200
Message-ID: <20230920112853.572490234@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

[ Upstream commit 3c44191dd76cf9c0cc49adaf34384cbd42ef8ad2 ]

The commit in fixes introduced flags to control the status of hardware
configuration while processing packets. At the same time another structure
is used to provide configuration of timestamper to user-space applications.
The way it was coded makes this structures go out of sync easily. The
repro is easy for 82599 chips:

[root@hostname ~]# hwstamp_ctl -i eth0 -r 12 -t 1
current settings:
tx_type 0
rx_filter 0
new settings:
tx_type 1
rx_filter 12

The eth0 device is properly configured to timestamp any PTPv2 events.

[root@hostname ~]# hwstamp_ctl -i eth0 -r 1 -t 1
current settings:
tx_type 1
rx_filter 12
SIOCSHWTSTAMP failed: Numerical result out of range
The requested time stamping mode is not supported by the hardware.

The error is properly returned because HW doesn't support all packets
timestamping. But the adapter->flags is cleared of timestamp flags
even though no HW configuration was done. From that point no RX timestamps
are received by user-space application. But configuration shows good
values:

[root@hostname ~]# hwstamp_ctl -i eth0
current settings:
tx_type 1
rx_filter 12

Fix the issue by applying new flags only when the HW was actually
configured.

Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 28 +++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index eec68cc9288c8..9c0e0ccbbe3cf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -844,6 +844,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	u32 tsync_tx_ctl = IXGBE_TSYNCTXCTL_ENABLED;
 	u32 tsync_rx_ctl = IXGBE_TSYNCRXCTL_ENABLED;
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	u32 aflags = adapter->flags;
 	bool is_l2 = false;
 	u32 regval;
 
@@ -864,20 +865,20 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	case HWTSTAMP_FILTER_NONE:
 		tsync_rx_ctl = 0;
 		tsync_rx_mtrl = 0;
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_SYNC_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_DELAY_REQ_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -891,8 +892,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_EVENT_V2;
 		is_l2 = true;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_NTP_ALL:
@@ -903,7 +904,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		if (hw->mac.type >= ixgbe_mac_X550) {
 			tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_ALL;
 			config->rx_filter = HWTSTAMP_FILTER_ALL;
-			adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+			aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
 			break;
 		}
 		/* fall through */
@@ -914,8 +915,6 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		 * Delay_Req messages and hardware does not support
 		 * timestamping all packets => return error
 		 */
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		config->rx_filter = HWTSTAMP_FILTER_NONE;
 		return -ERANGE;
 	}
@@ -947,8 +946,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 			       IXGBE_TSYNCRXCTL_TYPE_ALL |
 			       IXGBE_TSYNCRXCTL_TSIP_UT_EN;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
-		adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
-		adapter->flags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
+		aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+		aflags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
 		is_l2 = true;
 		break;
 	default:
@@ -981,6 +980,9 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 	IXGBE_WRITE_FLUSH(hw);
 
+	/* configure adapter flags only when HW is actually configured */
+	adapter->flags = aflags;
+
 	/* clear TX/RX time stamp registers, just to be sure */
 	ixgbe_ptp_clear_tx_timestamp(adapter);
 	IXGBE_READ_REG(hw, IXGBE_RXSTMPH);
-- 
2.40.1



