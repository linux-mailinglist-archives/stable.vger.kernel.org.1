Return-Path: <stable+bounces-189863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19594C0ABB4
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2FD3B3484
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE681DF99C;
	Sun, 26 Oct 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pDSKd5qs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DC2ED871
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490689; cv=none; b=VwU60CUHZegW+w17OA5xo3DTxYaXiPBno4zmjWTgbbbGJAOaHTR2u0HaJqeYHEQO//ry25NQ2hG2BRfWcLp46TXEImJW2pPTC95fmYIXsNe6QRSNidVJe0vAdI6Jq74abYc281pZgPzXtzoq3QGKLL5pMX9cPzwddYWXTAYEyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490689; c=relaxed/simple;
	bh=W6g9ECBFwoiFsvntgPR09QMYMn8OIKtmEAuAS7uxPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY+nNx8uxXrr6rqkC7x+vekWXYrTRZkui19/mMnJ9w7cI6bTR1al8bh37txy6+ugCcHOcTf0PCMB533CEh4itq/pzvH8cPTyT65hq+ck6+AKbdkhRm6IHzWDpoi5pNaQt1TNqFhw/ynIh6LYa16N2979vATRqyeBIlsdw0Z3dYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pDSKd5qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86973C4CEE7;
	Sun, 26 Oct 2025 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761490688;
	bh=W6g9ECBFwoiFsvntgPR09QMYMn8OIKtmEAuAS7uxPhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDSKd5qsIptN+/Jn+JcHFXtzQd+4kh4fA3JxhhosxGz8mkEP98qNDZXBYN/zMw1gF
	 VB7ag33U0W7oqGcHXVvE9xXQmjOcmzpf4UPkJFPPsrDcePPBZJdO6NVfeiy7mcQq4l
	 O/nBGXqcSrP/hMgI4lojKmu6w3UJczGxty0R3RqY=
Date: Sun, 26 Oct 2025 15:58:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Guido Berhoerster <guido+debian@berhoerster.name>
Subject: Re: Please apply commit d88a8bb8bbbe ("Bluetooth: btintel: Add DSBR
 support for BlazarIW, BlazarU and GaP") to 6.12.y
Message-ID: <2025102658-resigned-portly-0aba@gregkh>
References: <aPyGqPklZSrC7FJ2@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPyGqPklZSrC7FJ2@eldamar.lan>

On Sat, Oct 25, 2025 at 10:13:28AM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> Guido Berhoerster asked in Debian (https://bugs.debian.org/1118660) to
> consider adding support for bluetooth device of BlazarIW, BlazarU and
> Gale Peak2 cores, which landed in 6.13-rc1, via d88a8bb8bbbe
> ("Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and
> GaP").
> 
> While it is not exactly a bugfix, as things were not working
> beforehand as well, this type of hardware might be very common during
> the lifecycle of users for 6.12.y stable series.
> 
> Can you consider picking the commit for 6.12.y?

Now queued up, thanks.

greg k-h

