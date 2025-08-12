Return-Path: <stable+bounces-167163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5CB22A05
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E47AA072
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC73074A4;
	Tue, 12 Aug 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDuo6LzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742430749C
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008137; cv=none; b=RPaKv7RXanqWp0liShiK5mVz9OUBWRahu37dfMlW6FogAcxAWPSGlj0Ed/tWh7IB3dhlRG3YpAICO8wyAbzn+I8kmFU0tTcjyR3pTZoltBvca3Z1ZFPoDgVdOV8EOSVL8BHAUlHsd0leTIl/B51DoC1qckBD7ooAMaLRj2RWkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008137; c=relaxed/simple;
	bh=JrQRLPolKpFY3JEARgxKy7PE8/lNdkw0MbKXRP0zeJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1MwNgHeQHa09/ASCq9yYcnsghXoK3TbcbcrKPiK1kpg/yYS2fX3KD0TEFCVPRu9sm1m0cy0nGAJ2DbM8k7bZzxEMK9dtVu3HhkDqwYGCPlcx4pFcncu/bym/XDI7mpEsS9nazTPCV5+MpxoZz/a6WvoV6FsX2NlstugC97NA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDuo6LzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A88EC4CEF0;
	Tue, 12 Aug 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755008137;
	bh=JrQRLPolKpFY3JEARgxKy7PE8/lNdkw0MbKXRP0zeJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDuo6LzGVfmy9IkFlfvcngt3UG2qBno3XtA1FDv7Ejt3dP3XobKfuYeXnLQ9bO1Ix
	 GfzH5MgiPqpvn/zPE9DSoYbn2XciGiGHInvqkA71viVhNYyJoypw1S+4KW5mQlap7R
	 4FyXcHTioyMen7Fc4mYV0lh/7Ew7xOtRCeLmzCu4=
Date: Tue, 12 Aug 2025 16:15:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Achill Gilgenast <achill@achill.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stable-queue] scripts/quilt-mail: add my email address to
 the 0th mail CC list
Message-ID: <2025081221-defective-denatured-7f2f@gregkh>
References: <20250812132440.423727-1-achill@achill.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812132440.423727-1-achill@achill.org>

On Tue, Aug 12, 2025 at 03:24:30PM +0200, Achill Gilgenast wrote:
> Now that I have a proper email address, add me to the CC list so I don't
> have to subscribe to <stable@vger.kernel.org> only to get this mail.
> 
> Signed-off-by: Achill Gilgenast <achill@achill.org>
> ---
>  scripts/quilt-mail | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/quilt-mail b/scripts/quilt-mail
> index e0df3d935f..531d9fafb9 100755
> --- a/scripts/quilt-mail
> +++ b/scripts/quilt-mail
> @@ -181,7 +181,8 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
>  	  "rwarsow@gmx\.de"
>  	  "conor@kernel\.org"
>  	  "hargar@microsoft\.com"
> -	  "broonie@kernel\.org")
> +	  "broonie@kernel\.org"
> +	  "achill@achill\.org")
>  
>  #CC_LIST="stable@vger\.kernel\.org"
>  CC_LIST="patches@lists.linux.dev"
> -- 
> 2.50.1
> 

Applied, thanks.

greg k-h

