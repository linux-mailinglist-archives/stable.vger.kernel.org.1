Return-Path: <stable+bounces-34339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF5893EEE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C8E1F21256
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602B47A6A;
	Mon,  1 Apr 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iS538/PB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F54778E;
	Mon,  1 Apr 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987787; cv=none; b=CswBc1QnYKvYlnG+brIx1rpq0AObaoLKf9LOhTmBINYw2GiC6b9766EKWQ6fkMotG3CNxE5djBFK0OHuKfmtze1jqpm3OJCgq6F3L/ShjUH7SRpi6FQ2jd90b/jxZVGvDR2yHqOlWAnAHVhFXOASisIBHkhzc/GLXn0zIMcjkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987787; c=relaxed/simple;
	bh=JKJnSumkDFDy/aGA8c/iMFzXcKyB/2vy85UGfC+IGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKwlV2nIjBePg9decb7BtEWIcDqkN4ZhcLB3u4m9FHNuX05Hj3p2fbmpiUpZTbXIDb4DN06m8BEiHqxzVAyLh1EF7KO+fjPAUkmQvGiXn/9rT+C3/cCpmD2q2Zp6kanLmxekZqWEnAlfHYDcWXffMsrzhOR4e7KclpbBxwea+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iS538/PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF4AC43390;
	Mon,  1 Apr 2024 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987787;
	bh=JKJnSumkDFDy/aGA8c/iMFzXcKyB/2vy85UGfC+IGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iS538/PBPFjhvbFn2fdK3AIwvzxUzAjk0DO/wO+WInYf41MOP8/oAkHqSpOsbLReN
	 eTFQTnKrbOLhOwDS70rpDYrDY7HIQTT/YZta/cSEo1sWJr2ikzLNJpv7OSHVazv+8Z
	 8Zyp2GcCWmpHfWQmrAyaSi1Q89wkyIZXmMtOhBso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: [PATCH 6.8 362/399] usb: dwc2: host: Fix hibernation flow
Date: Mon,  1 Apr 2024 17:45:28 +0200
Message-ID: <20240401152559.973316281@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

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



