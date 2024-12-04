Return-Path: <stable+bounces-98514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7618E9E44B2
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37A0BC459A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912A233682;
	Wed,  4 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajxnLeeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519F207E0A;
	Wed,  4 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332385; cv=none; b=bJSLl7VpNjbtYT7sdlVEFKRUog100B0W9jLJWXDVMF9DJc/caiq8YnymlJNejxSnA5kh2UGzcel8QU+J8A0wiuTxZD11GPUwUU/6H48n57OQXrKfTwZ1lo/Dpjujbs3TH6ZbUIanaVsUFUZjrdOwA1yKp9zJVgQW/I8InhAVFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332385; c=relaxed/simple;
	bh=+X9biTYdLqrN3HM1KDhzN5t9z9vfwvlhW1FN3fQOejA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeeR2b1vakZKn+M+HD2xP5LjGh35bXTQKppQbnsOibZRPAqNTLn/fIGCwbWFSnQjsW39kEASFMmJFx/3BA6XQfEVGMr5jDWHw++ccBMGf3XWNjxZtuNa3d5HbD7C7HpF6wvoo8Vxjnm7IuCGk+x5FRIlw2792VEsNtzZri302g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajxnLeeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E20C4CECD;
	Wed,  4 Dec 2024 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332385;
	bh=+X9biTYdLqrN3HM1KDhzN5t9z9vfwvlhW1FN3fQOejA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajxnLeeb085mWVEg9KwPr6PmyI3YcELttv0mK7reaBYVVESGlICh1qHR8IWPliX5V
	 Ft152cAeXzT0c/hkmGHMZuJGIFv4A5vcvxkQSEBHxN6niu1JbJNgHWRHmMG0GvACFr
	 i6EC3CcL0H28PRC2lhdBbqT+/i4T7nFaJu31w5VJQN4u34EuyFuXCbuC3wrfc3PGg4
	 bqXSZ8NuR6rF0llTux/7VFxiGt0NGYEyNogzuFLtasCBwvwuCxCMQPaEw/Lnj3EGMJ
	 RaX1PuFZznDvXZPKNWv1K0a1X/uSG3PtRT+pqBwks21XGwgcIo1XMr07aV9wamXuFi
	 nuIdM28rKsp1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 2/6] i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
Date: Wed,  4 Dec 2024 11:01:34 -0500
Message-ID: <20241204160142.2217017-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160142.2217017-1-sashal@kernel.org>
References: <20241204160142.2217017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 6ca2738174e4ee44edb2ab2d86ce74f015a0cc32 ]

Bus cleanup path in DMA mode may trigger a RING_OP_STAT interrupt when
the ring is being stopped. Depending on timing between ring stop request
completion, interrupt handler removal and code execution this may lead
to a NULL pointer dereference in hci_dma_irq_handler() if it gets to run
after the io_data pointer is set to NULL in hci_dma_cleanup().

Prevent this my masking the ring interrupts before ring stop request.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20240920144432.62370-2-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index edc3a69bfe31f..bcc0c7d4131f2 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -174,10 +174,10 @@ static void hci_dma_cleanup(struct i3c_hci *hci)
 	for (i = 0; i < rings->total; i++) {
 		rh = &rings->headers[i];
 
+		rh_reg_write(INTR_SIGNAL_ENABLE, 0);
 		rh_reg_write(RING_CONTROL, 0);
 		rh_reg_write(CR_SETUP, 0);
 		rh_reg_write(IBI_SETUP, 0);
-		rh_reg_write(INTR_SIGNAL_ENABLE, 0);
 
 		if (rh->xfer)
 			dma_free_coherent(&hci->master.dev,
-- 
2.43.0


