Return-Path: <stable+bounces-75042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBE9732B0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D6288734
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94B199931;
	Tue, 10 Sep 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpc7HQYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12A192581;
	Tue, 10 Sep 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963579; cv=none; b=NuSwE8/sLEmgja1iMpgrRMkT3VNOVOZa6VZvYFEUrUY9FgXnx5xmbMUbg0hR7hX6kMb9POzHtGZC939mk1DlLQExKwc2KndzuBOjepZshz+Qi3ZWfoL347jasHOg3m23kBJjcQbsxeqSxVgfU54fOBw6BkteTGdMJopGoW13CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963579; c=relaxed/simple;
	bh=hDumZNeO2yMMYpVKlDRvzdzLw9YWsHMdOhfyiG+77Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiN2khXmAWKR8MjsYqDGTpX6v0+Fh68w7HyTR94oCXB6iEtG0W6nLeoPGRqo5R+URzl70pNbLcZ8VVBhQ03+rIFwoZ51r3hZXHTyU5E97GTDlRy0VuUj12+T6s09RdlmC/w8Uuw/lDefnV4sTAQ9oLhpVcHIKQoPv31e8CT6RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpc7HQYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FC9C4CEC3;
	Tue, 10 Sep 2024 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963579;
	bh=hDumZNeO2yMMYpVKlDRvzdzLw9YWsHMdOhfyiG+77Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpc7HQYsWG47Qbkj64nxIUeu/FmRuDARJF1T6/XrKoyfX4Clo25oQsUXNDhqFe2ek
	 nhWOjRZN2zxq2gRNW0KeqpeXFCoYOlaQYlJOadLH9QPULdvBktEguuBnHrf0WNgZSw
	 MPoyfy0K6Gdcv5fHJo5Q4t5xB5QLIJ3x3j2CcGsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 105/214] irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1
Date: Tue, 10 Sep 2024 11:32:07 +0200
Message-ID: <20240910092603.096919146@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 01709c61e364..3fa6bd70684b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,6 +546,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
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




