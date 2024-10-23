Return-Path: <stable+bounces-87890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385809ACCF4
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDABB245BF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001202003AD;
	Wed, 23 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg/CyFHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C81CC8A2;
	Wed, 23 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693926; cv=none; b=EDio5KEfPhOUleUAXpr/+R2fzUUGaRxoSnnvw9SFCERUYGg+waxs4Dbo2ApNFZ+SRu6IB243v6KxOaBNEjcHtoFOsmYZO6PBCE7+kiTMMgWOlsmRaFbROioYHt8FN9QwKVORSUDPrIiwHknvPfYBxuDA7CRgGD/qo29VStoBWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693926; c=relaxed/simple;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOuPk21MIAbh0sftBrvWS6dv5n4mnve37zLe1ujnsQHDisLcIEOa7GZh0oADqyMYPMsPbTBepBd4+g5nLzavoIK44EUXIjrh5KD/FbQv252s/xHYGtsxcVgoN9YzimaxzrEt3QkoBOnBCWWxCWI9fr46GZ/lhTInV0menAGuiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg/CyFHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E32C4CECD;
	Wed, 23 Oct 2024 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693926;
	bh=eLcq8MuiQb/sOJuduYqKMuTG95hX8gQlc+dMMaRWQKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg/CyFHOv2OS0eFx/Sk8dwK1t/eH+4zHvDFWPVQ+9ZHVBhbEmcrtbHNZBPyO1TACz
	 rfQLW7/JKfM1LiyTSAm9arjk/c+7dFOFEUGmcAjCKm77NMHqgdYhHkKaSVjmh84w7C
	 sMoO6mE1I+aWvLQt/4MbHJZleCRCacZhFVq2ALffAMWiDnRhT++XT7+lvNGp53Fp9A
	 ypZqt0mMivGeumCSGk7iVYqxMjd25Q1Aj/kBeON0Y6fn+By/2XK4ZdZph3sf35f2K3
	 Gv28CD52LBs6R0BgZdyi+jAa680pKZfqrCeIS9ejloi60Gjs5xrBA0eXY88HG3dHEa
	 OMgWqtx3bM+QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 02/17] irqchip/ocelot: Fix trigger register address
Date: Wed, 23 Oct 2024 10:31:41 -0400
Message-ID: <20241023143202.2981992-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

From: Sergey Matsievskiy <matsievskiysv@gmail.com>

[ Upstream commit 9e9c4666abb5bb444dac37e2d7eb5250c8d52a45 ]

Controllers, supported by this driver, have two sets of registers:

 * (main) interrupt registers control peripheral interrupt sources.

 * device interrupt registers configure per-device (network interface)
   interrupts and act as an extra stage before the main interrupt
   registers.

In the driver unmask code, device trigger registers are used in the mask
calculation of the main interrupt sticky register, mixing two kinds of
registers.

Use the main interrupt trigger register instead.

Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240925184416.54204-2-matsievskiysv@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mscc-ocelot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 4d0c3532dbe73..c19ab379e8c5e 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -37,7 +37,7 @@ static struct chip_props ocelot_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 24,
 };
 
@@ -70,7 +70,7 @@ static struct chip_props jaguar2_props = {
 	.reg_off_ena_clr	= 0x1c,
 	.reg_off_ena_set	= 0x20,
 	.reg_off_ident		= 0x38,
-	.reg_off_trigger	= 0x5c,
+	.reg_off_trigger	= 0x4,
 	.n_irq			= 29,
 };
 
-- 
2.43.0


