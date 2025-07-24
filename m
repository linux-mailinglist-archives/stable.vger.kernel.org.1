Return-Path: <stable+bounces-164510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC29B0FE0D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C012996473B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD4C147;
	Thu, 24 Jul 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtkkdOKc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B52E371D
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316023; cv=none; b=qoifc6DriChMbv+C8jWIhJR91MnSvR94LCX6oprXuxxNWEGPCoDJw13NbRRu68uNuJCwhXzcKjLURdJzhTWyo26chv2jCrSSqLY61cCUrbtqSquiF6Pz9JU/cVLJTIWzJQW+DM/3vdyA4zQDVxzOBP3roJ4QotfaMJRGj+ufuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316023; c=relaxed/simple;
	bh=0bvM6xrsW1Z7djK7NL8Z2iDfIyL9eKrqJwKRDCwymEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHHuHJl2wK+58FfuZV6QvcQq20jm/BcQOh9D3VAu8jwzcJLIJU7luVSBueob7HD37PpsdqJlCkXHZ6zkPC+aRqV4tZz3As8dfvkEUa9klq1NNfYjGNlg1phVN79GRKsrKS84XrltWWs+5U7LjFs19WPTcFTGrTlNHkR2iYFGKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtkkdOKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D300DC4CEE7;
	Thu, 24 Jul 2025 00:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316022;
	bh=0bvM6xrsW1Z7djK7NL8Z2iDfIyL9eKrqJwKRDCwymEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtkkdOKcqcnae3M0vZSQZh0R5xpokgFeWWSrJwGyq97TrrRnHFDAaF2AprJAGv+9e
	 q/1CMsflNvIhsMhf04blpmSfMt3Gnlbo674zt5ctLFWNeH1pXDEN5Ij87EsWrfS/RI
	 C8C3fY4tYNjO7f3xffh/lfI4u6Irt3D2OLobEyjs3cRkWtdqB1CYUURle2u98lyVUb
	 J83PNqsQ9l8NFUNDwPkK6IgVeqrpWS0HYqCE51DFnLFEgLgsHDLbihpqDwAWWNRboY
	 zFCa1TckUbPMOAPYNogopejhNbwTOd7GHKekTO3uq+50UCP/MAFfq0vFlq2ioHK6Nv
	 wID22a7hkGGJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/3] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 23 Jul 2025 20:13:34 -0400
Message-Id: <20250724001336.1206130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070813-antidote-uncoated-dabd@gregkh>
References: <2025070813-antidote-uncoated-dabd@gregkh>
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
index 214d45f8e55c2..76e6b5d1bc20d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4602,12 +4602,17 @@ static void tcpm_snk_detach(struct tcpm_port *port)
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


