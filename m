Return-Path: <stable+bounces-105558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA779FA553
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB941888DBF
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F518CC08;
	Sun, 22 Dec 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCQSwka4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C017BB16;
	Sun, 22 Dec 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734864775; cv=none; b=qxtDJwx+cP+hNjKu2aIN3MwAcqd8SkNLr2NQk6/qx2EBCMmAprBcOywQbjwFbfkwgNVMJousBeXKZL3VzfweAkZJkAO8VtvA21EUAucDK3CVHIHOTcsj50Y7ZCLzyyyIx+I2s1dOaNft8VODRaCyfvv/+WYlFiej3qkc3nkRliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734864775; c=relaxed/simple;
	bh=h5nwueyLHAMrr/r6B/rngW9mD3SzGCPi3imb1lkKzXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REKKvHMBasGwvRcGCLq+aPjoNi18Edre7l0QgOuGJU/uwb1yvCv1oypmiGUP0HCfr/gGnRbgeqSNGUAuKqjlkTX9lG2KyZUhN1rFS1I9ulW6WUt0vhU1OVpUvRU5vyMVXEnJSz3mFepK+MtUCZCcRF2pQvhR1YfPzZELYbc0o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCQSwka4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7265c18d79bso3832305b3a.3;
        Sun, 22 Dec 2024 02:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734864773; x=1735469573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbcJcMX7zSTkTnNdpGo7HbEeA32pcsOh0F01DmZwU/I=;
        b=kCQSwka4I/uIiJeuytyZOr7IExGlToKoci+kghwZGZKWjBCpDdwyXRYtuPzvQIdy5l
         RQPsGhMmIa7RS22DFqFclqOEyr7zbF6WgcHVS0j0tzMpDDmtUPMZdWnrd8JQ2FmEUzU3
         4MDS5P1EImcHMg++gqFwmUMWgQm7iPere5mABZ0EAVcR/3nRKk9iRPVqCSh7/wtM8OhD
         IOKa3WGjiWSstQaDpOfl80PnpCyhpkmMm0IM99k1E9H02E0iOQyzNQ0FKPYcyyW24zeh
         Trb5GM5jF90N6usRCmXtPGdqrrGAZM5YOyVE46UZFNfvx4RX2XGsGZBHCS7xXoT4u7mQ
         DVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734864773; x=1735469573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbcJcMX7zSTkTnNdpGo7HbEeA32pcsOh0F01DmZwU/I=;
        b=cDtDCVSG5uHk5dUPgg86jRP2J/5m/rqjfGfKZp3MjHJfQUabbzHAeGuN8soV0uuygK
         3cRZHY+OoEouC0oY8WEkP1Wy82/vLo/0u/tqbq+gkEvyAszWjDm4FXg3VLnPHCxiOYLr
         9j63w08Y6oASoLoUQjuynhJ+uWus01rOFm2F09V27sw+1a0Cs1piOTxwCBZc3FuRbk2I
         Tv37FIsN9NNOqmIv9NKIBSYpwQx/7/hw3j2t1EpwKlL1daEEjOANOGXa4Bp7xeQY7sxp
         0SRZ8/s30U87kyDUuoQ1T0iKq+AN/dvodf+t+kXDL0Djef8sOUWAa2wYJRofH9Laek2h
         b6cA==
X-Forwarded-Encrypted: i=1; AJvYcCVkF6UsQxW29MsdRgtifoeT0C0n8jAHOj36bquCGzEwsiLDJzxd4boiqv33+U8j0j4fTzuNMECXSZF/@vger.kernel.org, AJvYcCWIItafBwPblwcPVnJw7TD2ChQf8ZbVwhiZZFWYF/ods95LIK8MbJHCct6XwXclwRQKug2oQxV/@vger.kernel.org, AJvYcCXiT6Dliea+Z2hkQ9/LYkWhTbQmImyxudhJds5iCogcAbj/d6+Sdkn8u1oV4zqUGOrtZMfJH6OrTBJPyijM@vger.kernel.org, AJvYcCXuYEgAZDZ2l/z/aR6UuItXa/wuJ6d8lC6f4EVMZed0YDr7aMDFNwmAOlAiHkJDVihKEDM0SMI9SbdU@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5y/8+0MrijKhz8PVeKwBo8hP4RkbuiYJP+8BrUpyj0y2s4ag
	pj3jySP2lkM6UyWSavKGpxNHLtwICSr6LgCr+oJKw2NprfIg4TW+
