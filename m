Return-Path: <stable+bounces-45247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEF8C71B4
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DDD280D03
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A839171AF;
	Thu, 16 May 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AjWMPjsf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202162119
	for <stable@vger.kernel.org>; Thu, 16 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841897; cv=none; b=TARy65ZMeXW0Jy//VNF+uCJtudwdGZ+M7X96xlvzI/2nKiQOUB6KDm4ytekLkMrtY8R2/aNQQJsQyfrB+yM0yhSM1dYlbBm0nTquISLHNqtJj8uP46tvkLQ0te+vdldwpYnCkQeQ5N0oCV7YxaTwCJmFiY8lX7m09QRCsnqsF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841897; c=relaxed/simple;
	bh=g7pYxiKSLA2oQCqln3s0R+Viz6wE3AIq48FfbKGphF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvF/04Vbj8NnG5xQDP8QPBAB2mmomjptYl7or120GU4bhCgcTEpTkPkK4coVodtZjBdTXwr7unashZU7jzx1lUGbYQU/uYdeiNvgYRsvALEiPD26RgGU7YfAEw9vRIDLjsjebqkUNeNpT73be4f5XVzSNo2bxYc5cDKbcVSZZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AjWMPjsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37662C113CC;
	Thu, 16 May 2024 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715841896;
	bh=g7pYxiKSLA2oQCqln3s0R+Viz6wE3AIq48FfbKGphF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjWMPjsffd8AJuVOONH5dSX6A9jjom0yum7D6OuCJC9rsgaw4sPI6FBC5PdDsQAMQ
	 YHioIGVHZ5mkU4UcxsYii9sTMVvEhe9bo7CZdJivuxx+osfMr67F5n4pNUglu+GdXT
	 bkovFiOlOO+mWraaxChXxyfR6nvojGqdo3AVOZ+8=
Date: Thu, 16 May 2024 08:44:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Fix Intel's ice driver in stable
Message-ID: <2024051653-agility-dawn-0da9@gregkh>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>

On Wed, May 15, 2024 at 03:16:39PM -0600, Ahmed Zaki wrote:
> Hello,
> 
> Upstream commit 11fbb1bfb5bc8c98b2d7db9da332b5e568f4aaab ("ice: use relative
> VSI index for VFs VSIs") was applied to stable 6.1, 6.6 and 6.8:
> 
> 6.1: 5693dd6d3d01f0eea24401f815c98b64cb315b67
> 6.6: c926393dc3442c38fdcab17d040837cf4acad1c3
> 6.8: d3da0d4d9fb472ad7dccb784f3d9de40d0c2f6a9
> 
> However, it was a part of a series submitted to net-next [1]. Applying this
> one patch on its own broke the VF devices created with the ice as a PF:
> 
>   # [  307.688237] iavf: Intel(R) Ethernet Adaptive Virtual Function Network
> Driver
>   # [  307.688241] Copyright (c) 2013 - 2018 Intel Corporation.
>   # [  307.688424] iavf 0000:af:01.0: enabling device (0000 -> 0002)
>   # [  307.758860] iavf 0000:af:01.0: Invalid MAC address 00:00:00:00:00:00,
> using random
>   # [  307.759628] iavf 0000:af:01.0: Multiqueue Enabled: Queue pair count =
> 16
>   # [  307.759683] iavf 0000:af:01.0: MAC address: 6a:46:83:88:c2:26
>   # [  307.759688] iavf 0000:af:01.0: GRO is enabled
>   # [  307.790937] iavf 0000:af:01.0 ens802f0v0: renamed from eth0
>   # [  307.896041] iavf 0000:af:01.0: PF returned error -5 (IAVF_ERR_PARAM)
> to our request 6
>   # [  307.916967] iavf 0000:af:01.0: PF returned error -5 (IAVF_ERR_PARAM)
> to our request 8
> 
> 
> The VF initialization fails and the VF device is completely unusable.
> 
> This can be fixed either by:
> 1 - Reverting the above mentioned commit (upstream
> 11fbb1bfb5bc8c98b2d7db9da332b5e568f4aaab)

If you want this reverted, can you send the revert?

> Or,
> 
> 2 - applying the following upstream commits (part of the series):
>  a) a21605993dd5dfd15edfa7f06705ede17b519026 ("ice: pass VSI pointer into
> ice_vc_isvalid_q_id")
>  b) 363f689600dd010703ce6391bcfc729a97d21840 ("ice: remove unnecessary
> duplicate checks for VF VSI ID")

We can take these too, it's your choice, which do you want us to do?

thanks,

greg k-h

