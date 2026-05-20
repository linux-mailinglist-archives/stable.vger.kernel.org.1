Return-Path: <stable+bounces-252095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +yIODwciDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:05:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5E59A6EA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A009037C2D3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8286D368941;
	Wed, 20 May 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuebp+I7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6B29B8D0;
	Wed, 20 May 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299733; cv=none; b=fGf3ugTOFHsHHCI5RzjknLLVjW+t2DtC8i9wBTmHpY88Aaokh+GHX49+fT+BPjTKRaHp2Dw6E5mUkx4ft8wAxsdXc6MeCtO8Ie2paJhzLRNNqGPj8cdMU0k3iRR1QM5cLmDOxnGm0JQDmj3edaRc9Hl3fNpCtB9NvmHGPVfMXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299733; c=relaxed/simple;
	bh=K4YOa8/L2idYSGT1sgNVCj/4+2iA4y4+FPL7L5kIxm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE1PFmSR15EjJEv4uBW4dAQSN0NN1lOUOF46eTjxg+XJIY4FW69aMtFYq2nWiaLi5TyvDjvzuw/CzV/Mddm72wAC4jnb8kcvAYhzfAEeL+jAnOUKdT28mMHERJ0EYNXElzk7AOdRaHZ/6qWCjIXAi725pVIy2pnlv2naP6jIGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuebp+I7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4691F000E9;
	Wed, 20 May 2026 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299732;
	bh=fxGF9kwf93kF6M2HesQWoiCI5httgOixvgjMT0p5I8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uuebp+I77ZQ47jtZoN/eyXtAwUz0GAbJbIS/fr4muhepzqV6DcXMdV5cN6EBBLG+6
	 o9WPuCYtN10cTIQ70yq2gNrraZbPMrnxyPxl4oGH8Zbh6F3JYSWaei+Mo4XvPRhMkI
	 Ii01jZpLZBcXyV5qGoMYfJg1OFFLFYK7BjrhNjdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 882/957] net: ena: PHC: Fix potential use-after-free in get_timestamp
Date: Wed, 20 May 2026 18:22:45 +0200
Message-ID: <20260520162153.694525459@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252095-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 90C5E59A6EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Kiyanovski <akiyano@amazon.com>

commit e42c755582f0960e684298762f0ab927b3778376 upstream.

Move the phc->active check and resp pointer assignment to after
acquiring the spinlock. Previously, phc->active was checked without
holding the lock, and resp was cached from ena_dev->phc.virt_addr
before the lock was acquired.

If ena_com_phc_destroy() runs between the lockless active check and
the lock acquisition, it sets active=false, releases the lock, frees
the DMA memory, and sets virt_addr=NULL. The get_timestamp path would
then read a NULL virt_addr and dereference it.

With both the active check and the pointer read under the lock,
destroy cannot free the memory while get_timestamp is using it.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://patch.msgid.link/20260508062126.7273-1-akiyano@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e67b592e5697..8c86789d867a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1782,20 +1782,23 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 
 int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 {
-	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ktime_t zero_system_time = ktime_set(0, 0);
 	struct ena_com_phc_info *phc = &ena_dev->phc;
+	volatile struct ena_admin_phc_resp *resp;
 	ktime_t expire_time;
 	ktime_t block_time;
 	unsigned long flags = 0;
 	int ret = 0;
 
+	spin_lock_irqsave(&phc->lock, flags);
+
 	if (!phc->active) {
+		spin_unlock_irqrestore(&phc->lock, flags);
 		netdev_err(ena_dev->net_device, "PHC feature is not active in the device\n");
 		return -EOPNOTSUPP;
 	}
 
-	spin_lock_irqsave(&phc->lock, flags);
+	resp = ena_dev->phc.virt_addr;
 
 	/* Check if PHC is in blocked state */
 	if (unlikely(ktime_compare(phc->system_time, zero_system_time))) {
-- 
2.54.0




