Return-Path: <stable+bounces-74797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2697317C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5496B28BEB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5F193081;
	Tue, 10 Sep 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8UIOQzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641C188CC1;
	Tue, 10 Sep 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962858; cv=none; b=nyHj5LINRi5SVcypbSA347MVpf1/o75hqBWhfRZA61MbuYjI5UNXvuqzI5o8AcCUPA1IgEzy7EYpDs82hNLTmKKwaXoflddoGiGFXuM0a+HOntcn3DXL7IR/uBSQEP5mAa3dfKa+vAax8l/sVB/FezELGEcgdYTorCXzr4OMAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962858; c=relaxed/simple;
	bh=Mrfl+YDbRNyRzFTZ000QJzgKJDod9PDE50aZuUDoR6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLgISxcjVEn3lrSK2mv/UXhtZOD4HsFPv3OkrDN/zwN8HxJi7rGMfTOTYneeEvN15nPdwA2VnhBgLauS4YExeFYqkqqSJDfF3FP22HXYoXy12zvC2l148m/O+/tBGeH1mQ5hGP/oJhH/6AY8RJP74ZCs8NKTHuUSDTSQ+77b+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8UIOQzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3674EC4CEC3;
	Tue, 10 Sep 2024 10:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962857;
	bh=Mrfl+YDbRNyRzFTZ000QJzgKJDod9PDE50aZuUDoR6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8UIOQzE5XWLyiUpkp0SqwJRmzKUH+mMTzwAFHyWxZ3+AP9pvlYsqq1WyrSKSf8fU
	 DaC+s0xA4dTF4Ta45EIjfMIxBFGTx0xDJ2FNG3YLc8Ntca4daTKNVqn+P8GEoU0eYQ
	 84lLVFXGilZFcZwpD94ZgQSMGSq/iAJKo4AXsytU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/192] irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1
Date: Tue, 10 Sep 2024 11:31:10 +0200
Message-ID: <20240910092559.893833367@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 3cef738208e5c3cb7084e208caf9bbf684f24feb ]

IRQs 0 (IPI) and 1 (MSI) are handled internally by this driver,
generic_handle_domain_irq() is never called for these IRQs.

Disallow mapping these IRQs.

[ Marek: changed commit message ]

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee18eb3e72b7..ab02b44a3b4e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -567,6 +567,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <= 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
-- 
2.43.0




