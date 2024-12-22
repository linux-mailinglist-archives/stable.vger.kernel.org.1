Return-Path: <stable+bounces-105557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F39FA54C
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C0E16648B
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EC517BB16;
	Sun, 22 Dec 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm95NsVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCC2F5A
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734864392; cv=none; b=GiTSnn8jhHNdiiymEWDlU5x0emvg0LZv3elleOgzqwKrn9Kn6MKEOw3LkSaahtJPDEqANbtApRXaMh68o6rGikSLeHfNLq8dwBadTYu2SlulgGRK734cYXB2pwulWLFNRUqFNoG8BbF4OHIpKeX20ADD3ho1cmSQawJy+wCW+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734864392; c=relaxed/simple;
	bh=h5nwueyLHAMrr/r6B/rngW9mD3SzGCPi3imb1lkKzXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED4C26pnPeY4u1zwEmt9hYvdqOVEz7RunnIZxcScLAMenRdTC0DZLZkV96Mhm9gYkU6+htLXFJ+/Dygc+fkxBzncJEyk9F8K+84tm95uWEbmXImLiGC3oxrPOwR/XJRgalCMFtvy5JBneUDn3aKZOSoN4E+W6iwY1pm84scX98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm95NsVs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so2690659b3a.3
        for <stable@vger.kernel.org>; Sun, 22 Dec 2024 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734864390; x=1735469190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbcJcMX7zSTkTnNdpGo7HbEeA32pcsOh0F01DmZwU/I=;
        b=lm95NsVsx1kDkJEZrZ5kJV/d8FltKjcwhLH3cTZtHWcHn2n5g4NhCa63e877YzmtZf
         MxQSEXT1i7sesMF8gWwaHN8QJ0wBOMyUWmT6RM+ib7cbzxQ71TO/353NiHXpdgN0vsnq
         nwMXRJTK999gp7zkIOmzAFuOqMQFpzgIc7atQH1zNo/O8k+i7EG/llIyvSBIouMkoUEj
         OgGRcDXDIUZsYLPwzFdeK4CbS9LolAAGbXK/SGkouChm+8R+ShZSP8OI9WYtdnVeD9TN
         3f+WpB3DvoOF2a2JY0sJlQteiFtjKWLImB1bqSTusgUK8KErPyXolEk2aX+Gv2RKvsSU
         d95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734864390; x=1735469190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbcJcMX7zSTkTnNdpGo7HbEeA32pcsOh0F01DmZwU/I=;
        b=Izkn6a6VLhXs4VY8wtE2BrZpyW+59D7/gsBJClc6sxG5ElFJt3mJl7xMcQxQMP6PBj
         tAHMQqWPvoAbJP/M7AHVR4TiEBzR9XeKNxVJJfavak0GX3gLoKV5YuYdmEZg7EQOsvvI
         SAopBcXpE8sv5m4q9s0qTnImlOOyK6FLLj8F6/w1uCa8VzO8xnImbGWvkmjUa9I9IgOk
         Srwsjv40gTEUcd3Vnyyft6ttFm1LWpqLhEif81jgc2V4Ux1u77Jc5RAYSLy1x1kMJPjI
         qL2MsfN4sQ32IkrsHgqIMw4gbU78n6h0x7uBlTyLipElXvuKlRkkKEQZjJG8HxPhs8Jb
         WUsw==
X-Forwarded-Encrypted: i=1; AJvYcCWOM5pbYeahJAjzpZVQ0ybIXB8jigX2vyZXPbXaEpr5LgzmKHCF8zKHDsSM6TeBjCTbFE1w7YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yYPLHdW4OfaukR+5Q9m0iTvBvcz/LUbqGiRfmdJ5cxpEJtHW
	g14yllwNXrFZJ4NoURDYw8B6EEGQDUN8iRx2wGJpJKb5mNRKhn9J
X-Gm-Gg: ASbGncsI03WKAZ4f87nM4+XEu0IwpwzaHyOjGyOd6FrH2SDOOPNzK7wnS71lgKDCT2W
	DXoAEKmZF7xQbasKDD0Zvcy6TBWS6Ib51tDLXSnElZeM2YjSxbqB6C621qBKYS3WF6DEqitkGmV
	DVq2nLdEZUMZ9qaPYL/N3T0vmJ8KSRuj0UL/Ss21vaSebZ+BZemlwfvRyuZ1bRAjjD2843tKH+E
	zn+IAi/iqxq6p9993Hn0HGrapWPPsm3wL0xvNmq4OJYUjSQVSAKBgDCyG20ZAPS
X-Google-Smtp-Source: AGHT+IE4owh1p9tSEbYdKwEj4dZjR43njL701srBwIPLIcG970uEB2FWaoWQm3ZPbkNy9s0ZTbzu4Q==
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-72abdd7cbaemr16274095b3a.8.1734864390027;
        Sun, 22 Dec 2024 02:46:30 -0800 (PST)
Received: from localhost ([36.40.178.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd2bfsm6151198b3a.148.2024.12.22.02.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2024 02:46:29 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: wangjie102317@qq.com
Cc: Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
Date: Sun, 22 Dec 2024 18:45:59 +0800
Message-Id: <20241222104559.2369-2-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241222104559.2369-1-joswang1221@gmail.com>
References: <20241222104559.2369-1-joswang1221@gmail.com>
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


