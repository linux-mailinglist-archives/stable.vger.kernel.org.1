Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34579BB9D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbjIKWfG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbjIKO77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:59:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8DE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:59:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653CAC433C7;
        Mon, 11 Sep 2023 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444394;
        bh=9ieM9sBm+Voeup3z0AU8F3U2y6FfUhbM+oFpLXI19k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjMApQmZvPpM3NTMe34hjhTSpMfJYvdv7jGY7IiCOqRsSRX8K8xz2R+mbfBslFh4A
         xFTGIctfyvYRJsP5hx/CQeqFShQf5uVgERW3FY48B5ZxDhS4aGJkonnI39bJP9RyVW
         dTsQ2wNFWh2k4RChhZ9F5/fUMVgKLCZVEo9Eoi5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, RD Babiera <rdbabiera@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.4 715/737] usb: typec: tcpm: set initial svdm version based on pd revision
Date:   Mon, 11 Sep 2023 15:49:34 +0200
Message-ID: <20230911134710.491165866@linuxfoundation.org>
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

From: RD Babiera <rdbabiera@google.com>

commit c97cd0b4b54eb42aed7f6c3c295a2d137f6d2416 upstream.

When sending Discover Identity messages to a Port Partner that uses Power
Delivery v2 and SVDM v1, we currently send PD v2 messages with SVDM v2.0,
expecting the port partner to respond with its highest supported SVDM
version as stated in Section 6.4.4.2.3 in the Power Delivery v3
specification. However, sending SVDM v2 to some Power Delivery v2 port
partners results in a NAK whereas sending SVDM v1 does not.

NAK messages can be handled by the initiator (PD v3 section 6.4.4.2.5.1),
and one solution could be to resend Discover Identity on a lower SVDM
version if possible. But, Section 6.4.4.3 of PD v2 states that "A NAK
response Should be taken as an indication not to retry that particular
Command."

Instead, we can set the SVDM version to the maximum one supported by the
negotiated PD revision. When operating in PD v2, this obeys Section
6.4.4.2.3, which states the SVDM field "Shall be set to zero to indicate
Version 1.0." In PD v3, the SVDM field "Shall be set to 01b to indicate
Version 2.0."

Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230731165926.1815338-1-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3935,6 +3935,29 @@ static enum typec_cc_status tcpm_pwr_opm
 	}
 }
 
+static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
+{
+	switch (port->negotiated_rev) {
+	case PD_REV30:
+		break;
+	/*
+	 * 6.4.4.2.3 Structured VDM Version
+	 * 2.0 states "At this time, there is only one version (1.0) defined.
+	 * This field Shall be set to zero to indicate Version 1.0."
+	 * 3.0 states "This field Shall be set to 01b to indicate Version 2.0."
+	 * To ensure that we follow the Power Delivery revision we are currently
+	 * operating on, downgrade the SVDM version to the highest one supported
+	 * by the Power Delivery revision.
+	 */
+	case PD_REV20:
+		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
+		break;
+	default:
+		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
+		break;
+	}
+}
+
 static void run_state_machine(struct tcpm_port *port)
 {
 	int ret;
@@ -4172,10 +4195,12 @@ static void run_state_machine(struct tcp
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract to decide whether to send the command.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else {
 			port->send_discover = false;
+		}
 
 		/*
 		 * 6.3.5
@@ -4462,10 +4487,12 @@ static void run_state_machine(struct tcp
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else {
 			port->send_discover = false;
+		}
 
 		power_supply_changed(port->psy);
 		break;


