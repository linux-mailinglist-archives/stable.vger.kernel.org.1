Return-Path: <stable+bounces-163587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC56B0C587
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EC1AA3550
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407152D978B;
	Mon, 21 Jul 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW5mIlGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B81F03C5
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105893; cv=none; b=mQOi3YJUCmAwpcG6rod19TxuHLH9ZtMffEMtchiJza18XQAySwq7udcOhYXBnDLaQuMeyw4Ey2bt2sMUfbuahqij3Zgz5hgl3tuU70l60IuQaoFGrNfFAIifvpWAKVhLdJFEG+q9ZeGfysDNq/xlp6UlR1N0v1XQtFpaizb2UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105893; c=relaxed/simple;
	bh=8R3IKQqK7CYl8o7GzOH57Q8qGW0DqDooqBGJAKXPG5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwEZfu/V6rK3/RFmxkAtRC/0FGr5WPdOMY67zbVV54Nl8bseCshE0JRsPfNWo3gYNYc3+dtumgANj+LHHcdFg31q+PydSLwI+GPOV0818Mj7naCcMRNfsXrEAxAF3ADlc2/j/lB/T4WvyQfQUIbDetGqUjE4N5A9Bn+hKumNRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW5mIlGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934AEC4CEED;
	Mon, 21 Jul 2025 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105892;
	bh=8R3IKQqK7CYl8o7GzOH57Q8qGW0DqDooqBGJAKXPG5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XW5mIlGMdhpsjFcGDefzm4Kay+R4P6iKbKWKcIKgYOECh7S14FOcGjQswGEPIz4WU
	 VXQORviSrGtmfZi8wC72P8bx9z/Z+KgQ1DQO31iz5oXko/EF6NhZnVbyIMufD/FZ/t
	 aOnXOgAD4kvVf+cqeGFlMVCneGz+1e8+NvhuqdLENy9DfSP/eAyBE9TSZmP4ZWIiiA
	 7WxJ2X/QDHFX+o1j0CtlvmkaVw4w6385+/hTzNby3hy6kU5j1b1LKqySsWem/9MjRg
	 5KnNlSMHmqVQHU94476cLLAGHWYalQSbU5lTuCMFhB5goER64pAYTHL6sBrXT6ec9A
	 RT4hDQ/40zrTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: musb: Add and use inline functions musb_{get,set}_state
Date: Mon, 21 Jul 2025 09:51:26 -0400
Message-Id: <20250721135127.840100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072132-slum-strum-0148@gregkh>
References: <2025072132-slum-strum-0148@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 21acc656a06e912341d9db66c67b58cc7ed071e7 ]

Instead of manipulating musb->xceiv->otg->state directly, use the newly
introduced musb_get_state() and musb_set_state() inline functions.

