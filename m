Return-Path: <stable+bounces-209524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F85D27A74
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3D7F306F911
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89333B8BA7;
	Thu, 15 Jan 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ksLogmbD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B2D73B4;
	Thu, 15 Jan 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498941; cv=none; b=H78g5/qTOwpy+DHLnvVpUYb+4oZs3eiVi+4j7qhfkBp1pG7cMTUGK2n6GhH6EjtKb9Kl62TjC2BnB6t20b94gnkcASUhYM0vu1bo8ttPGMeCFnhS/ul2x+QALjz9sa6U6rHJ+CWjDh3TO7KYlIpBJVh+NMm5UX7Fq6G/DSeHDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498941; c=relaxed/simple;
	bh=xwDhYAkfSdLQuPyKQQqUbnuw0Qx/hk7p+kEaJvT4w0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWYx/9LCTozk+Lv/DJkJweyRPI+vP8xIcFlVRnj1n+Yy1deJXO4DqfmUNI5VoeAwNZWRQm5eOK0GiGwSCloIoW6n1Nrc8ORC+9VURkU09gUTdRaOpt+gbLz0TLFNNGmW+KkE/x9JQfESEP1v7RPHlUPZ6WPBBdfCkTOLMGoH+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ksLogmbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFEAC116D0;
	Thu, 15 Jan 2026 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768498941;
	bh=xwDhYAkfSdLQuPyKQQqUbnuw0Qx/hk7p+kEaJvT4w0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksLogmbDjsdGGa/nLmHOjEI2Mj9O7Cj8u4C6Peu3mYAdoNAaWHzSaQQxyLPG/lzjM
	 YzM3CDq17R6oyIL/MRJPWLfsSSmSOxnN8hpoZZmAtmwf1hXhYHcm23K03vHBZG/vI4
	 v4qopjJHBEt5Iz+nf2Wl8l+MmMcRArnav0PvIP74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 020/451] pinctrl: qcom: msm: Fix deadlock in pinmux configuration
Date: Thu, 15 Jan 2026 17:43:41 +0100
Message-ID: <20260115164231.620122745@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 049a34f0e13f7..f72a1598de28a 100644
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




