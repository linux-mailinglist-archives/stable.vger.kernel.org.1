Return-Path: <stable+bounces-21818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A0A85D61A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889281C224CD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724D3C067;
	Wed, 21 Feb 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vC9u+Mve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A073A1C1
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512848; cv=none; b=Ncl9iPxZAi+ZOfoR9PYjYE5bOpXekoTVvCRxeNELY1n+X3A6mk1a77z0ky2JLolcrayN+Em63jOVdSQMtg3HfW8TQ+dRDrqQtfwyEcNg1ME4KVumZKKfib9ZU3HnL3eTMfxYiYrlIX7YIjVMKk8QHKcU7qVn+8rwakxNO6a4sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512848; c=relaxed/simple;
	bh=Dn4h5PqCIg9EZ6kpalEQzTRoeKJSK/CBggj0dgKUqUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjZs19Dv6PjE4xGnLyJl0LyeSx4dLBDj3AU+3l/MRuLA6xRFAAInXPnCXkp3SLdZk2mX1UhXuZOMdVtBDYNnl//tCGL0FSWEE8DX30WAs54MNywoMe9ezlHMsZprf/LjOHxoNxKJ+QlGL5tcxo8AVRIT7suBGAMCKowbZZvpxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vC9u+Mve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6058DC433C7;
	Wed, 21 Feb 2024 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708512847;
	bh=Dn4h5PqCIg9EZ6kpalEQzTRoeKJSK/CBggj0dgKUqUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vC9u+Mve7VB+i+q5AVgcct96pCu/uOdwG+4vZEbGU4DN1j5tFGK6ijNUQ3snLkJoR
	 Cr5/Cvi+xXjLNPaA+KJbOgP/+BKFp4BeAaCFg+OqRwtxDJUVv0GQRa4GjnUZOC9Mw9
	 lymK8enL+Lxsxp19EJwmZ8g9ymJnX3iBmaGgjEc4=
Date: Wed, 21 Feb 2024 11:54:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Allen <allen.lkml@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Patches for v5.15.149-rc
Message-ID: <2024022141-bonus-boozy-44c8@gregkh>
References: <CAOMdWSKyoAgFHiSnfbPKELB57295VTBqh-mvjPd--MCDU-uvyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSKyoAgFHiSnfbPKELB57295VTBqh-mvjPd--MCDU-uvyw@mail.gmail.com>

On Tue, Feb 06, 2024 at 08:28:04AM -0800, Allen wrote:
> Hi Greg,
> 
>    I believe these patches are likely already on your radar. I just wanted to
> inform you that it would be highly appreciated if we could see their inclusion
> in the upcoming release.
> 
> e0526ec5360a 2024-01-30hv_netvsc: Fix race condition between
> netvsc_probe and netvsc_remove [Jakub Kicinski]
> 
>   We would like to even get:
> 
> 9cae43da9867 hv_netvsc: Register VF in netvsc_probe if
> NET_DEVICE_REGISTER missed
> 
> included, but the patch is still in netdev and has not made it into
> Linus's tree. If it does come in,
> could you please consider including it too.

This last did not apply to all of the relevent kernels, please provide
backports if you need them there.

thanks,

greg k-h

