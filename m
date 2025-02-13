Return-Path: <stable+bounces-116306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D8A34873
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999A43AFE36
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF41FECC0;
	Thu, 13 Feb 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CbwYrvMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27E194080;
	Thu, 13 Feb 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461182; cv=none; b=AzLSE2wz1QqcjbApWNIJrL3wFYaXxkNDBHW7ysNfHrTGJ1SVg8y7rhgu2t887qQ6j/J/1T+rd8nV1PAKXxSkmwLxnRhnei5AE19bFO4MOTKCIdzEXpUM7ZK6C5FHF0Za+Cqqw4gurSawoX7v0mGY8Oam9t5tTTZ8Zdur+Tf2Hdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461182; c=relaxed/simple;
	bh=N7VgWC9txPrYH43ZJC6BIPtNVK/FbLcCcfiWGu1tJw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaPlRW1uLqSIyXGJFQXrQa0aUHsLIYTstiqqeD/MMlSCH4JpyXivBHYwzPLf86IZD7gjWFTpStAaFAjKGdGkgjxX7KPMfqGxrw8s9XX3eCXOXhnuQ/YLm39eWohmcVzKg/ey7W/lOtn1TrSRNvAn5063tr2S+y3DQ7/rUilBZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CbwYrvMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40256C4CEE5;
	Thu, 13 Feb 2025 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739461180;
	bh=N7VgWC9txPrYH43ZJC6BIPtNVK/FbLcCcfiWGu1tJw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbwYrvMVYyU8YexgFtVOz1C5FBWtZIBB9RmDRka1ijjeiyeMSQRsgGn1XPNFLRgIQ
	 Zy9pkNgsUeYdqUvRQCjILJdIw/ov0aYbFN8lQO2NJlQeglQ6SxJw9bGzb9x0DULzzb
	 V+a5YeOfOCr+U0LUByT0TmUkg/1FeVGcEk3odCS4=
Date: Thu, 13 Feb 2025 15:51:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, stfomichev@gmail.com,
	shannon.nelson@amd.com, darren.kenny@oracle.com
Subject: Re: [PATCH 6.12.y 0/2] Fix rtnetlink.sh kselftest failures in stable
Message-ID: <2025021346-lankiness-vagabond-60d5@gregkh>
References: <20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com>
 <a33f888c-2121-46c0-8fcb-7ba469309a8b@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33f888c-2121-46c0-8fcb-7ba469309a8b@oracle.com>

On Thu, Feb 13, 2025 at 08:14:25PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 09/02/25 00:25, Harshit Mogalapalli wrote:
> > This is reproducible on on stable kernels after the backport of commit:
> > 2cf567f421db ("netdevsim: copy addresses for both in and out paths") to
> > stable kernels.
> > 
> > Using a single cover letter for all stable kernels but will send
> ...
> > Solution:
> > ========
> > 
> > Backport both the commits commit: c71bc6da6198 ("netdevsim: print human
> > readable IP address") and script fixup commit: 3ec920bb978c ("selftests:
> > rtnetlink: update netdevsim ipsec output format") to all stable kernels
> > which have commit: 2cf567f421db ("netdevsim: copy addresses for both in
> > and out paths") in them.
> > 
> > Another clue to say this is right way to do this is that these above
> > three patches did go as patchset into net/ [1].
> > 
> > I am sending patches for all stable trees differently, however I am
> > using same cover letter.
> > 
> > Tested all stable kernels after patching. This failure is no more
> > reproducible.
> > 
> 
> Ping on this series:
> 
> 6.12.y: https://lore.kernel.org/all/20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com/
> 
> 6.6.y: https://lore.kernel.org/all/20250208185711.2998210-1-harshit.m.mogalapalli@oracle.com/
> 
> 6.1.y: https://lore.kernel.org/all/20250208185756.2998240-1-harshit.m.mogalapalli@oracle.com/
> 
> 5.15.y: https://lore.kernel.org/all/20250208185909.2998264-1-harshit.m.mogalapalli@oracle.com/
> 
> 5.10.y: https://lore.kernel.org/all/20250208190215.2998554-1-harshit.m.mogalapalli@oracle.com/
> 
> I noticed new stable rc tags being released, so pinging. Sorry if I pinged
> before you got to these.

No, thanks for the ping, these fell through the cracks, I'll queue them
up for the next round after these.

thanks,

greg k-h

