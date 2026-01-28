Return-Path: <stable+bounces-212608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMj6EXw6emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F23A5D19
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C0083041E1F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E5302779;
	Wed, 28 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBgFwKPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9181AA8;
	Wed, 28 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616090; cv=none; b=Fxe1myPwhvek1NJ3V4YeLL05CDtSB1ToMPVk2G+b9NeXe5Sk7FcM4e7Tj+yJYPi+P6bxzKWDAkIlJqjZsr9O0kxefl8m04T1lmKKcPAuKi5Il1+BO2rrNzuXwgfJVUUKOfEDDw2hkVMBrLAbHDbBuU7TAFKE36oR4JOS3YTUIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616090; c=relaxed/simple;
	bh=lJL2RRIR8dlqPqYCFWrLwC+4Ot5vjMuN/L8UO5+au+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuztdMuXFG+lw92kFA3EQ19KyDfc3KzbaBx8tn4hTJeSFHJ7HxmTNODRkFlwZrDY2NPMZLpcaz0yXms8vngMqOiXSial9iwDGfPfpaHTG4gSdnDuOMgzJiLaHh+bHJglWRfzQ5eysuqa0sv8OJCFCi524/jEW6JkGa5z0eKLkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBgFwKPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B94C4CEF1;
	Wed, 28 Jan 2026 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616090;
	bh=lJL2RRIR8dlqPqYCFWrLwC+4Ot5vjMuN/L8UO5+au+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBgFwKPDiWOR9sV4Xhp7jz9MWhlIyze6Ai/KXYnuzWAbjfoMw5NbubN/XwWvn/gn+
	 U6wcUaVj0YlOeKGiMELg1U7tcKOqz8jcVb7RZH4zjqOr/t4x//I3pYWAdplGFWyQfJ
	 hTDzX+8+k+2opArW6vEdWdZxa0vN7QhOk2gXgzzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.18 171/227] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode
Date: Wed, 28 Jan 2026 16:23:36 +0100
Message-ID: <20260128145350.603844874@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212608-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,collabora.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rock-chips.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 69F23A5D19
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 3009738a855cf938bbfc9078bec725031ae623a4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -608,6 +608,13 @@ static void dwcmshc_rk3568_set_clock(str
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



