Return-Path: <stable+bounces-187493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5600BEA4AC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB90C1887E25
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E9322C88;
	Fri, 17 Oct 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSFmCvGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9E2D6E40;
	Fri, 17 Oct 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716230; cv=none; b=X/4o1tS1Ha5Y6I74Q+M1SZN4ieFSECZUl5vuocX9EO7P3YZucTG9epUAxdETRS3EHpgwZU4T4LgzMIVqF1+YC+qxEfXa1Z1y/az1RUBnDRkJ2iE6mIlRpjxKUXM+UqSWg98A6SabjtaltZaM9fpvPQgJHmCo03rEsuNkoPCJI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716230; c=relaxed/simple;
	bh=yGXoHX4Hg7kdxVJrmWm2WaIqovPeQqtYxJFrzsAiZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyTjqedp6iYuHCeFjuYuXjscwqEw2SqN0V0UVAOkBFut6hg0yg+McI7hcXRf+px9QzNZrtqxm65ycDH+9RJFFIRCBH3+cs8xDnv4vx1IzcAI2azIUFL2mDLrpXyj01Vu3cl2htNybh61pV1pq+UeEWlPpW0754guVoVCRxcdQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSFmCvGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B1C113D0;
	Fri, 17 Oct 2025 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716230;
	bh=yGXoHX4Hg7kdxVJrmWm2WaIqovPeQqtYxJFrzsAiZHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSFmCvGmdkmcqYxQT/nBnVkJtnhrZA2IbaXGaF4pUT2BS/G/qSCzP9fSOXTYCv/yp
	 umw5Q1I2XxBSI3un1BkyYhndUE6ztZFwOGk65s53C5zgHO4XRbWDos9HWEW/gCf0XF
	 OmQ1QwmwmrFJ9zHy0VZMtyqakhFCIIoUUnHQ54nk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 5.15 119/276] usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call
Date: Fri, 17 Oct 2025 16:53:32 +0200
Message-ID: <20251017145146.822069265@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Miaoqian Lin <linmq006@gmail.com>

commit e9c206324eeb213957a567a9d066bdeb355c7491 upstream.

The cdnsp-pci driver uses pcim_enable_device() to enable a PCI device,
which means the device will be automatically disabled on driver detach
through the managed device framework. The manual pci_disable_device()
call in the error path is therefore redundant.

Found via static anlaysis and this is similar to commit 99ca0b57e49f
("thermal: intel: int340x: processor: Fix warning during module unload").

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20250903141613.2535472-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-pci.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -90,7 +90,7 @@ static int cdnsp_pci_probe(struct pci_de
 		cdnsp = kzalloc(sizeof(*cdnsp), GFP_KERNEL);
 		if (!cdnsp) {
 			ret = -ENOMEM;
-			goto disable_pci;
+			goto put_pci;
 		}
 	}
 
@@ -173,9 +173,6 @@ free_cdnsp:
 	if (!pci_is_enabled(func))
 		kfree(cdnsp);
 
-disable_pci:
-	pci_disable_device(pdev);
-
 put_pci:
 	pci_dev_put(func);
 



