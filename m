Return-Path: <stable+bounces-62250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4468793E791
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C2AB22C1C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40AF824BF;
	Sun, 28 Jul 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQat1EPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87E823D1;
	Sun, 28 Jul 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182756; cv=none; b=s8k80Wz5CWxK8snuhxPkKSViTDlDp5EuRDCzIeLQ+puKMnj9EBfF0S1CZSptg5iv+PXGF1Cpx54k4Z+jhQ1PnsskbVphlzrstwAl9UGcumK+t67svmf/ypoTNj6LjTe98+cbUt7CSUtTecxhqsNBsEshh5cMDpsb07+g0Un3TV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182756; c=relaxed/simple;
	bh=IhxHZ4Gft0uBewt7GTLhDe/iMtaLA4L3wrfKLnQwW1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVdhuPxFppc/m+YWnd9VWX9PG326Gkw1Xi8VLyCWdllu1Z+L8G9v5S7v6tr6G/TSAJpPaJvv0Jqg04QDWnrSSYm86rRP6vdTWJeuVsa9xdvpuAd+p7wveCEYDOfWtcsx9fpSwrXZBEnR1j20A3BhTgVsCs2bhaonqQozAwmC1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQat1EPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF82C32782;
	Sun, 28 Jul 2024 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182755;
	bh=IhxHZ4Gft0uBewt7GTLhDe/iMtaLA4L3wrfKLnQwW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQat1EPZl9CN2oM5qGYqUSKFSryclXgsO3pDCTPdzOgbuSr41fvEdQa7A7Y4h0YrT
	 fzT8tzOs5ieOmJKigEg3wjQTjyMPChtEs+To7iP2mAAPK03gRf1s5VxvRwb5nIPODl
	 CPRHmXxVJku28xLCP3eOu21T1oZ1UU+B2cZFdnJfvlzRMSvhNncC99ruejvhYe16oJ
	 zjQR8MrtylJRin/SnfdFaj8S1OrZzeztS0CO7SPp4GjjW5FBThy7i31hj+b4WCo5uv
	 aD3ld3RgSXnSLRgiqYtQ9STnMSoti8BQSJ1lVthPbP+73mfXm3HDh2hZBYC0dhQkWP
	 7dVrkqMNOhczA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	linux@roeck-us.net,
	badhri@google.com,
	kyletso@google.com,
	xu.yang_2@nxp.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 07/23] usb: typec: tcpm: avoid resets for missing source capability messages
Date: Sun, 28 Jul 2024 12:04:48 -0400
Message-ID: <20240728160538.2051879-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit 122968f8dda8205c5735d7e1b1ccb041a54906d1 ]

When the Linux Type-C controller drivers probe, they requests a soft
reset, which should result in the source restarting to send Source
Capability messages again independently of the previous state.
Unfortunately some USB PD sources do not follow the specification and
do not send them after a soft reset when they already negotiated a
specific contract before. The current way (and what is described in the
specificiation) to resolve this problem is triggering a hard reset.

But a hard reset is fatal on batteryless platforms powered via USB-C PD,
since that removes VBUS for some time. Since this is triggered at boot
time, the system will be stuck in a boot loop. Examples for platforms
affected by this are the Radxa Rock 5B or the Libre Computer Renegade
Elite ROC-RK3399-PC.

Instead of directly trying a hard reset when no Source Capability
message is send by the USB-PD source automatically, this changes the
state machine to try explicitly asking for the capabilities by sending
a Get Source Capability control message.

For me this solves issues with 2 different USB-PD sources - a RAVPower
powerbank and a Lemorele USB-C dock. Every other PD source I own
follows the specification and automatically sends the Source Capability
message after a soft reset, which works with or without this change.

I decided against making this extra step limited to devices not having
the self_powered flag set, since I don't see any huge drawbacks in this
approach and it keeps the logic simpler. The worst case scenario would
be a power source, which is really stuck. In that case the hard reset
is delayed by another 310ms.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240523171806.223727-1-sebastian.reichel@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5d4da962acc87..5f7ea0fab47ab 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -57,6 +57,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE),		\
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
+	S(SNK_WAIT_CAPABILITIES_TIMEOUT),	\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
@@ -3110,7 +3111,8 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 						   PD_MSG_CTRL_REJECT :
 						   PD_MSG_CTRL_NOT_SUPP,
 						   NONE_AMS);
-		} else if (port->state == SNK_WAIT_CAPABILITIES) {
+		} else if (port->state == SNK_WAIT_CAPABILITIES ||
+			   port->state == SNK_WAIT_CAPABILITIES_TIMEOUT) {
 		/*
 		 * This message may be received even if VBUS is not
 		 * present. This is quite unexpected; see USB PD
@@ -5041,10 +5043,31 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(port, hard_reset_state(port),
+			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
 				       PD_T_SINK_WAIT_CAP);
 		}
 		break;
+	case SNK_WAIT_CAPABILITIES_TIMEOUT:
+		/*
+		 * There are some USB PD sources in the field, which do not
+		 * properly implement the specification and fail to start
+		 * sending Source Capability messages after a soft reset. The
+		 * specification suggests to do a hard reset when no Source
+		 * capability message is received within PD_T_SINK_WAIT_CAP,
+		 * but that might effectively kil the machine's power source.
+		 *
+		 * This slightly diverges from the specification and tries to
+		 * recover from this by explicitly asking for the capabilities
+		 * using the Get_Source_Cap control message before falling back
+		 * to a hard reset. The control message should also be supported
+		 * and handled by all USB PD source and dual role devices
+		 * according to the specification.
+		 */
+		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
+			tcpm_set_state_cond(port, hard_reset_state(port), 0);
+		else
+			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
+		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
 		tcpm_set_partner_usb_comm_capable(port,
-- 
2.43.0


