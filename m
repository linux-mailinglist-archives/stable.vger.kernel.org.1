Return-Path: <stable+bounces-188040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63678BF0DAA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C56E4EB4AF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5F1D63D8;
	Mon, 20 Oct 2025 11:35:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6523D7D2
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960102; cv=none; b=AGCQygyOLvHJhWJ821x4YGHfM7akOc/LKvKlzuDPPuih5xmjujbBWZ0CV2uXlD6f86h6pxT92b2ZnoSZULPVNF7w0MjyUtzT/eI7eEhf0gyWEVTuBkdLK1GQ3jOdrCT+cIb6U/ZRWgKeL5geY2qQLQP7KewjcncpXzh4iCWCCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960102; c=relaxed/simple;
	bh=kDNU1VZRvLNKxiiKzrPuVBiAaDGRSLGk5fWfXxh6JGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I/e9rshe6jV0A3CsXZQPL8Un9tr8dffTwe25706kkj2MynyBLhmUteDqt6Uiev4evYO/+asppl/8O8XPkwq1wBJ7qB/S9OCSMQFJWGvi/EOYH3SjrgaEtOxcB/brzvfxiqpJZIxgPMAzn6P/YS69clRLaA0V8SIL0FmVHzY9Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vAoA7-0002j5-Cu; Mon, 20 Oct 2025 13:34:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vAoA7-004XYw-01;
	Mon, 20 Oct 2025 13:34:51 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B055D48B1A3;
	Mon, 20 Oct 2025 11:34:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Oct 2025 13:34:42 +0200
Subject: [PATCH can] can: netlink: can_changelink(): allow disabling of
 automatic restart
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-netlink-fix-restart-v1-1-3f53c7f8520b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAFEe9mgC/x2MSQqAMAwAvyI5G2jrgvoV8VA0alCipEUE8e8Wj
 8Mw80AgZQrQZQ8oXRz4kAQ2z2BcvSyEPCUGZ1xljTMoFHeWDWe+USlErxFrY+u5nNqCigZSeSo
 l/V97GL3A8L4f6U2h9GoAAAA=
X-Change-ID: 20251020-netlink-fix-restart-6016f4d93e38
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-2196b
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=kDNU1VZRvLNKxiiKzrPuVBiAaDGRSLGk5fWfXxh6JGc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo9h5X2JCZcavGBOSF3ZCtEzlQmXp4FZ8rv1spy
 JxOqBUEyjSJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaPYeVwAKCRAMdGXf+ZCR
 nKr/CACy7MaS9SyKjY3LpHAmw2cp2qqwGHjVYgqGKh3GN6iNMtMAH5cq1nbOAChjFszbUWQwZGY
 105ATKqqDtpDNgH4jgvbobkuHOTNQOOi4tc8Netwu88b+bJPcDSjbp5MypKYHrbyae3cYpr7ro8
 GmH0pG0nW10iIaNA1Tm2AE+huoClGFdvVQ1ukVzDrhqzv7g83pG3Rj0uFWFssASqy5hg+TLONn6
 q2oS6EqMzJ4KgRhLJLaG8U5ELJ881fCNhu3QSUIXTCraUCt0OVPFaSJCObDWHmVQNGs4shP4j8P
 ZGyW4o9HbEP/37lYMJEfnhHstiddj9zf47Z0d4UZu33fNzzM
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Since the commit c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL
pointer deref of struct can_priv::do_set_mode"), the automatic restart
delay can only be set for devices that implement the restart handler struct
can_priv::do_set_mode. As it makes no sense to configure a automatic
restart for devices that doesn't support it.

However, since systemd commit 13ce5d4632e3 ("network/can: properly handle
CAN.RestartSec=0") [1], systemd-networkd correctly handles a restart delay
of "0" (i.e. the restart is disabled). Which means that a disabled restart
is always configured in the kernel.

On systems with both changes active this causes that CAN interfaces that
don't implement a restart handler cannot be brought up by systemd-networkd.

Solve this problem by allowing a delay of "0" to be configured, even if the
device does not implement a restart handler.

[1] https://github.com/systemd/systemd/commit/13ce5d4632e395521e6205c954493c7fc1c4c6e0

Cc: stable@vger.kernel.org
Cc: Andrei Lalaev <andrey.lalaev@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20251020-certain-arrogant-vole-of-sunshine-141841-mkl@pengutronix.de
Fixes: c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 0591406b6f32..6f83b87d54fc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -452,7 +452,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -461,7 +463,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {

---
base-commit: ffff5c8fc2af2218a3332b3d5b97654599d50cde
change-id: 20251020-netlink-fix-restart-6016f4d93e38

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


