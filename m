Return-Path: <stable+bounces-98475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0859E41E4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813F7287481
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1CC204A03;
	Wed,  4 Dec 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJFDG2Yk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AF202C5D;
	Wed,  4 Dec 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332296; cv=none; b=d4R09dqEXpMdCo5KUhWMGrlwdiyhQsYSBqXnKjrpxZ/gIp1a2MkrK5QDBrdoiz3pHXKaS8GhSqH0gR0p9LuCliygllUk0TfNrYjeVbRlnQUuwLzl0GY7a8dFapsX38HzIEkYrJ/639zx0aDxyPrW8kmaykO+ods1Oiz0JK/TZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332296; c=relaxed/simple;
	bh=W/y8zXZkHB6ZxAKXAe+UMRSHimjoR/7RwfdqEpMrYMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFADI0VyOOfoXmUAzdGgWa2n7iZRzSRh50R6Qhba7f+wSRC5XjKIZzbHTTlVkP/yk8PygRA/XogK9+W7XsKw9BeNNiypkYk7c9QryPo0D7Sm4lTCihe0LEp8Gbj6uoaBqmUrrkoWPRJMgl/KqrT0Ty6tjh71SP6P/MLwTYYU2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJFDG2Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD4C4CECD;
	Wed,  4 Dec 2024 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332294;
	bh=W/y8zXZkHB6ZxAKXAe+UMRSHimjoR/7RwfdqEpMrYMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJFDG2YkiOjqwWF8hYSlozCkbw57pw18u5JZovElrkrtQ81J5vTCQX7tCrA7YWzoM
	 kSNIqRLH6dMbpsTBfn/SLd0EMYsbeiaUnzd5u59YQGP2Qc0pa8UFyLk7Fu3m69GCtj
	 0zL6v2jykiHuKoBG6U3I5tb/sXrqfHBBi60rdGjEBzvHvZyERIGLbuRSWMQ2ZEtQZa
	 wo1yrjwYVirb08BvGcJF2iC95mv67eFLhMBWt0Y/IoUELfUmFaWVToOsuLn/ww4mps
	 JVxnpCP2k6kr2pOW+1n64uhKSyDICK75j0xflC9iDwYeAY18DZZssv3CDcvGUXGucW
	 Ci61SMoXk8w4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 03/15] i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
Date: Wed,  4 Dec 2024 10:59:51 -0500
Message-ID: <20241204160010.2216008-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


