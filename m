Return-Path: <stable+bounces-198140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C696C9CC36
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487CA3A8FE9
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8E2D9782;
	Tue,  2 Dec 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXqoDpPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3132C327C
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703606; cv=none; b=aTqHxXsWvU8NxDUFQJH3ALl/jbuZfS1nSBHi4NvDzncEb0GXYm2MhruK4EbjMlrVE0LDk39iyAdnIXsBl6WtyLFPKymK664IfE2GLHp5hqXsLzyk8AZcsLbIpIUEi7zWJEoWoecvbrcS4YrxbQiYjbn1v8HAb+tTvXCvwTqaz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703606; c=relaxed/simple;
	bh=yv4UvKXUWWkp+HaiuyKG56HWJ1eeOVh4x7cZ2u1YS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRnE4jOltDLPGRZYpG2XEeD3RoH4KAN+YMEYCu2IyqUp3W5DJ5S69wiGsHlnRWambcBkfq+Pt3gLuWu1jDhq/E1T/C8oIBddJ8VzdgbbqZkza0KmuM9np4rtEmjd2ee0u4oy7OAqq53aiKaabfrj683ZDT9UVV8vbvPSi3Mr9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXqoDpPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E00C4CEF1;
	Tue,  2 Dec 2025 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703606;
	bh=yv4UvKXUWWkp+HaiuyKG56HWJ1eeOVh4x7cZ2u1YS8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXqoDpPTcsN1ICXfd/LWed8iY2pMqfdqtm06wEIAfKr65b3qII+tTBL9mhSb7iQZd
	 GGkeWOJIX9khjSbeKhFhXtfetvLBLWgKGXL9RcbP+OXUvWxvDCseed268K3SQjfiUu
	 sCVkmimMsq+SnKnxQrtwnz2jKRoe83YFhz4JDfVkrmQICsjnNdj60Kw1eXnUM26nuP
	 4Xcpwh9ZYU+4sfeLxpauh6zCFAJ2h9IeiRVks7Uo3jc6nAI4iF5FvzLlCQf3F3wXhb
	 7Hru7e/nAanHBJDd4No6Ag4W8EdAhzOG4mnrRjGxbJX9hy9Y1dC7d0WyqAYJUw0Ye5
	 NVad1WIJEgXNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()
Date: Tue,  2 Dec 2025 14:26:37 -0500
Message-ID: <20251202192637.2408676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120217-pelvis-rotunda-cb95@gregkh>
References: <2025120217-pelvis-rotunda-cb95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>

[ Upstream commit d0b8fec8ae50525b57139393d0bb1f446e82ff7e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 7ef5fac69657f..950c45d37cd73 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,19 +1099,19 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
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
 
 	snprintf(ptpmsg_irq->name, sizeof(ptpmsg_irq->name), name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1141,9 +1141,6 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
-
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
 	if (ptpirq->irq_num < 0) {
 		ret = ptpirq->irq_num;
@@ -1165,12 +1162,11 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
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
-- 
2.51.0


