Return-Path: <stable+bounces-223687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHM5F17mrmmsJwIAu9opvQ
	(envelope-from <stable+bounces-223687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:25:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17423B990
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD07C30C3989
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85363DA7C2;
	Mon,  9 Mar 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mKMdxNOD"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E173DA5B4;
	Mon,  9 Mar 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069582; cv=none; b=EQzxv6gUIgL/12Meb+hvKzytF29OnSv7pRsVL228hX6Ks1mgWMQuncGo5jnPicWdrz43OZInW90f6d0v3aKV68ii5CYe2IEvE00e59kKjtNvDZ5YAViRH+YA96jJlTT/F1Gep9QW7nAENqME0/DOpupLx/dJY1RFMznPuUQSC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069582; c=relaxed/simple;
	bh=MK5QZLRvehnPJwlcJZSg4AJUG9618T3uQC/FnAXJVsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rRrXvTvS/BhK6Rj4WLQ0GwMkkuIxE98aNSn5LA5GY61P1gXMefQYC/9PDNEzJNRBQtlZNG6J9qN9t0XwgZEprWA+TLsfT6jAzBe7f1RY0kQAj9YNRBoAbf/v2hisevAJrREpzsoDuzV2PzKwjDvyEn3mil7kVCNns5Pcz68GWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mKMdxNOD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773069579;
	bh=MK5QZLRvehnPJwlcJZSg4AJUG9618T3uQC/FnAXJVsE=;
	h=From:Date:Subject:To:Cc:From;
	b=mKMdxNODb/4UbCG7p+Gm6aEYRc+LYJJr7BT0CjDHKpqbNWAfLWtuHFkoUUCcFhebN
	 OLJ4IDPJQWAePbgnUd2du/s0Mw+sgnb2dHHxpS8eLSXza8RwZGaDKDhsmk3K1O0OzB
	 yO2vLOaaKfVC2XOK4eG5ozjaJZBmNr+tYBFuEwhz0owujXXb8DCzgEB5M152Jo3GKo
	 VkuPZPcC0/Ss4SqNenElCUBd/1K37cF/Pcv+0HW06PKJB6wvyX493zphgy/gYgogo1
	 vD00+HK2MX5Q+d9VqjgzMoEQtUVBJ9VNiTzd62XaGDoGYh1m4CU3tM1qll1VUCJmSZ
	 W+RfHPuLYukBw==
Received: from jupiter.universe (dyndsl-091-248-212-188.ewe-ip-backbone.de [91.248.212.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6334417E0E91;
	Mon,  9 Mar 2026 16:19:39 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 060DD480026; Mon, 09 Mar 2026 16:19:39 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 09 Mar 2026 16:15:28 +0100
Subject: [PATCH v3] usb: typec: tcpm: improve handling of DISCOVER_MODES
 failures
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-tcpm-discover-modes-nak-fix-v3-1-a4447f5c1c61@collabora.com>
X-B4-Tracking: v=1; b=H4sIAA/krmkC/43OTQ6CMBCG4auQrh0zbS0GV97DuOjPKI1ASUsaD
 eHuFjYmbnT5fotnZmaJoqfETtXMImWffBhKyF3FbKuHO4F3pZlAUaPgEiY79uB8siFThD44SjD
 oB9z8E7DBIxqjRGMVK8IYqcybfrmWbn2aQnxtxzJf1//czAGhMdYo7cyBbvXZhq7TJkS9t6Fnq
 53Fx5P4wxPAQelaYvkXhdLf3rIsb8B9FJMaAQAA
X-Change-ID: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7328;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=MK5QZLRvehnPJwlcJZSg4AJUG9618T3uQC/FnAXJVsE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGmu5Qoes9mig9F0rvpSMNNNeC0rASbsMKFBf
 VooBMGvBMuKO4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpruUKAAoJENju1/PI
 O/qaH5cP/jnzI838jl6FP6CbO+zmeETvKvh4ONGdmogtFrCO3FGmcT8OtrrFO+aPTv68qj6NFbs
 jXy3JOxRJjdxXQx9HoOZm8Jl73lolUFXH2XgeGOBEAOwg8sVS02Z7BYoMzwULE6Itw2qhZimPcL
 SXRD5NOjmLbAmn0pgOoicZFNwxVHGtlCOdirwQUdR+TJUV55431S2C5bnKsFUPj8eM9PXVlnr0/
 2We+jeRA5xnr0hArGv3XkSbtIZP0VUMdEYheN5EthWhG39rgR0eTHxAgGRrbesFIfFm8SVEOU+g
 hqLJe+7HPvl4pngv2SA0SusqUqnweiKG3cBrMmXLcs1grDAnZapruv2anWfsS7Oqh+hYarLS/xw
 CsedkZPJ4/EwlTX3Q6b5YDYM3eC0lviOrcVUvmaK1y/qpqJ/BHtEQl9cG9XvG3CKpDVN5x7CAkY
 caAc6Bw8M/uigRbUUUlbC5GmPzVRMMps/ZHobGwR1c1PeAFRHw3fCuwGz/la9wbm5uoI+lNLRuC
 9HAa4BEal1oOQOjaSWtwUk4x3v1BsK2QN+oqIY4ZizYzsXSOY+/so9A5H/+e9jX6QWJWlScVWb3
 bX1J4eGOz8AiCE5CetCIYSHKzAVJkgsgTvEF4ihrKOhcZKcAdyoFlL97zVCY0mAefddbY/6hAVV
 jXXztNp8QQCreUwndUm0reg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
X-Rspamd-Queue-Id: BF17423B990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223687-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:dkim,collabora.com:email,collabora.com:mid]
X-Rspamd-Action: no action

UGREEN USB-C Multifunction Adapter Model CM512 (AKA "Revodok 107")
exposes two SVIDs: 0xff01 (DP Alt Mode) and 0x1d5c. The DISCOVER_MODES
step succeeds for 0xff01 and gets a NAK for 0x1d5c. Currently this
results in DP Alt Mode not being registered either, since the modes
are only registered once all of them have been discovered. The NAK
results in the processing being stopped and thus no Alt modes being
registered.

Improve the situation by handling the NAK gracefully and continue
processing the other modes.

Before this change, the TCPM log ends like this:

(more log entries before this)
[    5.028287] AMS DISCOVER_SVIDS finished
[    5.028291] cc:=4
[    5.040040] SVID 1: 0xff01
[    5.040054] SVID 2: 0x1d5c
[    5.040082] AMS DISCOVER_MODES start
[    5.040096] PD TX, header: 0x1b6f
[    5.050946] PD TX complete, status: 0
[    5.059609] PD RX, header: 0x264f [1]
[    5.059626] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
[    5.059640] AMS DISCOVER_MODES finished
[    5.059644] cc:=4
[    5.069994]  Alternate mode 0: SVID 0xff01, VDO 1: 0x000c0045
[    5.070029] AMS DISCOVER_MODES start
[    5.070043] PD TX, header: 0x1d6f
[    5.081139] PD TX complete, status: 0
[    5.087498] PD RX, header: 0x184f [1]
[    5.087515] Rx VDM cmd 0x1d5c8083 type 2 cmd 3 len 1
[    5.087529] AMS DISCOVER_MODES finished
[    5.087534] cc:=4
(no further log entries after this point)

After this patch the TCPM log looks exactly the same, but then
continues like this:

[    5.100222] Skip SVID 0x1d5c (failed to discover mode)
[    5.101699] AMS DFP_TO_UFP_ENTER_MODE start
(log goes on as the system initializes DP AltMode)

Cc: stable@vger.kernel.org
Fixes: 41d9d75344d9 ("usb: typec: tcpm: add discover svids and discover modes support for sop'")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v3:
- Link to v2: https://lore.kernel.org/r/20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com
- Move svdm_consume_modes() out of tcpm_handle_discover_mode() (Heikki Krogerus)
- Move rlen return pointer argument into proper return code (Heikki Krogerus)
- Drop multiple tcpm_handle_discover_mode() arguments by re-getting them
  in the function  (Heikki Krogerus)
- Restructure if/else branches after these changes to make checkpatch happy
- Did not pick up R-b tag from Badhri Jagan Sridharan due to the amount
  of changes

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20260213-tcpm-discover-modes-nak-fix-v1-0-9bcb5adb4ef6@collabora.com
- Squash patches (Badhri Jagan Sridharan)
- Add Fixes tag (Badhri Jagan Sridharan)
- Move common svdm_consume_modes out of conditional statement (Badhri Jagan Sridharan)
- Add TCPM log to commit message (Badhri Jagan Sridharan)
---
 drivers/usb/typec/tcpm/tcpm.c | 97 +++++++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1d2f3af034c5..97a35b5590d9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1995,6 +1995,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
 	       tcpm_can_communicate_sop_prime(port);
 }
 
+static int tcpm_handle_discover_mode(struct tcpm_port *port, u32 *response,
+				     enum tcpm_transmit_type rx_sop_type,
+				     enum tcpm_transmit_type *response_tx_sop_type)
+{
+	struct typec_port *typec = port->typec_port;
+	struct pd_mode_data *modep;
+
+	if (rx_sop_type == TCPC_TX_SOP) {
+		modep = &port->mode_data;
+		modep->svid_index++;
+
+		if (modep->svid_index < modep->nsvids) {
+			u16 svid = modep->svids[modep->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP;
+			response[0] = VDO(svid, 1,
+					  typec_get_negotiated_svdm_version(typec),
+					  CMD_DISCOVER_MODES);
+			return 1;
+		}
+
+		if (tcpm_cable_vdm_supported(port)) {
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(USB_SID_PD, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_SVID);
+			return 1;
+		}
+
+		tcpm_register_partner_altmodes(port);
+	} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+		modep = &port->mode_data_prime;
+		modep->svid_index++;
+
+		if (modep->svid_index < modep->nsvids) {
+			u16 svid = modep->svids[modep->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(svid, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_MODES);
+			return 1;
+		}
+
+		tcpm_register_plug_altmodes(port);
+		tcpm_register_partner_altmodes(port);
+	}
+
+	return 0;
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action,
@@ -2252,41 +2301,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			}
 			break;
 		case CMD_DISCOVER_MODES:
-			if (rx_sop_type == TCPC_TX_SOP) {
-				/* 6.4.4.3.3 */
-				svdm_consume_modes(port, p, cnt, rx_sop_type);
-				modep->svid_index++;
-				if (modep->svid_index < modep->nsvids) {
-					u16 svid = modep->svids[modep->svid_index];
-					*response_tx_sop_type = TCPC_TX_SOP;
-					response[0] = VDO(svid, 1, svdm_version,
-							  CMD_DISCOVER_MODES);
-					rlen = 1;
-				} else if (tcpm_cable_vdm_supported(port)) {
-					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
-					response[0] = VDO(USB_SID_PD, 1,
-							  typec_get_cable_svdm_version(typec),
-							  CMD_DISCOVER_SVID);
-					rlen = 1;
-				} else {
-					tcpm_register_partner_altmodes(port);
-				}
-			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
-				/* 6.4.4.3.3 */
-				svdm_consume_modes(port, p, cnt, rx_sop_type);
-				modep_prime->svid_index++;
-				if (modep_prime->svid_index < modep_prime->nsvids) {
-					u16 svid = modep_prime->svids[modep_prime->svid_index];
-					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
-					response[0] = VDO(svid, 1,
-							  typec_get_cable_svdm_version(typec),
-							  CMD_DISCOVER_MODES);
-					rlen = 1;
-				} else {
-					tcpm_register_plug_altmodes(port);
-					tcpm_register_partner_altmodes(port);
-				}
-			}
+			/* 6.4.4.3.3 */
+			svdm_consume_modes(port, p, cnt, rx_sop_type);
+			rlen = tcpm_handle_discover_mode(port, response,
+							 rx_sop_type,
+							 response_tx_sop_type);
 			break;
 		case CMD_ENTER_MODE:
 			*response_tx_sop_type = rx_sop_type;
@@ -2329,9 +2348,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
 		case CMD_DISCOVER_SVID:
-		case CMD_DISCOVER_MODES:
 		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
 			break;
+		case CMD_DISCOVER_MODES:
+			tcpm_log(port, "Skip SVID 0x%04x (failed to discover mode)",
+				 PD_VDO_SVID_SVID0(p[0]));
+			rlen = tcpm_handle_discover_mode(port, response,
+							 rx_sop_type,
+							 response_tx_sop_type);
+			break;
 		case CMD_ENTER_MODE:
 			/* Back to USB Operation */
 			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


