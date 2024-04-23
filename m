Return-Path: <stable+bounces-40745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B78AF5C1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6822DB2222C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522413DDD0;
	Tue, 23 Apr 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYuTpMJr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80013CA8A;
	Tue, 23 Apr 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894171; cv=none; b=ri4vyfNCIjhVj1nDmemdUe3xw+bMdD6Ze1JwvTD/vj4UGdOXkU8SVUNuc0ERqFfEZ9nfT3Z4fXakOinhXOaN2rx5XBUn52DUE0JWPk7B3hvDGxSIt1mfShQ2MSEwMlUSKpqY72gRP6HF+MfCgbVApwxKR33oOt6VYiuGBLOm0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894171; c=relaxed/simple;
	bh=ock0VCrBpI7qAgfi6oLSfb/6Aqj77P5qLwRspEkgA+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiYlOrW4kOEEHJAsswPPHV0n6feBj6buO6YENN1EZ9cnFoSGSAf6ksdJqQTQZafuAiP55A7FD98kjaEAuDXnmy3LD8DcWVnC1xwhjOxn5Yc4QeO6BTmNgZkGXzWLiMjbwZHi2k3gcn77xLWcThAyVkUqe3HuVklJImbTF29Vf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYuTpMJr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713894169; x=1745430169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ock0VCrBpI7qAgfi6oLSfb/6Aqj77P5qLwRspEkgA+0=;
  b=JYuTpMJrYsYvG2zH96CSCX4ZfuRFsR5UKlULMH113Pes8PwfwuS1X3w5
   tb378XT1d4Frgt287QmgcNDq9w7ByPl4RBHhvZfTDIHo6swDtxcUm+Mdg
   P+O6r2saGNu1ZDDob2mtssLLsRN2PhinsKkKk47EYTfcS9AsGWSPgvwIT
   ZmQu6ik3w+qkGv4EZyIP1/1Uglzsi+pzltSAxzh9pqyUoIg0yZnLkVWWH
   hci05aWtSAH0RTLUDtqYtE/f2cM9wxXbDwIcj7W7EcA/1ZuhB2aIj4jaW
   oa3x5k7rvYDiN/7NdsCVIyyKHcLxp/W0bR+qrFgO193t0/DmcIm+9Kg3f
   A==;
X-CSE-ConnectionGUID: FfE8cmV3Qb+MlPAJXCVYug==
X-CSE-MsgGUID: jH8ugk9CSYOv2vFcRqfwhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20190151"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20190151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:42:49 -0700
X-CSE-ConnectionGUID: 8ZFtQpYoRle0DVMZKA1F/A==
X-CSE-MsgGUID: ypecsz0uS+eYg2VyLCsuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24321377"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.29.57])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:42:49 -0700
Date: Tue, 23 Apr 2024 10:42:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <ZifzF8cXObFiDiIK@aschofie-mobl2>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>

On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 

So, an invalid DPA is emitted in the trace event log and that could
lead to 'incorrect page retirement decisions...'

> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..cdfce932d5b1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)

This works but I'm thinking this is the time to convene on one 
CXL_EVENT_DPA_MASK for both all CXL events, rather than having
cxl_poison event be different.

I prefer how poison defines it:

cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)

Can we rename that CXL_EVENT_DPA_MASK and use for all events?

--Alison

> -- 
> 2.34.1
> 

