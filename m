Return-Path: <stable+bounces-222906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMpwE64Np2k0cwAAu9opvQ
	(envelope-from <stable+bounces-222906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:34:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66591F3E37
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB123029272
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589644BCAD;
	Tue,  3 Mar 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gnyOUEM6"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BE4DA541;
	Tue,  3 Mar 2026 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555370; cv=none; b=sfYOGtc93qvQnMgF2SgTTvwJ4VaabmI9Scs0IKUvyVWSHuASwMrdpTBxB24/UjfLOF90zZgjL1ubNYi0q7Yq7XHCwyrnpugbr2FmGum3M0flc3TGLlX/cUR9yubRJEgdi4C8itsRdqwvseEu+M/A3JLlaIlalmpjlRxj16e/4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555370; c=relaxed/simple;
	bh=+5o7xAkvJSZvOUHQyGnFureQJdqN/L3pCJpkTIpMYtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QQ87FM+UStUBZK0/0xjGPbRBfc81tEzZuY6+wj92/pXSS/ZRsz+/hI/g3qE3+W+ZFpLPJ9o2/1F1O9j+NikqAEslBXEFflsJOVTdvYGbrYsgGHKtlNRbMsYnH0eETSFR9d+ZEOWcOl+jMTXnwikJgZoYMs4ERaNrEfU54G7bB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gnyOUEM6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772555364;
	bh=+5o7xAkvJSZvOUHQyGnFureQJdqN/L3pCJpkTIpMYtc=;
	h=From:Date:Subject:To:Cc:From;
	b=gnyOUEM6bxKOvtnGvlEUtQGCO+EkV6ahWXR07qZi0Clb9KwRRr/IYyLRmVXbz9vz1
	 bHMjVYaBlX1U6jQBybjyUT7rHkZ4mBGPONVNwbp0GnRLCl8F2sif/ggI47jq8biCj3
	 isbuvVwexMquzyPb9xT2ZaayDrDOMedNHZUXPFuzgGLxMEj5/qtpwA6OxC8w0r0pd2
	 444150l4KOTyZLfRmFrYv5W4/vT4lFzYYWBV9jiOcHtXpc1Z/Z4tw0gJFRzSwyxUUD
	 1f4oLT46NaSJ+Kok/N+t7AUVhyrxdEUJxJ5KzomeQiIBsZb2YWseoFW3/N1cYE5/OC
	 qSBbiwZ97gESw==
Received: from jupiter.universe (dyndsl-091-248-210-138.ewe-ip-backbone.de [91.248.210.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D539117E00A3;
	Tue,  3 Mar 2026 17:29:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8EC57480024; Tue, 03 Mar 2026 17:29:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 03 Mar 2026 17:29:10 +0100
Subject: [PATCH v2] usb: typec: tcpm: improve handling of DISCOVER_MODES
 failures
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com>
X-B4-Tracking: v=1; b=H4sIAFUMp2kC/42NQQ6CMBAAv0J6dk2pgsET/zAc2u0iG4ElLWk0h
 L9beYHHmcPMpiIFpqjuxaYCJY4scwZzKhQOdn4SsM+sjDa1NuUFVlwm8BxREgWYxFOE2b6g5zf
 oRt+0c5VpsFK5sATK+qg/uswDx1XC55il8mf/66YSNDQOXWW9u1JftyjjaJ0Ee0aZVLfv+xfxc
 TPoygAAAA==
X-Change-ID: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6988;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+5o7xAkvJSZvOUHQyGnFureQJdqN/L3pCJpkTIpMYtc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGmnDGQizfFzZpRSfkS3gZE0etvI1dlN992Rl
 lJ27whFcK2ZsYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJppwxkAAoJENju1/PI
 O/qakUwQAJ0PrydS7TGvTf2BiIHH2FcRZWxN5CW310yK3umxfg/5VbXopgvkqKSU0DYfIlVspCm
 DuDHhsf0wVXcw6NxQdCB6kVNRAIBA80r2HH9wSW9yJwjqxsh/uGiYmvQ0MCuRc1m5Jq3aoLU1+4
 vne5wVrCf4SdZMp8+4vpMNdJaU7rZ/QXJmXq8Ox3z7Ol/VWMiZxGw5XDxx7jVdl6SSaroa9n6yo
 k3LGHVtP3+wnSsE9lnZ4yOXlbb1dMu83kod2X7Blj0C7Tju4RxnycaxYeLguayu1ZI5FH6vEVGZ
 w9b3lYWwC4jgHZLOitaTPxRtARew1ORl35TWgOhmrt1VCHsPMe4l84ilt7T+t/b/3IdwrNm3bCe
 2cERMiHsMeDUpkbZ0Dck9mkTWWa+yrFkbGZcppfUU8AoHv9eZJ8aZHg51PZw/lcVMWXGWyZMsmW
 iuyIaV42AfJvARNwdjdz7MViS/15k97KqDDtYW0O1ERf8RU5iEpyigMQyGUXOpR4d5yqFxs47D8
 QJoXiL5tFhS3C9lIAjWgGAh/u+CjJZMRklRQh2BDs6900rOG+gJwFOdNJQl9K922gPjeUaZeQaO
 3w3yBLaykm5kxVxdCs5YJTkOstzYan+8+TRaH+MImeFqZ3x5AhIvXJpY/QH4TcvzA7uyc91FZdN
 Hftd7OzmCEJIaC98zPsMxhQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
X-Rspamd-Queue-Id: A66591F3E37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222906-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
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
index 1d2f3af034c5..cd5260f408fb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1995,6 +1995,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
 	       tcpm_can_communicate_sop_prime(port);
 }
 
+static void tcpm_handle_discover_mode(struct tcpm_port *port,
+				      const u32 *p, int cnt, u32 *response,
+				      enum tcpm_transmit_type rx_sop_type,
+				      enum tcpm_transmit_type *response_tx_sop_type,
+				      struct pd_mode_data *modep,
+				      struct pd_mode_data *modep_prime,
+				      int svdm_version, int *rlen,
+				      bool success)
+
+{
+	struct typec_port *typec = port->typec_port;
+
+	/* 6.4.4.3.3 */
+	if (success)
+		svdm_consume_modes(port, p, cnt, rx_sop_type);
+
+	if (rx_sop_type == TCPC_TX_SOP) {
+		modep->svid_index++;
+		if (modep->svid_index < modep->nsvids) {
+			u16 svid = modep->svids[modep->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP;
+			response[0] = VDO(svid, 1, svdm_version,
+					  CMD_DISCOVER_MODES);
+			*rlen = 1;
+		} else if (tcpm_cable_vdm_supported(port)) {
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(USB_SID_PD, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_SVID);
+			*rlen = 1;
+		} else {
+			tcpm_register_partner_altmodes(port);
+		}
+	} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+		modep_prime->svid_index++;
+		if (modep_prime->svid_index < modep_prime->nsvids) {
+			u16 svid = modep_prime->svids[modep_prime->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(svid, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_MODES);
+			*rlen = 1;
+		} else {
+			tcpm_register_plug_altmodes(port);
+			tcpm_register_partner_altmodes(port);
+		}
+	}
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action,
@@ -2252,41 +2301,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
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
+			tcpm_handle_discover_mode(port, p, cnt, response,
+						  rx_sop_type, response_tx_sop_type,
+						  modep, modep_prime, svdm_version,
+						  &rlen, true);
 			break;
 		case CMD_ENTER_MODE:
 			*response_tx_sop_type = rx_sop_type;
@@ -2329,9 +2347,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
 		case CMD_DISCOVER_SVID:
-		case CMD_DISCOVER_MODES:
 		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
 			break;
+		case CMD_DISCOVER_MODES:
+			tcpm_log(port, "Skip SVID 0x%04x (failed to discover mode)",
+				 PD_VDO_SVID_SVID0(p[0]));
+			tcpm_handle_discover_mode(port, p, cnt, response,
+						  rx_sop_type, response_tx_sop_type,
+						  modep, modep_prime, svdm_version,
+						  &rlen, false);
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