X-Gm-Gg: ASbGncv9OJClr/IRwpc9hFk6z2u/kDrFrR+Qh2b1r0AQkM8wwIxNL83P/MRDiBPnG/e
	QKihJKbJrc8hrxLcok/sr/ogmdeRhQ7jZL/VmLB+ErH4lxjiSOCmyzExonRTUSAloXXz6by/qh+
	gniO+hi/hy7MgnkK9xXBO7XE+cYde10IWny8L8ryP0by4+Z1yjqpJALh7HY6BqstsDmxEMURuQN
	Y8ezS4hgYmoxEAAu/+0YmF0qKQa6Tuv3crPAu0S5lUcMIUDt7Yf6g6Gc8K4OQtn
X-Google-Smtp-Source: AGHT+IG9PIf5f2Wm7jV1oQxQS+4svNFhH+DPFq53UXblx5hBQRjQvd620ZZffUjj7waK2xFvjhXwHA==
X-Received: by 2002:a05:6a21:329f:b0:1e1:becc:1c91 with SMTP id adf61e73a8af0-1e5e0801c76mr15238247637.28.1734864772827;
        Sun, 22 Dec 2024 02:52:52 -0800 (PST)
Received: from localhost ([36.40.178.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b181b62asm5521474a12.18.2024.12.22.02.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2024 02:52:52 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	rdbabiera@google.com,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
Date: Sun, 22 Dec 2024 18:52:39 +0800
Message-Id: <20241222105239.2618-2-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241222105239.2618-1-joswang1221@gmail.com>
References: <20241222105239.2618-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jos Wang <joswang@lenovo.com>

According to the USB PD3 CTS specification
(https://usb.org/document-library/
usb-power-delivery-compliance-test-specification-0/
USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
tSenderResponse are different in PD2 and PD3 modes, see
Table 19 Timing Table & Calculations. For PD2 mode, the
tSenderResponse min 24ms and max 30ms; for PD3 mode, the
tSenderResponse min 27ms and max 33ms.

For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
item, after receiving the Source_Capabilities Message sent by
the UUT, the tester deliberately does not send a Request Message
in order to force the SenderResponse timer on the Source UUT to
timeout. The Tester checks that a Hard Reset is detected between
tSenderResponse min and max，the delay is between the last bit of
the GoodCRC Message EOP has been sent and the first bit of Hard
Reset SOP has been received. The current code does not distinguish
between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
This will cause this test item and the following tests to fail:
TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout

Considering factors such as SOC performance, i2c rate, and the speed
of PD chip sending data, "pd2-sender-response-time-ms" and
"pd3-sender-response-time-ms" DT time properties are added to allow
users to define platform timing. For values that have not been
explicitly defined in DT using this property, a default value of 27ms
for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.

Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v1 -> v2:
- modify the commit message
- patch 1/2 and patch 2/2 are placed in the same thread

 drivers/usb/typec/tcpm/tcpm.c | 50 +++++++++++++++++++++++------------
 include/linux/usb/pd.h        |  3 ++-
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6021eeb903fe..3a159bfcf382 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -314,12 +314,16 @@ struct pd_data {
  * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
  * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
  * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
+ * @pd2_sender_response_time: Deadline (in ms) for pd20 tSenderResponse timer
+ * @pd3_sender_response_time: Deadline (in ms) for pd30 tSenderResponse timer
  */
 struct pd_timings {
 	u32 sink_wait_cap_time;
 	u32 ps_src_off_time;
 	u32 cc_debounce_time;
 	u32 snk_bc12_cmpletion_time;
+	u32 pd2_sender_response_time;
+	u32 pd3_sender_response_time;
 };
 
 struct tcpm_port {
@@ -3776,7 +3780,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 			} else if (port->pwr_role == TYPEC_SOURCE) {
 				tcpm_ams_finish(port);
 				tcpm_set_state(port, HARD_RESET_SEND,
-					       PD_T_SENDER_RESPONSE);
+					       port->negotiated_rev >= PD_REV30 ?
+					       port->timings.pd3_sender_response_time :
+					       port->timings.pd2_sender_response_time);
 			} else {
 				tcpm_ams_finish(port);
 			}
@@ -4619,6 +4625,9 @@ static void run_state_machine(struct tcpm_port *port)
 	enum typec_pwr_opmode opmode;
 	unsigned int msecs;
 	enum tcpm_state upcoming_state;
+	u32 sender_response_time = port->negotiated_rev >= PD_REV30 ?
+				   port->timings.pd3_sender_response_time :
+				   port->timings.pd2_sender_response_time;
 
 	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
 		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
@@ -5113,7 +5122,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 		} else {
 			tcpm_set_state_cond(port, hard_reset_state(port),
-					    PD_T_SENDER_RESPONSE);
+					    sender_response_time);
 		}
 		break;
 	case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -5135,7 +5144,7 @@ static void run_state_machine(struct tcpm_port *port)
 				tcpm_set_state(port, SNK_READY, 0);
 		} else {
 			tcpm_set_state_cond(port, hard_reset_state(port),
-					    PD_T_SENDER_RESPONSE);
+					    sender_response_time);
 		}
 		break;
 	case SNK_TRANSITION_SINK:
