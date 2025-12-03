Return-Path: <stable+bounces-198215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE94C9F22A
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 908683486F9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EEC2F6914;
	Wed,  3 Dec 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0vwydmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADF2E719B
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768530; cv=none; b=mQB4Sz0N2G+LR9hD2qIqDsF9wQcgvcn8uxCNZ4m1LaovHttMB8ZPT1lHhPBaSpby8r+XuHPAaYjUtdGg3tXrEFpO3cep87KhcZSEN47nZ0pl2vAPsOlXeaXsWamT1RmHNlRwLXiFgYo/mD5juC1b28g9tU1tZGbmNC4RGDyUy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768530; c=relaxed/simple;
	bh=PPwtTQSeUT19c+DjAM5k5mLVt4TRwypSlG2x+P4B1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeOFVma3ANe/0jK/YRV3RKG6ObgVySSXbttfutYLA2RaJoS7tFpednN7KqzOeQmxVDgUcp6wrZN2V2fR4F+ZG83jRM78wJTvUV2yQlZ52EVFnFHF5XcTrYnmWRXY5WKdTU7W1k59mH7BMpKrEqZY8Fjq0ilRNU7m5x3x0HUH4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0vwydmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E567C4CEFB;
	Wed,  3 Dec 2025 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764768529;
	bh=PPwtTQSeUT19c+DjAM5k5mLVt4TRwypSlG2x+P4B1p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0vwydmgeBu7zcY2tLBbA+hnDLWeH5ZjVLr7o1e++qrsklF6qvvD8cL17daZEcrlO
	 DMM7s+w5xUJilKxSjSrW7A4F1t0r2j1uCkxZwONJbJ3gdGxxLRjHXVNV2zfCXiqg+D
	 2wETrh6DMO2aXWFutcihLuk/7FoGva7Ab3C7k4QM=
Date: Wed, 3 Dec 2025 14:28:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Subject: Re: please consider to backport "drm/i915/dp: Initialize the source
 OUI write timestamp always"
Message-ID: <2025120339-lusty-panorama-82e5@gregkh>
References: <23A212C2-BFAB-469C-AAED-375E979B9179@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23A212C2-BFAB-469C-AAED-375E979B9179@goldelico.com>

On Sat, Nov 29, 2025 at 06:34:37PM +0100, H. Nikolaus Schaller wrote:
> Adding this patch solves an observed 5 minutes wait delay issue with stable kernels (up to v6.12) on my AcePC T11 (with Atom Z8350 Cherry Trail).
> 
> Commit is 5861258c4e6a("drm/i915/dp: Initialize the source OUI write timestamp always") resp. https://patchwork.freedesktop.org/patch/621660/
> 
> It apparently appeared upstream with v6.13-rc1 but got not backported. 

Now queued up, thanks.


greg k-h

