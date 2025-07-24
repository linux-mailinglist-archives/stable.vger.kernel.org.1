Return-Path: <stable+bounces-164520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979ABB0FE2D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0674E8421
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B1259C;
	Thu, 24 Jul 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIXdDWr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627411CBA
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317050; cv=none; b=hQLi0IcOeMAop+4o04aqjyFrZ6bVBDrIlJgtHruNNDA0F4NUrkMuP/M7eG2jyTHPyiW/mKdmFLKA1peAZRaJ8QsSa5JuQltCLL6IM8OZVDpHIAQeMPn2Ahw8ULKZIOAGzZBBGfr/lNsPVzl/i5FOHfvim+DjUvnUnOYe6szihWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317050; c=relaxed/simple;
	bh=AjaNxeW6z3a74VJg7hVCdjx+56nEEfmy2EJ3UKqpuJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tjzy0nCL+n1Ioa3V8dI+GEfVhI/8gy2j+mCuRK9n0M7Vrgpet8lSeSlCfViRM36PRnhaCXFjkio1UBMuoQinnWbvy54viRAubiF53M6HlCMCGnpLw7sfZ10511ywk0SGxxz/9vx+L2PKgAAKsMgEYK+nCFD6Eti14vbBATfFp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIXdDWr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7913FC4CEE7;
	Thu, 24 Jul 2025 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317049;
	bh=AjaNxeW6z3a74VJg7hVCdjx+56nEEfmy2EJ3UKqpuJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIXdDWr1wyxNM/OIzsQ+CeyVAmzXhG+wmgPCco6j2neUiJ4nRnxsbsJgq4PosLycD
	 vfFQwISv1sfuZtPSTPUD+ktp+HYSt+YsE2EUZm7FopASSlmKm8EUEUE7bJ9o4zjcCB
	 OFCAOwgIYmyo/x+glLy+zk08Oi7d2YlgxElKQBDDzCwxSdtw8Dn3o/HztgObRggBS6
	 M2uBgf/PNpgt7gjoy/NwiYcdC7lFO9b8LRJVNQqo3Seytk06XhdSmhBLAV9QNRssKR
	 H7JRrBUAl+BTswf2/36LER8xFvgXWwAjq/Rx0qeif1z1+2GpINdR0bnls1JeXO9mDz
	 nN+8aoJ7aTTdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 23 Jul 2025 20:30:43 -0400
Message-Id: <20250724003045.1210003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070815-spongy-caravan-a8f7@gregkh>
References: <2025070815-spongy-caravan-a8f7@gregkh>
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
index d8e299bcbf840..69115c60285d3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3794,12 +3794,17 @@ static void tcpm_snk_detach(struct tcpm_port *port)
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


