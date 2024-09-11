Return-Path: <stable+bounces-75784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB79749A3
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85271B24D77
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 05:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629453E15;
	Wed, 11 Sep 2024 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYTfSlI2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9945464B;
	Wed, 11 Sep 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031887; cv=none; b=PumyrNRbM2EmhWdim1O9SHFeiJNsHwnAGYEQ3f9KeYcjP8FjeD00ouYC3P11StnLXsCI0Uf3vrvCiPSOsL+gRlkQa6jkEnrGIP1wzhsl59k4alcww5MAD3iD7nITRw2SCtaQrH6AL95LDfbrVcojA1+rfGpymFjo3r6DVw5Hifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031887; c=relaxed/simple;
	bh=HIl6FUMwsId7NWuqsLQb6qLx/lhvSz/FK61If7SUvoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBsGQLEQjFTbg6+nEhsPy41Auj2kDOOaX/oOGmkWqJQCIB1wj4832TVupokrwbo9edG1pDoOljAIGYD1ORPQ6MaWz1Mmp2l1ELKv7+ory+9wvko8cjRgag2CDnlLa6IZhvq928iP5xro1O3yUU5YWinIsWJbqQP1vDwKVd9KtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYTfSlI2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc47abc040so55830875ad.0;
        Tue, 10 Sep 2024 22:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031886; x=1726636686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPFFkBUH1KUQvGTAkddgh3AbnGWF386sDPxW9jKCyYA=;
        b=jYTfSlI2MpNebT2QE+MWXan2aR/VWtRcTdYgENU0JFp/jI5FokAkMjDySER5csvtPO
         z8139cwSSR9CF2HcqKXg0dtqKetZFTxEYvpFgVSt69/7rs32ghvhxosazCMGeFNuTAwR
         6uSQjmjtvsPtDt5fHnL+ktj1udMuutuX/tQvNP1xo0JtXOFJAd4bgl6ZG+la2POpYobN
         +3EsJTVbZrBgEbeic0EZ0VLElDiFMVUu2v1BVG7tUlCbgyJdBBRKUSnZfz008TxT6NVc
         2SBXs0pf26DEYJqNBRb6m6jSUnv/7RkTvXX5lTk9yCk0o/5Q6N8oRU3tX55GR6ZTgydp
         2XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031886; x=1726636686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPFFkBUH1KUQvGTAkddgh3AbnGWF386sDPxW9jKCyYA=;
        b=GuG8yjQhHejNTzLjkrigCSzBD7ZW1xJ6X7+JULZLIozZlIbbxIl2q5ghMc/122+nOO
         rF+xX0Ec8dZQnAo72ZO770HciYMEJKLDdB58UsVHzjCYp6zSkWxoZ7+0jwDDhtxJlIBf
         QnrZ+S82nD1ShFlC+LGBcAWDeaBK3BVaIzPAx31mTXixTUP5XndxR1GaYjIwvkhRmCnF
         Qkp4Z+sz4fBrmOJq50QPbZeqxpJgU2CQsAwrGoAcXh1rNwxdhBb6wYWwHeBN1PNt3+7t
         sz9NjNxJK/LmFYCQweDqQu0p93nlfWeQ6KspEzjqfZGoTrErQ+mlS1j63l23O/ZriRyQ
         r5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVn2CogJsO7a+SkEipabkU3/tWMIR22jjsCpKRycdujodOJsUk0CHe8lLc/xrnabWXGKbNtibPe@vger.kernel.org, AJvYcCXffJwqqKVIWFyqqvQ1OZ9j+tf2Lipxcuy5IN8UtafNtw88ILohUcGXSM+xA78kfBdM3OazD2B0c/9QvJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6JmSNUYsp+Gwvuitju//LpaZPmlJ6CAC2CuhQCII0RWNYokv
	blg/WK2I3ZLLv1UQUnslLysJunEJLPxzHNeu7NmCM2tLQbpgEsOE
X-Google-Smtp-Source: AGHT+IFIs42BaBHr5f6zXfAUHBDW+oglVKQHTCBImU/2pgw3MkM8yZdGXBV6oGVZLrxZQGsXtn/WcA==
X-Received: by 2002:a17:903:247:b0:207:c38:9fd7 with SMTP id d9443c01a7336-2074c5f13f8mr38917615ad.22.1726031885488;
        Tue, 10 Sep 2024 22:18:05 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10eb4sm56252735ad.7.2024.09.10.22.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:18:04 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 3/3] xhci: Don't perform Soft Retry for Etron xHCI host
Date: Wed, 11 Sep 2024 13:17:13 +0800
Message-Id: <20240911051716.6572-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f8f80be501aa ("xhci: Use soft retry to recover faster from
transaction errors"), unplugging USB device while enumeration results in
errors like this:

[ 364.855321] xhci_hcd 0000:0b:00.0: ERROR Transfer event for disabled endpoint slot 5 ep 2
[ 364.864622] xhci_hcd 0000:0b:00.0: @0000002167656d70 67f03000 00000021 0c000000 05038001
[ 374.934793] xhci_hcd 0000:0b:00.0: Abort failed to stop command ring: -110
[ 374.958793] xhci_hcd 0000:0b:00.0: xHCI host controller not responding, assume dead
[ 374.967590] xhci_hcd 0000:0b:00.0: HC died; cleaning up
[ 374.973984] xhci_hcd 0000:0b:00.0: Timeout while waiting for configure endpoint command

Seems that Etorn xHCI host can not perform Soft Retry correctly, apply
XHCI_NO_SOFT_RETRY quirk to disable Soft Retry and then issue is gone.

This patch depends on commit a4a251f8c235 ("usb: xhci: do not perform
Soft Retry for some xHCI hosts").

Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dda873f3fee7..19f120ed8dd3 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -399,6 +399,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 		xhci->quirks |= XHCI_NO_RESET_DEVICE;
 		xhci->quirks |= XHCI_NO_BREAK_CTRL_TD;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
@@ -406,6 +407,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 		xhci->quirks |= XHCI_NO_RESET_DEVICE;
 		xhci->quirks |= XHCI_NO_BREAK_CTRL_TD;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-- 
2.25.1


