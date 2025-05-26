Return-Path: <stable+bounces-146343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13260AC3D55
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDE18869B1
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033281D9694;
	Mon, 26 May 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy90u/JM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED11EF36C;
	Mon, 26 May 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253108; cv=none; b=NDGwyMqOc7kxmuilBeofd2pGtckhOGU6sJXgJ3q2vSPrjJoOinYDFNdAAdbLgNizHxyDedIQ/gjUjrBuWTGcwLgQ3L3EDpIQWWUoNyXOGe/1bKbdQXImwxsT+cluQi4r8DWzCVZ0Q1rla7hRI7cRrY+ZRxVG+2VUpt2A0lh1Ao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253108; c=relaxed/simple;
	bh=3qgtqvR99/jckDm4wJuF1A1c37Gw/lv4DloT3Rig0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Fhm29B5pAH2Ia6As2EOLpzn8ILsLsprZW16k6kaXKroS6SNEzLevMqYsXRoNNhFbzfhQJw82VmbzcTz6sEUBysTQFuKcIdNepu9gA3D6tYPebci1inYyA/++EsdUri5PqlUAGIt0ZIb11a/Rc8Ap2iKWoit764SEaWYUZqcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy90u/JM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748253107; x=1779789107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3qgtqvR99/jckDm4wJuF1A1c37Gw/lv4DloT3Rig0lQ=;
  b=iy90u/JMsFfKIfBDYntdkO0Pkr2DKZsBSFTEFpJpggfFzEG7uf52CuiS
   GhebsKL1Yi9ihSKCXwMwZJ2Wl3Bx6QpWLrvJm3noXSPfblFPShsFszCHp
   YXXtt+dTTUNjfWxL1soGnsUFJmSUnZI3fuymEp6KG7b4+3tT7B3EKfG8B
   OPUj4W42prHKTmgLuai3exPdpDn+dOuzJfEb+PmJ0d6RcV1v5LeujRbn6
   rPG92s8PSFYc9pQb0t9SEgGXt7ToV84WG7g3XjEUoK/oVH+femjoppCsZ
   tJiHTcaFHEVMS5nIx1+s6QKz4VYHiak6XCWpJ3G/sRyJP1keVPjtldLwA
   g==;
X-CSE-ConnectionGUID: 1C9Npc8/RQutka0fAiovGQ==
X-CSE-MsgGUID: +EsVJaAYSzi95Ac03nZqeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="61631864"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="61631864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:51:47 -0700
X-CSE-ConnectionGUID: MpZRJJz4QTupfXrYoxvo/A==
X-CSE-MsgGUID: f38UmJFZTmW3MP8a2UHD2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="142679357"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:51:43 -0700
Date: Mon, 26 May 2025 11:51:06 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sergey.temerkhanov@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ice: Fix a null pointer dereference in
 ice_copy_and_init_pkg()
Message-ID: <aDQ5ipcH346PJPGp@mev-dev.igk.intel.com>
References: <20250524072658.3586149-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524072658.3586149-1-haoxiang_li2024@163.com>

On Sat, May 24, 2025 at 03:26:58PM +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kmemdup()
> to prevent potential null pointer dereference.
> 
> Fixes: 2ffd87d38d6b ("ice: Move support DDP code out of ice_flex_pipe.c")

This commit is only moving the code to new file. I think it should be:
c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")

> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 59323c019544..351824dc3c62 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -2301,6 +2301,8 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
>  		return ICE_DDP_PKG_ERR;
>  
>  	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
> +	if (!buf_copy)
> +		return ICE_DDP_PKG_ERR;

Fix looks fine, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
>  	state = ice_init_pkg(hw, buf_copy, len);
>  	if (!ice_is_init_pkg_successful(state)) {
> -- 
> 2.25.1

