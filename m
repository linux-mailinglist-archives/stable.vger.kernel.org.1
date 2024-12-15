Return-Path: <stable+bounces-104275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D39F23E9
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4163164CB1
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F11865F0;
	Sun, 15 Dec 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPwvp0AV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705D1E871;
	Sun, 15 Dec 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267021; cv=none; b=U9xENAwmfwtn4vXuD0HO0BJ0DbB//FecwG58IA+NKLY2Hxshb/arRLxYIHDizBlJMS19B+r7ctHyU0fjs+ICUyZ6xDXYonQu1Xf+IV7cTuFaT9i3nWFqX18lH4lwnrOsO7G7cJZo4NFSee9ELriOQQ5wdEvixb1ie64sUClno4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267021; c=relaxed/simple;
	bh=WL8JmY7eey5z+pZwcZYZY+j5cIJM/sVgyqonCznAo8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AiomBBTPT1fbXVAikvl7yLuA8K0eWtE5xenTJ/OuiV0ib4aDQB0bD6iQ0CfmGtEqseaHbDkiG814JF98ZJSI9G4cSqZymAtqVWeRdeU34Resh24ExVkeZsAg9nXSTO+J7H9DmsI4sapozr2YG6lYj7oFb5RSF3S7C/SDSa/RBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPwvp0AV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7292a83264eso212671b3a.0;
        Sun, 15 Dec 2024 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734267018; x=1734871818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzaRb0xQAUQDs2LIcgxPnaAOwKV79xllc7FmZgiqoCw=;
        b=IPwvp0AVWjthMSqOTvTQvZJXaczV4GKiWeeKzWFGiSXM74kCE3C6vCA47sPFVbmqCX
         olHhB6Wdzeeh+f41q/XvAa/D3jttjfuLhF1J6PwbavMlC4aSbiK3uqwEpQh+zCNtk1I5
         8RUIxFrIRXYPChMpy8IOThDuHF+o4afJDb6dhHUUf7i+iYzonj786Tj+oFm1cyb76sLa
         l4JUv/YqrOWUZYvhyYWwze7m4FxCE1R1Y8hjYdNytc6P4JtYtks2LoSqedGELDf9SJQy
         tXG3gtyjfAuCQ8kiRyID89znaNCbzvP7zVFUQI7DOLDIG/MbJkLnAduyQwEH28VVx4c4
         CMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734267018; x=1734871818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzaRb0xQAUQDs2LIcgxPnaAOwKV79xllc7FmZgiqoCw=;
        b=tO9UqcVMQuHdUusuj+YDQEFGuO/dXC95xb/ReU5XPbgDX5Meb2ua2Vnb7YUrdJi1B5
         P4rl+e5ix4nHH+B5xRMOM5lKIb8o0uwBSAPjC4qRSkkLl9Wdiv1Rqj6Ohy8oPwhVoteK
         FKSvioCdQ3fcldbWG83VJz/9txVcPq9UCP7ADAr+rIe2gTGfvC7AMIZ/fUw6kVfiJGkH
         DpFLoqTtm8mJi5afgGgkcsazUYsmOvvMvQrJbuyf9MqZmKlWkxubE5Q/PojGTfgmrR9S
         Jc5+Y28seqeqTf0f0SobzIJOASpGaJZgJndjjR1Hc2IqQQhfx6e/CyL4rjCadN52BfjJ
         hSpg==
X-Forwarded-Encrypted: i=1; AJvYcCUeczLglQOkKeBW7RtbK392k8XVJJqRHTuO/PX9qF7xy/h3lkDXB5dzZ/ZBKTXMg1cDyI6htjBnHCE3@vger.kernel.org, AJvYcCV/99lZATSaDznnLTKsxdx9ACI7U8Yk8dH/sZtpuni3IC+Ip1YbDrbnV4cBClgaRFmaGMF4GDUO@vger.kernel.org, AJvYcCXBKQBw6z5Uj0w6IbgmyFNnJ1mYGKxAZWSdM/Hw2fgC+r6YHHOLZdsPs9aw78LkncHAkQYqU6CciJUUhp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXVwgDJUZ1DKf3kCvEGmkOfSgpSMojSszdQxrb4B5pQD0vmgq
	RMJQ5Edv3jUCtKrSVe989PRmVmIWzGyavEbwfF7iY82Nh2fSOEz1
X-Gm-Gg: ASbGncttNy9y84HMeisxY9XLINp5ZLqRNJWhE5tlU29i+M6Wq1xxMY5ot8qSd60axYl
	3VT1iuExKR9rwSeV3CcQKywqdSGICbLJpS9xxAx7eWmJ87TWG7hbc8WxO+LZAUemTQus9B2RLAv
	rwiFssk9J7AI8ajTzqBMfwMM57X2I6S6ynjadDSYf6vdUTdJ4odnhRoyV6nbgb9TRA/dvCuZ4Qe
	WisuXW+0OTDmK/orMVEmNhFwAccoEN3C4jOe3ovdNelzow210JLMkl6XXoSMMV6yw==
X-Google-Smtp-Source: AGHT+IH4JQoks6jbtt4JfsD3TvpP621d7NP/w6FqbLqDGESvvUM/s6XdZD6JlIXW+fmTHi7v6jWgBg==
X-Received: by 2002:a05:6a00:4295:b0:726:41e:b310 with SMTP id d2e1a72fcca58-7290c17bb87mr11598057b3a.12.1734267018297;
        Sun, 15 Dec 2024 04:50:18 -0800 (PST)
Received: from localhost ([36.45.249.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad8b7sm2862350b3a.161.2024.12.15.04.50.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2024 04:50:17 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: tcpm: fix the sender response time issue
Date: Sun, 15 Dec 2024 20:50:13 +0800
Message-Id: <20241215125013.70671-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jos Wang <joswang@lenovo.com>

According to the USB PD3 CTS specification, the requirements
for tSenderResponse are different in PD2 and PD3 modes, see
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

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
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


