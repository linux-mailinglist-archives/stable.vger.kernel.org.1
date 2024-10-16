Return-Path: <stable+bounces-86447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F699A0512
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158671F26B67
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5A204F94;
	Wed, 16 Oct 2024 09:09:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B1134A8;
	Wed, 16 Oct 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069745; cv=none; b=aZITqFU1qoeggMSR9JdzQqEwAQPokicS3OF39VDaHTeATf2VKZMUrt6RmQtaR+dPn2ezo5fohk1ht183CKBNwlXz7biTlYIpUXXRZ1rFG7TZV+EUTbM9R3z/v0rFEFEDyPOtpT5WTQ5ZGjvpd3N/ibYHpVOYouHgGoIA/2yHhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069745; c=relaxed/simple;
	bh=wJbwFG5BGPzQ/NGKhwbaKN/QlUVFVcVA/g8ORsnwSOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3oC3reTpp4o7QW6kMfj1uWnfoABn2sHQrSZByTsBrEEP8ck15/eQWLTGue17MinFnvTqu5YYaYKgm1jBz+Ejn4yhj3wBDMEvOX/lgu4S+BZwLINbPk0skp8QYgFBE/Bmg8PHKaK2NBnXQKJitiPW5E8wqoPWC1nxL3GxveT9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: DGmrN+ygRZ2wOoR/ExLtCA==
X-CSE-MsgGUID: klSEgzEGQcqTV5hxaW3EhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32425568"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="32425568"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 02:09:03 -0700
X-CSE-ConnectionGUID: RoebudO2StuMC+xZ3Byhcw==
X-CSE-MsgGUID: Q8JvlAiaQx2gCwjpS2+3ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78230317"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 02:09:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t101Z-00000003hZQ-2DBw;
	Wed, 16 Oct 2024 12:08:57 +0300
Date: Wed, 16 Oct 2024 12:08:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Message-ID: <Zw-CqayFcWzOwci_@smile.fi.intel.com>
References: <20241016072553.8891-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016072553.8891-2-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> pcim_iomap_regions() is placed on the stack. Neither
> pcim_iomap_regions() nor the functions it calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the strings on the heap through
> devm_kasprintf().

> ---

I haven't found the reason for resending. Can you elaborate here?

-- 
With Best Regards,
Andy Shevchenko



