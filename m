Return-Path: <stable+bounces-98521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237C9E4253
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABC91693AD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32282352CE;
	Wed,  4 Dec 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8HA1Zt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0982111B8;
	Wed,  4 Dec 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332403; cv=none; b=uxJd5b7sk+mCWuZGHSrYVLwmn/U/00svPTmKy37HuApr/34yfzrQejZwmxtRuBgFxho+gk8EnXbp7ue6HndTK6q1Jn2Dj55PGQdgflnbgzRWGScNibT3gLuOXK7aIL3QZSuXgV/X90/5ENseaPW5t0cbGa1bAqnf9uWrpPLYTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332403; c=relaxed/simple;
	bh=HcMhPImvTT4zfizAJqvG20GxrdA+50plVMVe8cC05KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3GF+nJEqbwj5qrt3EGcyZgwb1kfkdfUdyIvo872LJejFLu0lLTQAITIfg3YndMcjQr+L+e+IJXnM2eaWf6ANc7wSg1f8pSK86cxWK0rbdjjyb/vuemfri/cprKVxK7SgF1r5bOw4qvByYLGlm0PwBkp/oLp3OjzYryXvmAC0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8HA1Zt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD18C4CECD;
	Wed,  4 Dec 2024 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332403;
	bh=HcMhPImvTT4zfizAJqvG20GxrdA+50plVMVe8cC05KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8HA1Zt712gJo2q8XgmURCL8WJjz6Momgdrbpl9VBwyg/Xas1SWwjPcEufGuxVsxZ
	 hwasvy9mEcCV2RnObSXyAMZUm8mSudH9L8aW8h3CrcWDB/7q7OzKdEMOcAi7899dVB
	 5G3ZFEhaPA8H6TU1ex87SrRL5/mCi1HyX5STIK+dSRQcw0hewP0KuPbkLR8yB9bnxC
	 j/yS/ic8zlQlUBjzTZX3ARsKGCqBhdCIaTkg2cH+wUK9Zp/r1JaMmHNQw92miYrU4r
	 fouUkfUlSRc/UfPVji3zeY1kGB1/je/X6N9vcA1LApMD+QNzPUhIZPcM6P1W9rW6zv
	 pU2QmM4MQtZ7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 2/6] i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
Date: Wed,  4 Dec 2024 11:01:52 -0500
Message-ID: <20241204160200.2217169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160200.2217169-1-sashal@kernel.org>
References: <20241204160200.2217169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index b9b6be1864384..61a5abac50dc0 100644
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


