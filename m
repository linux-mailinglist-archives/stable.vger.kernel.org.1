Return-Path: <stable+bounces-172914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E0B352EA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D66D5E8115
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723362E2DCF;
	Tue, 26 Aug 2025 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R5PlInEp"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D72DECB2;
	Tue, 26 Aug 2025 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184231; cv=none; b=trRSqdWZwgqIL51zZ+ZIS25eB1OtEeBXHN4qFm4NCpodgGEN8aJjdygCcZ8KdCG3rt+Dy5WPecAY3ndKdp9xJznEo/kMNH4NUYNs/emnsWSowFTZ0D2V4RFaNqSmS7FAe9okcFZvBEAYJiuCBhlYdFRNBiebYGcB8OLY7OG+kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184231; c=relaxed/simple;
	bh=xwMIaGQKz8p0Si+xGqmhBmPMRxKtcpPXxfbp1aDgx/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIXdpeTjDgBipRuu1OIe1HducQQ7Ok0yaQcP/qjhX7h6LyShhDSt6f9CIsQfF6T/GjMTx/gtcJw+hSbXAG3pO+oFVbxtlflxVPa2D1whcI5jsaaoa8Ue4If7FUA2qKwwaBDt4jqIigyDTzFfZ/AOzqkO4btKl0tY8ox5NDxbD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R5PlInEp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 5ACCC211829D; Mon, 25 Aug 2025 21:57:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ACCC211829D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756184229;
	bh=1SFbtV4WkD6PXoKrfW4+V58ZRmMRw6Cp+HTFsBe/b9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5PlInEp8xIb3pHwGaQkKup92Sl6gUT5NR5COZvZXaLTfEnfE76mfeaHpy14ch4la
	 nRCWzZDBENIerpuXmpjyriFlrvVGfGSIkxJjKL+iguGAFph78S5tQkQ7eRvYzkB+ea
	 RH0Ogy98u8JsYR/tjb/+GEePlov1eMyfw6ZSSGGs=
Date: Mon, 25 Aug 2025 21:57:09 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Remove redundant
 netdev_lock_ops_to_full() calls
Message-ID: <20250826045709.GA2238@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1756119794-20110-1-git-send-email-ssengar@linux.microsoft.com>
 <20250825174133.30e58c60@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825174133.30e58c60@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 25, 2025 at 05:41:33PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 04:03:14 -0700 Saurabh Sengar wrote:
> > NET_SHAPER is always selected for MANA driver. When NET_SHAPER is enabled,
> > netdev_lock_ops_to_full() reduces effectively to only an assert for lock,
> > which is always held in the path when NET_SHAPER is enabled.
> > 
> > Remove the redundant netdev_lock_ops_to_full() call.
> > 
> > Fixes: d5c8f0e4e0cb ("net: mana: Fix potential deadlocks in mana napi ops")
> > Cc: stable@vger.kernel.org
> 
> If the call is a nop why is this a stable-worthy fix?

I am fine removing CC and fixes tag.
I can send a V2 for it.


- Saurabh


