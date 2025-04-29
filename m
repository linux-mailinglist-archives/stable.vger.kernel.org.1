Return-Path: <stable+bounces-137195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524CAA1223
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012B21BA288D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF2126BF7;
	Tue, 29 Apr 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sd2dXt0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D611244679;
	Tue, 29 Apr 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945347; cv=none; b=B1r4f98VjeQZHSq7Ny2HHOH7QoBDT3BHYeQs5dy7smV+QTrwVGOjo2VO3PxSsd6CNLd8nTeP0MGugr373zgSV22yVBg3jFAO4pYzoE52nY9GeOQPU+buzqefAewqwuEV9j3ebledlAGKfyrl+Zx7sWV5b2dI1uh62WYTV/UNb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945347; c=relaxed/simple;
	bh=IDk7Kvx1fe7JXW+4VfuOKS19zIHB1jPDUEoVDtvWizE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdXnLtZYRKqg0kkGGrJ4tkuC+5U8KystBvnZPIDfdEpbSnKOvDfkzVaxPTZ0t1xzqLBwSm6rtucc+fIR1Hi/R4gL5RqSVcbkHMzqOtWKH82w57VD3xO9r9d0xhJETBlfD2/ykN/CoEu/UpPFNlJii+hNfE1oYzXS0Dyg0+PS2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sd2dXt0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCEEC4CEE3;
	Tue, 29 Apr 2025 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945347;
	bh=IDk7Kvx1fe7JXW+4VfuOKS19zIHB1jPDUEoVDtvWizE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sd2dXt0W8voQpLA62tdO+El677HdGTGhR0cIyiDcTArtFTw4o0M9y/5t11L3ZIo2y
	 49X2/PD5J0+QH4KaPQis4UPVmferG6JHvQvKkEYxrxjCO+B/4mgA2MhjFSd55CfCVu
	 NuzVciJKA3dsMy4w9c+y0DeYarjD6dxY4A04gccA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5.4 081/179] pwm: mediatek: always use bus clock for PWM on MT7622
Date: Tue, 29 Apr 2025 18:40:22 +0200
Message-ID: <20250429161052.685661039@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
User-Agent: quilt/0.68
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

commit aa3c668f2f98856af96e13f44da6ca4f26f0b98c upstream.

According to MT7622 Reference Manual for Development Board v1.0 the PWM
unit found in the MT7622 SoC also comes with the PWM_CK_26M_SEL register
at offset 0x210 just like other modern MediaTek ARM64 SoCs.
And also MT7622 sets that register to 0x00000001 on reset which is
described as 'Select 26M fix CLK as BCLK' in the datasheet.
Hence set has_ck_26m_sel to true also for MT7622 which results in the
driver writing 0 to the PWM_CK_26M_SEL register which is described as
'Select bus CLK as BCLK'.

Fixes: 0c0ead76235db0 ("pwm: mediatek: Always use bus clock")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/Y1iF2slvSblf6bYK@makrotopia.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -296,7 +296,7 @@ static const struct pwm_mediatek_of_data
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
+	.has_ck_26m_sel = true,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {



