Return-Path: <stable+bounces-41731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F347B8B5A6E
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132B9B2494D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63C7442E;
	Mon, 29 Apr 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YmpS7gx3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386B74424
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398449; cv=none; b=mwd+1YSUfkaHSuwY2TtD9E3+cZ9IiPBt6atHdW4Hl3xp6rHq7jjiXBQCW1G5VPQ9R640L6+9COqdTzWRKQn8A5Yz/vspq1zDtc+v6iGTAavXFjPnOlxTY/ZUO7FjILMDFlq90YZtv/c1u+y/3VTU94pCXVYQZIOFtxQLuV3KzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398449; c=relaxed/simple;
	bh=VQ0QsrOxdXIVUFU+rHlx3ePWHK0as56z6LWtZHlXn/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj+pQel7tnMoacRvQOhxzYz/+Y+pkcTAIUdmWE9LT+IBoYHvUFZP3medCiwzEcAse3ZltlzVm4/A8veEQXOcnlsnOv/Qur6iHN9ynI9Om77rk8ckRnlLkWVOKY8NihzfyEUCQwl9rZzL8uDmzVS/rhDb4feeFbFIR/i1PG6Qg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YmpS7gx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D2EC4AF19;
	Mon, 29 Apr 2024 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714398448;
	bh=VQ0QsrOxdXIVUFU+rHlx3ePWHK0as56z6LWtZHlXn/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmpS7gx3JGWIZPMpRFeSXG65QRiRrrXFDbuAs+I6//VuPTQW62G4cI3FQsutIWGRD
	 RaJkvNPh1dQlAZgL5azRsGxI9O5Qel92BwizPXu5xuXiSuZaLinYSqJWhYDPXx9JEY
	 Guq4saC20UAl01avIEDZJ3upB1AIaQ3ay7X4j6ck=
Date: Mon, 29 Apr 2024 15:47:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org, Chris Oo <cho@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 6.6.y] x86/tdx: Preserve shared bit on mprotect()
Message-ID: <2024042902-grope-easing-82a1@gregkh>
References: <2024042908-modular-case-bbd4@gregkh>
 <20240429122700.4100457-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429122700.4100457-1-kirill.shutemov@linux.intel.com>

On Mon, Apr 29, 2024 at 03:27:00PM +0300, Kirill A. Shutemov wrote:
> The TDX guest platform takes one bit from the physical address to
> indicate if the page is shared (accessible by VMM). This bit is not part
> of the physical_mask and is not preserved during mprotect(). As a
> result, the 'shared' bit is lost during mprotect() on shared mappings.
> 
> _COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
> during modification. AMD includes 'sme_me_mask' in the define to
> preserve the 'encrypt' bit.
> 
> To cover both Intel and AMD cases, include 'cc_mask' in
> _COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.
> 
> Reported-and-tested-by: Chris Oo <cho@microsoft.com>
> 
> Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20240424082035.4092071-1-kirill.shutemov%40linux.intel.com
> (cherry picked from commit a0a8d15a798be4b8f20aca2ba91bf6b688c6a640)
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Both backports now queued up, thanks.

greg k-h

