Return-Path: <stable+bounces-98650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043409E499C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698E91883131
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672521884F;
	Wed,  4 Dec 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQFUdar8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1C2185B5;
	Wed,  4 Dec 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355022; cv=none; b=cvdts+SCnrBfT2ToBqRIwIg+zTl8qz2q209xhpG1TxqIreH+sDPk/An5VZPGKu8HDYdGjtdOq4qvrPhV0r8rpku1nsbHKE8EnAo5tkvnM8KOdDI3KOu0aHN8Ut1Ny5pbX4jFTv4Rw3Vqni3tOvnaGCPIQ8gx40U8noNRQ18/tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355022; c=relaxed/simple;
	bh=KQ80VICwcd94Dwl6hTQkb8LdadwXJDT8zixajxy5Yxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTP1WvIdNupbqQU5Yrq0d12ENnTdwXThNi/gA8uwpTQ2C9CQrGvKn+pcZDPScdlPsNDcrHM9c1Rof8oJewUHRudnvTgewuxEntqnGVBvKAL7BSdafs89JaSCDxiu8dGJ/mXZ70EdLFgyCEE3fcxulfqwbHaHeD3yv2ax3G7s51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQFUdar8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99045C4CECD;
	Wed,  4 Dec 2024 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355020;
	bh=KQ80VICwcd94Dwl6hTQkb8LdadwXJDT8zixajxy5Yxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQFUdar8Byt+7faLVkapPhJZAtxxcUsdXzpC0YYst/lnzKlK3yRf7NIm60BCmI+HJ
	 4Lzjj4e3rF9FDurfr7X4moFTGg4ZV46UUA7ZKMkVgY6Ux0R4zR8U0+ktgRR/y6Jp/O
	 er7CLjFSNJJ/Jxs/Azswj1FIkJDPHJdiqHMDKBU+MUSpMuBNwtGFzHGYL+It8FmZMa
	 BjeoBPZ6ET5DSa3M3aUNGriXmSULO3yQJNuVTCgUZnNgPkwODMx36sMrQVFxlCLUOm
	 RoKMUdAUzHsj+g0urwaQiT9Ssyiji1DnJegLSvWiZSBHCscXe05K0X4flLLSTYybJk
	 wHkaKO0fhYgTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/8] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:18:44 -0500
Message-ID: <20241204221859.2248634-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221859.2248634-1-sashal@kernel.org>
References: <20241204221859.2248634-1-sashal@kernel.org>
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

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 548f48b66c0c5d4b9795a55f304b7298cde2a025 ]

As per USBSTS register description about UEI:

  When completion of a USB transaction results in an error condition, this
  bit is set by the Host/Device Controller. This bit is set along with the
  USBINT bit, if the TD on which the error interrupt occurred also had its
  interrupt on complete (IOC) bit set.

UI is set only when IOC set. Add checking UEI to fix miss call
isr_tr_complete_handler() when IOC have not set and transfer error happen.

Acked-by: Peter Chen <peter.chen@kernel.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20240926022906.473319-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 3af0a7ef19f61..5882c1a3e0b25 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2200,7 +2200,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