@@ -5387,7 +5396,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->message_id_prime = 0;
 			port->rx_msgid_prime = -1;
 			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
-			tcpm_set_state_cond(port, ready_state(port), PD_T_SENDER_RESPONSE);
+			tcpm_set_state_cond(port, ready_state(port), sender_response_time);
 		} else {
 			port->message_id = 0;
 			port->rx_msgid = -1;
@@ -5398,7 +5407,7 @@ static void run_state_machine(struct tcpm_port *port)
 				tcpm_set_state_cond(port, hard_reset_state(port), 0);
 			else
 				tcpm_set_state_cond(port, hard_reset_state(port),
-						    PD_T_SENDER_RESPONSE);
+						    sender_response_time);
 		}
 		break;
 
@@ -5409,8 +5418,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->send_discover = true;
 			port->send_discover_prime = false;
 		}
-		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
-				    PD_T_SENDER_RESPONSE);
+		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT, sender_response_time);
 		break;
 	case DR_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
@@ -5444,7 +5452,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
-		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SENDER_RESPONSE);
+		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, sender_response_time);
 		break;
 	case FR_SWAP_SEND_TIMEOUT:
 		tcpm_set_state(port, ERROR_RECOVERY, 0);
@@ -5475,8 +5483,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PR_SWAP_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP);
-		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
-				    PD_T_SENDER_RESPONSE);
+		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT, sender_response_time);
 		break;
 	case PR_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
@@ -5574,8 +5581,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case VCONN_SWAP_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_SOP);
-		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
-			       PD_T_SENDER_RESPONSE);
+		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT, sender_response_time);
 		break;
 	case VCONN_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
@@ -5656,23 +5662,21 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case GET_STATUS_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SOP);
-		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
-			       PD_T_SENDER_RESPONSE);
+		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT, sender_response_time);
 		break;
 	case GET_STATUS_SEND_TIMEOUT:
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_PPS_STATUS_SEND:
 		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_TX_SOP);
-		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
-			       PD_T_SENDER_RESPONSE);
+		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT, sender_response_time);
 		break;
 	case GET_PPS_STATUS_SEND_TIMEOUT:
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case GET_SINK_CAP:
 		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_SOP);
-		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
+		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, sender_response_time);
 		break;
 	case GET_SINK_CAP_TIMEOUT:
 		port->sink_cap_done = true;
@@ -7109,6 +7113,18 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
 	ret = fwnode_property_read_u32(fwnode, "sink-bc12-completion-time-ms", &val);
 	if (!ret)
 		port->timings.snk_bc12_cmpletion_time = val;
+
+	ret = fwnode_property_read_u32(fwnode, "pd2-sender-response-time-ms", &val);
+	if (!ret)
+		port->timings.pd2_sender_response_time = val;
+	else
+		port->timings.pd2_sender_response_time = PD_T_PD2_SENDER_RESPONSE;
+
+	ret = fwnode_property_read_u32(fwnode, "pd3-sender-response-time-ms", &val);
+	if (!ret)
+		port->timings.pd3_sender_response_time = val;
+	else
+		port->timings.pd3_sender_response_time = PD_T_PD3_SENDER_RESPONSE;
 }
 
 static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index d50098fb16b5..9c599e851b9a 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -457,7 +457,6 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_NO_RESPONSE	5000	/* 4.5 - 5.5 seconds */
 #define PD_T_DB_DETECT		10000	/* 10 - 15 seconds */
 #define PD_T_SEND_SOURCE_CAP	150	/* 100 - 200 ms */
-#define PD_T_SENDER_RESPONSE	60	/* 24 - 30 ms, relaxed */
 #define PD_T_RECEIVER_RESPONSE	15	/* 15ms max */
 #define PD_T_SOURCE_ACTIVITY	45
 #define PD_T_SINK_ACTIVITY	135
@@ -491,6 +490,8 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_CC_DEBOUNCE	200	/* 100 - 200 ms */
 #define PD_T_PD_DEBOUNCE	20	/* 10 - 20 ms */
 #define PD_T_TRY_CC_DEBOUNCE	15	/* 10 - 20 ms */
+#define PD_T_PD2_SENDER_RESPONSE	27	/* PD20 spec 24 - 30 ms */
+#define PD_T_PD3_SENDER_RESPONSE	30	/* PD30 spec 27 - 33 ms */
 
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
-- 
2.17.1


