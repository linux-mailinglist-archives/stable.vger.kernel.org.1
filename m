Return-Path: <stable+bounces-104782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E375C9F52B2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6997A3CC1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726991F868F;
	Tue, 17 Dec 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQd9hpAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30E140E38;
	Tue, 17 Dec 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456083; cv=none; b=iqa3Qp6JhcQhCCmoc5ymelgN1tD5RztiFrJtwWHa/0Ym0HyizLIo6j4skpjzO9xUJBWppycn1+3quiRW4GOqV2C1gWORITdSl0XQ7LBuH/fygCTVNlVeexzp5zOgHEbjb/8jmcvZ8lAK9X3Ic0+IaECoAq0QG2h+QeKROrkknsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456083; c=relaxed/simple;
	bh=g9sZ+F42HvMa1stZTQ34TmYgF6d1KfBrv+t2RLQzF64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2r9taqNEaq6qcr/lj0LBJWzJlTysOJShYx+Pqd8nCGpGBng3pse1CWAi+cr/vYodONAu2WY+CtSr39GbSQUDMksxWMEfyt7n5dpDhctP18LOx6KQqQMCTXIKNXGLTtKvu+C+fwvRIhzLE25XooUTktAVnTPvg9FqsrJGi8fjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQd9hpAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC4DC4CEDD;
	Tue, 17 Dec 2024 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456083;
	bh=g9sZ+F42HvMa1stZTQ34TmYgF6d1KfBrv+t2RLQzF64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQd9hpAcv6Gl12sCgccEg1mgNj4u3/kPJJkDiAOO1fVMngrAz1yKeu/0eMPT4sQ82
	 gTy523MkxZlR32wybRTU75kjqbyd2CF4WTMEUQXYC6pQHkXIFe/wn1OqBhpV6FHo+L
	 lVxPQeZpbkVJpa+hz+HG9Ym7RHtAW/Y1El9Lsa5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/109] net: mscc: ocelot: improve handling of TX timestamp for unknown skb
Date: Tue, 17 Dec 2024 18:07:38 +0100
Message-ID: <20241217170535.626001136@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit b6fba4b3f0becb794e274430f3a0839d8ba31262 ]

This condition, theoretically impossible to trigger, is not really
handled well. By "continuing", we are skipping the write to SYS_PTP_NXT
which advances the timestamp FIFO to the next entry. So we are reading
the same FIFO entry all over again, printing stack traces and eventually
killing the kernel.

No real problem has been observed here. This is part of a larger rework
of the timestamp IRQ procedure, with this logical change split out into
a patch of its own. We will need to "goto next_ts" for other conditions
as well.

Fixes: 9fde506e0c53 ("net: mscc: ocelot: warn when a PTP IRQ is raised for an unknown skb")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20241205145519.1236778-3-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 3c22652879ac..1386fb2ff4a9 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -790,7 +790,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
 
 		if (WARN_ON(!skb_match))
-			continue;
+			goto next_ts;
 
 		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
 			dev_err_ratelimited(ocelot->dev,
@@ -808,7 +808,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
 		skb_complete_tx_timestamp(skb_match, &shhwtstamps);
 
-		/* Next ts */
+next_ts:
 		ocelot_write(ocelot, SYS_PTP_NXT_PTP_NXT, SYS_PTP_NXT);
 	}
 }
-- 
2.39.5




