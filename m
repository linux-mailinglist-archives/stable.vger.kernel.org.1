Return-Path: <stable+bounces-208947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE80D2653C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9DE73046A02
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23B3C0092;
	Thu, 15 Jan 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVAlXPlK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE033A0E9A;
	Thu, 15 Jan 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497298; cv=none; b=Sjizonc9F2zZl0IS0cNCIPafVRfoScj4RW72xasjAzHyt7seatp3eN+p5OxfGULCMdGmfz8P8+V1ThXVhXBlt1Gbhub8FHpjeC4EBai4Hc8WwB8xVUGlkWJwQrt2TvPvOUZCrCi0cjKvwdWgtU7fUPDOszBdElYKBegOiPaaeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497298; c=relaxed/simple;
	bh=Mg9fYUZ69Uvbzl1DN2ks1DqAA0tWit1Lr227B2kRgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAoC0FOW6li7cm2KvTHFGQEd158jeon5zN+4limhR4TZg3lQqC2aQOrpkX3UnrxuMvZdUWArmz26YTFiYqW5E7zop6N0C6vAXe7KcL3vT+L5Gd5DsMKAiTy6r7nnF+eVkcFpRHLLm9HV3L8PEgt1m0QLE4KIJyw9gAash9PaO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVAlXPlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E343C19425;
	Thu, 15 Jan 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497298;
	bh=Mg9fYUZ69Uvbzl1DN2ks1DqAA0tWit1Lr227B2kRgpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVAlXPlK7Z13vgyGNFY5bgILnIAUjtnBhYLg7q/D+HexvvgwB2OUfNJgwEOShFpJX
	 ZGz/+1EUOaXz18CXjN4+MZ+clobNK3I4lsYgorVXigGAkmfURU/B+jTc6hfQMaZ4O9
	 eQtHpenKwvpOz+q05IMVdj+OSClVnK7iE3NmSA94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/554] pinctrl: qcom: msm: Fix deadlock in pinmux configuration
Date: Thu, 15 Jan 2026 17:41:31 +0100
Message-ID: <20260115164247.151736344@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Praveen Talari <praveen.talari@oss.qualcomm.com>

[ Upstream commit 1c2e70397b4125022dba80f6111271a37fb36bae ]

Replace disable_irq() with disable_irq_nosync() in msm_pinmux_set_mux()
to prevent deadlock when wakeup IRQ is triggered on the same
GPIO being reconfigured.

The issue occurs when a wakeup IRQ is triggered on a GPIO and the IRQ
handler attempts to reconfigure the same GPIO's pinmux. In this scenario,
msm_pinmux_set_mux() calls disable_irq() which waits for the currently
running IRQ handler to complete, creating a circular dependency that
results in deadlock.

Using disable_irq_nosync() avoids waiting for the IRQ handler to
complete, preventing the deadlock condition while still properly
disabling the interrupt during pinmux reconfiguration.

Suggested-by: Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 676b16397b07c..1bb7be9ed92f2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -213,7 +213,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 */
 	if (d && i != gpio_func &&
 	    !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
-		disable_irq(irq);
+		disable_irq_nosync(irq);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-- 
2.51.0




