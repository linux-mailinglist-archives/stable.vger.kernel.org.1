Return-Path: <stable+bounces-164515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38EB0FE1B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29E63B2DDB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3A4A21;
	Thu, 24 Jul 2025 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Dns1Hv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA64430
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316245; cv=none; b=lB9mE0QReGcDwbB8sFmYEvYxvuKiX09dyjNuztw5S2il549oIFSww/ghSHgx597P9EPsjMMqPSNXy/CYSD+v0pLA+e3twcei2fuwl0sZdAhwM1Hp3kcQEJupFvHd/pbiE3eua/oIbDwRrUxz/xxXuHYyl4srtrB80EHAxQ0iNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316245; c=relaxed/simple;
	bh=3wSdLluhqCg4oj2fjI5gxhQfm/9GJi90bwTfldiTe+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcGTLFEvXVjXHnsr6NkWphLKala2U9ebR3bH4Jvj3hU1j3U3edz7v56ZD67Bhmt1LXiMeWGJ91JkIku5JcWKCq6wQAXxcQP62t1rMDG2p8sitc30rg9t1NZ8J2KT6hbwhL8eztCSRS1EEp2H2soPkaLPKiEQsFABNA8PzfRRI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Dns1Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE0AC4CEE7;
	Thu, 24 Jul 2025 00:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316244;
	bh=3wSdLluhqCg4oj2fjI5gxhQfm/9GJi90bwTfldiTe+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+Dns1Hv3aPyGfmqBoYc8pV1bjTFUlunwSdMmTSNRJqkeo4uzUsMBbaDWUBnCuFls
	 nGJIGTaVsPuUC7tis4iWCw+SbpJBcPd74swTTj0hhEbC0znQ/hx1mIkGeDiJR9b7Rb
	 egUVW0GfXdlGWj2FD1OV0jRYstedXF4fm4UmQfZHRUlsktdltFapEPk8IQnYpVBHCX
	 ZkyVAoZJHvsE51gE9fQ9vCwxYF30NMo1Ga/LuiWxSXAGooYvK1PFEX40e+z6cDaCCP
	 ZFh3Q8/mnjjhte6gobLTujTte+G1uG2NofNff6yCMiTxQ/HIOG/KehwcURJ42lO3ot
	 Gcf0plItDQbAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: RD Babiera <rdbabiera@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach
Date: Wed, 23 Jul 2025 20:17:17 -0400
Message-Id: <20250724001717.1207161-3-sashal@kernel.org>
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

From: RD Babiera <rdbabiera@google.com>

[ Upstream commit bec15191d52300defa282e3fd83820f69e447116 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index e4ecd5ac95c23..aa2fa720af155 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4339,17 +4339,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
@@ -4359,13 +4348,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
@@ -4376,14 +4376,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
 
-- 
2.39.5


