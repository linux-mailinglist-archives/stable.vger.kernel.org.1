Return-Path: <stable+bounces-62669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A2940CEF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B6E1C210D8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC519415C;
	Tue, 30 Jul 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faDYfKLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A0194099
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330401; cv=none; b=CA2mz8TL3KQqkLmRW9ItdMDc3s25c/a1V1GBydY4YGpl1l9QUVQWCgEw5Bhd8iAPimrWIUa03i+2Y7xIs6y58c3HgmhOoS8A0tH+yPgb73NHzMITm4XSZKQZI2/PihaTyWHtLqC8IqO5//Y8rlhHnaFKI7qp1e1wDP0xbcZK6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330401; c=relaxed/simple;
	bh=8Bb0g4u7l28RvXV+XmE/W0E6nSV2PlTfT4yfHpyFf8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tVPYq2wLEU0Qqb2DcsqEhAK9sLunxhidaBjuB9rvjIzsxsotUGUMq72Kass4RL+sUiiiUNF8Q9MRNXZ6b+PMFqVNLFji/cI8046IKOT/eYes/6bdFdowHUDB/beyiWqFI/AeTkEBE5Yb2xvdRaTOvOku/Cp8i06O+oPEjYzGoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faDYfKLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C7C4AF09;
	Tue, 30 Jul 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330401;
	bh=8Bb0g4u7l28RvXV+XmE/W0E6nSV2PlTfT4yfHpyFf8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=faDYfKLLWTIo/CkmN1ZyJ0xSPzebcmMCfh7CX8HbQcN8qNn+xzJB6ElZJsZ1RG1Bn
	 25hyqnN6R2yiZNxMii6s7WmSpo2yXNXB2/2xiWN3ru3Y55qd8/aqJxtWRlrPwjemWf
	 ZqmOn1C2SUPM99GYyLVBZb96Cu5/BPhUDHGnVlYU=
Subject: FAILED: patch "[PATCH] irqdomain: Fixed unbalanced fwnode get and put" failed to apply to 4.19-stable tree
To: herve.codina@bootlin.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:30 +0200
Message-ID: <2024073029-outfit-monogram-93d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 6ce3e98184b625d2870991880bf9586ded7ea7f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073029-outfit-monogram-93d9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

6ce3e98184b6 ("irqdomain: Fixed unbalanced fwnode get and put")
67a4e1a3bf7c ("irqdomain: Use return value of strreplace()")
ed1054a02aa2 ("irqdomain: Mark fwnodes when their irqdomain is added/removed")
181e9d4efaf6 ("irqdomain: Make __irq_domain_add() less OF-dependent")
43b98d876f89 ("genirq/irqdomain: Remove WARN_ON() on out-of-memory condition")
94967b55ebf3 ("genirq/debugfs: Reinstate full OF path for domain name")

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


