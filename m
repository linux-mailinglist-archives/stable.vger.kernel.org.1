Return-Path: <stable+bounces-5268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B980C47D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628E11C20976
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57A21347;
	Mon, 11 Dec 2023 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2r1tbDIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C521340
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D8BC433C7;
	Mon, 11 Dec 2023 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702286731;
	bh=ljlyPaJsxaEppisJ7zYZeYdls4iT1wr4AJRvS5wWfaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2r1tbDIrjWRjZoHEuON3Wn/gx+6rCTjIrSBx4gFWIdWgTFXQoZFAb3nD533mF00CZ
	 i7cqeU/VXItRIVRQkyEI0FPDi3RiDu9TGW+xJ7jrWkF84632YOPoEsHD0mOUQXlVlG
	 DCy4lYNy5LKrbPP2UqilhgEjwkvjPV90o7Sshfhg=
Date: Mon, 11 Dec 2023 10:25:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2023121139-scrunch-smilingly-54f4@gregkh>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>

On Mon, Dec 11, 2023 at 04:02:11PM +0700, Philip Müller wrote:
> Hi Johannes, hi Greg,
> 
> Any tree that back-ported 7e7efdda6adb wifi: cfg80211: fix CQM for non-range
> use that does not contain 076fc8775daf wifi: cfg80211: remove wdev mutex
> (which does not apply cleanly to 6.6.y or 6.6.1) will be affected.
> 
> You can find a downstream bug report at Arch Linux:
> 
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17
> 
> So we should either revert 7e7efdda6adb or backport the needed to those
> kernel series. 6.7.y is reported to work with 6.7.0-rc4.

Yeah, this looks bad, I'll go just revert this for now and push out a
new release with the fix as lots of people are hitting it.

thanks,

greg k-h

