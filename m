Return-Path: <stable+bounces-164511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E1B0FE0E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17191965197
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D28D2FB;
	Thu, 24 Jul 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnWGZc4T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA6C2EF
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316024; cv=none; b=CEd0FIo67yb1TGSQmZxRLfQABn8ZRld1mY/E/Uo6S5mcDfWM3R2sQAm3eFYUjVE/ibGcTr0/9tpo7w6Iozfb62OH7LE7S4a88o4Kw4utlnQdht4Lc0U5jyTZPn9dx1MGq4+GOE1Xzt5ExlYYgYgy5jdhip5LDZtQhU0cXdIXdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316024; c=relaxed/simple;
	bh=8Ym6iC9MqUp1tBQUdgoObQ5/M5Ubui7GTrut3uk64fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQzwOExnk1cltjOf4moiievmh6rwSg6RI92byibFtmPqDrgSWjHgaac8gY+DBpEgYiMQC+B8h56T9vljhEav5KzzzmFLFwcp/9dE+RaVWeXVcrE4B6jq7xdbqn1u83qdP+z9t0oFEOO7CGyoOqitlTDL6oCmmjdGFfO9E65QIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnWGZc4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A23C4CEEF;
	Thu, 24 Jul 2025 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316023;
	bh=8Ym6iC9MqUp1tBQUdgoObQ5/M5Ubui7GTrut3uk64fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnWGZc4TL97sEWajnhQXZ/cWnBBxWEYJRdXA+817oy36J2IcsDr+0XQoBjaJustAE
	 TJenJIxkutMQmXeR9K/kJGsQ+4bUrG+/URUGgu7gRzjbTrcr+tNpawSkzvCsrDu0X3
	 Uv2DGlR2I1LR4mh9LoXo6R9y2KgerYqPYAsfN3MgqevJAZho5InhOdzB7bAn+Kr79t
	 Z7vpV03bGiUc0i5TjxI5sn2R8oapi485k4wWaqdWKwTvgnw7TYNyJ9NHXqrth3n4lt
	 kbl1zBxItdf9b4tHQcpEZO0PcHFsMmFROl1ilsqe8AqJOFiskiaoFDPbs9BKmpVqgh
	 uBFUohIrNJ4AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/3] usb: typec: tcpm: allow switching to mode accessory to mux properly
Date: Wed, 23 Jul 2025 20:13:35 -0400
Message-Id: <20250724001336.1206130-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724001336.1206130-1-sashal@kernel.org>
References: <2025070813-antidote-uncoated-dabd@gregkh>
 <20250724001336.1206130-1-sashal@kernel.org>
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
index 76e6b5d1bc20d..ef111e7941e0a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1160,7 +1160,7 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 				     port->data_role);
 }
 
-static int tcpm_set_roles(struct tcpm_port *port, bool attached,
+static int tcpm_set_roles(struct tcpm_port *port, bool attached, int state,
 			  enum typec_role role, enum typec_data_role data)
 {
 	enum typec_orientation orientation;
@@ -1197,7 +1197,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 		}
 	}
 
-	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, state, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -4404,7 +4404,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
 	if (ret < 0)
 		return ret;
 
@@ -4579,7 +4580,8 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
+			     TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -4604,6 +4606,7 @@ static int tcpm_acc_attach(struct tcpm_port *port)
 	int ret;
 	enum typec_role role;
 	enum typec_data_role data;
+	int state = TYPEC_STATE_USB;
 
 	if (port->attached)
 		return 0;
@@ -4612,7 +4615,13 @@ static int tcpm_acc_attach(struct tcpm_port *port)
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
 
@@ -5382,7 +5391,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
 		/*
 		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
@@ -5414,7 +5423,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
 			tcpm_set_charge(port, false);
-		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+		tcpm_set_roles(port, port->self_powered, TYPEC_STATE_USB, TYPEC_SINK,
 			       tcpm_data_role_for_sink(port));
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
@@ -5538,10 +5547,10 @@ static void run_state_machine(struct tcpm_port *port)
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


