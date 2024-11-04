Return-Path: <stable+bounces-89604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D99F29BAEF3
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66276B20E22
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6F189F47;
	Mon,  4 Nov 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFDErdij"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2023AB;
	Mon,  4 Nov 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711054; cv=none; b=YgY83HBrX6p30CqTX9jn8M8/LzkTtj+xLQL3UUIl1GiaKKxw08yzCc4aGSLD4GNEa+12t0paGGqb5EWgvFT4VieZMzWz0TQLzH0XkgOK/em95chN6IIF1P6v2PxjAut+XHkyQ5BtcT2C1Sm2L/MLGWTvmLyKc+8HUdv00mgQidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711054; c=relaxed/simple;
	bh=83R5vPSx8LXJcjcBgV54w3tNRukTr6uar0kjVUuM/TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXYfDlpYlyPcWlQyjwjYNJ2dHRLAynhpQCCdJN68gJEdCZDHlSC3b/XshjB5ADLPgVNt4snZ2R39Iqu66PLswOquEcxcmv/wogcXB1Le8d4E9SOAhp29NRGdj/93mHAy793deX3a7xXWUEypmTVaAND9gnnwzrhS33iXi/yduWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFDErdij; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730711053; x=1762247053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83R5vPSx8LXJcjcBgV54w3tNRukTr6uar0kjVUuM/TA=;
  b=fFDErdijH6buSL3UaR/0tKWHHx6vXK2YAxmOCnvkjYBIduz5LMsjgaBh
   RkVIk0l7vrXR+dRvqmHjOvMm4Y7resdq9FjSmlmfkdGgWvfj8LcbomZNU
   1TJP7AJO1Qb7QUeWPjgAcs/0t7DA617drgrY3uz9voF8R9zf7Vh0qwXr9
   eYMQccmBhmJRInLTPHSbQ0F90MdPBK6Rm27IWSlIPrYKRfPN0qenSk6g5
   WgTTm2sEXs0vuHvzls9Fas0D/8gIv6AvhF6OpFhZDdPOE8i92Kcb+gncQ
   ieQnI4c5a17VwbKPLAOkvzFTGhG5Nj+wPlJgTvuGTIq7KJHCKhBNncZgZ
   A==;
X-CSE-ConnectionGUID: nWvzX1BcQbCnyfgCttkxGg==
X-CSE-MsgGUID: KQyGXXpGTVOfk8xdUmiV5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41029315"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="41029315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:04:12 -0800
X-CSE-ConnectionGUID: +ca51wSkSSKRXxOuqMzuVQ==
X-CSE-MsgGUID: F43Y4Se+RI2BWIg3ecTXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83476184"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa009.jf.intel.com with SMTP; 04 Nov 2024 01:04:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Nov 2024 11:04:09 +0200
Date: Mon, 4 Nov 2024 11:04:09 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: Drop reference to a fwnode
Message-ID: <ZyiOCV59lJDPo_LO@kuha.fi.intel.com>
References: <20241104083045.2101350-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104083045.2101350-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Nov 04, 2024 at 05:30:45PM +0900, Joe Hattori wrote:
> In typec_port_register_altmodes(), the fwnode reference obtained by
> device_get_named_child_node() is not dropped. This commit adds a call to
> fwnode_handle_put() to fix the possible reference leak.
> 
> Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Already fixed: 9581acb91eaf ("usb: typec: fix unreleased
fwnode_handle in typec_port_register_altmodes()")

thanks,

-- 
heikki

