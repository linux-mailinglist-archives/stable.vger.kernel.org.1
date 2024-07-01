Return-Path: <stable+bounces-56285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C591EA78
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D2E1C213B0
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9252171655;
	Mon,  1 Jul 2024 21:48:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6F2C1BA;
	Mon,  1 Jul 2024 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870538; cv=none; b=sYki0l9oiN3mzYoYMt1znP8es1bLTax8YaFLW7psOeX2wdkPw5CCmJsKQy/i1h8gIlOsYUbKrsrZ4qXwN8i/+TJ5/ZyhxRM+vT9cr+eoriL8R7TwHLXgd56n6bWRSv6kctKZVA8afrM2b0gITruzrKaQuoB1DSkgIUI66Acou9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870538; c=relaxed/simple;
	bh=GzRNisuqaSAEZ0LrxgDw5FMPxdmRSbQ8xg/Vndm7zBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ/Af82HjZ2bBuGnEzRSrNCmeRXDkd3rkLKeCEndo5Rwv0V8ZdXPoetMFZBahgdOaOXI4fh96iciEWHmAifXvOOcNd2Bd+R7KYhHJKBX+FUiTDGm34iEhIPnu54vSwRCE2HFcT2QYOc4oB68xiAMRe25DW99ko6Bv0CxczhLFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [31.221.216.127] (port=3052 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sOOtE-00HQgM-5L; Mon, 01 Jul 2024 23:48:50 +0200
Date: Mon, 1 Jul 2024 23:48:46 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org, patches@lists.linux.dev,
	Stefano Brivio <sbrivio@redhat.com>,
	Thorsten Alteholz <squeeze-lts@alteholz.de>
Subject: Re: [PATCH 4.19 164/213] netfilter: nft_set_rbtree: Switch to node
 list walk for overlap detection
Message-ID: <ZoMkPqf8AOpROvRd@calendula>
References: <20240613113227.969123070@linuxfoundation.org>
 <20240613113234.312205246@linuxfoundation.org>
 <861740945d6a21d549d82249475b6b5a573bc9ed.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <861740945d6a21d549d82249475b6b5a573bc9ed.camel@decadent.org.uk>
X-Spam-Score: -1.9 (-)

On Mon, Jul 01, 2024 at 10:51:17PM +0200, Ben Hutchings wrote:
> On Thu, 2024-06-13 at 13:33 +0200, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > 
> > commit c9e6978e2725a7d4b6cd23b2facd3f11422c0643 upstream.
> [...]
> 
> This turns out to cause a regression for nftables user-space versions
> older than v0.9.3, specifically before:
> 
> commit a4ec053812610400b7a9e6c060d8b7589dedd5b1
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Wed Oct 9 11:54:32 2019 +0200
>  
>     segtree: always close interval in non-anonymous sets

This is really fixing up userspace as the commit describes, otherwise
incremental updates are not possible on a set/map.

> Should nft_set_rbtree detect and fix-up the bad set messages that
> nftables user-space used to send?

Problem is that a non-anonymous set really needs close intervals,
otherwise incremental updates on it are not possible.

It should be possible to backport a fix for such nftables version.

I can see Debian 10 (Buster, oldoldstable) is using 0.9.0 but it was
discontinued in june 2022? But who is using such an old userspace version?

