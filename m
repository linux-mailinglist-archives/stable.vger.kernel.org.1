Return-Path: <stable+bounces-58202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00D92A19E
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F68B24CD9
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C57F7C6;
	Mon,  8 Jul 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0esNfPMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D37FBA0;
	Mon,  8 Jul 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439419; cv=none; b=WT7EB5W5N5H3v9+Wd5hs/PpeVIka0k73Bnn1ZjGU56cn27uy4HHuYex9KLhLg9wsDuQmWNnPD9BId5b1QJrvB8yr1HxJ4n3/zD9XHUJsR3Mji2nfJMBgqjIQHCin+K3mi6Qcd6Yxopzfp+hD5TtBLh2wThEQdqsaJxJC7KxYUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439419; c=relaxed/simple;
	bh=SxUZbRI7bqSAx5neIdyHhNGLnGAVgQxLpB4cmPiBAao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgMGSxHZWDVndSGA/HEiwrmz4yYk53JkQeLxYbbrxXOfO47qIM4DjlLam6jcGQHgLH1VN2k8r8DxfBkJXciMDmjEe954RINtvppfdLQ0dmKHiwzGGPZ8DrYnnhJl0nPceaCmvByT3jLClJuiF4z5Ldv42fSLP43l11r8K0ctg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0esNfPMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1859C116B1;
	Mon,  8 Jul 2024 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720439419;
	bh=SxUZbRI7bqSAx5neIdyHhNGLnGAVgQxLpB4cmPiBAao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0esNfPMVLehrV1AgTm5I9rUVZSVGf+96BIlzvTAZwls+4kg/CxsNT4coTwRfUW/2C
	 4TnSmIMhFurimWt1ZrZWzFTsGvZdTfOrExpIRvSCuKwpicEAkXgLaYDiMZ9cd2DeMd
	 6hc3JIqmfXSoGJ/UrAFMZVUSKKmCtY0jW6K6XfE4=
Date: Mon, 8 Jul 2024 13:50:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: Patch "igc: fix a log entry using uninitialized netdev" has been
 added to the 6.9-stable tree
Message-ID: <2024070852-spoils-detached-2c2b@gregkh>
References: <20240705192937.3519731-1-sashal@kernel.org>
 <ZouY6i1Oz77wGC77@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZouY6i1Oz77wGC77@calimero.vinschen.de>

On Mon, Jul 08, 2024 at 09:44:42AM +0200, Corinna Vinschen wrote:
> Hi Sasha,
> 
> my patch should not go into the stable branches.  Under certain
> circumstances it triggered kernel crashes.
> 
> Consequentially this patch has been reverted in the main
> development branch:
> 
>   8eef5c3cea65 Revert "igc: fix a log entry using uninitialized netdev"
> 
> So I suggest to remove my patch 86167183a17e from the stable branches or
> apply 8eef5c3cea65 as well.

I've queued that up as well now.

thanks,

greg k-h

