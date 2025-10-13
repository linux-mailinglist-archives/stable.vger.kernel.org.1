Return-Path: <stable+bounces-184821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EA1BD4773
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81424F8BB1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47376270576;
	Mon, 13 Oct 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r77Mb5Xz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259620125F;
	Mon, 13 Oct 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368532; cv=none; b=EtkgD/K6p254KJmgKhmn4jskB1CfJQ/HwW4sBErZVjL/6Xl/W94TuunW6y5JcPswmMOyha8VyW2MMfSzjzL+poKgIyuOQX9mC8X/GZOqXkoJTqgSYP+6Scg3I0CzwfTZNOKK4S+t4RA8SEXuVReEreAhEBcCenBaVIcZ8b8tbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368532; c=relaxed/simple;
	bh=3+NTBIOuvwdH/mvT3CJ4EzgaLM0SnYvw/bdMmhdqNos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH2uW+XkBLROGCMmRgGAtz5BafqB9WWINgEVDOGx0bNrf+z9W7yjzwomOYIJ14cCnIJqx+j32tAinD1id525kINuJzxAmPtIHhzwk6rMjbNxCY/MJFS5JJLjEVYxWHqTAD/cAgr8kjKI65A7hE3g/ei4cz1PY/nBvIzbwrZ1YZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r77Mb5Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E733C116D0;
	Mon, 13 Oct 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368531;
	bh=3+NTBIOuvwdH/mvT3CJ4EzgaLM0SnYvw/bdMmhdqNos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r77Mb5Xzn/Npg2zuilAqPBaHNyHASeJuGvTjVZjGCqkMl7EmsKd4pOcKBDW/Z2zyg
	 Ep3CHxN0Nsdewhh0Y+TQuX9auunYYtnTGyThDOwe4pnRfiu3eGH8bA2shmQtC2uwh4
	 lA7IyUG8eQ9KGwOMTS9rPIQbRnXivUwdj55dQrvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 194/262] PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
Date: Mon, 13 Oct 2025 16:45:36 +0200
Message-ID: <20251013144333.235359755@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 8795b70581770657cd5ead3c965348f05242580f ]

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
domain, after reset has been asserted by writing a matching reset bit into
register SRCR, it is mandatory to wait 1ms.

Because it is the controller driver which can determine whether or not the
controller is in HSC domain based on its compatible string, add the missing
delay in the controller driver.

This 1ms delay is documented on R-Car V4H and V4M; it is currently unclear
whether S4 is affected as well. This patch does apply the extra delay on
R-Car S4 as well.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[mani: added the missing r-b tag from Krzysztof]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Link: https://patch.msgid.link/20250919134644.208098-1-marek.vasut+renesas@mailbox.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5d77a01648606..5382008e366ec 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -182,8 +182,17 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+		/*
+		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
+		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
+		 * indicates that for peripherals in HSC domain, after
+		 * reset has been asserted by writing a matching reset bit
+		 * into register SRCR, it is mandatory to wait 1ms.
+		 */
+		fsleep(1000);
+	}
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
-- 
2.51.0




