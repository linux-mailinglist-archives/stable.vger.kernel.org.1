Return-Path: <stable+bounces-157582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59602AE54A9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346E2447C7E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCF22173D;
	Mon, 23 Jun 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5GXVbUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445321FF2B;
	Mon, 23 Jun 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716221; cv=none; b=VYGr+EWVYt/fMo0X6d2VXxIG31esmVMPG3eTV8+d71Nq1t9FNwmfaFslDpcxDR4Jvhlvyi3upAX4qxzqblrVTbKctLc7QwRKPIUo+9NND8qMfZ6UGXRzSXWCfbEYzOUoGBrWn8sKTGdUe4BVMdNdFHB6gotdscZCgfXeD6NCuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716221; c=relaxed/simple;
	bh=C5u4euelvUVii2V+pzSRDrCirSNPytNkezlWIDL++Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMpSMOOAU4yd2RSZau118fEfRTj20BVo471isZB4edRxIPm3RGpfnsIlBp+JUpXfuj10wD4wLZpHeTnXo3RrSfg2sDPB+52RCgpxhdV9IxiBU0GXlyPbDVP7CRYKaEoHmTyDLa+y0E/lnrh5xcx8VpqY0sDR6sRKK/yTi5jTR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5GXVbUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA318C4CEEA;
	Mon, 23 Jun 2025 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716221;
	bh=C5u4euelvUVii2V+pzSRDrCirSNPytNkezlWIDL++Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5GXVbUkKa0r6uISk48hkiejXCTAFCpTjKusnEVYb1EH9hmG5ir3/iW1+NxCRRjDh
	 fkVowXuQDhIHnOD9IixzOXK8h6Fs1Mi5KyIx7oLf4ysnb3orbNmeHBWEt9/2aZvWUc
	 Mt4fnspt8kTcOLl2vc7GpN2iunu+FEl29+GbPOsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1 309/508] media: ccs-pll: Start OP pre-PLL multiplier search from correct value
Date: Mon, 23 Jun 2025 15:05:54 +0200
Message-ID: <20250623130652.915121130@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 660e613d05e449766784c549faf5927ffaf281f1 upstream.

The ccs_pll_calculate() function does a search over possible PLL
configurations to find the "best" one. If the sensor does not support odd
pre-PLL divisors and the minimum value (with constraints) isn't 1, other
odd values could be errorneously searched (and selected) for the pre-PLL
divisor. Fix this.

Fixes: 415ddd993978 ("media: ccs-pll: Split limits and PLL configuration into front and back parts")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs-pll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/i2c/ccs-pll.c
+++ b/drivers/media/i2c/ccs-pll.c
@@ -817,6 +817,8 @@ int ccs_pll_calculate(struct device *dev
 			      one_or_more(
 				      DIV_ROUND_UP(op_lim_fr->max_pll_op_clk_freq_hz,
 						   pll->ext_clk_freq_hz))));
+	if (!(pll->flags & CCS_PLL_FLAG_EXT_IP_PLL_DIVIDER))
+		min_op_pre_pll_clk_div = clk_div_even(min_op_pre_pll_clk_div);
 	dev_dbg(dev, "pll_op check: min / max op_pre_pll_clk_div: %u / %u\n",
 		min_op_pre_pll_clk_div, max_op_pre_pll_clk_div);
 



