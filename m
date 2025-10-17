Return-Path: <stable+bounces-186537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A96BE98F1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB746509441
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9C32C94B;
	Fri, 17 Oct 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="atAWsymP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82C3370FA;
	Fri, 17 Oct 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713523; cv=none; b=cqvgCXGma/M9rFPNtjt2E4AcXrhttKUPl93yGnPMAJVFMSyAUGk4E2eVoWMbIUu0M5mqOhEPcCyziSSBB1MXEn80fgPmSv7yDefrClSv6caf5Kk4xCszHkwXgiAN9QSh06I7IAEcG3aHunyl02b/XYxsggfunhPycyIwguzobFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713523; c=relaxed/simple;
	bh=oht9A9jOBn81Fytxk43u3sIJEAdJJSJWkyxJSR+kgao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p038LgHaaINnUJk8jBEPSU7uU/vwnL8kubHTKue2VWJ+zvFYfcHmDY0JAMNoobXVqQbgQB3E41C5HnUO7fYwy98xcP945PiTNia+1rOX+LTL3ZxaMACZV0UrEQf6DndDEKC7HCYTdmFNktCZH5Tppb+p8vaqgmAH6fq28QPQ8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=atAWsymP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8473EC4CEE7;
	Fri, 17 Oct 2025 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713522;
	bh=oht9A9jOBn81Fytxk43u3sIJEAdJJSJWkyxJSR+kgao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atAWsymPqhE5pDgXtJMKd+KNu8xfpqwgkvUJbrynYTk5mi8nax0HarmAbBhwGM/Dr
	 CIRYNLYwsugQplixd7WUvOtlD9xsKQFZv4Mdolo9OM+b1hdt+H3QIA9ECpOKwVB6bM
	 TNI7G8J50NF0WQ3TvQxTbXrAkRcHgmff+1euu+dU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 009/201] clk: at91: peripheral: fix return value
Date: Fri, 17 Oct 2025 16:51:10 +0200
Message-ID: <20251017145135.072205818@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 47b13635dabc14f1c2fdcaa5468b47ddadbdd1b5 ]

determine_rate() is expected to return an error code, or 0 on success.
clk_sam9x5_peripheral_determine_rate() has a branch that returns the
parent rate on a certain case. This is the behavior of round_rate(),
so let's go ahead and fix this by setting req->rate.

Fixes: b4c115c76184f ("clk: at91: clk-peripheral: add support for changeable parent rate")
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/clk-peripheral.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c173a44c800aa..629f050a855aa 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -279,8 +279,11 @@ static int clk_sam9x5_peripheral_determine_rate(struct clk_hw *hw,
 	long best_diff = LONG_MIN;
 	u32 shift;
 
-	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max)
-		return parent_rate;
+	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max) {
+		req->rate = parent_rate;
+
+		return 0;
+	}
 
 	/* Fist step: check the available dividers. */
 	for (shift = 0; shift <= PERIPHERAL_MAX_SHIFT; shift++) {
-- 
2.51.0




