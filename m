Return-Path: <stable+bounces-164512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D619B0FE16
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460417B9AC1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378E2E371D;
	Thu, 24 Jul 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuP+Aq1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F72A48
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316026; cv=none; b=gv9VzP5zsQhKCtRk8n+lsMBuxbqqWmO6v5ajFgfIsgWwhuiVGDipBOVfrAekGi+AJicJQluEUQt/eD/4sxufoD8bhE8eMQFrRQ6gWKN291UjH8KnKVllbBpcj295lM3wmi8lPd6EU3eveZZKKPMRah0MbXQpIs2XiqlqPuicue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316026; c=relaxed/simple;
	bh=zNrJxRIKkD0ee2EXpMVu+b6oJSI1MQkUnbBmP48Rvk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qx2gECy5XYWp+Rvw2HXeJJzr6HhGTPGHGoeLamZzZa1IKQyjffWVuRkKuejykq959P/RtSGkx4m8TTZjqFPYz/AI6Xsd0+QY7FY9vAoOtfN5pRy22aRqtUSoJ/wbkAcYmBDUtjTalPp8OufaVPf4SO4kXEoeU+bHKJgidd9la6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuP+Aq1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A88C4CEFB;
	Thu, 24 Jul 2025 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316025;
	bh=zNrJxRIKkD0ee2EXpMVu+b6oJSI1MQkUnbBmP48Rvk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuP+Aq1jbb8V5xYQoLEoJmBFAmV+yGLmLh+uAXXq/fPXXd7rZpVc9+Y/z69Tq9yN1
	 2n1eTBPX95mTNZn2kxql9Qjko1kTeL9aGtHYJEq9YCGURVh3MLS4vsuqJo0lNOezSr
	 Y/lC3o517mf5VDAseoSoe96Q6DgGO+tfMyXq0cpQczYuqOfBLdaq4b1XyCCqteGIM1
	 1Ou2xLCRIBqCMWtjzrRdx3HRsjXOKJ2aTB3q8dzzZp3sXcC+Cq9NmId7Af3rXDvZOT
	 Er+wMUeAZTabkD667ZvnYXGAePfkpdux2fAyg6AnCIxnrmIFv86cCPbmariK2if3wF
	 58EsNejjYFk/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: RD Babiera <rdbabiera@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 3/3] usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach
Date: Wed, 23 Jul 2025 20:13:36 -0400
Message-Id: <20250724001336.1206130-3-sashal@kernel.org>
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
index ef111e7941e0a..5915bb249de5d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4404,17 +4404,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
@@ -4424,13 +4413,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
@@ -4441,14 +4441,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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


