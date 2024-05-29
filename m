Return-Path: <stable+bounces-47653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC68D3D0B
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D4B2827BC
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B0181BA9;
	Wed, 29 May 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdYz2AGL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E573181BA7;
	Wed, 29 May 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001029; cv=none; b=siryK/j6Y/1yHbumuv0HZsdLpXwrYJy51U3r8slhpgkTLJrDuek9ERaAAw6YInu74KLgMXmFuo2B7MAgxl2XuTDMkac5buyjBA7U5OuQfC1EM6Y2w4/9c3YiVBislHYaMILCuti6yexNQGJAktL/DcuNzGc7uJDlElHhfa3Jjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001029; c=relaxed/simple;
	bh=je77Ka8YprgrmbKHyRiQGt8NAHF7dfXlmbFMH/IJScs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWwfE00dQD2UYy9ACaJXLbek4RGPCzPzyYU0A1JQf2tq0iGdkj1W4LAIgwWgxiE9jzsic+KT1FMFTy+6ad1Ss775e8vkbPzdepNbfgXXwQepWzKxDQyemj+ViNMhYKGZC+LX4mNHUySmFA028MDz63GUhT4/lSZFvyaKD7mPLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdYz2AGL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717001027; x=1748537027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=je77Ka8YprgrmbKHyRiQGt8NAHF7dfXlmbFMH/IJScs=;
  b=KdYz2AGLDVw5ivRrfuYYeUP/L294xb+oL/FgR3dNT8BU0E4Ccaaml5Ls
   p53BGizLecX5x1mRua22Xzb+7WD0J+6uDXWIVZ7BFfhIYNs1daCNLvRP4
   BUCGL+LlJEKD0FQ1DQaXDHGeEo7P5EFm6LyKbd4e3KTR3TZqx+cizd+CI
   0zqumsGjqWrviKDCaMAzzkCN1HtI3F1Jg+MuJAMTEFWW9ji92ykSTnE60
   klcwb2oi3xipx8P0fZsQ830lQSibOZGexNCNXm7ckJk8Lm2h4cOcXVp/l
   OYpN1s5UZsSej7DF5zuyHYlZPO5K35ucFZ/71RvynyDQQPjXrWr/I9zSW
   A==;
X-CSE-ConnectionGUID: PyigqhlURrOm89TS73f5XA==
X-CSE-MsgGUID: wWAN3GG2Q2uuX+KibGtgSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="23972168"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="23972168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:43:45 -0700
X-CSE-ConnectionGUID: TF+Nn9NJTNWSWX6BpSAMdQ==
X-CSE-MsgGUID: jWVL5+PuQWyT30qg2i08rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35458498"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:43:44 -0700
Date: Wed, 29 May 2024 09:43:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pci: Convert PCIBIOS_* return codes to errnos
Message-ID: <ZldbPhzJ1LID096X@aschofie-mobl2>
References: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>
 <ZlZYrsPfzAiFzNLM@aschofie-mobl2>
 <78e5690b-832f-3da5-3500-141e9b155c09@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78e5690b-832f-3da5-3500-141e9b155c09@linux.intel.com>

On Wed, May 29, 2024 at 03:19:19PM +0300, Ilpo Järvinen wrote:
> On Tue, 28 May 2024, Alison Schofield wrote:
> 
> > On Mon, May 27, 2024 at 03:34:02PM +0300, Ilpo Järvinen wrote:
> > > pci_{read,write}_config_*word() and pcie_capability_read_word() return
> > > PCIBIOS_* codes, not usual errnos.
> > > 
> > > Fix return value checks to handle PCIBIOS_* return codes correctly by
> > > dropping < 0 from the check and convert the PCIBIOS_* return codes into
> > > errnos using pcibios_err_to_errno() before returning them.
> > 
> > 
> > Do we ever make a bad decision based on the wrong rc value or is this
> > a correction to the emitted dev_*() messaging, or both?
> 
> There is potential for bad decision.
> 
> Eg. cxl_set_mem_enable() it can return 0, 1 and rc that is currently 
> returning PCIBIOS_* return codes that are > 0).  devm_cxl_enable_mem() 
> then tries to check for >0 and <0 but the <0 condition won't match 
> correctly because PCIBIOS_* is not <0 but >0, devm_cxl_enable_mem() then 
> return 0 where it should have returned an error.
> 
> The positive "error code" from wait_for_valid(), cxl_dvsec_rr_decode(), 
> and cxl_pci_ras_unmask leaks out of .probe().
> 

Ah, I see the fix is quite tidy but the impact is more complex. Please
update the commit log to explain user visible impacts of this fix.


> -- 
>  i.
> 
> > > Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
> > > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> > > Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration in the core")
> > > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/cxl/core/pci.c | 30 +++++++++++++++---------------
> > >  drivers/cxl/pci.c      |  2 +-
> > >  2 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 8567dd11eaac..9ca67d4e0a89 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -121,7 +121,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
> > >  					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> > >  					   &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> > >  		if (valid)
> > > @@ -155,7 +155,7 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
> > >  		rc = pci_read_config_dword(
> > >  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> > >  		if (active)
> > > @@ -188,7 +188,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> > >  	rc = pci_read_config_word(pdev,
> > >  				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> > >  	for (i = 0; i < hdm_count; i++) {
> > > @@ -225,7 +225,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
> > >  	 */
> > >  	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	if (val & CXL_DVSEC_MEM_INFO_VALID)
> > >  		return 0;
> > > @@ -234,7 +234,7 @@ static int wait_for_valid(struct pci_dev *pdev, int d)
> > >  
> > >  	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	if (val & CXL_DVSEC_MEM_INFO_VALID)
> > >  		return 0;
> > > @@ -250,8 +250,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
> > >  	int rc;
> > >  
> > >  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> > > -	if (rc < 0)
> > > -		return rc;
> > > +	if (rc)
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
> > >  		return 1;
> > > @@ -259,8 +259,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
> > >  	ctrl |= val;
> > >  
> > >  	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> > > -	if (rc < 0)
> > > -		return rc;
> > > +	if (rc)
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -336,11 +336,11 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> > >  
> > >  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> > >  		dev_dbg(dev, "Not MEM Capable\n");
> > > @@ -379,14 +379,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> > >  		rc = pci_read_config_dword(
> > >  			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		size = (u64)temp << 32;
> > >  
> > >  		rc = pci_read_config_dword(
> > >  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> > >  		if (!size) {
> > > @@ -400,14 +400,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> > >  		rc = pci_read_config_dword(
> > >  			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		base = (u64)temp << 32;
> > >  
> > >  		rc = pci_read_config_dword(
> > >  			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
> > >  		if (rc)
> > > -			return rc;
> > > +			return pcibios_err_to_errno(rc);
> > >  
> > >  		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> > >  
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index e53646e9f2fb..0ec9cbc64896 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -540,7 +540,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > >  
> > >  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> > >  	if (rc)
> > > -		return rc;
> > > +		return pcibios_err_to_errno(rc);
> > >  
> > >  	if (cap & PCI_EXP_DEVCTL_URRE) {
> > >  		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> > > -- 
> > > 2.39.2
> > > 
> > 


