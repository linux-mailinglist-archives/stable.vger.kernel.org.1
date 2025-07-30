Return-Path: <stable+bounces-165481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA30B15DAD
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A0918C39FB
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DB28727F;
	Wed, 30 Jul 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z4JOp4qT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0F280033;
	Wed, 30 Jul 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869314; cv=none; b=EV2gKks3geC8jkufJO3wET9NQTHBD5FHdyjJLjyxcgmzqj6v0fiOB95NdwCvxda7o+ufKLzmX41qQHirffZkyjr1wapaUxvUPtOj0SrfUhQv/DTr7cSBqSF6I+6KrDCAljJ33DAgUk0KcfDDL+HDHdbcX1q2o2LpmJs9UTIfzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869314; c=relaxed/simple;
	bh=wwuOflYAUi5Mw2AxR7rWC3PLW7qzKJ8iCSqLoyF4sQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5eiH4r56LAuYoesc4zsGzyeZQxbhGi6Glc6Dt1qKJnJvmBH36PSWUT+adfvqfXIQmidWbawGitIuo0JM92PbBztp6xOdsk3io4HhSfoHHKtZVlvVIOWRnzhoeQ/e+UTgIQoaU/MkqwKqhbAa5RoV+j03dPfpcXj9rv1Up6+MOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z4JOp4qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB04C4CEF5;
	Wed, 30 Jul 2025 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753869313;
	bh=wwuOflYAUi5Mw2AxR7rWC3PLW7qzKJ8iCSqLoyF4sQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4JOp4qTnsYODHQp/6RoxaavcYxzB28r+OG5TxcCTRWcgWdjULhNpTwy6ZpUmqyft
	 doqWIenMiRzayOB/jbChpY5h8dp3w5nu1BmLuel5iykyao2avw41PRzDPnJR+YqL6f
	 ZAIig7lfdmVTbRLYkZYyvL1GyzUHSr72J9EgIXsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 87/92] usb: typec: tcpm: allow to use sink in accessory mode
Date: Wed, 30 Jul 2025 11:36:35 +0200
Message-ID: <20250730093234.108436142@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
References: <20250730093230.629234025@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

commit 64843d0ba96d3eae297025562111d57585273366 upstream.

Since the function tcpm_acc_attach is not setting the data and role for
for the sink case we extend it to check for it first.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250404-ml-topic-tcpm-v1-1-b99f44badce8@pengutronix.de
Stable-dep-of: bec15191d523 ("usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4602,12 +4602,17 @@ static void tcpm_snk_detach(struct tcpm_
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
 



