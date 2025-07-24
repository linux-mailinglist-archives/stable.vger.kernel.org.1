Return-Path: <stable+bounces-164516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A222B0FE23
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584E13BE19E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37D4A21;
	Thu, 24 Jul 2025 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyiLA7mH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006D29A5
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316565; cv=none; b=f5lTVOUTPbo8febR5p4pQtR6GU7JBGx9lC8gsKbyBhLHIq+G2CKMiGCXGP0HMTKSqBLcBcbJP6ZH+CC9DSb5C19V3khF3I54lV/I0UW5mHUgaLT6mFKBX6QhNgaNuDDRvJGWMd39WcDkMpbxulG7I2yB0QhgZ+oCuKJnqSwwWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316565; c=relaxed/simple;
	bh=DzRLagD866ebqHxHD8ppvMOym1YR4ASFb6u3x33jl1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOQwcLKPPOB6WFKuuwGUi27pksvWsPznpu7zdbTVwXGNI5YT6WFDdv2Ha2n4woCQn6I1rQ9Tdo4vTZzdLuj7qKdmGvrnEaK/T/rLuAtQ+S+/iQ2QohSALebnK5rL3RYqNEpXLrxf3muQCdv0VFSx/57Xu6VKW63D5PJ9Bo4tnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyiLA7mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE73AC4CEF4;
	Thu, 24 Jul 2025 00:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316564;
	bh=DzRLagD866ebqHxHD8ppvMOym1YR4ASFb6u3x33jl1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyiLA7mHvyi5tdpcDyY3rl3hkVKmqLx4tq0FTAbuGxqbXCguguwTX1UcmAo+2osxW
	 hDG2G5OQMj/IJ3XQTOXfQkEYM/O8wIv+7LWlJTXXmOE4D4niiK4lkOEnpfZlqmUA36
	 P0DsNsurlcKh61Z90Bs78txHbkw7sYMrnzj2F8EsU2TzJ1nJVpnw8eSLdJWbCRTR5+
	 4v6EY3MqUTTH9BA5z+RhmkrIHH299cig67eFz7Oa66mwM2B/69OAI5NrLwDZ4YoK2Q
	 0k1LIgrAX8FUuinQDkpiBnEFjIKpMyvrMcu0usZ/OOzew0S5J4dX23rKcUVnYmXYUx
	 3t1RBQQiJgYkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 23 Jul 2025 20:22:38 -0400
Message-Id: <20250724002240.1208325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070814-resume-lazy-4b81@gregkh>
References: <2025070814-resume-lazy-4b81@gregkh>
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
index bfcbccb400c3a..af7e18f6e930f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3802,12 +3802,17 @@ static void tcpm_snk_detach(struct tcpm_port *port)
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


