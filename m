Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD75E7A80BE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjITMka (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjITMjw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30547129
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6F2C433CA;
        Wed, 20 Sep 2023 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213581;
        bh=uanJtc3BU2606/puhkMK1j/vROfufs/941MnsGAbLXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsnTihdaCeVSrPeIMojZTFt/0y3Z2TgfpyCrscRuOyO2Z9M6jKiurUI0Tuz2/ABj3
         dCM1clyTzdbn5NDuBLAOTj5JOsuNXAXX2iEXXLPBeUbQ/iEI/QWAT71wpXTlH/xfEy
         sQHKbJktmo5jh2yxA5YuAXGMSJzrTRYpmvZK49uI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 289/367] usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling
Date:   Wed, 20 Sep 2023 13:31:06 +0200
Message-ID: <20230920112906.037249518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8afe9a3548f9d1805dcea6d97978f2179c8403a3 ]

Refactor the tcpm_handle_vdm_request payload handling by doing the
endianness conversion only once directly inside tcpm_handle_vdm_request
itself instead of doing it multiple times inside various helper functions
called by tcpm_handle_vdm_request.

This is a preparation patch for some further refactoring to fix an AB BA
lock inversion between the tcpm code and some altmode drivers.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200724174702.61754-3-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f23643306430 ("usb: typec: bus: verify partner exists in typec_altmode_attention")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 49 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b259a4a28f81a..949325692e664 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -969,16 +969,15 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	port->vdm_state = VDM_STATE_READY;
 }
 
-static void svdm_consume_identity(struct tcpm_port *port, const __le32 *payload,
-				  int cnt)
+static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
-	u32 vdo = le32_to_cpu(payload[VDO_INDEX_IDH]);
-	u32 product = le32_to_cpu(payload[VDO_INDEX_PRODUCT]);
+	u32 vdo = p[VDO_INDEX_IDH];
+	u32 product = p[VDO_INDEX_PRODUCT];
 
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
-	port->partner_ident.cert_stat = le32_to_cpu(payload[VDO_INDEX_CSTAT]);
+	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
 	port->partner_ident.product = product;
 
 	typec_partner_set_identity(port->partner);
@@ -988,17 +987,15 @@ static void svdm_consume_identity(struct tcpm_port *port, const __le32 *payload,
 		 PD_PRODUCT_PID(product), product & 0xffff);
 }
 
-static bool svdm_consume_svids(struct tcpm_port *port, const __le32 *payload,
-			       int cnt)
+static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
 	int i;
 
 	for (i = 1; i < cnt; i++) {
-		u32 p = le32_to_cpu(payload[i]);
 		u16 svid;
 
-		svid = (p >> 16) & 0xffff;
+		svid = (p[i] >> 16) & 0xffff;
 		if (!svid)
 			return false;
 
@@ -1008,7 +1005,7 @@ static bool svdm_consume_svids(struct tcpm_port *port, const __le32 *payload,
 		pmdata->svids[pmdata->nsvids++] = svid;
 		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
 
-		svid = p & 0xffff;
+		svid = p[i] & 0xffff;
 		if (!svid)
 			return false;
 
@@ -1038,8 +1035,7 @@ static bool svdm_consume_svids(struct tcpm_port *port, const __le32 *payload,
 	return false;
 }
 
-static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
-			       int cnt)
+static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
 	struct typec_altmode_desc *paltmode;
@@ -1056,7 +1052,7 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 
 		paltmode->svid = pmdata->svids[pmdata->svid_index];
 		paltmode->mode = i;
-		paltmode->vdo = le32_to_cpu(payload[i]);
+		paltmode->vdo = p[i];
 
 		tcpm_log(port, " Alternate mode %d: SVID 0x%04x, VDO %d: 0x%08x",
 			 pmdata->altmodes, paltmode->svid,
@@ -1084,21 +1080,17 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
 
-static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
+static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 			u32 *response)
 {
 	struct typec_altmode *adev;
 	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
-	u32 p[PD_MAX_PAYLOAD];
 	int rlen = 0;
 	int cmd_type;
 	int cmd;
 	int i;
 
-	for (i = 0; i < cnt; i++)
-		p[i] = le32_to_cpu(payload[i]);
-
 	cmd_type = PD_VDO_CMDT(p[0]);
 	cmd = PD_VDO_CMD(p[0]);
 
@@ -1159,13 +1151,13 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
 			/* 6.4.4.3.1 */
-			svdm_consume_identity(port, payload, cnt);
+			svdm_consume_identity(port, p, cnt);
 			response[0] = VDO(USB_SID_PD, 1, CMD_DISCOVER_SVID);
 			rlen = 1;
 			break;
 		case CMD_DISCOVER_SVID:
 			/* 6.4.4.3.2 */
-			if (svdm_consume_svids(port, payload, cnt)) {
+			if (svdm_consume_svids(port, p, cnt)) {
 				response[0] = VDO(USB_SID_PD, 1,
 						  CMD_DISCOVER_SVID);
 				rlen = 1;
@@ -1177,7 +1169,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			break;
 		case CMD_DISCOVER_MODES:
 			/* 6.4.4.3.3 */
-			svdm_consume_modes(port, payload, cnt);
+			svdm_consume_modes(port, p, cnt);
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
 				u16 svid = modep->svids[modep->svid_index];
@@ -1240,15 +1232,18 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 static void tcpm_handle_vdm_request(struct tcpm_port *port,
 				    const __le32 *payload, int cnt)
 {
-	int rlen = 0;
+	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
-	u32 p0 = le32_to_cpu(payload[0]);
+	int i, rlen = 0;
+
+	for (i = 0; i < cnt; i++)
+		p[i] = le32_to_cpu(payload[i]);
 
 	if (port->vdm_state == VDM_STATE_BUSY) {
 		/* If UFP responded busy retry after timeout */
-		if (PD_VDO_CMDT(p0) == CMDT_RSP_BUSY) {
+		if (PD_VDO_CMDT(p[0]) == CMDT_RSP_BUSY) {
 			port->vdm_state = VDM_STATE_WAIT_RSP_BUSY;
-			port->vdo_retry = (p0 & ~VDO_CMDT_MASK) |
+			port->vdo_retry = (p[0] & ~VDO_CMDT_MASK) |
 				CMDT_INIT;
 			mod_delayed_work(port->wq, &port->vdm_state_machine,
 					 msecs_to_jiffies(PD_T_VDM_BUSY));
@@ -1257,8 +1252,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 		port->vdm_state = VDM_STATE_DONE;
 	}
 
-	if (PD_VDO_SVDM(p0))
-		rlen = tcpm_pd_svdm(port, payload, cnt, response);
+	if (PD_VDO_SVDM(p[0]))
+		rlen = tcpm_pd_svdm(port, p, cnt, response);
 
 	if (rlen > 0) {
 		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
-- 
2.40.1



