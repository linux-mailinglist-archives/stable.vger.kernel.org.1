Return-Path: <stable+bounces-164518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C2B0FE25
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F396C3BF5CE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF05CA5E;
	Thu, 24 Jul 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVoPLpqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57929A5
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316568; cv=none; b=su9mn5kjhVUeSjsDB8jpzLdA0KC6zT8kHaIdahd021esbMRZFGWt79CCHkJ+3sm4k5ELYTdgNLLMhcrF9yw1TzSXidErk7dfzxoGBXBL9e43czgw7QVvuQZr4okAITiZXoSFHSBvTDD9qdp42t/1VL24WM+RAn4g+0B+Q2eS2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316568; c=relaxed/simple;
	bh=1Jlc1Yx5f/JppkSa2+F7bC37a20c6qKPLjPB1izIWh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kr354RRP7kSBtVj3amzuR7EBSqlwXOIqZBhdk5+3mnUXoFnwEG8fpypXXEUAECB2162dvEU1a5gGyWMnYWNnbYowZI/AKpILIYa+pZ0mQmqvcj0lc9yCffiZiP/ltD90jn4OYF4tMlcHbey17j+TNHt242FvIVhfJxQipgzdx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVoPLpqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F65C4CEE7;
	Thu, 24 Jul 2025 00:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316568;
	bh=1Jlc1Yx5f/JppkSa2+F7bC37a20c6qKPLjPB1izIWh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVoPLpqVvUEI1urDAshqfMsIsQIo29Y1XCMhjE1Ifxxg52vylwXsEiY/Xsxk7eua2
	 QMxzXX2HIg/gLZqzkleDGZfPAoO6CkTDPQ0+0gQqdv27U0lBUom0k9s5Mdu/zpUgEU
	 v9xF3UBcFje3Kqr66womUsHUrwBqUwJod4PSd2jjHnRh0JYhQPc9YmCbocIsr023iC
	 DPQlnwqmnDsaIkXanhxREul0+gxIpX2lIv1nMKrTsWOo8w9yYq+Uqf2wZHw9rYvAKY
	 iqb9OnZcasvTGfCU3QYaYT5xJVtGTh+z75e+pzri1MM/E3qUDuDezT2oPh9N83wFEC
	 j+ZH/TfdFiizA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: RD Babiera <rdbabiera@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach
Date: Wed, 23 Jul 2025 20:22:40 -0400
Message-Id: <20250724002240.1208325-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724002240.1208325-1-sashal@kernel.org>
References: <2025070814-resume-lazy-4b81@gregkh>
 <20250724002240.1208325-1-sashal@kernel.org>
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
index c7680e10b6229..5774b50eeaf7f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3622,17 +3622,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
@@ -3642,13 +3631,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
@@ -3658,14 +3658,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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


