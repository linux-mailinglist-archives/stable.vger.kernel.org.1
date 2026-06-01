Return-Path: <stable+bounces-259443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIv6GUoVHWpNVgkAu9opvQ
	(envelope-from <stable+bounces-259443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 07:14:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF116619990
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 07:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A4C30125CC
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4F33368BA;
	Mon,  1 Jun 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gz0wDi6T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060B32ED40;
	Mon,  1 Jun 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290855; cv=none; b=ilyZPiOiw7mG6WRzqWD+GZ+PRBKRgIzjvRUOPPEiCtgrDz0KBuRUO+TdVzzem9phGsyWQ1i8otHTFT4Jp38gVy5wA4Bq6xnPxbO1NLc6dNW8cMi9ztlUda97BEgPxTLO1g2Zy+vNxFaouM2tgE+uEcGgRhw6RzUdjgTClab1pCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290855; c=relaxed/simple;
	bh=Fiz4iY/YcutQJJ/+A3JH/I6rOTTrRVt16Bnb9RgMVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLEP6l3up2LaYLnPxAcoSZRflDZHtoG6d/lxoBdA7L+MaZRzQgQmf5nd4HAjK2EXaETcBVlNbR5zDGr/YeCsQ5pMcNtLkJ9lLaICfZH80B63kxpyYSZN8VlxQzq0h+VwGdwk+dLtevCUhT1+wxXNBCUHr6ht8r+VOxD+CmSeyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gz0wDi6T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780290854; x=1811826854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fiz4iY/YcutQJJ/+A3JH/I6rOTTrRVt16Bnb9RgMVSU=;
  b=Gz0wDi6THujVizGfv7eLDGwcp71hfwZ1edYvlDwrRrIRSXdr7h4KPex3
   YBap6vgRbjRuOe+1tPeIq5NScMy6lxTYjfvQ6JrjtxVpOtoTeTbJL/yQh
   l2h9d99Z0zDj1rY6DQObf31CyckiEqT9M9KzfJpFMB8068XEKnlWk6Ss0
   Cd+pU2tNpjk6wm1dI93ckNSXabfIzLiEBc0VtMuqKAUGRSXgnj+PDMB01
   tgXfy3lccgc0nw84IuPtB58OomgiY36twtNd58hFVCcEsnQS8uZCX2kcn
   cMSOlvnXCK6QP0n5iTxwjqRSulRLuZn5S1bkKVXIIKn3IXMVDt+wtvNhM
   g==;
X-CSE-ConnectionGUID: iKrG44IHSp6Mm2mwJkV11w==
X-CSE-MsgGUID: ZQYRbbR2RmKEKkBZR+z47g==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83618053"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="83618053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:14:13 -0700
X-CSE-ConnectionGUID: 3sF0PFfpRluY6xhnlOEVFw==
X-CSE-MsgGUID: arMnjOiERAqQMU3pW1HcqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="242410357"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 31 May 2026 22:14:11 -0700
Date: Mon, 1 Jun 2026 12:50:01 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 0/3] fpga: bounds checks and input validation fixes
Message-ID: <ah0PeR1lESJjH/yv@yilunxu-OptiPlex-7050>
References: <20260518190742.61426-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518190742.61426-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: EF116619990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:07:39PM -0600, Sebastian Alba Vives wrote:
> This series adds three defensive fixes to FPGA drivers:
> 
> Patch 1/3 fixes dfh_get_param_size() in the DFL driver where the loop
> bounds check is evaluated before incrementing size, potentially returning
> an inflated size that exceeds the feature region boundary.
> 
> Patch 2/3 validates the DMA mapping length in afu_ioctl_dma_map() at the
> ioctl entry point before passing it down the call chain, preventing
> implicit integer truncation in pin_user_pages_fast().
> 
> Patch 3/3 fixes mpf_ops_parse_header() in the Microchip SPI FPGA manager
> where a zero header_size from the bitstream causes a one-byte read before
> the buffer start.
> 
> Sebastian Alba Vives (3):
>   fpga: dfl: add bounds check in dfh_get_param_size()
>   fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
>   fpga: microchip-spi: fix zero header_size OOB read in
>     mpf_ops_parse_header()
> 
>  drivers/fpga/dfl-afu-main.c  | 3 +++
>  drivers/fpga/dfl.c           | 2 ++
>  drivers/fpga/microchip-spi.c | 3 +++
>  3 files changed, 8 insertions(+)

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

