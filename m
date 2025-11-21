Return-Path: <stable+bounces-196555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D0C7B485
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25B3835BB53
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FF2F658A;
	Fri, 21 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="giRd/W/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDE285CA3;
	Fri, 21 Nov 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749010; cv=none; b=f0XDApYE41+t+KxaBTIQqfH8kW2hS/Lnij7cshUZIsVyKqvHMvyN5hfDnsKbH902HApLbDpB0PAFO48Wp3LymcFYdY4Wd6kbE77VrTF3Yn8jy01eYQv1N367uHr7Z10De2L9mHfK6gpU0ArrFGXqBl47sGth/MPmsHf8+t8tm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749010; c=relaxed/simple;
	bh=FKFhoeOq4jsAOmHfzzNktnqeRvgyJi3lqxDZKCaXEtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s6ZMiBjAClXWWbhBWhVb9yBUIOPw5zuCegPlT2nF+F9ZYVP40ql6SFnOoIq2GXDus4L1kmu4cF55MaEEKyc3kQoJK62/QA0aJ69fdLfwhPEOM9BVO65cEfn5s+cTa+2KE8msNeuwgW2qvGo6yYuxzKgW6bZmsQm+75i/DXL8AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=giRd/W/X; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 587E6600024E;
	Fri, 21 Nov 2025 18:16:44 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id SpYkz7SZHBfh; Fri, 21 Nov 2025 18:16:41 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 8F313600300D;
	Fri, 21 Nov 2025 18:16:41 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1763749001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IFjrkGmKM4swDN+X/CnAGkhhu1lJqouwzP7tt4P6POo=;
	b=giRd/W/XEUXmpOBYEWBVkZkp1SXAUCdw3meXQSbWUXZVVk8PAfYGqzLN+xRaKrMFi1kmjM
	onogdxY4/Eq6NZUQN1DR6U5PVMgpAJMDcmNP2dCusi8IWsnwm+4qLORGSGoTBpKRrR11LK
	QLWyp7UhI82tlXXCn8nMaw0FfYiHIQ4ZTvc3UcpRYY2qJbYFBWARJtCZrXsoa5WhP0ukKO
	mB5RcUOp2pmm9/a9kLQV5mweZ60PkhpA5Hv2Q6FPECJnLht+6qmgnjeywNcp7ZIrRz+Rzy
	NKs6npWrGzl1HN/JnPlYLQgsf4HPXtCzo9IRcPrNkM8EKGfcRv9rAYqjDHt7zw==
Received: from [192.168.1.151] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 95E2F360107;
	Fri, 21 Nov 2025 18:16:40 +0000 (WET)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Fri, 21 Nov 2025 18:16:36 +0000
Subject: [PATCH v2] usb: phy: Initialize struct usb_phy list_head
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-diogo-smaug_typec-v2-1-5c37c1169d57@tecnico.ulisboa.pt>
X-B4-Tracking: v=1; b=H4sIAIOsIGkC/32NQQqDMBBFryKzbsSJVbSr3qNISeKoA60JSZSKe
 PemHqDL9+C/v0MgzxTglu3gaeXAdk4gLxmYSc0jCe4TgyxkhYil6NmOVoS3WsZn3BwZUdVaFlW
 rm1ZqSDvnaeDP2Xx0iScO0frtvFjxZ//VVhQoBlSq1NemlkV/j2RmNjZfXhy0VbmL0B3H8QWSL
 l0duwAAAA==
X-Change-ID: 20251113-diogo-smaug_typec-56b2059b892b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763749000; l=2292;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=FKFhoeOq4jsAOmHfzzNktnqeRvgyJi3lqxDZKCaXEtQ=;
 b=yyPlNwdYWcGi5hgivtw3AoH1PRJ51ftuo50jVIqI58b5oBUA2UWYpuOWvo1bhPb/wzJ1fg9uK
 VHo02FXXWMEB4leO99qDsllMhWk5WDSgfpgXCbCD8IpYV35Pl+p8Zmi
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=

As part of the registration of a new 'struct usb_phy' with the USB PHY core
via either usb_add_phy(struct usb_phy *x, ...) or usb_add_phy_dev(struct
usb_phy *x) these functions call list_add_tail(&x->head, phy_list) in
order for the new instance x to be stored in phy_list, a static list
kept internally by the core.

After 7d21114dc6a2 ("usb: phy: Introduce one extcon device into usb phy")
when executing either of the registration functions above it is possible
that usb_add_extcon() fails, leading to either function returning before
the call to list_add_tail(), leaving x->head uninitialized.

Then, when a driver tries to undo the failed registration by calling
usb_remove_phy(struct usb_phy *x) there will be an unconditional call to
list_del(&x->head) acting on an uninitialized variable, and thus a
possible NULL pointer dereference.

Fix this by initializing x->head before usb_add_extcon() has a
chance to fail. Note that this was not needed before 7d21114dc6a2 since
list_add_phy() was executed unconditionally and it guaranteed that x->head
was initialized.

Fixes: 7d21114dc6a2 ("usb: phy: Introduce one extcon device into usb phy")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
Changes in v2:
- Adjust Fixes: sha1 to 12 digits
- Reword commit message to clarify the need to introduce
  INIT_LIST_HEAD()
- Link to v1: https://lore.kernel.org/r/20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt
---
 drivers/usb/phy/phy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index e1435bc59662..5a9b9353f343 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)
@@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)

---
base-commit: b612b9a01026a268af6a191180e846ad121d1eab
change-id: 20251113-diogo-smaug_typec-56b2059b892b

Best regards,
-- 
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>


