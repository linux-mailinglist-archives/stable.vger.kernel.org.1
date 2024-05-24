Return-Path: <stable+bounces-46053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8258CE483
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA561C20BF6
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8E85C44;
	Fri, 24 May 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+p5TNps";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wyrt3ETa"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144585956;
	Fri, 24 May 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548268; cv=none; b=kbBFGQIqWT89qGnsNFnWMt7Jwpvqm1gNSRV/8dA85bN20dN3O5UGkYHrbYapPLY9P6NwDnkg0Tx51O67WuHplYji2tk9Q6H3+xClCCREZh5Mv8Tva7MvMyQOLY4OlHltP3Te+3QNmsMtfXx4Q6dGR3rRik0xmwsD1ee2PSCh5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548268; c=relaxed/simple;
	bh=colrypTjylwyez/3r9sQhQskA+fGLFAX5Vtn76reIsw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IBk+ySyHK/134aWZZttRdRwqDlBUvwutEH2ekEfFewr5svqs3uIG+OAc2Uo1PSr5r2SvN+x/8jNFNeWhVKKFRzWb9/eQr1QdVzcB+38O6WHIS4OHnOyg3nqmv3Sc6IH5FX/pmBpmJC25sjETq9vXL1XcS4BOKWO2k3k6qc+6rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+p5TNps; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wyrt3ETa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 May 2024 10:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716548264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLYn3FwQBwFMOl0ONyA3r9l1SvJ452A313P0X1CGLe0=;
	b=J+p5TNpsmfs1LzuvHTrFETBpJUNc2Ow2jID0Odkui9OWA14LfyWRuQdwoZQghv3yGVqcQp
	iFoQYQi3VOwZhVUKikSDbrQ5eclREGbuBLE7vKPUSstHlLNpl6QuMtC95rO5fEQrKhH+af
	H7Eieono3dKrINSXXHWv5K43wDVRK6WKBxDalCckG2lwRoFHIJoE/YOlL2+y9/LnzSJpXJ
	3Xqw9gkNHwTlSYGnDUkTqYSh/LMPNe1o/gtnECEJjmv7eE/nrxBhQWWXeyiHkrbWVkCRwe
	RozwWzJBdKbhTvBBI5HiOks2aOxAlxBiDJwUTnvZTyW5Udrc8LnMuNW9UXap4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716548264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLYn3FwQBwFMOl0ONyA3r9l1SvJ452A313P0X1CGLe0=;
	b=Wyrt3ETaQN8tBUGYJimQo23LgMKAtNZQ0hlQiv9n7oPAun+/7GAigxd4mFzwIGd7vRnqwg
	tTH4gAxF5U9OjNAQ==
From: "tip-bot2 for dicken.ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/irqdesc: Prevent use-after-free in
 irq_find_at_or_after()
Cc: "dicken.ding" <dicken.ding@mediatek.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240524091739.31611-1-dicken.ding@mediatek.com>
References: <20240524091739.31611-1-dicken.ding@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171654826399.10875.17851209724801691980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b84a8aba806261d2f759ccedf4a2a6a80a5e55ba
Gitweb:        https://git.kernel.org/tip/b84a8aba806261d2f759ccedf4a2a6a80a5e55ba
Author:        dicken.ding <dicken.ding@mediatek.com>
AuthorDate:    Fri, 24 May 2024 17:17:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 May 2024 12:49:35 +02:00

genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()

irq_find_at_or_after() dereferences the interrupt descriptor which is
returned by mt_find() while neither holding sparse_irq_lock nor RCU read
lock, which means the descriptor can be freed between mt_find() and the
dereference:

    CPU0                            CPU1
    desc = mt_find()
                                    delayed_free_desc(desc)
    irq_desc_get_irq(desc)

The use-after-free is reported by KASAN:

    Call trace:
     irq_get_next_irq+0x58/0x84
     show_stat+0x638/0x824
     seq_read_iter+0x158/0x4ec
     proc_reg_read_iter+0x94/0x12c
     vfs_read+0x1e0/0x2c8

    Freed by task 4471:
     slab_free_freelist_hook+0x174/0x1e0
     __kmem_cache_free+0xa4/0x1dc
     kfree+0x64/0x128
     irq_kobj_release+0x28/0x3c
     kobject_put+0xcc/0x1e0
     delayed_free_desc+0x14/0x2c
     rcu_do_batch+0x214/0x720

Guard the access with a RCU read lock section.

Fixes: 721255b9826b ("genirq: Use a maple tree for interrupt descriptor management")
Signed-off-by: dicken.ding <dicken.ding@mediatek.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240524091739.31611-1-dicken.ding@mediatek.com
---
 kernel/irq/irqdesc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 88ac365..07e99c9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -160,7 +160,10 @@ static int irq_find_free_area(unsigned int from, unsigned int cnt)
 static unsigned int irq_find_at_or_after(unsigned int offset)
 {
 	unsigned long index = offset;
-	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
+	struct irq_desc *desc;
+
+	guard(rcu)();
+	desc = mt_find(&sparse_irqs, &index, nr_irqs);
 
 	return desc ? irq_desc_get_irq(desc) : nr_irqs;
 }

