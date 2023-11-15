Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190A67ECDF5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjKOTjZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjKOTjX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6911A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C666EC433C8;
        Wed, 15 Nov 2023 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077160;
        bh=yE2KU9zVyy6gtq9xuXshLX6zFI1GrNLMAXQJREry5V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VT0kJBGOHRABdK3s37MJM/eJt57UCJHVtFfRB+guZ4fBmfrjsDhlm2L+i3budzfAG
         gm3FjX8FPXnn7sYSL4qRgCR6iQCnBnZJOjQ5FC9bM5VRmXH5i6xo4pWMg8q5zWmqSv
         U0LbN9Oe5qPMFJHHgHYXkeaZnRHBqaTZC63t5EIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 524/550] net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN
Date:   Wed, 15 Nov 2023 14:18:28 -0500
Message-ID: <20231115191637.262895314@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f968c56417f00be4cb62eadeed042a1e3c80dc53 ]

NETLINK_MAX_FMTMSG_LEN is currently hardcoded to 80, and we provide an
error printf-formatted string having 96 characters including the
terminating \0. Assuming each %d (representing a queue) gets replaced by
a number having at most 2 digits (a reasonable assumption), the final
string is also 96 characters wide, which is too much.

Reduce the verbiage a bit by removing some (partially) redundant words,
which makes the new printf-formatted string be 73 characters wide with
the trailing newline.

Fixes: 800db2d125c2 ("net: enetc: ensure we always have a minimum number of TXQs for stack")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202311061336.4dsWMT1h-lkp@intel.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20231106160311.616118-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35461165de0d2..b92e3aa7cd041 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2769,7 +2769,7 @@ static int enetc_setup_xdp_prog(struct net_device *ndev, struct bpf_prog *prog,
 	if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
 	    priv->num_tx_rings) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Reserving %d XDP TXQs does not leave a minimum of %d TXQs for network stack (total %d available)",
+				       "Reserving %d XDP TXQs does not leave a minimum of %d for stack (total %d)",
 				       num_xdp_tx_queues,
 				       priv->min_num_stack_tx_queues,
 				       priv->num_tx_rings);
-- 
2.42.0



