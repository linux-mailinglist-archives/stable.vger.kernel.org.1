Return-Path: <stable+bounces-57344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB4925C21
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB68D1F210E2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA117B423;
	Wed,  3 Jul 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOEsK5Vm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254717B40E;
	Wed,  3 Jul 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004596; cv=none; b=kOwTHPQOUXrAvHk4YtM8jmfdcn37yjEt7JG/7A61ueMG68WIgTLx+a9z6EQLpxKDzPUa8msqCIlgMJSQnKF/v8L2orFx8l9O8ACh2epHuEHmLGiZOaG6n9lHVBAPqqEB8SQMXNRc6QiPIzs9u6aQMhl/GrG7Di89BSx2XEPa96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004596; c=relaxed/simple;
	bh=qvMg7vcZjMX3HnFj0HqONEmUq6RSsZXYcD+2+EGNebI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1QU1hu+A0ZcKjnUa9bQdIoanV8sJLkXxR2HWiCeKIYeKaNhqVArh//sszpaGXMtFiw4pT7/DgzQ1rs1qFOkk/SbSgGp6J8qp7ZEnZvF0MLanOZ07rtJplKMSoq0q2MN1m0a/PllsPE/D1vJgQ+wFg3iooYN+CCGSF8SszU5T1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOEsK5Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A9C2BD10;
	Wed,  3 Jul 2024 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004596;
	bh=qvMg7vcZjMX3HnFj0HqONEmUq6RSsZXYcD+2+EGNebI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOEsK5VmMCHYezfC/RTwP7RcBG+5wIb+9Hf7ldNA2dPxtQ8Bd4SqQXNrioWg8HxGi
	 pBZ2D1ZCNa2BhQAJvSrHzIgweVlexVuHkES8V3b0e4BC6n4WIksKAcDhDDxzef+Uiv
	 ukRV6a7t8rFYLAJsjwsoA6zhQc0CrDUyJHzoFILw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 5.10 087/290] intel_th: pci: Add Granite Rapids support
Date: Wed,  3 Jul 2024 12:37:48 +0200
Message-ID: <20240703102907.479924735@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit e44937889bdf4ecd1f0c25762b7226406b9b7a69 upstream.

Add support for the Trace Hub in Granite Rapids.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20240429130119.1518073-11-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -305,6 +305,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Granite Rapids */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



