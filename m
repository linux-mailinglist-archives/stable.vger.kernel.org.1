Return-Path: <stable+bounces-8740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126B8204A4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD17B21261
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387D7481;
	Sat, 30 Dec 2023 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3GGw3DC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446C8BE3
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E14C433C7;
	Sat, 30 Dec 2023 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703936484;
	bh=CqdDnFAbI8FhaFclS9aGSJD2BLFwugjEz1oimhQ0BRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3GGw3DCfcegfpIFsXOYLINFgtzqfg3cK2qmCOpXpkylpN4BsZ5JB/Vekv0ucppwV
	 3ReFU5XJ4W/hPz/EDh2zMi6pXRBi4zrATY6+NYgtONJwj4jXHIdWDcPtc43Q4rrho7
	 ZH37BAVXf7TAa+SWKtfpE2q28LJjyTwboDHKE5XQ=
Date: Sat, 30 Dec 2023 11:41:21 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Anthony Brennan <a2brenna@hatguy.io>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix missing xas_retry() calls in xarray
 iteration
Message-ID: <2023123046-faceted-latticed-1e0c@gregkh>
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

No, this is a merge commit, sorry.  To quote my bot:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

