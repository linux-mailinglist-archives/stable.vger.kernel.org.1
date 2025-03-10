Return-Path: <stable+bounces-122327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A39A59F07
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0D16FDC8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC0231A51;
	Mon, 10 Mar 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KvSS1VdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D622D7A6;
	Mon, 10 Mar 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628182; cv=none; b=rs9L5Omos5b4uIsT/lUhgleI3neW8eumbKNfiRh4NRO967vzSC9fBeINEnANElG4jDr6sDUTGbL+onnAvwG6ahlzj7WeSefptruVfgQ1h2ZcfUtMuejPUAkvCL/EoCwwTYNegpPGbhCk+MOWnuzm9Vw8skPejxoB4HfyVpwt67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628182; c=relaxed/simple;
	bh=Bnym0fn8b5tARkFELdWXKcZEfTt60hGt4sFD46zS5fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLCb026BIQ6RzKWvh5p13TIHQVLOnIZ91OCSHFr9aF/NWwBsZUJ1lnYeghrqQmW3YYYiAhUMoaFSlimEFRUNB1rQy9s/IX4HjWcsDq9o3hcTWRrMgHdt9e2bKh85JHmchQePnIy2bl6MzvN6Yrcsyvu9votr2BUwShiZ1wfA+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KvSS1VdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F269C4CEE5;
	Mon, 10 Mar 2025 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628181;
	bh=Bnym0fn8b5tARkFELdWXKcZEfTt60hGt4sFD46zS5fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvSS1VdJQk/El3v5Ai+PB3dkn8hldTYgxM2tZ/Z69tfRAjx/os1a6o68WcDE3Q5eE
	 l7raJSs0+6W4Ki/7Zfp5mWOZwPetXiOjj0ywdPMdk+h5Cv1Xg3WhQMd0RTFh022pXW
	 E7/jp8aG0LsIEafkNvShEPyTGISGyDLh8H76QQ7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 6.6 116/145] intel_th: pci: Add Panther Lake-H support
Date: Mon, 10 Mar 2025 18:06:50 +0100
Message-ID: <20250310170439.441876775@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit a70034d6c0d5f3cdee40bb00a578e17fd2ebe426 upstream.

Add support for the Trace Hub in Panther Lake-H.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20250211185017.1759193-5-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -335,6 +335,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Panther Lake-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe324),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



