Return-Path: <stable+bounces-164514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B337B0FE1E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157067BAB95
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A29C147;
	Thu, 24 Jul 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4VCCvng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D214C81
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316243; cv=none; b=a9iGv+GucNzeRke6EU9JawTUx1oJC2sOD/+XrFnEPAqO61AaL94JsnKHLT5K2sEMcikgkDvQSgZWE5yeZAKAx2WHlgzO7l54Fsrth/fHdeLegN14M4CO0zImbTuHtbwtEVb6QDHg7TOSfF7oTij6185zsH2BEOfq30VBv50fZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316243; c=relaxed/simple;
	bh=m+4zrL5DuB8sQItcKfcCQTb1aHsVh2r8btV6kBdnak0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qsg87muOBStZTOu2BX8IciM/k//gvv39ZfWCe/VQYunUnsSJHhQFFmAMR5//ymUgupSneaCbRPRQj9jDCtAOX1u6Ompj024ti4l2okJLZoblv4TG+n8nF48YZbRsV56ZNPd627S93Fp8PxYFO61L7181mbepAlCItUP1iS/UAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4VCCvng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24AEC4CEF4;
	Thu, 24 Jul 2025 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316243;
	bh=m+4zrL5DuB8sQItcKfcCQTb1aHsVh2r8btV6kBdnak0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4VCCvngWNd/cRfBtQf7A6zlJc3k6YLBgjNKqL6Mcyl+Ei1UDqDbnS2Ppio3pObyA
	 D4R8e/zHHR0cwW0EwExYPV0HQ03VbZfxCa8pXfS6qOAOm8h5yQF6/JnxzADfQ3FOWy
	 2EBJj6nOd6lduk3lfwSH3t9lmbkJKzi/he4i3oiYuoEEXfIXYuqEP6fXy4oCliuyCm
	 be/+/5zl7t0kTgmbHD3tsfPpg4JviDyWD4G0oiSVjgIMn9NCeXLVbAZ6A/Uaqdtuut
	 fodR7RetKMh6ALRlP0NA2gtSwAaBwHqHQTTxL9mIKkCVHZcZaIAddWds4yuTGSaZR3
	 3+G0X+gzK2eEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: typec: tcpm: allow switching to mode accessory to mux properly
Date: Wed, 23 Jul 2025 20:17:16 -0400
Message-Id: <20250724001717.1207161-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724001717.1207161-1-sashal@kernel.org>
References: <2025070813-unwoven-idealness-eaa2@gregkh>
 <20250724001717.1207161-1-sashal@kernel.org>
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
index c72b108199c40..e4ecd5ac95c23 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1132,7 +1132,7 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 				     port->data_role);
 }
 
-static int tcpm_set_roles(struct tcpm_port *port, bool attached,
+static int tcpm_set_roles(struct tcpm_port *port, bool attached, int state,
 			  enum typec_role role, enum typec_data_role data)
 {
 	enum typec_orientation orientation;
@@ -1169,7 +1169,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 		}
 	}
 
-	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, state, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -4339,7 +4339,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
 	if (ret < 0)
 		return ret;
 
@@ -4514,7 +4515,8 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -4539,6 +4541,7 @@ static int tcpm_acc_attach(struct tcpm_port *port)
 	int ret;
 	enum typec_role role;
 	enum typec_data_role data;
+	int state = TYPEC_STATE_USB;
 
 	if (port->attached)
 		return 0;
@@ -4547,7 +4550,13 @@ static int tcpm_acc_attach(struct tcpm_port *port)
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
 
@@ -5306,7 +5315,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
 		/*
 		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
@@ -5338,7 +5347,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
 			tcpm_set_charge(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SINK,
 			       tcpm_data_role_for_sink(port));
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
@@ -5462,10 +5471,10 @@ static void run_state_machine(struct tcpm_port *port)
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


