Return-Path: <stable+bounces-220538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IC8AQw+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E261C6AED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9919F31D5025
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F443D0E6B;
	Sat, 28 Feb 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkbZadYo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2603D0E62;
	Sat, 28 Feb 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300421; cv=none; b=TBEMBvnlkXk+BJ3DVChziTraPjXk2/qTKnfYuub6r1zfQOtgSciimQoaGMFXMAAacUOai4Px2MvczQ8K40OL22awRi1izG7c/Z3hhM1JnZvRy3PX59gyiasBpW75ottSN34VPCills6ADkTxEANuBieSvrAD64KpkslbX7La+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300421; c=relaxed/simple;
	bh=pUCiQnWyxC0p8wloLakDOX3hNyutKCYZb/R46N5Q2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok08tJhVFqV3T/kl/1we5NJOBnEbGVNuvRDvjZBc00VRq9zjfIETpW2ZqkqUedgNdlm2JoNyNngDoOQT30ok8lbQYB00ZWZNrRObizIbT7l1dak2hhfdIJu6yPrGKjnXprXynRFXYdy5ObdXCR++P5BU4sLiwZ4kjDcUX9jgKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkbZadYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB2C19424;
	Sat, 28 Feb 2026 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300421;
	bh=pUCiQnWyxC0p8wloLakDOX3hNyutKCYZb/R46N5Q2zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkbZadYoLx8GqFKaVmefhtgXeb1NP4roJw0WF1kz92XCm5b5Go3WblALsXkqTtqyg
	 3rxJduYmy6OvoNWwIl/EVqM6Ybp9ONglspr6ja01xhwBDcPsYPhpF3pNzp8EdIw9vO
	 fitUS+HY2kXjsP6EHXSFCYJiwTzQkJr5lbADattVIRDmMWU8oqMTt1f8gMclXneLQd
	 bFBzqey1GuAm9f2fz7r+nqBp/zRezOTfTK8mboL2jKbuUe8MabWzLqiIvCw4d01F7B
	 mbIVwe+hkMjsePNWhP8FuO/nXRD95m0MCyXHgxp1K4LX3VTtfLeGJPlUHqhx86DQjS
	 wrHD3bKqZgb9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 459/844] net: ethernet: xscale: Check for PTP support properly
Date: Sat, 28 Feb 2026 12:26:12 -0500
Message-ID: <20260228173244.1509663-460-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54E261C6AED
X-Rspamd-Action: no action

From: Linus Walleij <linusw@kernel.org>

[ Upstream commit 594163ea88a03bdb412063af50fc7177ef3cbeae ]

In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
unconditionally despite this feature only existing on
ixp46x, leading to the following splat from tcpdump:

root@OpenWrt:~# tcpdump -vv -X -i eth0
(...)
Unable to handle kernel NULL pointer dereference at virtual address
  00000238 when read
(...)
Call trace:
 ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
 ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
 ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
 __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
 __dev_ethtool from dev_ethtool+0x160/0x234
 dev_ethtool from dev_ioctl+0x2cc/0x460
 dev_ioctl from sock_ioctl+0x1ec/0x524
 sock_ioctl from sys_ioctl+0x51c/0xa94
 sys_ioctl from ret_fast_syscall+0x0/0x44
 (...)
Segmentation fault

Check for ixp46x in ixp46x_ptp_find() before trying to set up
PTP to avoid this.

To avoid altering the returned error code from ixp4xx_hwtstamp_set()
which before this patch was -EOPNOTSUPP, we return -EOPNOTSUPP
from ixp4xx_hwtstamp_set() if ixp46x_ptp_find() fails no matter
the error code. The helper function ixp46x_ptp_find() helper
returns -ENODEV.

Fixes: 9055a2f59162 ("ixp4xx_eth: make ptp support a platform driver")
Signed-off-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260219-ixp4xx-fix-ethernet-v3-1-f235ccc3cd46@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 5 +----
 drivers/net/ethernet/xscale/ptp_ixp46x.c | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e1e7f65553e76..b0faa0f1780d0 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -403,15 +403,12 @@ static int ixp4xx_hwtstamp_set(struct net_device *netdev,
 	int ret;
 	int ch;
 
-	if (!cpu_is_ixp46x())
-		return -EOPNOTSUPP;
-
 	if (!netif_running(netdev))
 		return -EINVAL;
 
 	ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
 	if (ret)
-		return ret;
+		return -EOPNOTSUPP;
 
 	ch = PORT2CHANNEL(port);
 	regs = port->timesync_regs;
diff --git a/drivers/net/ethernet/xscale/ptp_ixp46x.c b/drivers/net/ethernet/xscale/ptp_ixp46x.c
index 94203eb46e6b0..93c64db22a696 100644
--- a/drivers/net/ethernet/xscale/ptp_ixp46x.c
+++ b/drivers/net/ethernet/xscale/ptp_ixp46x.c
@@ -232,6 +232,9 @@ static struct ixp_clock ixp_clock;
 
 int ixp46x_ptp_find(struct ixp46x_ts_regs *__iomem *regs, int *phc_index)
 {
+	if (!cpu_is_ixp46x())
+		return -ENODEV;
+
 	*regs = ixp_clock.regs;
 	*phc_index = ptp_clock_index(ixp_clock.ptp_clock);
 
-- 
2.51.0


