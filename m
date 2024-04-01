Return-Path: <stable+bounces-35458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CC894406
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2ED1C21BDF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62D482CA;
	Mon,  1 Apr 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVhOOcJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D721105;
	Mon,  1 Apr 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991463; cv=none; b=tzmaZzj5dSp5BGQ/3nGiR1Po+TP762lnTPZne96UazvJECcKXj2MOsvqaRc2KpEk35mLPWt+6jK/LGSKfoCI5FFDiK87PqcRwXGaBTnBzLxJd/6pGYxg9EBcaIBCKHBr+Vq8yvPLwfzBV4EmmIHmHvW1Euftpyl4w4NnVbBugjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991463; c=relaxed/simple;
	bh=QvF4Xb8JlxusVGcv4NEWpqWPjc23fSGqghXbcx+xhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIHdgSzp1pNBPZcQfWC6zDGRzoUtc8GjN58Xz7AEWFWasB3phSCObsgiRFQ0Mp4NV/0wSVAP5i7yO+KxNXfNVKx8PyRy+O6rVpvve2ZVa1rvFH/H/P8sj0B9w4cBmq5uFK9xcvLAvYCyWuLGopssEFu5k25grw3IN7+eUOROjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVhOOcJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59160C433F1;
	Mon,  1 Apr 2024 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991462;
	bh=QvF4Xb8JlxusVGcv4NEWpqWPjc23fSGqghXbcx+xhgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVhOOcJLR24SPieLdSYkJAhc2xSMcL84Dd9UTtfL9ztj/ZRdvgQk6KQydhy7h7ydM
	 a5mKiiadAPeBrCP1uv+KS3GjM7Vp+tqJPXDT8HH8OSiO2E8tSMHxLsmA0DxRQW4Zmm
	 1No1O78uP/+nzy/blpRjwYZ+pAepeomL4p56ZnPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: [PATCH 6.1 244/272] usb: dwc2: host: Fix hibernation flow
Date: Mon,  1 Apr 2024 17:47:14 +0200
Message-ID: <20240401152538.602973337@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

commit 3c7b9856a82227db01a20171d2e24c7ce305d59b upstream.

Added to backup/restore registers HFLBADDR, HCCHARi, HCSPLTi,
HCTSIZi, HCDMAi and HCDMABi.

Fixes: 58e52ff6a6c3 ("usb: dwc2: Move register save and restore functions")
Fixes: d17ee77b3044 ("usb: dwc2: add controller hibernation support")
CC: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Link: https://lore.kernel.org/r/c2d10ee6098b9b009a8e94191e046004747d3bdd.1708945444.git.Minas.Harutyunyan@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.h |   12 ++++++++++++
 drivers/usb/dwc2/hcd.c  |   18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -729,8 +729,14 @@ struct dwc2_dregs_backup {
  * struct dwc2_hregs_backup - Holds host registers state before
  * entering partial power down
  * @hcfg:		Backup of HCFG register
+ * @hflbaddr:		Backup of HFLBADDR register
  * @haintmsk:		Backup of HAINTMSK register
+ * @hcchar:		Backup of HCCHAR register
+ * @hcsplt:		Backup of HCSPLT register
  * @hcintmsk:		Backup of HCINTMSK register
+ * @hctsiz:		Backup of HCTSIZ register
+ * @hdma:		Backup of HCDMA register
+ * @hcdmab:		Backup of HCDMAB register
  * @hprt0:		Backup of HPTR0 register
  * @hfir:		Backup of HFIR register
  * @hptxfsiz:		Backup of HPTXFSIZ register
@@ -738,8 +744,14 @@ struct dwc2_dregs_backup {
  */
 struct dwc2_hregs_backup {
 	u32 hcfg;
+	u32 hflbaddr;
 	u32 haintmsk;
+	u32 hcchar[MAX_EPS_CHANNELS];
+	u32 hcsplt[MAX_EPS_CHANNELS];
 	u32 hcintmsk[MAX_EPS_CHANNELS];
+	u32 hctsiz[MAX_EPS_CHANNELS];
+	u32 hcidma[MAX_EPS_CHANNELS];
+	u32 hcidmab[MAX_EPS_CHANNELS];
 	u32 hprt0;
 	u32 hfir;
 	u32 hptxfsiz;
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5406,9 +5406,16 @@ int dwc2_backup_host_registers(struct dw
 	/* Backup Host regs */
 	hr = &hsotg->hr_backup;
 	hr->hcfg = dwc2_readl(hsotg, HCFG);
+	hr->hflbaddr = dwc2_readl(hsotg, HFLBADDR);
 	hr->haintmsk = dwc2_readl(hsotg, HAINTMSK);
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		hr->hcchar[i] = dwc2_readl(hsotg, HCCHAR(i));
+		hr->hcsplt[i] = dwc2_readl(hsotg, HCSPLT(i));
 		hr->hcintmsk[i] = dwc2_readl(hsotg, HCINTMSK(i));
+		hr->hctsiz[i] = dwc2_readl(hsotg, HCTSIZ(i));
+		hr->hcidma[i] = dwc2_readl(hsotg, HCDMA(i));
+		hr->hcidmab[i] = dwc2_readl(hsotg, HCDMAB(i));
+	}
 
 	hr->hprt0 = dwc2_read_hprt0(hsotg);
 	hr->hfir = dwc2_readl(hsotg, HFIR);
@@ -5442,10 +5449,17 @@ int dwc2_restore_host_registers(struct d
 	hr->valid = false;
 
 	dwc2_writel(hsotg, hr->hcfg, HCFG);
+	dwc2_writel(hsotg, hr->hflbaddr, HFLBADDR);
 	dwc2_writel(hsotg, hr->haintmsk, HAINTMSK);
 
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		dwc2_writel(hsotg, hr->hcchar[i], HCCHAR(i));
+		dwc2_writel(hsotg, hr->hcsplt[i], HCSPLT(i));
 		dwc2_writel(hsotg, hr->hcintmsk[i], HCINTMSK(i));
+		dwc2_writel(hsotg, hr->hctsiz[i], HCTSIZ(i));
+		dwc2_writel(hsotg, hr->hcidma[i], HCDMA(i));
+		dwc2_writel(hsotg, hr->hcidmab[i], HCDMAB(i));
+	}
 
 	dwc2_writel(hsotg, hr->hprt0, HPRT0);
 	dwc2_writel(hsotg, hr->hfir, HFIR);



