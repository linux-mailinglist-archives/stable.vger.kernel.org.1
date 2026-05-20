Return-Path: <stable+bounces-251244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDqINHoWDmpb6AUAu9opvQ
	(envelope-from <stable+bounces-251244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:15:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7C5995CD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4EB339425D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4C372691;
	Wed, 20 May 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9DpeBek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAA331220;
	Wed, 20 May 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297478; cv=none; b=nhcHXeA51zs8wPTaqoyvPtSvist8NG/FXVvso86fQvywcAnKEJnXaKqCUedmm7zXeJbV193fENFFeIrkVtzVLoih9o277MGrpSj6OxEx6LTVQ6G834XphAzjESZGVdfNNHsId4OtJZg8sQU3+ShXu+836ZDbRn3ayZEtRB2JZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297478; c=relaxed/simple;
	bh=ww3FYpGNpxTdV6FfdpPAu3f1Iv4ZR/gDGFXUYoqQzJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbDLXOGHuoDaXAKKjxXF6u/CPPnD2KCYxKgLAFER4Y7Hv7T6nPYrYhkz8Vx71B9SiMAYIBzsMFVCWpFPJIkXpBSghzJymzqF4aqHpl7QIuf9oDstRbTViRrWmZHCOXDwFws9Pd/AKyL+/gfXB6/1i3MPQw6IVmgrV7xMI0NAdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9DpeBek; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A466E1F00893;
	Wed, 20 May 2026 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297476;
	bh=k0mRf2wHuDXlsb2ja+kWXpOzRL7tR7D3adJMXbtUMCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9DpeBekoGxHYeOFbOTGlXiIFYXbJnJ0hlG1ZuS4LQHAODxmEN67e8Y9jiwk1vsiN
	 ikmlJjxX/XmF4pSoVPh1DsK+WUZo4WkoMCzSgUId36crjozfQnuytSojSFZxB94SIZ
	 EIqLcPE+k1p+BgRMngHq+zwxqYJS4p3v8spGfwj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/957] irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
Date: Wed, 20 May 2026 18:08:50 +0200
Message-ID: <20260520162135.578618457@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251244-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 40A7C5995CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fb74e35f78105efd8635c89b39f4389f567edbdc ]

Replace pm_runtime_put() with pm_runtime_put_sync() when
irq_domain_create_hierarchy() fails to ensure the device suspends
synchronously before devres cleanup disables runtime PM via
pm_runtime_disable().

[ tglx: Fix up subject and change log to be precise ]

Fixes: 7de11369ef30 ("irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-4-biju.das.jz@bp.renesas.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1bf19deb02c4e..c938ab1592895 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -573,7 +573,7 @@ static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct device_n
 	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ, dev_fwnode(dev),
 						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 		return -ENOMEM;
 	}
 
-- 
2.53.0




