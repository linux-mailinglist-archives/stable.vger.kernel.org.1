Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE8769D7F
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjGaRBL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjGaRA4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 13:00:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF867186
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 10:00:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583fe0f84a5so60393387b3.3
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822788; x=1691427588;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZTl2ixYLkiekFh512ZpXFmexDEsp3/EWshctHq7A8s=;
        b=a+MCr9PcyoKgDFj1V66wj4dMmYDwlfvfq7xE3nTpO7o0i+/Rnd65+VTdvGxuEQSBg0
         hH0bLpEqgbjbJsi0XS1JSticmclXCJ+7Drx8qtPJUmUAxAmRLAoMrN1xip9vqUbFIDND
         ojXMo0qc3rpuw5S1MKfI4ss9pKyH8Qvt9iW7uKOReqJuIGycLq2nwdASdSz5jm8ZFcLj
         0Mk/kAOWcAjsDCtttS8y8uQs1WZymNa5v1pOj/uEF+GB11Na9S35l9Ngvl+iJ64Bpqe4
         9Ymn+blGYyQn+vfNe7NzB9dBdxThV1NeJR/4bnrDvBuRv4hAlS02z4JVFw0LK3iJiiNt
         17gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822788; x=1691427588;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZTl2ixYLkiekFh512ZpXFmexDEsp3/EWshctHq7A8s=;
        b=knUhve0Ab1m/E7Lsh2ei8F5VXTLUF8ts8RzenjO8b96vIsojzngGN2rNfK8B++hB9u
         3T8Wk/wrpQwawKRmYO8wrmcuEkH7jQZySNajiCa7cKHI0quUCvTgczbbRoQMIMVWXcpS
         KLfAjkCMckmSqnlNjoZjo2RlRpvC78EmlKVjMFqKo65QvDO7DmMXVFsyB4FM2GYBPqqO
         +bX3fD0pUyEgMn1mOfDSr1Aq4yaLBS0E1evvJbeOjxFfQSDfRqBrsnJWSN/LXccZ/NMX
         M0V1XBBs0847wFpdJnqWsZEOyLmZxF82l/DSiFQ4fs7sInjwi6QeM5c/wz57vefBdBVi
         zr9A==
X-Gm-Message-State: ABy/qLYLQ7TipGmU8hkbWxMrlRAwDfMirlbuYO6WJYzlsHBtoAdesM6Q
        vNQ3EyqYXqTqrKi8Q1pwvfQ0xLS8He+ZBVc=
X-Google-Smtp-Source: APBJJlHZwVutiQMSo/NJW3ifIByD0Rx5U+7eNMLDUToEVOmXYvxiAQawHDSRkjnliM6KwHbbM+XQaln0gD7qMms=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6902:564:b0:d0f:a0a6:8e87 with SMTP
 id a4-20020a056902056400b00d0fa0a68e87mr54331ybt.2.1690822787818; Mon, 31 Jul
 2023 09:59:47 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:59:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731165926.1815338-1-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: tcpm: set initial svdm version based on pd revision
From:   RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, kyletso@google.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
Changes since v1:
* Fixed styling errors.
---
 drivers/usb/typec/tcpm/tcpm.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 829d75ebab42..5024354a0fe0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3928,6 +3928,29 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
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
@@ -4165,10 +4188,12 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -4455,10 +4480,12 @@ static void run_state_machine(struct tcpm_port *port)
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

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.585.gd2178a4bd4-goog

