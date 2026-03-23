Return-Path: <stable+bounces-229575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJpAJph7wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:42:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F012FA44D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6168531BC4F0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D683BBA08;
	Mon, 23 Mar 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePLIYG9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6393BBA06;
	Mon, 23 Mar 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282291; cv=none; b=f+vV7qyWTGP1Mmne3Tg5TikEHDljLDEoNUsmAMhlye3Bmfb2UVIw3f0YEksi95F5dE1xd729YlhcAHT4OvoVsCBixyLqWEZunOF4iwZcSUR8qDwp2kg+1GMJrwWKlQOcKo3166z4VmSoJik5lnQf709TIkaz7NyAKTVludPbdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282291; c=relaxed/simple;
	bh=/7PcYa8vUXYpxU8zV4JOyd8vCf3xXpMKL0aST5Cmvas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFgcXIxnuSjH/ErNAizD8sxMIYC9lGl5QVa57MAo4bsFQrXFpYYJ1OID8Hi7ay6vOQji2osN4EsdCbJmZC/0tPGbA7fIUy7SR57zhdDCTeyy7j0t2ClFORED1QA9sbcsm9bJQOqvZVoL5FZdFanTf68C8HrcADYF4S+oSX+Y8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePLIYG9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF36BC2BCB0;
	Mon, 23 Mar 2026 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282291;
	bh=/7PcYa8vUXYpxU8zV4JOyd8vCf3xXpMKL0aST5Cmvas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePLIYG9vWiz9r0277TMMi9UuWyZoFkVYx6WXMe6pWnfwYaT8JtiZmgOsCPT88U4jv
	 kwOgRYbSb7UZthJA+FmN8YBS2Y3j44pfLj7ZibhwzccMCvZKaB2l1GEqFWmJo7RAli
	 uKKPV+JxHAaQiX4agI7Qts5qZ+g0vs/HKJgBL80Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/481] dpaa2-switch: do not clear any interrupts automatically
Date: Mon, 23 Mar 2026 14:41:25 +0100
Message-ID: <20260323134527.798838408@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229575-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E6F012FA44D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit f6da276479c63ca29774bc331a537b92f0550c45 ]

The DPSW object has multiple event sources multiplexed over the same
IRQ. The driver has the capability to configure only some of these
events to trigger the IRQ.

The dpsw_get_irq_status() can clear events automatically based on the
value stored in the 'status' variable passed to it. We don't want that
to happen because we could get into a situation when we are clearing
more events than we actually handled.

Just resort to manually clearing the events that we handled. Also, since
status is not used on the out path we remove its initialization to zero.

This change does not have a user-visible effect because the dpaa2-switch
driver enables and handles all the DPSW events which exist at the
moment.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 74badb9c20b1 ("dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 68378d694c5d3..b29f49ec64049 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1522,9 +1522,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	struct device *dev = (struct device *)arg;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct ethsw_port_priv *port_priv;
-	u32 status = ~0;
 	int err, if_id;
 	bool had_mac;
+	u32 status;
 
 	err = dpsw_get_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DPSW_IRQ_INDEX_IF, &status);
@@ -1559,12 +1559,12 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 		rtnl_unlock();
 	}
 
-out:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
 		dev_err(dev, "Can't clear irq status (err %d)\n", err);
 
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.51.0




