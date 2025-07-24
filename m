Return-Path: <stable+bounces-164523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E45B0FE30
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199791C87D8D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FC4C8F;
	Thu, 24 Jul 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2ND08OJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C8256D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317384; cv=none; b=rJOacG7XeCgTozUL1aXNz0DiVlGYSO+/Fhw1mYuV+qM939qJKEePMFcdFBDK1l7Eq7YEq+uhAAmUIVkkpIsTEf1h6JyqtSyQiwt8j8LWXip015Gi0gHWZopMSZWVGnNtHMZh8ALekL5s4h+DJYs83JisRuHKFEbRU4OpZWPS9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317384; c=relaxed/simple;
	bh=HZBD7SjwdumnBwDOleRyDFLRYfuiB/ICVIojn2myv0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBebrKezSlDrIhmOZZyGEdRi6aOUWcvmAXnvrJmCVDAA0Bnyw74FhaBp0e/yuVwo45GbUJ+MzWqnHdBWBjDWBgaQUZ0zYAkHjwCEF7YX/RUn3JIssJMdlJQoEt9AjLlcWrwkEP5MUX+g7loEBx2BuraZGjVC49PS0jew22nePW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2ND08OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71AC4CEE7;
	Thu, 24 Jul 2025 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317384;
	bh=HZBD7SjwdumnBwDOleRyDFLRYfuiB/ICVIojn2myv0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2ND08OJnIQRE8TUxKWLKWLHOF85eqcSdYAZ44ICQsupxmtx2PjXFuWQn7KQgcA3k
	 S881H/K51W7YRwMEg+UwA/arH+2+51pliH1M+9clk84DffwtBGievFo+BdSNPhsVke
	 uls72Wx+POhoiIn9+9yHMFoUxYugv/sOJFJMmvN5mu3REfxtQ79K2s9p7TIXVBycmb
	 LzSXh5NV/RIs+LWHQvdE1O6vGguOnv5ngDmj6/5TcW2huxNZ5seYho2wLMZ2Q6Koke
	 py1dpWpE9SssB7UAy5htSSWU/sTZi22ngSWso3/+GwFcup0/rOmgBBc+oAFt/5k/ar
	 LH0tqeqfaHrlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 23 Jul 2025 20:36:17 -0400
Message-Id: <20250724003619.1211156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070814-evict-shelf-8b8d@gregkh>
References: <2025070814-evict-shelf-8b8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 64843d0ba96d3eae297025562111d57585273366 ]

Since the function tcpm_acc_attach is not setting the data and role for
for the sink case we extend it to check for it first.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250404-ml-topic-tcpm-v1-1-b99f44badce8@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: bec15191d523 ("usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f40eabb7e24f7..2515fa12c626e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3866,12 +3866,17 @@ static void tcpm_snk_detach(struct tcpm_port *port)
 static int tcpm_acc_attach(struct tcpm_port *port)
 {
 	int ret;
+	enum typec_role role;
+	enum typec_data_role data;
 
 	if (port->attached)
 		return 0;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE,
-			     tcpm_data_role_for_source(port));
+	role = tcpm_port_is_sink(port) ? TYPEC_SINK : TYPEC_SOURCE;
+	data = tcpm_port_is_sink(port) ? tcpm_data_role_for_sink(port)
+				       : tcpm_data_role_for_source(port);
+
+	ret = tcpm_set_roles(port, true, role, data);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


