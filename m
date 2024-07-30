Return-Path: <stable+bounces-62667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5D940CED
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD84F2860F7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306A1946AB;
	Tue, 30 Jul 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNSK3eSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304A188CAD
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330395; cv=none; b=ijDm4dD/ImyZqvR+zijPrJp9rG/EAXAoFmFe5IE5gy5FJ+1W1tkDPC6qozH/JctEEKzva6ma/5X03nx9tEvEn0nDQ3NrQmOXjcapiSKwhOSfdxRf6PibD/ZhhD5ebGMRL0P2HmcmnJeIsjyofqi4M/ZiOhqVy/Tjr/ioijKT2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330395; c=relaxed/simple;
	bh=z8TB2wQ+yDt4vAP0ovrPkl2hNknT5M8Sy2RUXuo1QRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qV7N3uZ6sESi49+dbufYIFXgfNB7Ob+lKR7Y+fA8od2QG1zVBvsbJA3hHUSboCrriwhSu2P/Wu3UjZZZp7DUTSuBWnvoyQjgnmUVOpAqHmI9LDmMWCLCwG8BEmElWbZ7OjCTURJP8jqSIa5YWUUCgN+ZxiyFthU3XLpwjzbLxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNSK3eSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CA2C4AF0B;
	Tue, 30 Jul 2024 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330394;
	bh=z8TB2wQ+yDt4vAP0ovrPkl2hNknT5M8Sy2RUXuo1QRQ=;
	h=Subject:To:Cc:From:Date:From;
	b=PNSK3eSdBThScbgjRM59PRvYfeoYVaEn9OS8UTF8UUhUzy7fJtjtaFKbymxtzUSqU
	 MatimsvtpQpyxiNtETx1vU7QWHsOyHm1GApXZ+2GhKclgXIj1XkgxfZ2lzf1/MPQsy
	 NiC0qFig/KA0KCOm/JWOWHh6v5mHIuLyOuA58BGA=
Subject: FAILED: patch "[PATCH] irqdomain: Fixed unbalanced fwnode get and put" failed to apply to 5.10-stable tree
To: herve.codina@bootlin.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:28 +0200
Message-ID: <2024073028-suffix-spoiler-8263@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6ce3e98184b625d2870991880bf9586ded7ea7f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073028-suffix-spoiler-8263@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6ce3e98184b6 ("irqdomain: Fixed unbalanced fwnode get and put")
67a4e1a3bf7c ("irqdomain: Use return value of strreplace()")
ed1054a02aa2 ("irqdomain: Mark fwnodes when their irqdomain is added/removed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ce3e98184b625d2870991880bf9586ded7ea7f9 Mon Sep 17 00:00:00 2001
From: Herve Codina <herve.codina@bootlin.com>
Date: Fri, 14 Jun 2024 19:32:04 +0200
Subject: [PATCH] irqdomain: Fixed unbalanced fwnode get and put

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

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 28709c14d894..7b4d580fc8e4 100644
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


