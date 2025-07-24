Return-Path: <stable+bounces-164513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5DB0FE1A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134F45A0CC5
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41259211F;
	Thu, 24 Jul 2025 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq9eYMBb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C74C81
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316242; cv=none; b=boHsuWigjexzV6++MjHxZpLsv65jMCRJeYwXNjKpiRcedCGl2yXW0hOo14ry095IAHJp5yLqg+W/KE9+L99GH0l8xCr2m9yBVNQk27wvjLypRK8nat4uXbgyxAw1MylwQoq45iXb9FpJYGP1ZBVJtqWe9JQKFD6n8QxcheyC5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316242; c=relaxed/simple;
	bh=UMUDENAImGdl20ms0SPBoh/FQDRni20gtkHn2w4ZQ54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzTz+xPDd3mKRWyjZmKHWVZiDV1xjFQ64l8D6d2GPaye3X6nOlR+MvTwqHlCHt32swKMvsYglc1I8PWc420q+Xt6LZQGKvdwaccvh5xrg77vC52TMJRepDZlG43SgIb9owPV6dPtwoHzg2gMvmPHstBkZQKwxJjfCVRFkHuNg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq9eYMBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB98C4CEE7;
	Thu, 24 Jul 2025 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316241;
	bh=UMUDENAImGdl20ms0SPBoh/FQDRni20gtkHn2w4ZQ54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq9eYMBbU5qphozGUP94awHZAZ/QFrj3J9a4sns1keV6b/R0wl/76k4D1erujJaG8
	 Xsu54dpqzHAqkcR1B/+ZfVzzK+HPbr5Ik1+imaWh+zJeUNktnzIUC1jrFOsVZocLeQ
	 ZL+eEAl9a9t+czhlryiZYpOu/bkim2AWKrEI88MvNoU69LrdHNiaAa4hEdv1bAYfao
	 Vy7kw2lbOzORSEnowI1q1duDqP5S3dkn9fYgKpX5/X+jOJfrghsLTaoS+vLCLHpMs/
	 iM4qIRmg2aAL3XKMGib2/GRMwbsnGOVlAhIE0Rg++C9RJ3p0I5/EShLPF+Qn2Dq0rT
	 5506GReHVrOGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 23 Jul 2025 20:17:15 -0400
Message-Id: <20250724001717.1207161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070813-unwoven-idealness-eaa2@gregkh>
References: <2025070813-unwoven-idealness-eaa2@gregkh>
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
index 9838a2c8c1b85..c72b108199c40 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4537,12 +4537,17 @@ static void tcpm_snk_detach(struct tcpm_port *port)
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


