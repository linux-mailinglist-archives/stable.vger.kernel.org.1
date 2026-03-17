Return-Path: <stable+bounces-226817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO7wIquVuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C82B05D4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A890B31AB25F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633132DECC6;
	Tue, 17 Mar 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e3B52pXG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A27320CCF;
	Tue, 17 Mar 2026 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768316; cv=none; b=BVBZ+FDbQzUVAJRONIhNxxwDa3pBRMIQ+uhB7JWJC2rpsRsdXnlgko2gjWqKF9RW2nulqY9iRifqtbqnXDOQtBQqxtlYF/ncFv+YGcAB2Vvk91MFYlKCdzkI/x30/PM96GyfYR5bB8vKU7hZX8twUKT2FLP82gelN+x0VXvPHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768316; c=relaxed/simple;
	bh=QGNPpkhAFRM2z3ct6CjHdNl1X+FvIt98WaLjAd2KiXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtIJpyXozYLPU9XBnHu3svpcC3yHrnG66U3c9LTNsgOM8hp/ysK3Dt1RrqPIGtBjx5IkrK7qo7sIH6oPT18kAIqXbLs+NaW80eguYPbJV8GHUcnvxU3byc7WM0fFUKZ3jhnm6rL4mHRSi6h607KORb463n++E2+27RJjLZOsqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e3B52pXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F0BC4CEF7;
	Tue, 17 Mar 2026 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768316;
	bh=QGNPpkhAFRM2z3ct6CjHdNl1X+FvIt98WaLjAd2KiXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3B52pXGBqY2s2ZlFKfv5CqDaNTC6p0xHwLd9cgaIe92e5e1qsyOJvddkBOIVfGCf
	 T333P4+BbIJsfSYILcbZ9HXfKUg8G34HwJDHgmWJtufuCN4DtziZn+zkLXmbpHBDEk
	 SGbS9LoE7++GR+GaaOXMLRpeOJd65oFZ7LgqrVYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 249/333] net: dsa: microchip: Fix error path in PTP IRQ setup
Date: Tue, 17 Mar 2026 17:34:38 +0100
Message-ID: <20260317163008.599783103@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bootlin.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-226817-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bootlin.com:email]
X-Rspamd-Queue-Id: 103C82B05D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

commit 99c8c16a4aad0b37293cae213e15957c573cf79b upstream.

If request_threaded_irq() fails during the PTP message IRQ setup, the
newly created IRQ mapping is never disposed. Indeed, the
ksz_ptp_irq_setup()'s error path only frees the mappings that were
successfully set up.

Dispose the newly created mapping if the associated
request_threaded_irq() fails at setup.

Cc: stable@vger.kernel.org
Fixes: d0b8fec8ae505 ("net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/microchip/ksz_ptp.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1095,6 +1095,7 @@ static int ksz_ptp_msg_irq_setup(struct
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
 	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
+	int ret;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
 	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
@@ -1106,9 +1107,13 @@ static int ksz_ptp_msg_irq_setup(struct
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	return request_threaded_irq(ptpmsg_irq->num, NULL,
-				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
-				    ptpmsg_irq->name, ptpmsg_irq);
+	ret = request_threaded_irq(ptpmsg_irq->num, NULL,
+				   ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
+				   ptpmsg_irq->name, ptpmsg_irq);
+	if (ret)
+		irq_dispose_mapping(ptpmsg_irq->num);
+
+	return ret;
 }
 
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)



