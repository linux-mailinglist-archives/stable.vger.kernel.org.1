Return-Path: <stable+bounces-138528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0259AA18C9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A403B0CCF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A6247280;
	Tue, 29 Apr 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txFSjMiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBD38FB0;
	Tue, 29 Apr 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949537; cv=none; b=khgy8/LsKItpK5Boe7HdEeytPk9Rp/8wDTKxjYGM0uKelRKZzBr/YPRo4UAJNIaot8s+Bn19Ykm1YVFmacjiACkNVtgE7CNbEAAFVI3Ja778ZKeU8t1k7Lf9JyzE87rWYuOIookn4fcS+dPkjbJrPRqCrvrqrqblFNqFYWdR8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949537; c=relaxed/simple;
	bh=BkeegXV7QathaBW0sgS68LPj+A0DFCAbbY+Vb3SKAA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ45osR7f9ppuJaDsoR1ZUpp1VQPSFJxgTUDaeEYERoLaajWmaBwdPPIS56M4TCjXAJiLpHzQ0qMPikN0UUJGxzBXUF/5OgXQ3R1agDMyjDkJ95DPCs/DiO+BSzo0ZY9cDpy3HzEdsAfJPf4FsOiYOgI8+dR6ji+3OrjcWmB27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=txFSjMiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E6C4CEE3;
	Tue, 29 Apr 2025 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949537;
	bh=BkeegXV7QathaBW0sgS68LPj+A0DFCAbbY+Vb3SKAA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txFSjMiJN/bx5MuXyXKEgWnfeppdMFH2tlj4U+EU8wAnpybaEfVbSU/2x48SKigMU
	 oMG24eSYsGzNg4vNQqAegCAuLap9nLHCz0UN9ZqboUd2DE66JF6s04PEKshsxACXfk
	 NCt0YJ0Qg4teBHAONHYixfyL7cdlTuo5KZnntARs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	Peter Chen <peter.chen@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5.15 310/373] usb: cdns3: Fix deadlock when using NCM gadget
Date: Tue, 29 Apr 2025 18:43:07 +0200
Message-ID: <20250429161135.862025812@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Siemsen <ralph.siemsen@linaro.org>

commit a1059896f2bfdcebcdc7153c3be2307ea319501f upstream.

The cdns3 driver has the same NCM deadlock as fixed in cdnsp by commit
58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM gadget").

Under PREEMPT_RT the deadlock can be readily triggered by heavy network
traffic, for example using "iperf --bidir" over NCM ethernet link.

The deadlock occurs because the threaded interrupt handler gets
preempted by a softirq, but both are protected by the same spinlock.
Prevent deadlock by disabling softirq during threaded irq handler.

Cc: stable <stable@kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Acked-by: Peter Chen <peter.chen@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdns3-gadget.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1960,6 +1960,7 @@ static irqreturn_t cdns3_device_thread_i
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2001,6 +2002,7 @@ static irqreturn_t cdns3_device_thread_i
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }



