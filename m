Return-Path: <stable+bounces-160507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F25AFCEE6
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A47B16C8D3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38662E0B7C;
	Tue,  8 Jul 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kB9SOOLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565714F9D6
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987963; cv=none; b=QsBX7hAkrLrxVDjLuJQi4VOBeDc8RuVnNopGYdnHUGibx+RJzg0vPxO2vnhhSgum3urhBPbtCvxeqMZ5jezbLTZO4dYmzvGrxmLWo7ntnH+/X3bSchWf0kK9MZIj/dR2XLEh22C7COBacaNmC2hdNuEv2ge2A2aFlum5xnuzprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987963; c=relaxed/simple;
	bh=gswXtpaJXsf+0iKxkwlcC/N3rKhOl8r99/lB4Am4n90=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ObFxB5napeCykXy7tsvsyrDsOKnSdtX9rNz9UOgWztjaak3JqPcqtVo1EibNFkCH4xUmInSZtsXwpXhyaOGMcddPtchY2xLkGTp6BX24l9ERl5Cbtydxhypb/Qqo92DmMqlLBrDzesUb6IiKaLV8sMIEv8h7bBUF2ZMv1xNiiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kB9SOOLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C63C4CEED;
	Tue,  8 Jul 2025 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751987963;
	bh=gswXtpaJXsf+0iKxkwlcC/N3rKhOl8r99/lB4Am4n90=;
	h=Subject:To:Cc:From:Date:From;
	b=kB9SOOLEnzs/qgpXab2rg9dJwWo08sYb3VoPHs2ndv6Rmo2WU9MGy0du4cx6nS7z4
	 RxO5x+KaNdQWHMq2hn80mKZhQ5aeMZVf07/fULUVNYkqJzJ7Pn6e9SGKXT6vIPmnXy
	 t039m2iZM8P//w5SZfyL9FuPTG0aFlz1767qAVK0=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: apply vbus before data bringup in" failed to apply to 6.6-stable tree
To: rdbabiera@google.com,badhri@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:19:14 +0200
Message-ID: <2025070814-resume-lazy-4b81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bec15191d52300defa282e3fd83820f69e447116
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070814-resume-lazy-4b81@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bec15191d52300defa282e3fd83820f69e447116 Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Wed, 18 Jun 2025 23:06:04 +0000
Subject: [PATCH] usb: typec: tcpm: apply vbus before data bringup in
 tcpm_src_attach

This patch fixes Type-C compliance test TD 4.7.6 - Try.SNK DRP Connect
SNKAS.

tVbusON has a limit of 275ms when entering SRC_ATTACHED. Compliance
testers can interpret the TryWait.Src to Attached.Src transition after
Try.Snk as being in Attached.Src the entire time, so ~170ms is lost
to the debounce timer.

Setting the data role can be a costly operation in host mode, and when
completed after 100ms can cause Type-C compliance test check TD 4.7.5.V.4
to fail.

Turn VBUS on before tcpm_set_roles to meet timing requirement.

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable <stable@kernel.org>
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250618230606.3272497-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1a1f9e1f8e4e..1f6fdfaa34bf 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4410,17 +4410,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
-			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
-	if (ret < 0)
-		return ret;
-
-	if (port->pd_supported) {
-		ret = port->tcpc->set_pd_rx(port->tcpc, true);
-		if (ret < 0)
-			goto out_disable_mux;
-	}
-
 	/*
 	 * USB Type-C specification, version 1.2,
 	 * chapter 4.5.2.2.8.1 (Attached.SRC Requirements)
@@ -4430,13 +4419,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	    (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
 		ret = tcpm_set_vconn(port, true);
 		if (ret < 0)
-			goto out_disable_pd;
+			return ret;
 	}
 
 	ret = tcpm_set_vbus(port, true);
 	if (ret < 0)
 		goto out_disable_vconn;
 
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB, TYPEC_SOURCE,
+			     tcpm_data_role_for_source(port));
+	if (ret < 0)
+		goto out_disable_vbus;
+
+	if (port->pd_supported) {
+		ret = port->tcpc->set_pd_rx(port->tcpc, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
+
 	port->pd_capable = false;
 
 	port->partner = NULL;
@@ -4447,14 +4447,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	return 0;
 
-out_disable_vconn:
-	tcpm_set_vconn(port, false);
-out_disable_pd:
-	if (port->pd_supported)
-		port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
 	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
+out_disable_vbus:
+	tcpm_set_vbus(port, false);
+out_disable_vconn:
+	tcpm_set_vconn(port, false);
+
 	return ret;
 }
 


