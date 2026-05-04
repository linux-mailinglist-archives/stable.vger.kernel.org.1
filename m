Return-Path: <stable+bounces-242965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLGuBllm+GlpuAIAu9opvQ
	(envelope-from <stable+bounces-242965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C64BAEE8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FD083012BD4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EED3793AA;
	Mon,  4 May 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdiMFFae"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED3364948;
	Mon,  4 May 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886806; cv=none; b=ivqI0wzjoaNcR8yXCCU2FunFEBWGu6ybp7hXNsNoWgFdJo6oq/TV0rG8w+cECq25VnUqrSaO4oxJYWcF3ipQpgV2hJhgylLNwabYtEfUyEmZk/EjsuasK0Qvvwy80lD/4Rmgvyxey7Yss6lWD+xJJTVIUIQorC/Hv/uDNyCxUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886806; c=relaxed/simple;
	bh=dema2WUow3kMCZriE6YLuCVex+rSZ9EF1Wt4GBMk3MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsXmfBx5Dskk7FbvxWMHCy4AiD+QyIEASDcdNGaW+x9a2vGQCjyPRpZcK+6sZ5GuUIetTIGrAdgaohn9Dm4TCg5BHqiVTw60Tor0WiTayX6sXSyqSgH9gv3TYIQpXVLZi7maMjsS5V6lyu+nUyA+5CDgZR52Z/fncTQc4B4ZDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdiMFFae; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777886805; x=1809422805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dema2WUow3kMCZriE6YLuCVex+rSZ9EF1Wt4GBMk3MU=;
  b=WdiMFFaeFtGuGbCBEPN0dxdC78dNs73U6Rg/sttNkfA3ZwXr6jnx/s7H
   ag5p8HSd6vtUh2PIw+9CZq5BxPDCn4f+nLONB7+RPn6APVkOs8TO5INN3
   BlSx3ufSSSkPJzaV/A9vn9hkn+CVk9S4hyUcJTtxk69V9iDWdYYACqvPw
   a1CPwLSXiBixMDPr3fPM5LsIi8mtUKYDbwc9w640DLEk/Ep5M1IbCxgvO
   Z5dJJBn/Xduo61Kh2RS3dE9wrpxFmE2HVbIfg/sVOzS9T4oCvzArcpPjr
   k7nQotDsYFnjsTcpcJF5pHYRVEjExu/+5RkHSj9BCUFqdv9JAS45QOCPp
   g==;
X-CSE-ConnectionGUID: k6cS7Qs7Q2WhUlc56u//Xw==
X-CSE-MsgGUID: urjLezqHRx2FuNvGpRsU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82590054"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82590054"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:26:44 -0700
X-CSE-ConnectionGUID: zop30cPORoOlK/GwW7HoEg==
X-CSE-MsgGUID: FHR8CGRBR4eOJSvPq9p31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234604217"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 04 May 2026 02:26:43 -0700
Date: Mon, 4 May 2026 17:03:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fpga: microchip-spi: fix OOB read in
 mpf_ops_parse_header()
Message-ID: <afhg+stuaTvRCMO6@yilunxu-OptiPlex-7050>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
 <20260407172230.40775-3-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407172230.40775-3-sebasjosue84@gmail.com>
X-Rspamd-Queue-Id: 839C64BAEE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242965-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 07, 2026 at 11:22:17AM -0600, Sebastian Alba Vives wrote:
> mpf_ops_parse_header() reads header_size at MPF_HEADER_SIZE_OFFSET (24)
> without first checking that count is large enough, leading to an
> out-of-bounds read if the buffer is smaller than 25 bytes.
> 
> Additionally, when header_size is zero, the expression
> *(buf + header_size - 1) reads one byte before the buffer start.
> Since a zero header_size cannot be resolved by providing a larger
> buffer, return -EINVAL instead of falling through.
> 
> Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v4:
>   - Reduce to two minimal fixes only: minimum count check before
>     reading header_size, and -EINVAL for zero header_size.
>     Drop redundant block loop checks — the pre-loop bounds extension
>     already ensures all block offsets are within count.
>     Suggested by Xu Yilun.
> Changes in v3:
>   - Add overflow check for 32-bit in component size loop.
> Changes in v2:
>   - Return -EINVAL for header_size == 0, -EAGAIN in block loop,
>     add count check before MPF_HEADER_SIZE_OFFSET read.
> ---
>  drivers/fpga/microchip-spi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 6134cea..dca1a5d 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  		return -EINVAL;
>  	}
>  
> +	if (count < MPF_HEADER_SIZE_OFFSET + 1)
> +		return -EINVAL;

Why do you think the fpga-mgr core would provide a buffer that is not
good for low-lever driver to start with? There should be contract
between the core and the driver, if you've found anyone breaks the
contract, fix the breaker, not to add defensive code here.

Thanks,
Yilun

> +
>  	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
> +	if (!header_size)
> +		return -EINVAL;
> +
>  	if (header_size > count) {
>  		info->header_size = header_size;
>  		return -EAGAIN;
> -- 
> 2.43.0
> 
> 

