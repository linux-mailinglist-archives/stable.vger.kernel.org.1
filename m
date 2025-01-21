Return-Path: <stable+bounces-109616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73892A17EC8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F641646B7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689161F2364;
	Tue, 21 Jan 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2zrEiqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26896E57D
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466047; cv=none; b=o0Su5OKD+jTygeMWhmWAOiQWW73L2AJzl0jis2HVBYl9vddXAtejkQXZMDPq319Qrpd+x53hK83qnobhtKNXcubffZqsAns1yDHEuGJd0LpyUZf9ShC9CUnr2deU+P85fVNlgOxuJdGx21D0Fil+iR+A1fyxOs/cVCxNfome364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466047; c=relaxed/simple;
	bh=dZbLVP6Jq8BkvWQLa3pP/11PrHEbM/Se8oTySur6lIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB6SuZb6mqYVd4s8oGL5z0cnV0knpSwPNq+MnypLzOSa/Ezb4BNeH6kzLS35UYUnYKoSbWfzV9MYYf3jcv/eyTRlOYiSXV1tv0Q6xIFaWBAIv2Obs2578aRu2d6DY/6Sp8ZOn12OuI7bEOzWTsgmvHiI0WFwteey41fQv4K3hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2zrEiqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5086AC4CEE0;
	Tue, 21 Jan 2025 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737466046;
	bh=dZbLVP6Jq8BkvWQLa3pP/11PrHEbM/Se8oTySur6lIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2zrEiqLcfy7pNcCE1r4D3mIXXK9JO5boVdkv7RANd2Gus8dfT2H/U6rh9SCc13mf
	 6/vWtt2fYuYnS9upJg3NqxxotG2YNe4sJnTMXWEIuv9Kf0nl+P5Yb5Fq8p5QtmZicG
	 2juoH04VBgnjbviHfmxPx2NBUZoB7QeuIznVpkko=
Date: Tue, 21 Jan 2025 14:27:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: stable@vger.kernel.org, broonie@kernel.org, rafael@kernel.org,
	demonsingur@gmail.com
Subject: Re: [PATCH 6.1.y] regmap: fix wrong backport
Message-ID: <2025012107-playmate-hulk-b0bb@gregkh>
References: <20250115033244.2540522-1-tzungbi@kernel.org>
 <2025012144-whinny-haggler-9aba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012144-whinny-haggler-9aba@gregkh>

On Tue, Jan 21, 2025 at 02:23:31PM +0100, Greg KH wrote:
> On Wed, Jan 15, 2025 at 03:32:44AM +0000, Tzung-Bi Shih wrote:
> > 48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
> > wrongly backported upstream commit 3061e170381a.
> > 
> > It should patch regmap_exit() instead of regmap_reinit_cache().
> > 
> > Fixes: 48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  drivers/base/regmap/regmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> How about submitting a revert of the mistake and then the original
> commit properly backported as a patch series of 2 commits?  That way it
> makes it more obvious what is happening here.

I've done the revert now, a fixed up backport would be appreciated now.

thanks

greg k-h

