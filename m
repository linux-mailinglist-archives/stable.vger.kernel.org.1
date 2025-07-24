Return-Path: <stable+bounces-164521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC26B0FE2C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DDB58332E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D522083;
	Thu, 24 Jul 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOnVCSAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874F4C8F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317050; cv=none; b=Z0ZaIqI6Y6PPCsJt4fvEULZD53gIAo0dPF3JzRviQE3SoiXzk+UWanRz68fWS8NnaiJ7rbvmJseg+LgNFsmzH6C9IoBdQapn9Y3E+cEO5ae+CB9L2vJNLQmfVg9SvQhEQhhUBzio4vC6EKx1rGWfKYlDU426y7mgHkPgAv77NBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317050; c=relaxed/simple;
	bh=/onvWpI3sRyuvjPVMNIi027P8n9uPawOHSrdQCaegZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cy1ZBGep+hwqA2IKj9wZvC/dT+FstHnKzbsKhK+X5tXQLg6ewxEQVL6tNKPR9I+T0GeFJyZszksd1fdaHH0c2Mn8pAkkbb0wM74edImHftWot66goClQSl/RATT+eSgx9CesS87zNaURLSppXx4wGcXp/usrGn+qaKF/ENJm/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOnVCSAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F41C4CEF5;
	Thu, 24 Jul 2025 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317050;
	bh=/onvWpI3sRyuvjPVMNIi027P8n9uPawOHSrdQCaegZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOnVCSAonKGubcP9r7uNMQnnqMMUYQmooqmw0lC1AZj2a6tbdE2g9KQKZ5TXFvOS7
	 gxNs4Eh9UHekxlac+F2DiQFClIpHYfC12+Hncf0LSQyEqkqomUTH5yvJ0B/U3syI8m
	 OZDh77ZU1yMF91GU+nZ777DAlZ0d9pZ2/LQSP5baEog3XsQ4B4NkQykV1op6Sk21SC
	 yfKY5nmqAeCM1BC7CVlXLD+pZ9VVQBppbNWWD9XbEIhe3Bz7EahD3ZrW0GyLBUMzIb
	 qlJc128N0kucMEtjMiY03oFlke00yLl07ospbho2HNprUbYDJ3z/aNIbcbwPyd9f1A
	 DtLNCpgJaMFbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] usb: typec: tcpm: allow switching to mode accessory to mux properly
Date: Wed, 23 Jul 2025 20:30:44 -0400
Message-Id: <20250724003045.1210003-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724003045.1210003-1-sashal@kernel.org>
References: <2025070815-spongy-caravan-a8f7@gregkh>
 <20250724003045.1210003-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 8a50da849151e7e12b43c1d8fe7ad302223aef6b ]

The funciton tcpm_acc_attach is not setting the proper state when
calling tcpm_set_role. The function tcpm_set_role is currently only
handling TYPEC_STATE_USB. For the tcpm_acc_attach to switch into other
modal states tcpm_set_role needs to be extended by an extra state
parameter. This patch is handling the proper state change when calling
tcpm_acc_attach.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250404-ml-topic-tcpm-v1-3-b99f44badce8@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: bec15191d523 ("usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 69115c60285d3..0fe66a99fcc41 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1024,7 +1024,7 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 				     port->data_role);
 }
 
-static int tcpm_set_roles(struct tcpm_port *port, bool attached,
+static int tcpm_set_roles(struct tcpm_port *port, bool attached, int state,
 			  enum typec_role role, enum typec_data_role data)
 {
 	enum typec_orientation orientation;
@@ -1061,7 +1061,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 		}
 	}
 
-	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, state, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -3622,7 +3622,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
 	if (ret < 0)
 		return ret;
 
@@ -3772,7 +3773,8 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -3796,6 +3798,7 @@ static int tcpm_acc_attach(struct tcpm_port *port)
 	int ret;
 	enum typec_role role;
 	enum typec_data_role data;
+	int state = TYPEC_STATE_USB;
 
 	if (port->attached)
 		return 0;
@@ -3804,7 +3807,13 @@ static int tcpm_acc_attach(struct tcpm_port *port)
 	data = tcpm_port_is_sink(port) ? tcpm_data_role_for_sink(port)
 				       : tcpm_data_role_for_source(port);
 
-	ret = tcpm_set_roles(port, true, role, data);
+	if (tcpm_port_is_audio(port))
+		state = TYPEC_MODE_AUDIO;
+
+	if (tcpm_port_is_debug(port))
+		state = TYPEC_MODE_DEBUG;
+
+	ret = tcpm_set_roles(port, true, state, role, data);
 	if (ret < 0)
 		return ret;
 
@@ -4484,7 +4493,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
 		/*
 		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
@@ -4516,7 +4525,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
 			tcpm_set_charge(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SINK,
 			       tcpm_data_role_for_sink(port));
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
@@ -4615,10 +4624,10 @@ static void run_state_machine(struct tcpm_port *port)
 	case DR_SWAP_CHANGE_DR:
 		tcpm_unregister_altmodes(port);
 		if (port->data_role == TYPEC_HOST)
-			tcpm_set_roles(port, true, port->pwr_role,
+			tcpm_set_roles(port, true, TYPEC_STATE_USB, port->pwr_role,
 				       TYPEC_DEVICE);
 		else
-			tcpm_set_roles(port, true, port->pwr_role,
+			tcpm_set_roles(port, true, TYPEC_STATE_USB, port->pwr_role,
 				       TYPEC_HOST);
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
-- 
2.39.5


