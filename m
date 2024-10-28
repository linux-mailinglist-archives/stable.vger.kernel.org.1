Return-Path: <stable+bounces-88263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12379B2356
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C9BB224B9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADB18785D;
	Mon, 28 Oct 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHbKlpiU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE786186E56;
	Mon, 28 Oct 2024 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084098; cv=none; b=PD7O7jP22kbIaR3EdCqnpFeQrdehPf2NJq3WkDfUAbTKow/RPyilKG/unjL63UZ9bIyyd8F6KZCtzD11RvScftoBT0BDCsUgcdErJUn2zAxHLXBugpBGe6i3yBo2VNQZ8S0CXryEQ8zmbsr3Ta+Uw2aVogKdMAwbTu11zfbbtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084098; c=relaxed/simple;
	bh=8aJ72J3uShMo3aQrLTV90CjREd5Jx3aaV+9tVdJCtZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCukwqf74N3MvrurFtOjds0QMGsvcPSStZLTsh9gZyv61ElTYS6ce0TCp2BvralMvDYKY4KZicA0X4EnmTYMIm0LKBVw3TidJVq3H6yn2i8FnxgKFFoCsxgirQe2qPNLSc3CpEgPtIBQphKu5TMNU5hmwmluusq2vre0lhKsI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHbKlpiU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so3039125a91.1;
        Sun, 27 Oct 2024 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084096; x=1730688896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSvONcZYerkXhxJYp5FBOVnq9rockH+jmTpBlMHJfrs=;
        b=BHbKlpiUhpbWUGlQZ8kXL5amtxRNL/E4fA+H4tltp0JTTnCdCjdJFJPe1kEByQrsoA
         ipxWJhtBT6p+OpB/Z6qcbef3u+qhSc+iETy7wW9lDgPTJFw4SRfY342iFR80E5gvprME
         2LTkT7tEEmAXkaYlAtRTppDl2hNwswYZVvetNEdlGxr6qN8FWx7M54QUJeMS8uH2F2qM
         Q3MJ1HEk7JCIPh0l8yrIhD7Rn2sGHxHV/HgUyHMhu/uQM6WLtjJWMMjpGLIU0DfKRnND
         RbDXGw4oua1E28WngnNTKozKNRv+dcbC3kKRFYdsXJCIgvdcxIHEw0NKfH4nBfBqQ/ha
         XHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084096; x=1730688896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSvONcZYerkXhxJYp5FBOVnq9rockH+jmTpBlMHJfrs=;
        b=d7xtbs0Mwa3MXfS0oL9EY3pPKCsGU3+3YHHjC/ek8P/AX335ktPypLuyaNktH3+vlw
         53+ZJ0wX5Cg0z4TsGWWd2EtaYT8ZL5nCZ8iC9DwS3u68ugosWSSKy/YUzPTVdLz2A796
         /PKAx/P6iYA+HwVmvqtKySH+CdiS+F9bmvLJRseF++eSLvGWRPsdACtXwrE+J/OhduYa
         cGrpCWzTgBTPmblflmN5g5gp46ZYBoGzNtJ26rHRnG0HxjlkAxfDwXUSrUdUeho+MJm/
         rz7yjOiTpj2fd/umsG2Qb7JRnm5pWPBPtslexGHeXrd6JMPkChA0SB9wLWSMRnhgz7mA
         cYvg==
X-Forwarded-Encrypted: i=1; AJvYcCU+mTDop+BO0RPG9OjLNjvBnQIMl/XAB27XxP5d3IJ1J3KwoWQN3kbZ85izFcXeN7bjbQRQ7G/Q@vger.kernel.org, AJvYcCX0SDWh2r7xZYMeSakLBNsUq4+rb27nFYJOPFJPE+BDmFm0nMkAumGQw7+DlqlPAVonpPZXInequBtzhfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSyHplG6yQjDnt3RZiwJ3SK7lFWRS5dur03xWzCEfA/pI4Xep
	Cn03OYoF9IYEf02yVoQcYhdG8DAnYt2Qfn8jYTRmbBCsRy6kokku
X-Google-Smtp-Source: AGHT+IHkvyPe2PiqNYzslfpIG+xTD3M2I/RWCiYR6TBRNnErJYy7MhV0TUPoUnGvJaQvg4J6Na+GZA==
X-Received: by 2002:a17:90a:9a86:b0:2da:8e9b:f37b with SMTP id 98e67ed59e1d1-2e8f107c738mr8471784a91.24.1730084095917;
        Sun, 27 Oct 2024 19:54:55 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:54:55 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] xhci: Don't perform Soft Retry for Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:36 +0800
Message-Id: <20241028025337.6372-5-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028025337.6372-1-ki.chiang65@gmail.com>
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
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
 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ddc9a82cceec..f2ca0b912977 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -400,6 +400,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_ETRON_HOST;
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-- 
2.25.1