Later, these inline functions will be modified to get rid of the
musb->xceiv dependency, which prevents the musb code from using the
generic PHY subsystem.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20221026182657.146630-2-paul@crapouillou.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 67a59f82196c ("usb: musb: fix gadget state on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_core.c    | 62 ++++++++++++++++-----------------
 drivers/usb/musb/musb_core.h    | 11 ++++++
 drivers/usb/musb/musb_debugfs.c |  6 ++--
 drivers/usb/musb/musb_gadget.c  | 28 +++++++--------
 drivers/usb/musb/musb_host.c    |  6 ++--
 drivers/usb/musb/musb_virthub.c | 18 +++++-----
 6 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f7b1d5993f8c1..4253df50fc4b6 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -502,7 +502,7 @@ int musb_set_host(struct musb *musb)
 
 init_data:
 	musb->is_active = 1;
-	musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+	musb_set_state(musb, OTG_STATE_A_IDLE);
 	MUSB_HST_MODE(musb);
 
 	return error;
@@ -549,7 +549,7 @@ int musb_set_peripheral(struct musb *musb)
 
 init_data:
 	musb->is_active = 0;
-	musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+	musb_set_state(musb, OTG_STATE_B_IDLE);
 	MUSB_DEV_MODE(musb);
 
 	return error;
@@ -599,12 +599,12 @@ static void musb_otg_timer_func(struct timer_list *t)
 	unsigned long	flags;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_B_WAIT_ACON:
 		musb_dbg(musb,
 			"HNP: b_wait_acon timeout; back to b_peripheral");
 		musb_g_disconnect(musb);
-		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_SUSPEND:
@@ -612,7 +612,7 @@ static void musb_otg_timer_func(struct timer_list *t)
 		musb_dbg(musb, "HNP: %s timeout",
 			usb_otg_state_string(musb->xceiv->otg->state));
 		musb_platform_set_vbus(musb, 0);
-		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
+		musb_set_state(musb, OTG_STATE_A_WAIT_VFALL);
 		break;
 	default:
 		musb_dbg(musb, "HNP: Unhandled mode %s",
@@ -633,7 +633,7 @@ void musb_hnp_stop(struct musb *musb)
 	musb_dbg(musb, "HNP: stop from %s",
 			usb_otg_state_string(musb->xceiv->otg->state));
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_PERIPHERAL:
 		musb_g_disconnect(musb);
 		musb_dbg(musb, "HNP: back to %s",
@@ -643,7 +643,7 @@ void musb_hnp_stop(struct musb *musb)
 		musb_dbg(musb, "HNP: Disabling HR");
 		if (hcd)
 			hcd->self.is_b_host = 0;
-		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		MUSB_DEV_MODE(musb);
 		reg = musb_readb(mbase, MUSB_POWER);
 		reg |= MUSB_POWER_SUSPENDM;
@@ -671,7 +671,7 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 			usb_otg_state_string(musb->xceiv->otg->state));
 
 	if (devctl & MUSB_DEVCTL_HM) {
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_SUSPEND:
 			/* remote wakeup? */
 			musb->port1_status |=
@@ -679,14 +679,14 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 					| MUSB_PORT_STAT_RESUME;
 			musb->rh_timer = jiffies
 				+ msecs_to_jiffies(USB_RESUME_TIMEOUT);
-			musb->xceiv->otg->state = OTG_STATE_A_HOST;
+			musb_set_state(musb, OTG_STATE_A_HOST);
 			musb->is_active = 1;
 			musb_host_resume_root_hub(musb);
 			schedule_delayed_work(&musb->finish_resume_work,
 				msecs_to_jiffies(USB_RESUME_TIMEOUT));
 			break;
 		case OTG_STATE_B_WAIT_ACON:
-			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+			musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 			musb->is_active = 1;
 			MUSB_DEV_MODE(musb);
 			break;
@@ -696,10 +696,10 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 				usb_otg_state_string(musb->xceiv->otg->state));
 		}
 	} else {
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_SUSPEND:
 			/* possibly DISCONNECT is upcoming */
-			musb->xceiv->otg->state = OTG_STATE_A_HOST;
+			musb_set_state(musb, OTG_STATE_A_HOST);
 			musb_host_resume_root_hub(musb);
 			break;
 		case OTG_STATE_B_WAIT_ACON:
@@ -750,7 +750,7 @@ static irqreturn_t musb_handle_intr_sessreq(struct musb *musb, u8 devctl)
 	 */
 	musb_writeb(mbase, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
 	musb->ep0_stage = MUSB_EP0_START;
-	musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+	musb_set_state(musb, OTG_STATE_A_IDLE);
 	MUSB_HST_MODE(musb);
 	musb_platform_set_vbus(musb, 1);
 
@@ -777,7 +777,7 @@ static void musb_handle_intr_vbuserr(struct musb *musb, u8 devctl)
 	 * REVISIT:  do delays from lots of DEBUG_KERNEL checks
 	 * make trouble here, keeping VBUS < 4.4V ?
 	 */
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_HOST:
 		/* recovery is dicey once we've gotten past the
 		 * initial stages of enumeration, but if VBUS
@@ -833,7 +833,7 @@ static void musb_handle_intr_suspend(struct musb *musb, u8 devctl)
 	musb_dbg(musb, "SUSPEND (%s) devctl %02x",
 		usb_otg_state_string(musb->xceiv->otg->state), devctl);
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_PERIPHERAL:
 		/* We also come here if the cable is removed, since
 		 * this silicon doesn't report ID-no-longer-grounded.
@@ -858,7 +858,7 @@ static void musb_handle_intr_suspend(struct musb *musb, u8 devctl)
 		musb_g_suspend(musb);
 		musb->is_active = musb->g.b_hnp_enable;
 		if (musb->is_active) {
-			musb->xceiv->otg->state = OTG_STATE_B_WAIT_ACON;
+			musb_set_state(musb, OTG_STATE_B_WAIT_ACON);
 			musb_dbg(musb, "HNP: Setting timer for b_ase0_brst");
 			mod_timer(&musb->otg_timer, jiffies
 				+ msecs_to_jiffies(
@@ -871,7 +871,7 @@ static void musb_handle_intr_suspend(struct musb *musb, u8 devctl)
 				+ msecs_to_jiffies(musb->a_wait_bcon));
 		break;
 	case OTG_STATE_A_HOST:
-		musb->xceiv->otg->state = OTG_STATE_A_SUSPEND;
+		musb_set_state(musb, OTG_STATE_A_SUSPEND);
 		musb->is_active = musb->hcd->self.b_hnp_enable;
 		break;
 	case OTG_STATE_B_HOST:
@@ -909,7 +909,7 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 		musb->port1_status |= USB_PORT_STAT_LOW_SPEED;
 
 	/* indicate new connection to OTG machine */
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_B_PERIPHERAL:
 		if (int_usb & MUSB_INTR_SUSPEND) {
 			musb_dbg(musb, "HNP: SUSPEND+CONNECT, now b_host");
@@ -921,7 +921,7 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 	case OTG_STATE_B_WAIT_ACON:
 		musb_dbg(musb, "HNP: CONNECT, now b_host");
 b_host:
-		musb->xceiv->otg->state = OTG_STATE_B_HOST;
+		musb_set_state(musb, OTG_STATE_B_HOST);
 		if (musb->hcd)
 			musb->hcd->self.is_b_host = 1;
 		del_timer(&musb->otg_timer);
@@ -929,7 +929,7 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 	default:
 		if ((devctl & MUSB_DEVCTL_VBUS)
 				== (3 << MUSB_DEVCTL_VBUS_SHIFT)) {
-			musb->xceiv->otg->state = OTG_STATE_A_HOST;
+			musb_set_state(musb, OTG_STATE_A_HOST);
 			if (hcd)
 				hcd->self.is_b_host = 0;
 		}
@@ -948,7 +948,7 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 			usb_otg_state_string(musb->xceiv->otg->state),
 			MUSB_MODE(musb), devctl);
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_HOST:
 	case OTG_STATE_A_SUSPEND:
 		musb_host_resume_root_hub(musb);
@@ -966,7 +966,7 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 		musb_root_disconnect(musb);
 		if (musb->hcd)
 			musb->hcd->self.is_b_host = 0;
-		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		MUSB_DEV_MODE(musb);
 		musb_g_disconnect(musb);
 		break;
@@ -1006,7 +1006,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 	} else {
 		musb_dbg(musb, "BUS RESET as %s",
 			usb_otg_state_string(musb->xceiv->otg->state));
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_SUSPEND:
 			musb_g_reset(musb);
 			fallthrough;
@@ -1025,11 +1025,11 @@ static void musb_handle_intr_reset(struct musb *musb)
 		case OTG_STATE_B_WAIT_ACON:
 			musb_dbg(musb, "HNP: RESET (%s), to b_peripheral",
 				usb_otg_state_string(musb->xceiv->otg->state));
-			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+			musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 			musb_g_reset(musb);
 			break;
 		case OTG_STATE_B_IDLE:
-			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+			musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 			fallthrough;
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_reset(musb);
@@ -1216,8 +1216,8 @@ void musb_start(struct musb *musb)
 	 * (c) peripheral initiates, using SRP
 	 */
 	if (musb->port_mode != MUSB_HOST &&
-			musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
-			(devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
+	    musb_get_state(musb) != OTG_STATE_A_WAIT_BCON &&
+	    (devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
 		musb->is_active = 1;
 	} else {
 		devctl |= MUSB_DEVCTL_SESSION;
@@ -1908,7 +1908,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
 	spin_lock_irqsave(&musb->lock, flags);
 	/* force T(a_wait_bcon) to be zero/unlimited *OR* valid */
 	musb->a_wait_bcon = val ? max_t(int, val, OTG_TIME_A_WAIT_BCON) : 0 ;
-	if (musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON)
+	if (musb_get_state(musb) == OTG_STATE_A_WAIT_BCON)
 		musb->is_active = 0;
 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -2089,8 +2089,8 @@ static void musb_irq_work(struct work_struct *data)
 
 	musb_pm_runtime_check_session(musb);
 
-	if (musb->xceiv->otg->state != musb->xceiv_old_state) {
-		musb->xceiv_old_state = musb->xceiv->otg->state;
+	if (musb_get_state(musb) != musb->xceiv_old_state) {
+		musb->xceiv_old_state = musb_get_state(musb);
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
 	}
 
@@ -2532,7 +2532,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	MUSB_DEV_MODE(musb);
-	musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+	musb_set_state(musb, OTG_STATE_B_IDLE);
 
 	switch (musb->port_mode) {
 	case MUSB_HOST:
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index a8a65effe68b5..4a4d485d37bd3 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -592,6 +592,17 @@ static inline void musb_platform_clear_ep_rxintr(struct musb *musb, int epnum)
 		musb->ops->clear_ep_rxintr(musb, epnum);
 }
 
+static inline void musb_set_state(struct musb *musb,
+				  enum usb_otg_state otg_state)
+{
+	musb->xceiv->otg->state = otg_state;
+}
+
+static inline enum usb_otg_state musb_get_state(struct musb *musb)
+{
+	return musb->xceiv->otg->state;
+}
+
 /*
  * gets the "dr_mode" property from DT and converts it into musb_mode
  * if the property is not found or not recognized returns MUSB_OTG
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 5401ae66894eb..2d623284edf63 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -235,7 +235,7 @@ static int musb_softconnect_show(struct seq_file *s, void *unused)
 	u8		reg;
 	int		connect;
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_HOST:
 	case OTG_STATE_A_WAIT_BCON:
 		pm_runtime_get_sync(musb->controller);
@@ -275,7 +275,7 @@ static ssize_t musb_softconnect_write(struct file *file,
 
 	pm_runtime_get_sync(musb->controller);
 	if (!strncmp(buf, "0", 1)) {
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_HOST:
 			musb_root_disconnect(musb);
 			reg = musb_readb(musb->mregs, MUSB_DEVCTL);
@@ -286,7 +286,7 @@ static ssize_t musb_softconnect_write(struct file *file,
 			break;
 		}
 	} else if (!strncmp(buf, "1", 1)) {
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_WAIT_BCON:
 			/*
 			 * musb_save_context() called in musb_runtime_suspend()
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 22c3df49ba8af..78b12b034cd6f 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1523,7 +1523,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_B_PERIPHERAL:
 		/* NOTE:  OTG state machine doesn't include B_SUSPENDED;
 		 * that's part of the standard usb 1.1 state machine, and
@@ -1785,7 +1785,7 @@ int musb_gadget_setup(struct musb *musb)
 	musb->g.speed = USB_SPEED_UNKNOWN;
 
 	MUSB_DEV_MODE(musb);
-	musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+	musb_set_state(musb, OTG_STATE_B_IDLE);
 
 	/* this "gadget" abstracts/virtualizes the controller */
 	musb->g.name = musb_driver_name;
@@ -1850,7 +1850,7 @@ static int musb_gadget_start(struct usb_gadget *g,
 	musb->is_active = 1;
 
 	otg_set_peripheral(otg, &musb->g);
-	musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+	musb_set_state(musb, OTG_STATE_B_IDLE);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	musb_start(musb);
@@ -1895,7 +1895,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 
 	(void) musb_gadget_vbus_draw(&musb->g, 0);
 
-	musb->xceiv->otg->state = OTG_STATE_UNDEFINED;
+	musb_set_state(musb, OTG_STATE_UNDEFINED);
 	musb_stop(musb);
 	otg_set_peripheral(musb->xceiv->otg, NULL);
 
@@ -1926,7 +1926,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 void musb_g_resume(struct musb *musb)
 {
 	musb->is_suspended = 0;
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_B_IDLE:
 		break;
 	case OTG_STATE_B_WAIT_ACON:
@@ -1952,10 +1952,10 @@ void musb_g_suspend(struct musb *musb)
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 	musb_dbg(musb, "musb_g_suspend: devctl %02x", devctl);
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_B_IDLE:
 		if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS)
-			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+			musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		break;
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_suspended = 1;
@@ -2001,22 +2001,22 @@ void musb_g_disconnect(struct musb *musb)
 		spin_lock(&musb->lock);
 	}
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	default:
 		musb_dbg(musb, "Unhandled disconnect %s, setting a_idle",
 			usb_otg_state_string(musb->xceiv->otg->state));
-		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+		musb_set_state(musb, OTG_STATE_A_IDLE);
 		MUSB_HST_MODE(musb);
 		break;
 	case OTG_STATE_A_PERIPHERAL:
-		musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
+		musb_set_state(musb, OTG_STATE_A_WAIT_BCON);
 		MUSB_HST_MODE(musb);
 		break;
 	case OTG_STATE_B_WAIT_ACON:
 	case OTG_STATE_B_HOST:
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
-		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		musb_set_state(musb, OTG_STATE_B_IDLE);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
@@ -2080,13 +2080,13 @@ __acquires(musb->lock)
 		 * In that case, do not rely on devctl for setting
 		 * peripheral mode.
 		 */
-		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		musb->g.is_a_peripheral = 0;
 	} else if (devctl & MUSB_DEVCTL_BDEVICE) {
-		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 		musb->g.is_a_peripheral = 0;
 	} else {
-		musb->xceiv->otg->state = OTG_STATE_A_PERIPHERAL;
+		musb_set_state(musb, OTG_STATE_A_PERIPHERAL);
 		musb->g.is_a_peripheral = 1;
 	}
 
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ef0b1589b10eb..08c73e9f75d0f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2508,7 +2508,7 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 	if (!is_host_active(musb))
 		return 0;
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_SUSPEND:
 		return 0;
 	case OTG_STATE_A_WAIT_VRISE:
@@ -2518,7 +2518,7 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 		 */
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS)
-			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
+			musb_set_state(musb, OTG_STATE_A_WAIT_BCON);
 		break;
 	default:
 		break;
@@ -2727,7 +2727,7 @@ int musb_host_setup(struct musb *musb, int power_budget)
 
 	if (musb->port_mode == MUSB_HOST) {
 		MUSB_HST_MODE(musb);
-		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+		musb_set_state(musb, OTG_STATE_A_IDLE);
 	}
 	otg_set_host(musb->xceiv->otg, &hcd->self);
 	/* don't support otg protocols */
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index cafc69536e1d7..d1cfd45d69e36 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -43,7 +43,7 @@ void musb_host_finish_resume(struct work_struct *work)
 	musb->port1_status |= USB_PORT_STAT_C_SUSPEND << 16;
 	usb_hcd_poll_rh_status(musb->hcd);
 	/* NOTE: it might really be A_WAIT_BCON ... */
-	musb->xceiv->otg->state = OTG_STATE_A_HOST;
+	musb_set_state(musb, OTG_STATE_A_HOST);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
@@ -85,9 +85,9 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 		musb_dbg(musb, "Root port suspended, power %02x", power);
 
 		musb->port1_status |= USB_PORT_STAT_SUSPEND;
-		switch (musb->xceiv->otg->state) {
+		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_HOST:
-			musb->xceiv->otg->state = OTG_STATE_A_SUSPEND;
+			musb_set_state(musb, OTG_STATE_A_SUSPEND);
 			musb->is_active = otg->host->b_hnp_enable;
 			if (musb->is_active)
 				mod_timer(&musb->otg_timer, jiffies
@@ -96,7 +96,7 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 			musb_platform_try_idle(musb, 0);
 			break;
 		case OTG_STATE_B_HOST:
-			musb->xceiv->otg->state = OTG_STATE_B_WAIT_ACON;
+			musb_set_state(musb, OTG_STATE_B_WAIT_ACON);
 			musb->is_active = otg->host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
@@ -123,7 +123,7 @@ void musb_port_reset(struct musb *musb, bool do_reset)
 	u8		power;
 	void __iomem	*mbase = musb->mregs;
 
-	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE) {
+	if (musb_get_state(musb) == OTG_STATE_B_IDLE) {
 		musb_dbg(musb, "HNP: Returning from HNP; no hub reset from b_idle");
 		musb->port1_status &= ~USB_PORT_STAT_RESET;
 		return;
@@ -204,20 +204,20 @@ void musb_root_disconnect(struct musb *musb)
 	usb_hcd_poll_rh_status(musb->hcd);
 	musb->is_active = 0;
 
-	switch (musb->xceiv->otg->state) {
+	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_SUSPEND:
 		if (otg->host->b_hnp_enable) {
-			musb->xceiv->otg->state = OTG_STATE_A_PERIPHERAL;
+			musb_set_state(musb, OTG_STATE_A_PERIPHERAL);
 			musb->g.is_a_peripheral = 1;
 			break;
 		}
 		fallthrough;
 	case OTG_STATE_A_HOST:
-		musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
+		musb_set_state(musb, OTG_STATE_A_WAIT_BCON);
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
-		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		musb_set_state(musb, OTG_STATE_B_IDLE);
 		break;
 	default:
 		musb_dbg(musb, "host disconnect (%s)",
-- 
2.39.5


