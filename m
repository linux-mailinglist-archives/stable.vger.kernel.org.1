Return-Path: <stable+bounces-198102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A882C9BF7C
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597CE3A35FA
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E547224AFB;
	Tue,  2 Dec 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2g9FFcPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E411E51EB
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689658; cv=none; b=DDBkdefRXk13+BOeyap+5uasamo7ADwczm5N0aDsY/1L01D9rtz8vUa3nYxOWWHt/vU4N0W/Fj0hbWdu3ZEUU+7mdicDRPVYrRdx0o9sESv896vyVNyplTmWw4QtdhryCJYNMRQlHTKy0uziqRTpP7XJ6ApYtkTpUE/vUGy5QJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689658; c=relaxed/simple;
	bh=HT9IiVOE8RrvyWgI1JkbxP0JDL2wkYPS1PCnh2RREQg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jlQPuzQPATd1thvpF5cxs9UkD9zieLjQi9kVM+Gwj98kOEu1KRnR0iZGI8xO7U24UDJr2TLzdMty7Su5nyToMXVtX18lzAmx1qsPFqpKKnjRHtfteAoI3fQBqt3e+ofpFRiT9naBJAsaSDndQWLpJeV9zsS6pR9WaVK0YQrFfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2g9FFcPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F5C4CEF1;
	Tue,  2 Dec 2025 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764689658;
	bh=HT9IiVOE8RrvyWgI1JkbxP0JDL2wkYPS1PCnh2RREQg=;
	h=Subject:To:Cc:From:Date:From;
	b=2g9FFcPAdYKdw5mlBc5cMou8jtc5Goem5rARHFpt38FNR+rG7IIW2vDsitwAZZ7eq
	 vt1+fZztsKK0m0627sBIE+Y1aX2Es/o7QugfLn9fYWv6y08O3pgdtixPrsokU1SWBc
	 oIpdsw5ta+jnmEGf9+ucB/iUnsZ/yByqFfbnIwiU=
Subject: FAILED: patch "[PATCH] net: dsa: microchip: Fix symetry in" failed to apply to 6.12-stable tree
To: bastien.curutchet@bootlin.com,andrew@lunn.ch,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 16:34:14 +0100
Message-ID: <2025120214-musky-conjure-b8b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d0b8fec8ae50525b57139393d0bb1f446e82ff7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120214-musky-conjure-b8b9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0b8fec8ae50525b57139393d0bb1f446e82ff7e Mon Sep 17 00:00:00 2001
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:04 +0100
Subject: [PATCH] net: dsa: microchip: Fix symetry in
 ksz_ptp_msg_irq_{setup/free}()

The IRQ numbers created through irq_create_mapping() are only assigned
to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
between their creation and their assignment (for instance during the
request_threaded_irq() step), we enter the error path and fail to
release the newly created virtual IRQs because they aren't yet assigned
to ptpmsg_irq[n].num.

Move the mapping creation to ksz_ptp_msg_irq_setup() to ensure symetry
with what's released by ksz_ptp_msg_irq_free().
In the error path, move the irq_dispose_mapping to the out_ptp_msg label
so it will be called only on created IRQs.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20251120-ksz-fix-v6-5-891f80ae7f8f@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c8bfbe5e2157..997e4a76d0a6 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1093,19 +1093,19 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
+	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
+	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	if (!ptpmsg_irq->num)
+		return -EINVAL;
 
 	ptpmsg_irq->port = port;
 	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[n]);
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1135,9 +1135,6 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
-
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
 	if (!ptpirq->irq_num) {
 		ret = -EINVAL;
@@ -1159,12 +1156,11 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 out_ptp_msg:
 	free_irq(ptpirq->irq_num, ptpirq);
-	while (irq--)
+	while (irq--) {
 		free_irq(port->ptpmsg_irq[irq].num, &port->ptpmsg_irq[irq]);
-out:
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
 		irq_dispose_mapping(port->ptpmsg_irq[irq].num);
-
+	}
+out:
 	irq_domain_remove(ptpirq->domain);
 
 	return ret;


