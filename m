Return-Path: <stable+bounces-97135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D09E22A1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7D2856D0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44891F754A;
	Tue,  3 Dec 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8cAGWLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD81E3DED;
	Tue,  3 Dec 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239620; cv=none; b=TKZLSfBGtWBO11oKDzL4ISfoZFLH5RUX3oHnJI1WTqY8w2/XV17uE2qzP1IBp7d9+fPVCrCcAXxRwv6+PDtdeWKTrbvT5wdlCAYSmZkeD6OJKWt/brzftwIo9DaYVnjQCCqZqkmg17dmjD3U/HjxQUmD9W5IJnZVhs9AQBf7qPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239620; c=relaxed/simple;
	bh=oM57isJKgwn6LDLeWJPM+YMVegMtFEpcseXAIZvrZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VakXPEYFkMFVClcRg+Elb+cyVz1N3xP7X6aYQi7K8mFpiWE5cF8B77nRGg65o7BH8Zd1rCP8m/FgGWdc+rdIiA0zGS2DO4xWBnlxIV6eYsdMz4beQro2etQaFDjLpjG9Vf2vSd5AQCX7amvjT8vtNvmeWxMEKIaFkFtND+XYlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8cAGWLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1CFC4CED6;
	Tue,  3 Dec 2024 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239620;
	bh=oM57isJKgwn6LDLeWJPM+YMVegMtFEpcseXAIZvrZxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8cAGWLYCwOQ2iiOZjIjCWMtTwuyJoaTlt+xTY4IaAvsKLyxOkTVZyX2RyC7zMymI
	 cV4JARMXHdxR6X46CZ1iYpcqsNXfIHHP13+AtjhC3Agorex3egRu+5a3rO88z6xdr5
	 KCAhScSDc+YWUtKdq9KRBMWSBRmoU9bEQRVOL8JU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuangyi Chiang <ki.chiang65@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.11 675/817] xhci: Dont perform Soft Retry for Etron xHCI host
Date: Tue,  3 Dec 2024 15:44:07 +0100
Message-ID: <20241203144022.306403716@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuangyi Chiang <ki.chiang65@gmail.com>

commit e735e957f2b9cfe4be486e0304732ec36928591f upstream.

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
Cc: stable@vger.kernel.org
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-21-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -405,6 +405,7 @@ static void xhci_pci_quirks(struct devic
 	     pdev->device == PCI_DEVICE_ID_EJ188)) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&



