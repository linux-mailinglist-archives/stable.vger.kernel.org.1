Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726AC7A80C0
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjITMkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjITMjx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE6AC9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63723C433C9;
        Wed, 20 Sep 2023 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213583;
        bh=xYTawRPuZIh+jF//ehjOGQs9cS92JY+RaafCKnmR3BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r89zsJqKsJ9ufIsxmQSYu162cIstL9LvtqI9zn6lPdUDBjXwp1SvKmiVSvQCoVH0L
         DdyDI9UMUVC3VgBrw0ww/3MfilPPDwtt78qTWSE7CpfhZBlV310gtEHzCdKPm7wLWZ
         KVliuCjwMNKjlZSwLPtxBxUim6kazLZuMSD/xSJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 290/367] usb: typec: tcpm: Refactor tcpm_handle_vdm_request
Date:   Wed, 20 Sep 2023 13:31:07 +0200
Message-ID: <20230920112906.062768780@linuxfoundation.org>
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

[ Upstream commit 95b4d51c96a87cd760c2a4f27fb28a59a27b6368 ]

Refactor tcpm_handle_vdm_request and its tcpm_pd_svdm helper function so
that reporting the results of the vdm to the altmode-driver is separated
out into a clear separate step inside tcpm_handle_vdm_request, instead
of being scattered over various places inside the tcpm_pd_svdm helper.

This is a preparation patch for fixing an AB BA lock inversion between the
tcpm code and some altmode drivers.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200724174702.61754-4-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f23643306430 ("usb: typec: bus: verify partner exists in typec_altmode_attention")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 76 ++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 949325692e664..9e71e0d9a09cd 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -159,6 +159,14 @@ enum pd_msg_request {
 	PD_MSG_DATA_SOURCE_CAP,
 };
 
+enum adev_actions {
+	ADEV_NONE = 0,
+	ADEV_NOTIFY_USB_AND_QUEUE_VDM,
+	ADEV_QUEUE_VDM,
+	ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL,
+	ADEV_ATTENTION,
+};
+
 /* Events from low level driver */
 
 #define TCPM_CC_EVENT		BIT(0)
@@ -1080,10 +1088,10 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
 
-static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
-			u32 *response)
+static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
+			const u32 *p, int cnt, u32 *response,
+			enum adev_actions *adev_action)
 {
-	struct typec_altmode *adev;
 	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
 	int rlen = 0;
@@ -1099,9 +1107,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 
 	modep = &port->mode_data;
 
-	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
-				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
-
 	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
 				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
 
@@ -1127,8 +1132,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 			break;
 		case CMD_ATTENTION:
 			/* Attention command does not have response */
-			if (adev)
-				typec_altmode_attention(adev, p[1]);
+			*adev_action = ADEV_ATTENTION;
 			return 0;
 		default:
 			break;
@@ -1182,23 +1186,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 		case CMD_ENTER_MODE:
 			if (adev && pdev) {
 				typec_altmode_update_active(pdev, true);
-
-				if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-					response[0] = VDO(adev->svid, 1,
-							  CMD_EXIT_MODE);
-					response[0] |= VDO_OPOS(adev->mode);
-					return 1;
-				}
+				*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
 			}
 			return 0;
 		case CMD_EXIT_MODE:
 			if (adev && pdev) {
 				typec_altmode_update_active(pdev, false);
-
 				/* Back to USB Operation */
-				WARN_ON(typec_altmode_notify(adev,
-							     TYPEC_STATE_USB,
-							     NULL));
+				*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
+				return 0;
 			}
 			break;
 		default:
@@ -1209,11 +1205,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 		switch (cmd) {
 		case CMD_ENTER_MODE:
 			/* Back to USB Operation */
-			if (adev)
-				WARN_ON(typec_altmode_notify(adev,
-							     TYPEC_STATE_USB,
-							     NULL));
-			break;
+			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
+			return 0;
 		default:
 			break;
 		}
@@ -1223,15 +1216,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const u32 *p, int cnt,
 	}
 
 	/* Informing the alternate mode drivers about everything */
-	if (adev)
-		typec_altmode_vdm(adev, p[0], &p[1], cnt);
-
+	*adev_action = ADEV_QUEUE_VDM;
 	return rlen;
 }
 
 static void tcpm_handle_vdm_request(struct tcpm_port *port,
 				    const __le32 *payload, int cnt)
 {
+	enum adev_actions adev_action = ADEV_NONE;
+	struct typec_altmode *adev;
 	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
 	int i, rlen = 0;
@@ -1239,6 +1232,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	for (i = 0; i < cnt; i++)
 		p[i] = le32_to_cpu(payload[i]);
 
+	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
+				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
 	if (port->vdm_state == VDM_STATE_BUSY) {
 		/* If UFP responded busy retry after timeout */
 		if (PD_VDO_CMDT(p[0]) == CMDT_RSP_BUSY) {
@@ -1253,7 +1249,31 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	}
 
 	if (PD_VDO_SVDM(p[0]))
-		rlen = tcpm_pd_svdm(port, p, cnt, response);
+		rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action);
+
+	if (adev) {
+		switch (adev_action) {
+		case ADEV_NONE:
+			break;
+		case ADEV_NOTIFY_USB_AND_QUEUE_VDM:
+			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
+			typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			break;
+		case ADEV_QUEUE_VDM:
+			typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			break;
+		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
+			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
+				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
+				response[0] |= VDO_OPOS(adev->mode);
+				rlen = 1;
+			}
+			break;
+		case ADEV_ATTENTION:
+			typec_altmode_attention(adev, p[1]);
+			break;
+		}
+	}
 
 	if (rlen > 0) {
 		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
-- 
2.40.1



