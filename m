Return-Path: <stable+bounces-8311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815ED81C509
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FD51C22FBD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C06FD2;
	Fri, 22 Dec 2023 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vp0MRYAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA1C2F0
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 06:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD7C433C7;
	Fri, 22 Dec 2023 06:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703226386;
	bh=XcKIoXgpDSyt3kzpK2C0nyN/RTN7pVvzRwQ/qHSEP88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp0MRYAYY5NS4Tl5FAve1ma7lyZG7Xvyrq/aG/KupEjkTXpf0EMa8bscK4PEWxHql
	 0XA/VvwzEj0HLog/D0a0Y37Se+IAtKLTKSK6K/L0G8LFhWeqBht38RD93XD+EqgAgC
	 sjl0IWczoal5EVgitSL6B319Q12500U8U9X2afK8=
Date: Fri, 22 Dec 2023 07:26:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Anthony Brennan <a2brenna@hatguy.io>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix missing xas_retry() calls in xarray
 iteration
Message-ID: <2023122200-outsell-renewal-525d@gregkh>
References: <20231222013229.GA1202@hatguy.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222013229.GA1202@hatguy.io>

On Thu, Dec 21, 2023 at 08:32:29PM -0500, Anthony Brennan wrote:
> To be applied to linux-5.15.y.
> 
> commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream

That is not this commit at all :(


