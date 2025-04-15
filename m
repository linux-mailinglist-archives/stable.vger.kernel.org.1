Return-Path: <stable+bounces-132732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B531EA89CAB
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951BA3B7AC3
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF8291169;
	Tue, 15 Apr 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="DgubTRi2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAB28E61D
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717222; cv=none; b=lfQpVq9Ifmw1I10t54DL0F/nqfi8//aIUAwRIF+au8t9sih5FG0EQcLHkGIZxmMl+14vNE7ickdMG1pE1J5eZpSizVZS7j6gcY11VABuEKCnCRh89MWb6yCL/tMkiCMVCSeMs73z5VKz27Ji4nXb4F/AHPTK+f9Z5YymufkpPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717222; c=relaxed/simple;
	bh=O/rT8+I9mTT1hvtVqcKe/fjxb+s+XOn8MkeEF7/UclI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkrEOOgz0Afw6JNUuUVonLNQqAsraB7nBAQ5wohCo73wg31B2z5QTYMynEKs1uOZ9mQWZ/JBZWyRjcqViEh4uOqS0AJSdH6P7rsm7OtkpkICzLLA1hAT81z4B68/OV/Zs7e0aHJUqWm4XPiUIWEiMJ1KbkYEcvph8uUL65Npqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=DgubTRi2; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-227aaa82fafso42845285ad.2
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744717217; x=1745322017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aev0NKrAlcg9mgeOUSYkPy9/PBVFtBme5rActlatexo=;
        b=DgubTRi2CjCvf/OMQDWR4F1rIUepe1UIQy+Zlzzp2g4KtxOmIFwFaNeY0NI9Zbmk84
         8EFyscGNfQFUrAzopoDrgOSp8yQaq1d2dQ17ELMow8wrmu00TpJV2CQcUGl0A1Ulqfnj
         53SsiIaJV/zQIPou88ZvjxO3rGa6DMbpD+Qqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744717217; x=1745322017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aev0NKrAlcg9mgeOUSYkPy9/PBVFtBme5rActlatexo=;
        b=j9l1dxNJOmmeeB4owGfvFKXzCnkdlPk8WAj8CP/fWWH1YTw1vvRj5ATPx+lt9jSKun
         tFLqa7zz5qF7Sru/eT8RUIbeHdQd6EnMZ3u7nJzXXGnVm+J0oxwhMBdCnoxZQ2ppqUN2
         UaeEwJj/FR8UGl5osOIBq29dz+MJ6nNYrvoeKKE6kAa/iEIzXlIN8GSb1vMtwyij0THT
         iID0ip/w70OjZtFWo7asEL7wfGcOWkFunwkk9YJdLYbDJtgmnmgQyaenJrjKqjTHoc4b
         5Qz7Yc6PMmxqQYzeIYBj5qccurQhWf6guc9iHcQ7FX2uwOPFieTxiYlbRa7LFExWvy/I
         oEPw==
X-Gm-Message-State: AOJu0YyJnbfj8flmzpEI76BB55IWJ5MvO9dL/d8mzC4233OrKdpKnLk2
	Ebrkpq9TkdZwKU+ayy+zEo9JYcJBgUv6jcjonqbhE4AZflOCzBlvgnnf3uDTajlXXndbukYuJp8
	UtrCS/mn+
X-Gm-Gg: ASbGnctK2D/y38nnMKpR9z8Dda47sHBay7d24IlJahvAJdujGvzoKs9YqPMclJTMNmI
	azoLzNlWGJL/J2Ug3vCjgs0/ejdgdqPCzyx1AkYAONICqpCEhDjjxp0IG4KMkOpEtQ27ENnYi3V
	Er0NpHjxFWhu051lgsUx1YoylfKVdimjOvOiFzzbRrLP1ToOxCueI+52w+Ki3tj2UG4HTYw0Ps9
	bGK7LRt+wTsfKAcCRyH7DUtAGgYOQWlMIImwogNiYwIbLiiZ0Xa2t2IO359VtMVkFLk7Ss8cy29
	ki6nnC07aZl1Ss6dXbstJTh3y1cMv0OO8fOiVym2HId3RjsLQlku/Npn
