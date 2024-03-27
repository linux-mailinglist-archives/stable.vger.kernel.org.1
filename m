Return-Path: <stable+bounces-32958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65888E9F1
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A42B373E8
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9912F385;
	Wed, 27 Mar 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxI1SAnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477028E2E
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550146; cv=none; b=BtiR2zPtmFSB3+674hJKeVPHpabry1jv+VidL7pZHiegiWNDvsBNjNBVQ4W1ElIDI1+iwVbxPo1/4sMQu5gdrXbtK8VX76uzHjAkMQh9soBb7PhyAnTYvwdLMmLk/MoZfdVV66FP1rRva5YAvQYUgIyQ43J+AoEsSw9XR7ySv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550146; c=relaxed/simple;
	bh=/mJShPZSUkQEYhgDolv7Px250Da2F6cbpIB2opSvOxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t10nsMT9AQVbW1AkJ3EWihJq7Li9pYG95q01IKCC4QB0Pyxk0PLCjCV1REO9Wy6+UGJSsdb9zs1yJd8jmjJO68D/4fbe3Ux1F7CD293/8AKXPn8g7aEKX/343PUAhS+RpUUivJr2Rtnq1zQyO/dQ1VS5QdxIqRfhpkjw2HFzQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxI1SAnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C55C43394;
	Wed, 27 Mar 2024 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711550146;
	bh=/mJShPZSUkQEYhgDolv7Px250Da2F6cbpIB2opSvOxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxI1SAnvDL7Ex/bm3ENH78kRVFCTUSIxvP+LMbTzPZaeIctoSGQ+YnSA7K7TLmOnO
	 JJtqWTl3w5rJq3s7tzJhSNtCNd+CkwmuU21ZV0Ft8Ryo6CKTDC40YX9co+6rfBeqWO
	 DpWm4JoCa19bQXx8eWC41+kdtikDgG7CxjV9fhpw=
Date: Wed, 27 Mar 2024 15:35:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>, Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
Message-ID: <2024032703-wager-mandatory-d732@gregkh>
References: <20240307155930.913525-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307155930.913525-1-lee@kernel.org>

On Thu, Mar 07, 2024 at 03:59:29PM +0000, Lee Jones wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> [ Upstream commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb ]
> 
> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete().
> Reorder scheduling the work before calling complete().
> This seems more logical in the first place, as it's
> the inverse order of what the submitting thread will do.
> 
> Reported-by: valis <sec@valis.email>
> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit 6db22d6c7a6dc914b12c0469b94eb639b6a8a146)
> [Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/tls/tls_sw.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

Now qeueued up, but only this version, the older ones I've dropped from
my review queue based on the review from Jakub.  If they are still
needed, can you provide backported versions?

thanks,

greg k-h

