Return-Path: <stable+bounces-88334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658A9B257A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD6A1F21B85
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEB18E05D;
	Mon, 28 Oct 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVlhiUrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BC152E1C;
	Mon, 28 Oct 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096963; cv=none; b=LGcJh1hKAvPZgYd0R65Ip20CCviRRJuzHZMi9bDCHkJ1xPtE2i1TTXY+L9yDqMihQ6z/4+SZlPw4Zb4RHgz963xXJxCVXnp7Rzu7qD633G7LnK2luzN0lQM4Du9zwCwyF80kxXvgOQID7wpABYcjBFZaqSd1fMcP171BlEcpljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096963; c=relaxed/simple;
	bh=uLQ8O0RdILf9HWh2BB0oORmMRSA/bXAmZWYrLqQjRcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/pID6BL1fZf7dTZWHCegrN204yZqJeHoLBjBqvxiSvwE1bRXzhCJUc7NcJaE8xdcnsgEsDVnTneDvIQE0S7aaf+4QsVSb55ViU9hMx1U973ZzzD0kxoX5Bs+fMrEdAzB8k5Zc2xCzxyj0DSQV17FcDcM0Ve/rKlA4iJ7dcUkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVlhiUrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AFCC4CEC3;
	Mon, 28 Oct 2024 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096963;
	bh=uLQ8O0RdILf9HWh2BB0oORmMRSA/bXAmZWYrLqQjRcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVlhiUrT5EsOnRGN5UZ11j6GcPvYEwqOBsnk6/DyvG6Mz4171aDxnfO6keetEGP3v
	 A8MhT4oMp2MTnlXD4n7o4rMuTZFKDEOFQwIXwcIIk8xX+z9+kl+IzO5CLHSVnOTGb4
	 cJ7s5WY+LCjSERbDj9CabtVhgdppZQvYGWZqyEGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Atlas Yu <atlas.yu@canonical.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 62/80] r8169: avoid unsolicited interrupts
Date: Mon, 28 Oct 2024 07:25:42 +0100
Message-ID: <20241028062254.337333751@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 10ce0db787004875f4dba068ea952207d1d8abeb ]

It was reported that after resume from suspend a PCI error is logged
and connectivity is broken. Error message is:
PCI error (cmd = 0x0407, status_errs = 0x0000)
The message seems to be a red herring as none of the error bits is set,
and the PCI command register value also is normal. Exception handling
for a PCI error includes a chip reset what apparently brakes connectivity
here. The interrupt status bit triggering the PCI error handling isn't
actually used on PCIe chip versions, so it's not clear why this bit is
set by the chip. Fix this by ignoring this bit on PCIe chip versions.

Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
Tested-by: Atlas Yu <atlas.yu@canonical.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7ce11c9529c58..8e910f3349b2a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4627,7 +4627,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
 
-	if (unlikely(status & SYSErr)) {
+	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
+	if (unlikely(status & SYSErr &&
+	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
 		rtl8169_pcierr_interrupt(tp->dev);
 		goto out;
 	}
-- 
2.43.0




