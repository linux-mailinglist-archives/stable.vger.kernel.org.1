Return-Path: <stable+bounces-233560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLIeOQ7l1GluygcAu9opvQ
	(envelope-from <stable+bounces-233560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:05:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 323693AD785
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCC130234CF
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92813AC0C2;
	Tue,  7 Apr 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btueZz6J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A33932C6;
	Tue,  7 Apr 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559947; cv=none; b=ROt6dtA7xj1MMcN0cEg/8ZQuzDVBgwW8HVfvsE/uYwI6R8YEZaL4QoM+SnpEdRx7IviMzXhacbu5glpuEfgU3wkyLmNbXBRugrrvGDCgeWbVRqZhvVI7gf4VoHKgWVyVLSyMAKFw3I32AGbkCEuxcqLR3i1HS/jIQicI9kDI1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559947; c=relaxed/simple;
	bh=MT5b3e1TTdPydwuW3S2ObgjW8crI/laqDyEwE/eGvAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geLc7ooqMiJznGVCxro1yVoSxsSigl/jq6a5zaN7iZyKTSsFmdVwprC9WsLIaJYAvaXY4a6uYw3w4UrWVSI11Jv5f3/kSp1IV/awy2TM8LICZqYWcJt44DPi+GBSNZ2x649iDdKeuCwFcSZMNPdYbHPElBgwPhluQDk26cm4o/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btueZz6J; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775559947; x=1807095947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MT5b3e1TTdPydwuW3S2ObgjW8crI/laqDyEwE/eGvAw=;
  b=btueZz6Jm2HZoQvUTn8boSUe+CQBMOzX7dC64TbTMOPAoU1axVwkGRpW
   6zNOKvwdbFJVJ7WHJP9iaoXKVb28cP40XCYOZRt5zdZqGFam1JFDU+/6J
   ZVG2YpM1B09TZobcZdiTMaOu7HxNVd7FJjl6x5mh9K37LNWVcEuFd6SPd
   9iwjQ7FTFvaRAyjr6IH10cjA9mEidAuWprDYtJ3KBqWWvu1XO+Rrjz8So
   ZDwjVi0s1vnEUnGYr1qDkBMCTy6z5Q/8RC8kXKHa18MucBWI+TCsq2bkd
   0IU0L1h1po/YfAITA1njnkU3Mb8eqyv/7X+plOvXKTGNyXJWzQawl+0xM
   Q==;
X-CSE-ConnectionGUID: 7ZReo/t7TOqrbmQHyyR+eA==
X-CSE-MsgGUID: 1TSGt/4bQbSzTT6YOhT+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76532026"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76532026"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:05:46 -0700
X-CSE-ConnectionGUID: Tv3I9oshSAS0Cgq1VaMUog==
X-CSE-MsgGUID: CI8jSjOmTkm8r4moA7hNXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="251436423"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2026 04:05:44 -0700
Date: Tue, 7 Apr 2026 18:44:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <adTf/leheKK4TV/g@yilunxu-OptiPlex-7050>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
 <20260402162302.3804617-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402162302.3804617-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233560-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 323693AD785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> @@ -139,6 +145,12 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  	bitstream_start = 0;
>  
>  	while (blocks_num--) {
> +		if (block_id_offset >= count ||
> +		    block_start_offset + sizeof(u32) > count) {
> +			info->header_size = block_start_offset + sizeof(u32);
> +			return -EAGAIN;
> +		}
> +

The image header has already been extended up to all look-up table for
blocks, is it?

	header_size += blocks_num * MPF_LOOKUP_TABLE_RECORD_SIZE;
	if (header_size > count) {
		info->header_size = header_size;
		return -EAGAIN;
	}

>  		block_id = *(buf + block_id_offset);
>  		block_start = get_unaligned_le32(buf + block_start_offset);
>  
> @@ -175,6 +187,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  	 * to each other. Image header should be extended by now up to where
>  	 * actual bitstream starts, so no need for overflow check anymore.
>  	 */
> +	if (MPF_DATA_SIZE_OFFSET + sizeof(u16) > count)
> +		return -EINVAL;
> +

Do you notice the comments above? IIUC it says all these header info
should be before actual bitstream starts, if we could ensure this, we
don't need to check the addresses inside the header byte by byte.

I think it is important we understand the structure of the image file
first then meaningfully check the boundaries chunk by chunk, rather than
byte by byte, which makes code unreadable.

Thanks,
Yilun

>  	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
>  
>  	for (i = 0; i < components_num; i++) {
> @@ -183,6 +198,11 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  		component_size_byte_off =
>  			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
>  
> +		if (components_size_start + component_size_byte_num < components_size_start ||
> +		    components_size_start + component_size_byte_num +
> +		    sizeof(u32) > count)
> +			return -EINVAL;
> +
>  		component_size = get_unaligned_le32(buf +
>  						    components_size_start +
>  						    component_size_byte_num);
> -- 
> 2.43.0
> 

