Return-Path: <stable+bounces-10856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E982D4AA
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 08:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219191F2177D
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8788440D;
	Mon, 15 Jan 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bA+Dq1bM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80929B4;
	Mon, 15 Jan 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705304471; x=1736840471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9xDS5m0/Xi1G++zGCcpFutHH1c/4WneyytlOz4IGWY=;
  b=bA+Dq1bMRKWJU7l07DUq+dCVD7x5pJ548vwWextArvNUkZ5iOnoZqTWE
   k6J1iKOZpF+apb7X2ou83cjjux7QFxq3PHJgSG21q9Pmya1U5C0G/ILZ6
   E6+KZLyHKlnWLT6hVv0KhoFsEtvbV+EecglY0qrxfqNW62rzaI0BFef8X
   o8xU5TC7/vlrNxD6EzXdDHMvS+Q10FPqGhQE6HABj5BHpGNxIVZnh8PxM
   75uaFXYdf1FsLtepPgVLRiIEAnN16NCwU29eMGJPqqBp54m9BoqXdYx24
   gxkUVmWs0OalRhc8C1Ysmff+3o4Cm9vS3pyPtGrTwTeO6UkJSbR8VTMzW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="396695762"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="396695762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 23:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="906984077"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="906984077"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 14 Jan 2024 23:41:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jan 2024 09:41:06 +0200
Date: Mon, 15 Jan 2024 09:41:06 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: pci: add support for the Intel Arrow Lake-H
Message-ID: <ZaThkgy/MPLahejz@kuha.fi.intel.com>
References: <20240112143723.3823787-1-heikki.krogerus@linux.intel.com>
 <20240113013918.fhcz32gkwtlf6viu@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113013918.fhcz32gkwtlf6viu@synopsys.com>

On Sat, Jan 13, 2024 at 01:39:22AM +0000, Thinh Nguyen wrote:
> On Fri, Jan 12, 2024, Heikki Krogerus wrote:
> > This patch adds the necessary PCI ID for Intel Arrow Lake-H
> > devices.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/usb/dwc3/dwc3-pci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> > index 6604845c397c..39564e17f3b0 100644
> > --- a/drivers/usb/dwc3/dwc3-pci.c
> > +++ b/drivers/usb/dwc3/dwc3-pci.c
> > @@ -51,6 +51,8 @@
> >  #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
> >  #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
> >  #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
> > +#define PCI_DEVICE_ID_INTEL_ARLH		0x7ec1
> > +#define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
> >  #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
> >  #define PCI_DEVICE_ID_AMD_MR			0x163a
> >  
> > @@ -421,6 +423,8 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
> >  	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
> >  	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
> >  	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
> > +	{ PCI_DEVICE_DATA(INTEL, ARLH, &dwc3_pci_intel_swnode) },
> > +	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
> >  	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
> >  
> >  	{ PCI_DEVICE_DATA(AMD, NL_USB, &dwc3_pci_amd_swnode) },
> > -- 
> > 2.43.0
> > 
> 
> Can you send a "v2" and a change log under the --- line next time?
> 
> Regardless whether you'd send a v2:
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Yes, sorry about that. I'll send v3.

-- 
heikki

