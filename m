Return-Path: <stable+bounces-114495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EACA2E7A8
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477611886FBD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EC19AD8D;
	Mon, 10 Feb 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFqXMA5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59515B543
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179836; cv=none; b=s/CbYI+cnlJhSJEACoZiBtGLRCupjWpz2X70uwzNuNkfSA9RROOY4zTr38n7YWFOjWGdRMEbTspxKmgOTPaSRhBa1jh/5vMoIBKk9qSfx/FD99HGByiSom7Dn5vch0f21j7FJAP+03JKRkVGeJbm33uQmpGjiKC9MyZCQs5daGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179836; c=relaxed/simple;
	bh=u+rw1Mstm2dWgWaGuJrPmlwwqT2udLjm30G8ZwYTOUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9dmMX7wO30YNRbIkUBuA7q1OaE6hC3ORDCHqcCBl1Ixt8IoM/Zlz14bcrjGQbDBaHAWnM6tcvb57ibjhlzKyoYwZ1G/wLTlBHWbYwz8n45Ku3h21BF+Zgmb+KEJI2sPeRVJHZ3SCpg6IlDFJ7IZLxCs+gX+XcsI75WTq4ilV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFqXMA5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80277C4CED1;
	Mon, 10 Feb 2025 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739179836;
	bh=u+rw1Mstm2dWgWaGuJrPmlwwqT2udLjm30G8ZwYTOUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zFqXMA5d7elrol9JbCgzlyULDkx+pHSwqGSUK3pXlNWCqrasEcYoPfOxcpDmxXoFP
	 wltcj1I/ITZKiBtGF7W91LICBGO4K/nDFJGnBnhenS0J4qFw2qMOW2ybcibzsDuPGj
	 Wvi8z3w3RT9MprRvTV/vA2YQm01dgEhnM9izsD9g=
Date: Mon, 10 Feb 2025 10:30:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>,
	Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH v5.15-v5.4] lib/generic-radix-tree.c: Don't overflow in
 peek()
Message-ID: <2025021059-waking-parlor-c55d@gregkh>
References: <20250210091546.208211-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210091546.208211-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 10:15:46AM +0100, hsimeliere.opensource@witekio.com wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> [ Upstream commit 9492261ff2460252cf2d8de89cdf854c7e2b28a0 ]
> 
> When we started spreading new inode numbers throughout most of the 64
> bit inode space, that triggered some corner case bugs, in particular
> some integer overflows related to the radix tree code. Oops.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  include/linux/generic-radix-tree.h |  7 +++++++
>  lib/generic-radix-tree.c           | 17 ++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)

Why is this needed in these older kernels?  Is there an existing
workload that triggers this that this fixes?

thanks,

greg k-h

