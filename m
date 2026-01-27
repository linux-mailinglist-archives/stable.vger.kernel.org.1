Return-Path: <stable+bounces-211778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIG6Cqe5eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:12:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA294B76
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2FE301B931
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823DB3559D1;
	Tue, 27 Jan 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2jM7rEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E0355024
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519513; cv=none; b=Cq0o2EJHOuccOPPQn82+l/fgoG3pEhqoIAIszT+TKjQ6tOcvAkL6urNCbiJKSUL0D3Eqx1X3ZwvPE9NHHN+JVjO7r/v/dXnRQzmsePo+YcUd2G9nm7IQnjUnGy93XApzSAh4Uw+8lgr/9lOffmEFjlj0xT6J+bZVcwLPM/qHylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519513; c=relaxed/simple;
	bh=ZCjCoTLMMBJiq/mWz0JS/zqnA3jy2uYaaBawzKKp4Fo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u3ATR9QXfvlVV3enDPkCn2uIKMvVgOU4V0x0QBVDY/lARq6r/NWdmtnqWrsDlA7YuHZz8Yfj2w2/3dkUKsSxbBEibX6AYt528adtuX2g4uTz/lS8wAQfrZqtKvANoxcQIPo3Es5eUTmvnvvUBs03Sy6u0F2uZEpxlotHuwiYJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2jM7rEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC33C116C6;
	Tue, 27 Jan 2026 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519513;
	bh=ZCjCoTLMMBJiq/mWz0JS/zqnA3jy2uYaaBawzKKp4Fo=;
	h=Subject:To:Cc:From:Date:From;
	b=x2jM7rEElw8dpGh7TqtmK43Txah3qtyeUQWQkTunWkr18zfWDBVPP7wceInjCqpGw
	 MkeWpSEol4Jv2q+pGfQvFzKD4OiH1CIc1H1bAX2u3PYilVmP8NHPxv17T6r5k0+5Ul
	 vcIeKsO5A6qGqRkjpAOr49t3VhcKxVJQxhcRgIiM=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in" failed to apply to 6.1-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulf.hansson@linaro.org,yifeng.zhao@rock-chips.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:11:50 +0100
Message-ID: <2026012749-barrier-oppressor-3ac6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211778-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,debian:email,collabora.com:email,rock-chips.com:email]
X-Rspamd-Queue-Id: 89EA294B76
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3009738a855cf938bbfc9078bec725031ae623a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012749-barrier-oppressor-3ac6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3009738a855cf938bbfc9078bec725031ae623a4 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 22 Dec 2025 15:11:25 +0800
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in
 HS200/HS400 mode

When operating in HS200 or HS400 timing modes, reducing the clock frequency
below 52MHz will lead to link broken as the Rockchip DWC MSHC controller
requires maintaining a minimum clock of 52MHz in these modes.

Add a check to prevent illegal clock reduction through debugfs:

root@debian:/# echo 50000000 > /sys/kernel/debug/mmc0/clock
root@debian:/# [   30.090146] mmc0: running CQE recovery
mmc0: cqhci: Failed to halt
mmc0: cqhci: spurious TCN for tag 0
WARNING: drivers/mmc/host/cqhci-core.c:797 at cqhci_irq+0x254/0x818, CPU#1: kworker/1:0H/24
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0H Not tainted 6.19.0-rc1-00001-g09db0998649d-dirty #204 PREEMPT
Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
Workqueue: kblockd blk_mq_run_work_fn
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cqhci_irq+0x254/0x818
lr : cqhci_irq+0x254/0x818
...

Fixes: c6f361cba51c ("mmc: sdhci-of-dwcmshc: add support for rk3588")
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 51949cde0958..204830b40587 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -739,6 +739,13 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	sdhci_writel(host, extra, reg);
 
 	if (clock <= 52000000) {
+		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
+		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+			dev_err(mmc_dev(host->mmc),
+				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
+			return;
+		}
+
 		/*
 		 * Disable DLL and reset both of sample and drive clock.
 		 * The bypass bit and start bit need to be set if DLL is not locked.


