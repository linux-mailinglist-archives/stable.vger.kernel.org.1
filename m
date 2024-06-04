Return-Path: <stable+bounces-47938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4898FB7EC
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA8A1F21BF8
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0413C9CF;
	Tue,  4 Jun 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ti8A6U98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3914884C
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516038; cv=none; b=g1eO9PFaqE2WbJgArAFt+R4qdcxcz4cgzNDVtRMxL0633UEiWxRfkQlqc51iBTYfEigM6Cu2eu4Hxm1E8fCuX7dTnDWbaG5r3qm9E1KK6Lbv+MHcjW10/V5O0bStCbp5Wv8t0TQ2c63L/EVL9hlwDhnTqETiJq+eos7F/k7T7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516038; c=relaxed/simple;
	bh=/qfGLKowwJOObnt/5ckYY8o+3jDz4luaAEq+AP0TtV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkwK7Q2291JxeG5JmnN5bapa7xyIEj6JBZbFlfHvdqL5hysgkCIxXLb2mwJByLOUO9SSvsURgxd0dJJnZyNfynHQ5zFaQ+Srby2Mgs/VNd7Mu5u0WtxgvhSsAxKD+ZxK9VX+4GZhtZ8CgJG6f6+N4uDoKrGwjK/pARZLhEDhCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ti8A6U98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BEC2BBFC;
	Tue,  4 Jun 2024 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717516037;
	bh=/qfGLKowwJOObnt/5ckYY8o+3jDz4luaAEq+AP0TtV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti8A6U98PIp4Nj1/m+SXlO81sYBOFCUqzhC7DI0oxNR6bAdUruyyopijCwmDxeixO
	 KfPu5SplbQXPEhuZenLVtgD1eD/hIzP3SHKvo7v+nWiWEucSE4VUG+i2edeVaMHP+T
	 7CmkpWlm/zhiy6Ke7dm7eJp4n0p92xhjrtwRAEeI=
Date: Tue, 4 Jun 2024 17:44:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
Message-ID: <2024060452-headrest-deny-2a5b@gregkh>
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>

On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffstätte wrote:
> 
> Just ${Subject} since it's a fix for a potential security footgun/DOS, whereever
> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
> has been queued up.

Only applies to 6.9.y, have backports for older kernels?

thanks,

greg k-h

