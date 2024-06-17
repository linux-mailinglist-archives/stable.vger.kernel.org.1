Return-Path: <stable+bounces-52552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447790B2D3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028B3285667
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404521D6E27;
	Mon, 17 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxP+Sh+I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6HKMIZz3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7B1D5433;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632281; cv=none; b=lMmM7k4PTaM2wgiu7HLgp5Zs1abBcvLhpvnm9RKfe8qNuXUErxtA1EJOj9Nbi56x4k/Fhx6Y3voKKFgaubtZsnmBdIO65VBXkoMIJPsoBdu/WRVKP2k/k2MdSBv9H8+DE7KNUf4f/Pd9wEG3Krz7IieAPiCGYSWRgZhHqYan/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632281; c=relaxed/simple;
	bh=fQq7PHR8M445wVBb/0ZvAoxrWZZ9HinlKyuqw5Vd3Ow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZyGWY7LkYeN2ufBACSHx763GYV2Pv6vS5PDpl+hZE1ElelqFukjq9D6zKMj0D1214bG2Aa2P57F8aEfQHnOL5vH9/JzKEmNzayoIbONybrjg1dNwrdEwUGskZM38ywnI0925G+ZtIZOdVXM6SSYRA+xCyuLzvAvSlDVetmvJrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxP+Sh+I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6HKMIZz3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=878SgARI29axMiPLPOHUwfeMGmniB6Eg913PCg6AJk8=;
	b=FxP+Sh+Ic5t6KzRWYmbLiIPf7CaXFpx05iNRnXT1hLlRgta5vNH8NP+I8y0dQsmW+b86JF
	RctNKNe1JJr1XPs8Aq24bY+1NfjQo63yWevRGmEIydJlDVqnDBrzzTSQIIoM6XjglKLght
	TbROC25+hklFiL51OqnMM1SgUe5yQ282X5TOgD3XPaywo9qxLnm5OioNcgxfbUKcGtO/lo
	MKfzzTy/zhfz5obtwCehHsVYGO+QKx0YWHvQnTcHmMDycex2d6w8QXfgVsptlUMsw5684N
	1x29wHWSQafqKpqKGBaRudOHNwcIihYgm86wN4//139dyBNr2O8m6SFVQxbacw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=878SgARI29axMiPLPOHUwfeMGmniB6Eg913PCg6AJk8=;
	b=6HKMIZz3IophxisZu3Xrm9r6mS1GwzX1KrUCmoVqJcuLPA0VCjXFy/xx9RTbdd/nVf5VDO
	J0nOorSwBot+oGCA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Fixed unbalanced fwnode get and put
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-4-herve.codina@bootlin.com>
References: <20240614173232.1184015-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227547.10875.1961373221430883301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6ce3e98184b625d2870991880bf9586ded7ea7f9
Gitweb:        https://git.kernel.org/tip/6ce3e98184b625d2870991880bf9586ded7ea7f9
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:12 +02:00

irqdomain: Fixed unbalanced fwnode get and put

fwnode_handle_get(fwnode) is called when a domain is created with fwnode
passed as a function parameter. fwnode_handle_put(domain->fwnode) is called
when the domain is destroyed but during the creation a path exists that
does not set domain->fwnode.

If this path is taken, the fwnode get will never be put.

To avoid the unbalanced get and put, set domain->fwnode unconditionally.

Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240614173232.1184015-4-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 28709c1..7b4d580 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -156,7 +156,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
@@ -165,7 +164,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
-			domain->fwnode = fwnode;
 			domain->name = fwid->name;
 			break;
 		}
@@ -185,7 +183,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		}
 
 		domain->name = strreplace(name, '/', ':');
-		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
@@ -201,8 +198,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	fwnode_handle_get(fwnode);
-	fwnode_dev_initialized(fwnode, true);
+	domain->fwnode = fwnode_handle_get(fwnode);
+	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);

