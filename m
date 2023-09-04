Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52FE791D07
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjIDSeO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjIDSeN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62520CDB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3121FB80EF7
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E888C433C9;
        Mon,  4 Sep 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852448;
        bh=Jy1doPTpGlhtYqkugm8ITiuRJPWPoqEgIHEIS9doLNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1O8m6Nej4CHcUNsWMGcNfUxP2RllcGUfRNohe8lgqoJQ4snY/ZAvSdVcCZ9SZSv0r
         VyNL4n6bdHsMJVfbXlxhm4P9PpgcruY1xr/WwC2YuKQ4kDPkq4FHZblbGQuooXO1+f
         GzyEu0RvL4oBWqtJz/N3WmjqLOxjHkMRASIhTeeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.4 28/32] tcpm: Avoid soft reset when partner does not support get_status
Date:   Mon,  4 Sep 2023 19:30:26 +0100
Message-ID: <20230904182949.174130038@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
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

From: Badhri Jagan Sridharan <badhri@google.com>

commit 78e0ea4277546debf7e96797ac3b768539cc44f6 upstream.

When partner does not support get_status message, tcpm right now
responds with soft reset message. This causes PD renegotiation to
happen and resets PPS link. Avoid soft resetting the link when
partner does not support get_status message to mitigate PPS resets.

[  208.926752] Setting voltage/current limit 9500 mV 2450 mA
[  208.930407] set_auto_vbus_discharge_threshold mode:3 pps_active:y vbus:9500 ret:0
[  208.930418] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
[  208.930455] AMS POWER_NEGOTIATION finished

// ALERT message from the Source
[  213.948442] PD RX, header: 0x19a6 [1]
[  213.948451] state change SNK_READY -> GET_STATUS_SEND [rev3 GETTING_SOURCE_SINK_STATUS]
[  213.948457] PD TX, header: 0x492
[  213.950402] PD TX complete, status: 0
[  213.950427] pending state change GET_STATUS_SEND -> GET_STATUS_SEND_TIMEOUT @ 60 ms [rev3 GETTING_SOURCE_SINK_STATUS]

// NOT_SUPPORTED from the Source
[  213.959954] PD RX, header: 0xbb0 [1]

// sink sends SOFT_RESET
[  213.959958] state change GET_STATUS_SEND -> SNK_SOFT_RESET [rev3 GETTING_SOURCE_SINK_STATUS]
[  213.959962] AMS GETTING_SOURCE_SINK_STATUS finished
[  213.959964] AMS SOFT_RESET_AMS start
[  213.959966] state change SNK_SOFT_RESET -> AMS_START [rev3 SOFT_RESET_AMS]
[  213.959969] state change AMS_START -> SOFT_RESET_SEND [rev3 SOFT_RESET_AMS]

Cc: stable@vger.kernel.org
Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230820044449.1005889-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2753,6 +2753,13 @@ static void tcpm_pd_ctrl_request(struct
 			port->sink_cap_done = true;
 			tcpm_set_state(port, ready_state(port), 0);
 			break;
+		/*
+		 * Some port partners do not support GET_STATUS, avoid soft reset the link to
+		 * prevent redundant power re-negotiation
+		 */
+		case GET_STATUS_SEND:
+			tcpm_set_state(port, ready_state(port), 0);
+			break;
 		case SRC_READY:
 		case SNK_READY:
 			if (port->vdm_state > VDM_STATE_READY) {


