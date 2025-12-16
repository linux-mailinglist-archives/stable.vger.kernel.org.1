Return-Path: <stable+bounces-201964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEECC2D13
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D30330131E7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318334B192;
	Tue, 16 Dec 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGqs48W3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8034A3A7
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886374; cv=none; b=ARqPlSh3vD/kHElvTNIQu8QxxSHAg5qOko+jBgmhLF9S59jnUGh6/nozbaMNjUkq/leHmSl8OdztplxRGEQ7iADVfSE5NU4mNq+DyQ0ydpcL4wg/uZNUcBsnd8jQl5vpZQGbSCZ37WfOW90ZsWMH07GCmQ2tJC6tnG869CZ/uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886374; c=relaxed/simple;
	bh=2IEZhkTi0Sfms3VT3cErpWCHEqvL0iBPGCSylfX36Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duHBykHWBZfunEt2vDgejEXJvCoVy/TItxh9zQa7jTZi6tGpPHf4sRbK6iGoihTKYv2L2JsEFV5O1/tsf17LpE1L7/szjGm2zHcbeNyk/UAo+SjHjLpmSq3EDpAGl1IvPlK+2FvIoLU2b8PLSOg9+FclKfZqwJSP8Zv7OTrKyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGqs48W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D435C4CEF1;
	Tue, 16 Dec 2025 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765886374;
	bh=2IEZhkTi0Sfms3VT3cErpWCHEqvL0iBPGCSylfX36Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGqs48W31AX88po1cdpXr1jL9UHuRoL1T2ViNuKuvgv9Ac2R/xEytUVS4mKtFhq8I
	 QMsyPwwL05i2YTODu4ITjmLQZL13NRqUGO1Pp0NKJBsJ0CAwQLDJ28MRC4GQoZbIf0
	 HJ/jTUx+ovtylNQuq33S1mGrwFqRz34BWYw9s0L4de21ijH7GXiSnnVCFXXdk0Jc2t
	 O8eGwAYcoNsYqstnmTLii+dW3Rvq639pcIzTaRzaY5rM/TKFr6IEIRTx6dBqrRCCMd
	 jGHXtm+O/9P1TtmP/qKLwk52U4+xJ9K+XL6N1eQwcyGTB2LaFgcmZgEWto76WqmL6I
	 aR9RuvrW/tV/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Tue, 16 Dec 2025 06:59:20 -0500
Message-ID: <20251216115920.2789337-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121619-slug-udder-b8fe@gregkh>
References: <2025121619-slug-udder-b8fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 0c4a13ba88594fd4a27292853e736c6b4349823d ]

The wavefront_send_sample() function has an integer overflow issue
when validating sample size. The header->size field is u32 but gets
cast to int for comparison with dev->freemem

Fix by using unsigned comparison to avoid integer overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 09b368761cc00..23a02ab40b713 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -944,9 +944,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if (dev->freemem < 0 || dev->freemem < header->size) {
 			snd_printk ("insufficient memory to "
-				    "load %d byte sample.\n",
+				    "load %u byte sample.\n",
 				    header->size);
 			return -ENOMEM;
 		}
-- 
2.51.0


