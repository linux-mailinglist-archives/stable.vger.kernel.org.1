Return-Path: <stable+bounces-152857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE8ADCE29
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D201886D9B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB372E3AEE;
	Tue, 17 Jun 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2HjHfSty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC952E3AE1;
	Tue, 17 Jun 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168050; cv=none; b=QwU3Ydkkh/y+poauWFEdm5alIW1MSuV+fIDN58tQkpUscC7Ccvh8DFp0unxvbs2HNR4Fdu+NLE3bciNdUxUjCf6Kdv0KV3fUNjDHVRLEwOtBLn6X3dAtI6KMJXFehJaWdaNre66tOOLI1n72M8XiQtNLXGa7Pe6QcMZG3Zm9AoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168050; c=relaxed/simple;
	bh=eyMyGSNcqvteFG0DIEAevWESbOEqK0pVOYgeH8sLEoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT3+qaQEJJMPhkO6dVNzBswa/ZDSMjOC4EPjscQI21nTEfyx+IcEGU0BydoBl1jOUclDMTdF4OwVgMMOy6gdVffmrLFKTooFceIPFlsk5h+dy4eLFwZvw/sDk9AOEsCoXHEDlRGUWryShzD6uu8PA5UrjTsyv1ALaWwjHhSA2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2HjHfSty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC07FC4CEF2;
	Tue, 17 Jun 2025 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750168050;
	bh=eyMyGSNcqvteFG0DIEAevWESbOEqK0pVOYgeH8sLEoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2HjHfStyBvtrCdn0mLxQ3+AvlvM0MP/56taSpPPzqGLQ/bdKnbQQtww2/CSFAN/oT
	 skv+s23hXPhZZrAuAEG7w/slj7urPg10Kq8f5hKEZJug5l66vn0k8in55UYpc/kRmu
	 H50a2OOYiUqYoAf+WipQ+1AtCjeHphwRBL0sBid0=
Date: Tue, 17 Jun 2025 15:47:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett Sheffield <bacs@librecast.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <2025061745-calamari-voyage-d27a@gregkh>
References: <aElivdUXqd1OqgMY@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aElivdUXqd1OqgMY@karahi.gladserv.com>

On Wed, Jun 11, 2025 at 01:04:29PM +0200, Brett Sheffield wrote:
> Hello Stable Maintainers,
> 
> Longterm kernel 6.12.y backports commit:
> 
> - a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in cork"

It's also in older kernels:
	5.10.238
	5.15.185
	6.1.141
	6.6.93

> but does not backport these related commits:
> 
> - 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6 cookie initializer"
> - 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init calls with ipcm6_init_sk"
> 
> This causes a regression when sending IPv6 UDP packets by preventing
> fragmentation and instead returning EMSGSIZE. I have attached a program which
> demonstrates the issue.

Should we backport thse two to all of the other branches as well?

thanks,

greg k-h