X-Google-Smtp-Source: AGHT+IH7crPf+qwLzPI4w3eOrxW6iChDBV2CDgTRlXrgZfjm8Atec9trgc/njYSLmtbuVdbEstoRxQ==
X-Received: by 2002:a17:902:f54f:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22bea4fddfamr188923395ad.49.1744717217403;
        Tue, 15 Apr 2025 04:40:17 -0700 (PDT)
Received: from testing.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df07dcfasm14299971a91.14.2025.04.15.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:40:17 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	Yu Chen <chenyu56@huawei.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ferry Toth <fntoth@gmail.com>,
	Wesley Cheng <wcheng@codeaurora.org>,
	John Stultz <john.stultz@linaro.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Hardik Gohil <hgohil@mvista.com>
Subject: [PATCH v5.4.y] usb: dwc3: core: Do core softreset when switch mode
Date: Tue, 15 Apr 2025 11:39:52 +0000
Message-Id: <20250415113952.1847695-1-hgohil@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Chen <chenyu56@huawei.com>

commit f88359e1588b85cf0e8209ab7d6620085f3441d9 upstream.

From: John Stultz <john.stultz@linaro.org>

According to the programming guide, to switch mode for DRD controller,
the driver needs to do the following.

To switch from device to host:
1. Reset controller with GCTL.CoreSoftReset
2. Set GCTL.PrtCapDir(host mode)
3. Reset the host with USBCMD.HCRESET
4. Then follow up with the initializing host registers sequence

To switch from host to device:
1. Reset controller with GCTL.CoreSoftReset
2. Set GCTL.PrtCapDir(device mode)
3. Reset the device with DCTL.CSftRst
4. Then follow up with the initializing registers sequence

Currently we're missing step 1) to do GCTL.CoreSoftReset and step 3) of
switching from host to device. John Stult reported a lockup issue seen
with HiKey960 platform without these steps[1]. Similar issue is observed
with Ferry's testing platform[2].

So, apply the required steps along with some fixes to Yu Chen's and John
Stultz's version. The main fixes to their versions are the missing wait
for clocks synchronization before clearing GCTL.CoreSoftReset and only
apply DCTL.CSftRst when switching from host to device.

[1] https://lore.kernel.org/linux-usb/20210108015115.27920-1-john.stultz@linaro.org/
[2] https://lore.kernel.org/linux-usb/0ba7a6ba-e6a7-9cd4-0695-64fc927e01f1@gmail.com/

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ferry Toth <fntoth@gmail.com>
Cc: Wesley Cheng <wcheng@codeaurora.org>
Cc: <stable@vger.kernel.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Wesley Cheng <wcheng@codeaurora.org>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/374440f8dcd4f06c02c2caf4b1efde86774e02d9.1618521663.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
this fix is missing in v5.4.y stable version

apply the following dependend patch before applying this patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.236&id=c2cd3452d5f8b66d49a73138fba5baadd5b489bd

 drivers/usb/dwc3/core.c | 25 +++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1a420c00d6ca..650eb4f735f9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -122,6 +122,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	mutex_lock(&dwc->mutex);
+
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
@@ -155,6 +157,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	/* For DRD host or device mode only */
+	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg |= DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+		/*
+		 * Wait for internal clocks to synchronized. DWC_usb31 and
+		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
+		 * keep it consistent across different IPs, let's wait up to
+		 * 100ms before clearing GCTL.CORESOFTRESET.
+		 */
+		msleep(100);
+
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg &= ~DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
@@ -179,6 +200,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_core_soft_reset(dwc);
+
 		dwc3_event_buffers_setup(dwc);
 
 		if (dwc->usb2_phy)
@@ -201,6 +224,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 out:
 	pm_runtime_mark_last_busy(dwc->dev);
 	pm_runtime_put_autosuspend(dwc->dev);
+	mutex_unlock(&dwc->mutex);
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -1511,6 +1535,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_cache_hwparams(dwc);
 
 	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
 
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 34f3fbba391b..44b0239676a1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
@@ -929,6 +930,7 @@ struct dwc3_scratchpad_array {
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
+ * @mutex: for mode switching
  * @dev: pointer to our struct device
  * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
@@ -1061,6 +1063,9 @@ struct dwc3 {
 	/* device lock */
 	spinlock_t		lock;
 
+	/* mode switching lock */
+	struct mutex		mutex;
+
 	struct device		*dev;
 	struct device		*sysdev;
 
-- 
2.25.1


