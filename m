Return-Path: <stable+bounces-62386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59093EF08
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32D51C219FB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA412C522;
	Mon, 29 Jul 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2Mtnkf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7184A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239480; cv=none; b=AO57+LuNKu49fauxWWGzKBBC5JpLTwcs1g+vrKywRDsrEo9cPPoJRmbaqb3vJOv3YKgwY9BWP3K4TFirtJb2ISY+R4VcPl0SDgsmLWdc2TN/QiCWRUK77P7jNODpGkJJO+7z3whSRqVviC4VSU+SlUCrfXda1MS0dTkW0X0wmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239480; c=relaxed/simple;
	bh=wAm6u1EOv7BwO7sBFsv7oJ+CasKHpGleXn84tvnaZEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z/icQqACiMHcTpR/hz/MM1aIFA1XvGlxkGQ8Mhkv/1/2Bj+QLqxrNRORtGpjOie+iz6Y+G98opUPS7g5rG0jD3D/DBnOj38bvds37I4bYg6y9AUCIqJlIlBi+4yykT1EAvYNZA9/cUvXE8Afh7rnEEUuOAqvf9iy//EHXTRM+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e2Mtnkf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A10C32786;
	Mon, 29 Jul 2024 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239479;
	bh=wAm6u1EOv7BwO7sBFsv7oJ+CasKHpGleXn84tvnaZEM=;
	h=Subject:To:Cc:From:Date:From;
	b=e2Mtnkf+7h4fjzaF5m6pa9R2zJVR8vMSOpyoNz4FfV2hNumEX4byXM3bH/hvMKBEi
	 Iw5q1Nw7MyVs2sx8h0EdRO3Pd1H6gJP5M4Z+Vc4+gGNzzy9PTY1vrbPT/5fWXPIFm/
	 fZwy2P8VD8cd5bviX1KxhJZ8Mx6tTHu1yZqm38tU=
Subject: FAILED: patch "[PATCH] irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP" failed to apply to 6.10-stable tree
To: catalin.marinas@arm.com,maz@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:51:16 +0200
Message-ID: <2024072916-brewing-cavalier-a90a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 080402007007ca1bed8bcb103625137a5c8446c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072916-brewing-cavalier-a90a@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

080402007007 ("irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP and !ACPI")
d633da5d3ab1 ("irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs")
fa2dabe57220 ("irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 080402007007ca1bed8bcb103625137a5c8446c6 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 5 Jul 2024 12:54:29 +0100
Subject: [PATCH] irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP
 and !ACPI

Compiling the GICv3 driver on arm32 with CONFIG_SMP disabled
(CONFIG_ACPI is not available) generates an unused variable warning for
'broken_rdists'. Add a __maybe_unused attribute to silence the compiler.

Fixes: d633da5d3ab1 ("irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs")
Cc: <stable@vger.kernel.org> # .x
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc81515c1413..18619d29b2ed 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -44,7 +44,7 @@
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
-static struct cpumask broken_rdists __read_mostly;
+static struct cpumask broken_rdists __read_mostly __maybe_unused;
 
 struct redist_region {
 	void __iomem		*redist_base;


