Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEF79C07F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjIKVDf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjIKOh7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE7CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F57C433C7;
        Mon, 11 Sep 2023 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443074;
        bh=HLw6lIUlP2Y66eciXT/Kfa3vCCHocT0VPI/rtoftwZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGnDEmQxWmcRWxcQLZktWQ+hwL3en7OReuMWuawswH21+hUjQl3t+IsgxiAa3Vohl
         4qeKbOzEWAO3ApASq4GwLABbHE/Oj99zk9o1saHrO1wlv+QmWjEFWqfoZ1Pv86ocsj
         IO4cZmVCV8IRfXrFQm1Uhf/h4GU0g64gSHXSbZh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Siddaraju DH <siddaraju.dh@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH 6.4 249/737] ice: avoid executing commands on other ports when driving sync
Date:   Mon, 11 Sep 2023 15:41:48 +0200
Message-ID: <20230911134657.553425418@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 0aacec49c29e7c5b1487e859b0c0a42388c34092 ]

The ice hardware has a synchronization mechanism used to drive the
simultaneous application of commands on both PHY ports and the source timer
in the MAC.

When issuing a sync via ice_ptp_exec_tmr_cmd(), the hardware will
simultaneously apply the commands programmed for the main timer and each
PHY port. Neither the main timer command register, nor the PHY port command
registers auto clear on command execution.

During the execution of a timer command intended for a single port on E822
devices, such as those used to configure a PHY during link up, the driver
is not correctly clearing the previous commands.

This results in unintentionally executing the last programmed command on
the main timer and other PHY ports whenever performing reconfiguration on
E822 ports after link up. This results in unintended side effects on other
timers, depending on what command was previously programmed.

To fix this, the driver must ensure that the main timer and all other PHY
ports are properly initialized to perform no action.

The enumeration for timer commands does not include an enumeration value
for doing nothing. Introduce ICE_PTP_NOP for this purpose. When writing a
timer command to hardware, leave the command bits set to zero which
indicates that no operation should be performed on that port.

Modify ice_ptp_one_port_cmd() to always initialize all ports. For all ports
other than the one being configured, write their timer command register to
ICE_PTP_NOP. This ensures that no side effect happens on the timer command.

To fix this for the PHY ports, modify ice_ptp_one_port_cmd() to always
initialize all other ports to ICE_PTP_NOP. This ensures that no side
effects happen on the other ports.

Call ice_ptp_src_cmd() with a command value if ICE_PTP_NOP in
ice_sync_phy_timer_e822() and ice_start_phy_timer_e822().

With both of these changes, the driver should no longer execute a stale
command on the main timer or another PHY port when reconfiguring one of the
PHY ports after link up.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 55 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a38614d21ea8f..de1d83300481d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -131,6 +131,8 @@ static void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case READ_TIME:
 		cmd_val |= GLTSYN_CMD_READ_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
@@ -1226,18 +1228,18 @@ ice_ptp_read_port_capture(struct ice_hw *hw, u8 port, u64 *tx_ts, u64 *rx_ts)
 }
 
 /**
- * ice_ptp_one_port_cmd - Prepare a single PHY port for a timer command
+ * ice_ptp_write_port_cmd_e822 - Prepare a single PHY port for a timer command
  * @hw: pointer to HW struct
  * @port: Port to which cmd has to be sent
  * @cmd: Command to be sent to the port
  *
  * Prepare the requested port for an upcoming timer sync command.
  *
- * Note there is no equivalent of this operation on E810, as that device
- * always handles all external PHYs internally.
+ * Do not use this function directly. If you want to configure exactly one
+ * port, use ice_ptp_one_port_cmd() instead.
  */
 static int
-ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
+ice_ptp_write_port_cmd_e822(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 {
 	u32 cmd_val, val;
 	u8 tmr_idx;
@@ -1261,6 +1263,8 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val |= PHY_CMD_ADJ_TIME_AT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	/* Tx case */
@@ -1306,6 +1310,39 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	return 0;
 }
 
+/**
+ * ice_ptp_one_port_cmd - Prepare one port for a timer command
+ * @hw: pointer to the HW struct
+ * @configured_port: the port to configure with configured_cmd
+ * @configured_cmd: timer command to prepare on the configured_port
+ *
+ * Prepare the configured_port for the configured_cmd, and prepare all other
+ * ports for ICE_PTP_NOP. This causes the configured_port to execute the
+ * desired command while all other ports perform no operation.
+ */
+static int
+ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
+		     enum ice_ptp_tmr_cmd configured_cmd)
+{
+	u8 port;
+
+	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+		enum ice_ptp_tmr_cmd cmd;
+		int err;
+
+		if (port == configured_port)
+			cmd = configured_cmd;
+		else
+			cmd = ICE_PTP_NOP;
+
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_port_cmd_e822 - Prepare all ports for a timer command
  * @hw: pointer to the HW struct
@@ -1322,7 +1359,7 @@ ice_ptp_port_cmd_e822(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
 		int err;
 
-		err = ice_ptp_one_port_cmd(hw, port, cmd);
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
 		if (err)
 			return err;
 	}
@@ -2252,6 +2289,9 @@ static int ice_sync_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		goto err_unlock;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	/* Issue the sync to activate the time adjustment */
 	ice_ptp_exec_tmr_cmd(hw);
 
@@ -2372,6 +2412,9 @@ int ice_start_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	ice_ptp_exec_tmr_cmd(hw);
 
 	err = ice_read_phy_reg_e822(hw, port, P_REG_PS, &val);
@@ -2847,6 +2890,8 @@ static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		return 0;
 	}
 
 	/* Read, modify, write */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3b68cb91bd819..096685237ca61 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -9,7 +9,8 @@ enum ice_ptp_tmr_cmd {
 	INIT_INCVAL,
 	ADJ_TIME,
 	ADJ_TIME_AT_TIME,
-	READ_TIME
+	READ_TIME,
+	ICE_PTP_NOP,
 };
 
 enum ice_ptp_serdes {
-- 
2.40.1



