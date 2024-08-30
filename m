Return-Path: <stable+bounces-71656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C93966390
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B371C20B44
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F51199931;
	Fri, 30 Aug 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pajh9QeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17361A4B9C;
	Fri, 30 Aug 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026416; cv=none; b=mCOmAS9woRNvuVKwjXHO7Yt17OesZMQ8w1e3Z/aN8DwIzPVKtP/tEdugH4iZJ9ODPgwGGUp+yirb4x2eCfSV0pfItwJOJk8cynnpIurUxm/87ugTekbgiKmToTr/+9Kmh9wzvuYjbVomyfF9P+krcV6CmzFErpLgL30chJAKY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026416; c=relaxed/simple;
	bh=6LQwcRohtSWtE15WMfrdudFwvRpiK4GcwW19wTmXtD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGraeDUBXxxu7hDTVwUghinDraeo4jB6X2eTwTJRKH1+FvVZOGftLGeIHBvuSH/q507YxUEN8gFpdT7VGynAjkikAsY2gablJhkZPSbK9IHs+NivZpp0KWOAyKcp8iqTIDMEL+SuS+8FbKGi+mUC0CnMlX8c4r/nY8Gb9GR8L4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pajh9QeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8CEC4CEC2;
	Fri, 30 Aug 2024 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725026415;
	bh=6LQwcRohtSWtE15WMfrdudFwvRpiK4GcwW19wTmXtD8=;
	h=From:To:Cc:Subject:Date:From;
	b=pajh9QeWAnT7dxnYYu3bVSssLf8soLVH7pqiHzefUIkDK//7iFyWliwkYh7YrATwm
	 qwL6UjA51g1SjxrYahJBfJqbFIRJlefF7/A2CWMwuucnR94GWXIMfXeOmfwrtz9rpw
	 BuLdL/yzV6KfbaxYdxPE+2BXGR/uPqrcMe8exRIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Charles Yo <charlesyo@google.com>,
	Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Ondrej Jirman <megi@xff.cz>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.6] usb: typec: fix up incorrectly backported "usb: typec: tcpm: unregister existing source caps before re-registration"
Date: Fri, 30 Aug 2024 16:00:09 +0200
Message-ID: <2024083008-granddad-unmoving-828c@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 74
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=6LQwcRohtSWtE15WMfrdudFwvRpiK4GcwW19wTmXtD8=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkXL2SIPrgVc8hskxy/hsuXnDnbLaYVMStMLtu5tH3mj uvLg7kMOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAivrwM8yyC03+7T3R7Uc59 q5b133v7qpWa4gwLDqbMfHKoYXbvxynab8VLpTcr3D0XDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In commit b16abab1fb64 ("usb: typec: tcpm: unregister existing source
caps before re-registration"), quilt, and git, applied the diff to the
incorrect function, which would cause bad problems if exercised in a
device with these capabilities.

Fix this all up (including the follow-up fix in commit 04c05d50fa79
("usb: typec: tcpm: fix use-after-free case in
tcpm_register_source_caps") to be in the correct function.

Fixes: 04c05d50fa79 ("usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps")
Fixes: b16abab1fb64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
Reported-by: Charles Yo <charlesyo@google.com>
Cc: Kyle Tso <kyletso@google.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>
Cc: Ondrej Jirman <megi@xff.cz>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Note, this is also needed for 6.1, I'll fix up the git ids when
committing it to the stable tree there as well.

 drivers/usb/typec/tcpm/tcpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7db9c382c354..e053b6e99b9e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2403,7 +2403,7 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->negotiated_rev };
 	struct usb_power_delivery_capabilities_desc caps = { };
-	struct usb_power_delivery_capabilities *cap;
+	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
 
 	if (!port->partner_pd)
 		port->partner_pd = usb_power_delivery_register(NULL, &desc);
@@ -2413,6 +2413,11 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
 	caps.role = TYPEC_SOURCE;
 
+	if (cap) {
+		usb_power_delivery_unregister_capabilities(cap);
+		port->partner_source_caps = NULL;
+	}
+
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))
 		return PTR_ERR(cap);
@@ -2426,7 +2431,7 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->negotiated_rev };
 	struct usb_power_delivery_capabilities_desc caps = { };
-	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
+	struct usb_power_delivery_capabilities *cap;
 
 	if (!port->partner_pd)
 		port->partner_pd = usb_power_delivery_register(NULL, &desc);
@@ -2436,11 +2441,6 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
 	caps.role = TYPEC_SINK;
 
-	if (cap) {
-		usb_power_delivery_unregister_capabilities(cap);
-		port->partner_source_caps = NULL;
-	}
-
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))
 		return PTR_ERR(cap);
-- 
2.46.0


