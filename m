Return-Path: <stable+bounces-102271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 408EC9EF1F1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C7D17B994
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2E2397B2;
	Thu, 12 Dec 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VtHYUyYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC2226545;
	Thu, 12 Dec 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020619; cv=none; b=G/EWoA9NfZcwuqjhPcCudDuG90XBedGe7uPiu7gCOgyH6A1UH+uuJpItBLQownxGqYn/qLRvKYtWjWj1MuRlrx+mxbGHA+yumpiLBNUZNw8vT8x+jfFrCL2gKk9mm8ZN3ExIWPW817JZACgJ8Idm8P5b9SC/85P1tBwJ7pgXJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020619; c=relaxed/simple;
	bh=fxTEgtE1eg3XJLuEPT4vuOnv+Cat7KxEkMPUBH1qjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDDYK6EqeJeMRmElCedQLo4HI8H+C7Jkj/0o7ZGCIpVixVPWtWsd/SbhVvyBbM5lHo7LYh25ZIEUp58azT6EOQNcggKWs8rBAeoeotzhVz5e2Ojq6Rr5s4fmo1+PGhFGPSlOGhoupgdkzHhRxMMrMFkB5C/AaVZ3HupvafanomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VtHYUyYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B75C4CECE;
	Thu, 12 Dec 2024 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020619;
	bh=fxTEgtE1eg3XJLuEPT4vuOnv+Cat7KxEkMPUBH1qjPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtHYUyYxtQ84oDTaUVQMIylDvr3KBCE92LHe4C3QszIo70rtPgI01z/CZhhVPtw6b
	 spogEBi3DZEb1KckNiCvClLtJ6pcmcTB/jMnhzoiAD9cHAMDCcCb7euHGy2ZokcSsh
	 5BHRUv326Jr/jSRFks4ZIChRzb5z1RFu5BCHaIKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 6.1 488/772] PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
Date: Thu, 12 Dec 2024 15:57:13 +0100
Message-ID: <20241212144410.113470043@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 5a938ed9481b0c06cb97aec45e722a80568256fd upstream.

commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
device data ("struct ks_pcie_of_data"). However it failed to set the
mode for "ti,keystone-pcie" compatible.

Since the mode defaults to "DW_PCIE_UNKNOWN_TYPE", the following error
message is displayed for the v3.65a controller:

  "INVALID device type 0"

Despite the driver probing successfully, the controller may not be
functional in the Root Complex mode of operation.

So, set the mode as Root Complex for "ti,keystone-pcie" compatible to
fix this.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Link: https://lore.kernel.org/r/20240524105714.191642-2-s-vadapalli@ti.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[kwilczynski: commit log, added tag for stable releases]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-keystone.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1105,6 +1105,7 @@ static int ks_pcie_am654_set_mode(struct
 
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
+	.mode = DW_PCIE_RC_TYPE,
 	.version = DW_PCIE_VER_365A,
 };
 



