Return-Path: <stable+bounces-55033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5C915160
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425B0288EFB
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966619ADB3;
	Mon, 24 Jun 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yF8e4AHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08D1E869
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241571; cv=none; b=E95VP4kesp/iUIq7hPUmsyyfPYEl79CP+GBc1ZSramgabdHLRBcykD9X2Oug3MRedkfjZmchb71TxC4ivv7Qp/Oo8rHSBN7taF318JOHnsNQZPTI/4IfbqYnsYCnAMYO44Tnaex5JsugtQvtKjtpzxl0np/acXfNgbUBDOyp9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241571; c=relaxed/simple;
	bh=Cs8nO89DSEc/kOEYAaG5PgbrHfuzyB598i+zl4tvZTU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kPSkPV4PQhVzTbuHwaglDlj2pVHa/8hEAzX27ypR9DHRNbYAPuNhgmETZIWmv6VUkwDd/ptfcngNZZvkLyK+XtAHGRcFaUAFdWFTTvb+wutDMqtCLd1JM5itVZneg38alZEAgxhU2CGFudFxCOXRKmNEo1Bz4XvFoDvHzasv0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yF8e4AHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D0FC32782;
	Mon, 24 Jun 2024 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241570;
	bh=Cs8nO89DSEc/kOEYAaG5PgbrHfuzyB598i+zl4tvZTU=;
	h=Subject:To:Cc:From:Date:From;
	b=yF8e4AHPkDeqf7u5H69jGWwBhUM59S3EQh2H54dY6ZSnKMrggJFPtV6UMpEZp0olq
	 EXKffm+jU+YwyZfYqW0lj7NTr/Ey7NDzPw+RZkdti6I8Yy1XEsJ7WaRjNx4uH5ezyr
	 mz51euXgwaf56FNg2f+BEnMYVF43oOqe5Gfw0ISc=
Subject: FAILED: patch "[PATCH] net: stmmac: Assign configured channel value to EXTTS event" failed to apply to 5.15-stable tree
To: o.rempel@pengutronix.de,pabeni@redhat.com,wojciech.drewek@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:06:02 +0200
Message-ID: <2024062402-reabsorb-plausible-88b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8851346912a1fa33e7a5966fe51f07313b274627
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062402-reabsorb-plausible-88b5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8851346912a1 ("net: stmmac: Assign configured channel value to EXTTS event")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8851346912a1fa33e7a5966fe51f07313b274627 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Tue, 18 Jun 2024 09:38:21 +0200
Subject: [PATCH] net: stmmac: Assign configured channel value to EXTTS event

Assign the configured channel value to the EXTTS event in the timestamp
interrupt handler. Without assigning the correct channel, applications
like ts2phc will refuse to accept the event, resulting in errors such
as:
...
ts2phc[656.834]: config item end1.ts2phc.pin_index is 0
ts2phc[656.834]: config item end1.ts2phc.channel is 3
ts2phc[656.834]: config item end1.ts2phc.extts_polarity is 2
ts2phc[656.834]: config item end1.ts2phc.extts_correction is 0
...
ts2phc[656.862]: extts on unexpected channel
ts2phc[658.141]: extts on unexpected channel
ts2phc[659.140]: extts on unexpected channel

Fixes: f4da56529da60 ("net: stmmac: Add support for external trigger timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://lore.kernel.org/r/20240618073821.619751-1-o.rempel@pengutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index f05bd757dfe5..5ef52ef2698f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -218,6 +218,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 {
 	u32 num_snapshot, ts_status, tsync_int;
 	struct ptp_clock_event event;
+	u32 acr_value, channel;
 	unsigned long flags;
 	u64 ptp_time;
 	int i;
@@ -243,12 +244,15 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
 		       GMAC_TIMESTAMP_ATSNS_SHIFT;
 
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
+
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
 		get_ptptime(priv->ptpaddr, &ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		event.type = PTP_CLOCK_EXTTS;
-		event.index = 0;
+		event.index = channel;
 		event.timestamp = ptp_time;
 		ptp_clock_event(priv->ptp_clock, &event);
 	}


