Return-Path: <stable+bounces-250082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMZRCL0MDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:34:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88846598701
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9AF4329EE51
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3B36CDE9;
	Wed, 20 May 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9Np7pO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748543A3E79;
	Wed, 20 May 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294502; cv=none; b=NLK9eAEh+DCoyi+5PNUuXJGjRQE3fM6rOjK/yhDC4uGgtqLyA2P9EC0076Na/iXwi+b+oFYlnNaOCz35wjDF/Wm6JE596KI4jxbccQugegMs/0BzeGP5WA8anPtjemw4LTUvhT0HNDRvgc4O3sud+rUMw1cixN7R8WPm2iiUMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294502; c=relaxed/simple;
	bh=i+bVDtFSsbxDnA3MmBnwTbm3mwg0d45MW6rnKZhUx1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDCtqDITUAA5kSbmP2Frc7+MyIGLCdBxenUztguvtmU4+3xFLn6jZCdmjRz6BCDgNR17xlnEDP67x6Zjaus2g+z/9rgFnXn2piQUYyQcv/FQoHhDXoOWA65jhjKOlV6zjgzjPyiW2cP1QzfwARWyNm66C83IYOuZMG8JW5meNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9Np7pO5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761411F00894;
	Wed, 20 May 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294498;
	bh=yiDG/VDZw06dnWRYf2cQSQs0O1/65pUD1qBE3QWQQ0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9Np7pO5QZcvwzMGhxJB/A2LdQdqBeFUaOG3ksKcjgKlreIeey77OY/veyVxXDw4w
	 6pj8WDIeSxGwJ9IyAGKcviL3LF51ZVAbt3FyNs+tCKduKVLJqo9V+BoMs9FCNClgid
	 VOWCQjIOTwh62UzGM7xJGwk5pvbIz400a782v9dA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0062/1146] irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
Date: Wed, 20 May 2026 18:05:12 +0200
Message-ID: <20260520162149.771080898@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250082-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: 88846598701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index e73d426cea6d3..eb01d4c5aca75 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -577,7 +577,7 @@ static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct device_n
 	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ, dev_fwnode(dev),
 						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 		return -ENOMEM;
 	}
 
-- 
2.53.0




