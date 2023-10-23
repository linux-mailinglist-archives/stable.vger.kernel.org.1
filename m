Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92A47D326D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjJWLT5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjJWLT4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:19:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBADE8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:19:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61AAC433CA;
        Mon, 23 Oct 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059993;
        bh=wDOD1iJpPOl9URd3KhKwf0ggtTonHdJFXwa9msxpH+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k361anBe5E80OSn/rx+64Vh+84u0gohaAUU68xmGuFrmxJILLdLVpdaMg0dVWecIL
         8cIT10Q3nkP+q3CTbe0wjKZ3T6U8gqxXYpw7isAOy6lJOkYL1mEBcZB85jUWopvBWi
         lUvb9HC6VkagD7q+V4XcGNlF1Ee0fCKglUZqCw/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.1 006/196] igc: Add condition for qbv_config_change_errors counter
Date:   Mon, 23 Oct 2023 12:54:31 +0200
Message-ID: <20231023104828.667309629@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

commit ed89b74d2dc920cb61d3094e0e97ec8775b13086 upstream.

Add condition to increase the qbv counter during taprio qbv
configuration only.

There might be a case when TC already been setup then user configure
the ETF/CBS qdisc and this counter will increase if no condition above.

Fixes: ae4fe4698300 ("igc: Add qbv_config_change_errors counter")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |    1 +
 drivers/net/ethernet/intel/igc/igc_main.c |    2 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c  |    1 +
 3 files changed, 4 insertions(+)

--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -183,6 +183,7 @@ struct igc_adapter {
 	u32 max_frame_size;
 	u32 min_frame_size;
 
+	int tc_setup_type;
 	ktime_t base_time;
 	ktime_t cycle_time;
 	bool qbv_enable;
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6288,6 +6288,8 @@ static int igc_setup_tc(struct net_devic
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 
+	adapter->tc_setup_type = type;
+
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
 		return igc_tsn_enable_qbv_scheduling(adapter, type_data);
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -219,6 +219,7 @@ skip_cbs:
 		 * Gate Control List (GCL) is running.
 		 */
 		if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
+		    (adapter->tc_setup_type == TC_SETUP_QDISC_TAPRIO) &&
 		    tsn_mode_reconfig)
 			adapter->qbv_config_change_errors++;
 	} else {


