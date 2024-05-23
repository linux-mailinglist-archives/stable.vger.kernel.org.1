Return-Path: <stable+bounces-45815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90B8CD409
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B90B2155C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652C14A60C;
	Thu, 23 May 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2ZTsofT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B813BAC3;
	Thu, 23 May 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470440; cv=none; b=PDrI7wZq73r9uujZWZuicAe5kNskog/7qZxjBThX5ywMmaSKwUMnbb6s/gGGBU8omZhlFO6njZHNm97OfQb/vIWYakDgc22Mva+NTXsrCelX29r4lLYmocGZM8WJGeRwWI+b8EIksyZZ5uKADM704yfCZ25iONSmWqWqLXf/INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470440; c=relaxed/simple;
	bh=qPVn5sj0hQphBFDCn+6YY3b5439rF1z4lrhn7UBoDwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISPjaMTQcxxFvLg7iO5EfECjEbtvZtrZWyH2meMMoSeRCdxXlewfntt+OSvjXGvsFDLUBFbaZFvJ8nu/RG5BkRD37vbSFjc6KG6/enbwKzr0PVZ6eF2aW2pcVK3G5pla8wJyZZx8kuSsSf442t3z/ZiFAGSTTgDzgqtwxtgPVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2ZTsofT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B3C3277B;
	Thu, 23 May 2024 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470440;
	bh=qPVn5sj0hQphBFDCn+6YY3b5439rF1z4lrhn7UBoDwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2ZTsofTirOhaQGfCQQUJgVxtyhqa0EulKquz/DWwm50LJXP9nX1miB9eo2xVWFm8
	 6MvZ9+kqsDWBOU6DRNxfRE7z5pPtPcYC0Ld4YNUZ3P79myz05vGnDCd/tBZWp2c1u/
	 gHosTPur7/AZGcrYgHvoP1Tyz2j6UKQcSnCfQL+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 6.1 06/45] mfd: stpmic1: Fix swapped mask/unmask in irq chip
Date: Thu, 23 May 2024 15:12:57 +0200
Message-ID: <20240523130332.740537717@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

commit c79e387389d5add7cb967d2f7622c3bf5550927b upstream.

The usual behavior of mask registers is writing a '1' bit to
disable (mask) an interrupt; similarly, writing a '1' bit to
an unmask register enables (unmasks) an interrupt.

Due to a longstanding issue in regmap-irq, mask and unmask
registers were inverted when both kinds of registers were
present on the same chip, ie. regmap-irq actually wrote '1's
to the mask register to enable an IRQ and '1's to the unmask
register to disable an IRQ.

This was fixed by commit e8ffb12e7f06 ("regmap-irq: Fix
inverted handling of unmask registers") but the fix is opt-in
via mask_unmask_non_inverted = true because it requires manual
changes for each affected driver. The new behavior will become
the default once all drivers have been updated.

The STPMIC1 has a normal mask register with separate set and
clear registers. The driver intends to use the set & clear
registers with regmap-irq and has compensated for regmap-irq's
inverted behavior, and should currently be working properly.
Thus, swap mask_base and unmask_base, and opt in to the new
non-inverted behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20221112151835.39059-16-aidanmacdonald.0x0@gmail.com
Cc: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/stpmic1.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -108,8 +108,9 @@ static const struct regmap_irq stpmic1_i
 static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.name = "pmic_irq",
 	.status_base = INT_PENDING_R1,
-	.mask_base = INT_CLEAR_MASK_R1,
-	.unmask_base = INT_SET_MASK_R1,
+	.mask_base = INT_SET_MASK_R1,
+	.unmask_base = INT_CLEAR_MASK_R1,
+	.mask_unmask_non_inverted = true,
 	.ack_base = INT_CLEAR_R1,
 	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
 	.irqs = stpmic1_irqs,



