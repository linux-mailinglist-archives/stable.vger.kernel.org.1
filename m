Return-Path: <stable+bounces-167109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CFB21FAC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C141AA6047
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51A1FBE87;
	Tue, 12 Aug 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcPBN5ML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A461A9F99
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984158; cv=none; b=EawyIoXoMNO2KQmWKs6ryUfomSi7wjXoX/pmfb61047Gn6H/SgO+MYnRaH8ydDUu7zjDbqoKmZK0x18+JRnApwzIZt9TIPwG8dzPZcxNacd0aLbyptK0YYpjO23Ij2jqKopqzPAWNe8kV+9dPrQvWbl5myFhvEiGJZt/+0O2IL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984158; c=relaxed/simple;
	bh=pqht/1flFTNkomYAzdFrr2xZX0nTPOtt2KdJyJ5C0G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn504z7WPEPBrNohlF5gyBQl93H72fvMhEh4vO10O3nddIxmLEUqkQVWje7yiGuA/kM5zgw+hpc4wmXa6gQgjOtUlRizeu3+8HsopIl35YaZcckuK7KmNEZVhKgT1BtO+XfOX5uZrgVN5ryyOSSRH4xxajzFtgJL1rPQoGED2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcPBN5ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22255C4CEF0;
	Tue, 12 Aug 2025 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754984157;
	bh=pqht/1flFTNkomYAzdFrr2xZX0nTPOtt2KdJyJ5C0G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcPBN5MLo+vwTNJH0ndc3+6ecCC8XZU+VVZL4cjPSZB53EVDVE3Azh7O2W4XTd3sT
	 TXA3b8Yh+/mUCi5JtdxgK/C12WxiwCN7NoqNF0jmBm8LA0S0xxvovOqL10IvWOsgNt
	 IRI+O4jjw01PjGlfa3XgKnSr+xWVNvbUpAYeW/Lg=
Date: Tue, 12 Aug 2025 09:35:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp,
 hdmi}_connector() return type
Message-ID: <2025081221-authentic-swimsuit-ecde@gregkh>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
 <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>
 <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>

On Tue, Aug 12, 2025 at 03:35:54PM +0900, Sergey Senozhatsky wrote:
> On (25/08/05 11:11), Sergey Senozhatsky wrote:
> > On (25/08/04 19:16), Sergey Senozhatsky wrote:
> > > From: Jani Nikula <jani.nikula@intel.com>
> > > 
> > > [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
> > > 
> > > The caller doesn't actually need the returned struct intel_connector;
> > > it's stored in the ->attached_connector of intel_dp and
> > > intel_hdmi. Switch to returning an int with 0 for success and negative
> > > errors codes to be able to indicate success even when we don't have a
> > > connector.
> > > 
> > > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
> > > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > Just for the record, this series fixes multiple NULL-ptr derefs
> > in i915 code, which are observed in the wild.
> 
> Gentle ping.
> 

The merge window, and the weeks after that, are slammed for stable
backport work.  Please give us a chance to catch up with the thousands
of commits we have to now process...

thanks,

greg k-h

