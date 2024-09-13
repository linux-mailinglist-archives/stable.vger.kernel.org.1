Return-Path: <stable+bounces-76048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE8977BBA
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E826282D07
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE71D6C6F;
	Fri, 13 Sep 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frq4NGj3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463215443F;
	Fri, 13 Sep 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217968; cv=none; b=ebQqz1mXgi2eklQ6154+J3HwDHzvCNc6gvDIR2weqih7s+ewFRFHbB9Vi8qiQX+cPJJA2QMWTC2dt0hFtO9RCjkGH5rpe+8+RJFq9ixoMwFkIlYnkB6ocAP1CI/eqZNO9UAc4dJyyi7lvHoXfFLjFNQ7U8sGFyZ36nFwfoiOHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217968; c=relaxed/simple;
	bh=zRkh1Ji+XJM1QVnhjaVembi9RZTPeDYx7ZVLPItSeJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKlcynR2bmAqe170SJ8RDCTwUleyWkKFATugTlVRcmk3UhKFZwhOHwDzgR+TKfvc0c2Ss+1wvm5uTIfnxZKB5Rt51bwheLlVVIxfKhpDbr4v81A4pBz1sgpNouGJtjlODlvei5Gb7DqrxuRXRtdBTwrIfKbe4cZbLDAKJaJkFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frq4NGj3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217966; x=1757753966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zRkh1Ji+XJM1QVnhjaVembi9RZTPeDYx7ZVLPItSeJ4=;
  b=frq4NGj3b4BLxL/1iT7p6kWX2qr00W4qu6VqdUXeV+EJkjm3OCO+r378
   hy1m2yMP23g3k4IbSjpvRH+JZ070V3fWp/PmMiA553icPQP5cIy+KQyL/
   a7HW+Lsw3/Gh74+70NWK28JiW5h6KictKo6p5Cq0eB00lUhuycFvRMkgL
   XXsjr5iHpx2mIpAFP0tVkWfcGkn5bMWY82BVztYzM7XWf7vq/hXSFbxqk
   GD6pGzJnmAnMBTaNYKbKDDJWC5/1f6Iq7cq+SR3cqMt4dzzYjU9GyK/Bi
   WekFNkJ4vHoJyg5slbjKc1U6RLw3ZSbE+UZS8qQFhh87nSC5YHyFLebBs
   Q==;
X-CSE-ConnectionGUID: qUaf1PLWQQSQv/knTwHUHw==
X-CSE-MsgGUID: F1IfLTdhR9CQqmJ0AlSLvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="29004358"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="29004358"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:59:25 -0700
X-CSE-ConnectionGUID: RWGsGADGS/aa0PhV8zUxIw==
X-CSE-MsgGUID: j/LSU4Q5QsKg8MOzQAm9/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67834021"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2024 01:59:24 -0700
Message-ID: <7e73a66f-e853-4da5-bb95-f28c75d993f2@linux.intel.com>
Date: Fri, 13 Sep 2024 12:01:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: fix loss of data on Cadence xHC
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Pawel Laszczak <pawell@cadence.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "peter.chen@kernel.org" <peter.chen@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240905065716.305332-1-pawell@cadence.com>
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ZuMOfHp9j_6_3-WC@surfacebook.localdomain>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ZuMOfHp9j_6_3-WC@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.9.2024 18.53, Andy Shevchenko wrote:
> Thu, Sep 05, 2024 at 07:06:48AM +0000, Pawel Laszczak kirjoitti:
>> Please ignore this patch. I send it again with correct version in subject.
> 
> It seems it's in Mathias' tree, never the less, see also below.
> 
> ...
> 
>>> +#define PCI_DEVICE_ID_CADENCE				0x17CD
> 
> First of all this is misleadig as this is VENDOR_ID, second, there is official
> ID constant for Cadence in pci_ids.h.
> 
> #define PCI_VENDOR_ID_CDNS              0x17cd
> 

Thanks, fixed and rebased.

Changes:

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 5e7747f80762..4bc6ee57ec42 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -78,8 +78,7 @@
  #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI                        0x2142
  #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI                        0x3242
  
-#define PCI_DEVICE_ID_CADENCE                          0x17CD
-#define PCI_DEVICE_ID_CADENCE_SSP                      0x0200
+#define PCI_DEVICE_ID_CDNS_SSP                         0x0200
  
  static const char hcd_name[] = "xhci_hcd";
  
@@ -470,8 +469,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
                         xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
         }
  
-       if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
-           pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
+       if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
+           pdev->device == PCI_DEVICE_ID_CDNS_SSP)
                 xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
-Mathias


