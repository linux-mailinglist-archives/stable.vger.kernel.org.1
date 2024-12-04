Return-Path: <stable+bounces-98490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2169E45D5
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA4B31F7A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6E3DAC0C;
	Wed,  4 Dec 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvXW7W+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79AA3DAC08;
	Wed,  4 Dec 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332329; cv=none; b=iK4ozk6zGfebkZ9KMHcI8l1eUa3aFmgzd6TGx9DLoEKN801+pUhwIDkLlAqsqoOPhXtOZ0uD2xFcyCZ+VJlMzF3VTcVd5D1abj6dejrk/5rLVSIClt9rBuAh6MjqIHHRSyPOoFUkAeymUOE0oWA7cObxi3RS4CVg+NoPkI709pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332329; c=relaxed/simple;
	bh=W/y8zXZkHB6ZxAKXAe+UMRSHimjoR/7RwfdqEpMrYMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlgqHtAjunDpQuQkaYDV8UOjbc1JHCbTwd+ZFD7oe/AT8ID/2Bvo0EOri+fxiPPE5ox5pEuTX5QQhxwdVuyq4A7l0HW55ENkH6jAqSQGavsMX25mTyssid+8dJoyTQE/ExdAlL1RbUiUrRQYY7y07rzL9pJPeLKKWTkz4ZHbio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvXW7W+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EC2C4CECD;
	Wed,  4 Dec 2024 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332328;
	bh=W/y8zXZkHB6ZxAKXAe+UMRSHimjoR/7RwfdqEpMrYMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvXW7W+zgSylR/P9XrIDXCtKWEzmmT5NWD0UPj6IzY2SYzIbYbAAEvIbGvpl2Hgt7
	 W+PWqLwQIav469XCsj/2TFM2Tut3H+ddii77IvY19fH+y+nI/zdu5RjnXzRgW8br91
	 h3ZGtPeJUnnGCXLwvScnSQ6QUDvRnqreOIRTX2IhQQSFtsUu7z06V91IdJNoB/rydI
	 4XHbNo/Z/yffzLMA3/alaH+eLDpkWfBv6d2ScW4GVyL3uU3gjPDod+AWOhifANGgQc
	 glnVRQbbsTXJ8DfsaeZzbyeNvg9qCk3FdNsQsiAQP6HRxX4TwYdQ4sos7PpHDGcTIZ
	 Ld7rrGR/Jh75Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 03/13] i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
Date: Wed,  4 Dec 2024 11:00:28 -0500
Message-ID: <20241204160044.2216380-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index a918e96b21fdd..13adc58400942 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -159,10 +159,10 @@ static void hci_dma_cleanup(struct i3c_hci *hci)
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


