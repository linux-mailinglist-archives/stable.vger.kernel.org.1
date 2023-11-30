Return-Path: <stable+bounces-3258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0937FF2EC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C81AB2106B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D641C65;
	Thu, 30 Nov 2023 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhwXh/ky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60A3C6B6
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF26C433C7;
	Thu, 30 Nov 2023 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701355896;
	bh=pepcGMcCLB4rktMTVL2hU4UguoLrj7CjMSMFx42msO4=;
	h=Subject:To:Cc:From:Date:From;
	b=OhwXh/kyg8akxZtzxONuk+TvvbV8f+6+6SO3Ddx4YWN8M5qjOwx7zhRgClLnXFs2L
	 cb8bg7A0Vsxk5yDs/Hz2ZvhT2Z9xqt3YwZtzyJonLXd8s0fTcij7BmlfIcxaaWQRId
	 52Ds057W9kBQn22hR17K6xoQlQ/dEyUaykCnbbns=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: Skip hard reset when in error recovery" failed to apply to 4.19-stable tree
To: badhri@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:51:31 +0000
Message-ID: <2023113031-ethanol-diameter-52e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x a6fe37f428c19dd164c2111157d4a1029bd853aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113031-ethanol-diameter-52e7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

a6fe37f428c1 ("usb: typec: tcpm: Skip hard reset when in error recovery")
0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
a30a00e37ceb ("usb: typec: tcpm: frs sourcing vbus callback")
8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
3ed8e1c2ac99 ("usb: typec: tcpm: Migrate workqueue to RT priority for processing events")
aefc66afe42b ("usb: typec: pd: Fix formatting in pd.h header")
6bbe2a90a0bb ("usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart")
95b4d51c96a8 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request")
8afe9a3548f9 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling")
03eafcfb60c0 ("usb: typec: tcpm: Add tcpm_queue_vdm_unlocked() helper")
5f2b8d87bca5 ("usb: typec: tcpm: Move mod_delayed_work(&port->vdm_state_machine) call into tcpm_queue_vdm()")
6e1c2241f4ce ("usb: typec: tcpm: Stay in BIST mode till hardreset or unattached")
b2dcfefc43f7 ("usb: typec: tcpm: Support bist test data mode for compliance")
901789745a05 ("usb: typec: tcpm: Ignore CC and vbus changes in PORT_RESET change")
6ecc632d4b35 ("usb: typec: tcpm: set correct data role for non-DRD")
8face9aa57c8 ("usb: typec: Add parameter for the VDO to typec_altmode_enter()")
a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration mechanism")
00ec21e58dc6 ("usb: typec: tcpm: Start using struct typec_operations")
88d02c9ba2e8 ("usb: typec: tcpm: Ignore unsupported/unknown alternate mode requests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6fe37f428c19dd164c2111157d4a1029bd853aa Mon Sep 17 00:00:00 2001
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 1 Nov 2023 02:19:09 +0000
Subject: [PATCH] usb: typec: tcpm: Skip hard reset when in error recovery

Hard reset queued prior to error recovery (or) received during
error recovery will make TCPM to prematurely exit error recovery
sequence. Ignore hard resets received during error recovery (or)
port reset sequence.

```
[46505.459688] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
[46505.459706] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
[46505.460433] disable vbus discharge ret:0
[46505.461226] Setting usb_comm capable false
[46505.467244] Setting voltage/current limit 0 mV 0 mA
[46505.467262] polarity 0
[46505.470695] Requesting mux state 0, usb-role 0, orientation 0
[46505.475621] cc:=0
[46505.476012] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
[46505.476020] Received hard reset
[46505.476024] state change PORT_RESET -> HARD_RESET_START [rev3 HARD_RESET]
```

Cc: stable@vger.kernel.org
Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Heikki Krogeus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231101021909.2962679-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 058d5b853b57..b386102f7a3a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5391,6 +5391,15 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
 		port->tcpc->set_bist_data(port->tcpc, false);
 
+	switch (port->state) {
+	case ERROR_RECOVERY:
+	case PORT_RESET:
+	case PORT_RESET_WAIT_OFF:
+		return;
+	default:
+		break;
+	}
+
 	if (port->ams != NONE_AMS)
 		port->ams = NONE_AMS;
 	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)


