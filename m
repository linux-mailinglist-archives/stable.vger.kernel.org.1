Return-Path: <stable+bounces-172697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D367B32E0D
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755EC175386
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E324729D;
	Sun, 24 Aug 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLSUeIXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB211CA9;
	Sun, 24 Aug 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021968; cv=none; b=fWTWWFxgPPvduR7mitvN6+joNZPkue5Tg4wIap6uOjq8aBbC335ea7ru5s26uly3NCfkDCh9TgNpKhYi4WBHNsripJkZUV1YCbNOv3upWSjf8XHL9a/V5DGDCNQeWWblzA2KkYBQYOyqozv2ZA0578OVbSAqiKGnnwlZGR/D0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021968; c=relaxed/simple;
	bh=Guc/SQQ5h1bkuCtE0QKVBigq55j1VmJzs10vOXRwnPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/d3O1M6SpdqE6Xa+SaJdYpoNZWEoClzNv28k7TXHGYrgZA/H2je00hB381WBE1hp3tqXpihZbGl1gIWMOvqKCoKNlFEIPe51IiJxJwAcf7xgtKv+xlHdMOhQBpdjdmEJ/ffQ1lLE0gezaIEfYxl7F/RTul9jVX8M2rXdGo/E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLSUeIXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10424C4CEEB;
	Sun, 24 Aug 2025 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756021967;
	bh=Guc/SQQ5h1bkuCtE0QKVBigq55j1VmJzs10vOXRwnPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLSUeIXKkCGtczdimE1ChCQdfcazmuy6x4ZFoNL9dtOB7Z0dDW0Ni+0tqHU3J1/XP
	 3MumLDdVLsyUfvFfy+AvOsqYG4wdIt7ec2ASj27Y25+gNUEdNvLaKRae41kp64Yi17
	 +136UtNMaklsfapTtJhU8/7buNGLiILWkixvV7AI=
Date: Sun, 24 Aug 2025 09:52:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus@blochl.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	markus.bloechl@ipetronik.com
Subject: Re: [PATCH] ice/ptp: fix crosstimestamp reporting
Message-ID: <2025082425-studio-foam-1975@gregkh>
References: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>

On Fri, Jul 25, 2025 at 10:33:31PM +0200, Markus Blöchl wrote:
> From: Anton Nadezhdin <anton.nadezhdin@intel.com>
> 
> commit a5a441ae283d upstream.
> 
> Set use_nsecs=true as timestamp is reported in ns. Lack of this result
> in smaller timestamp error window which cause error during phc2sys
> execution on E825 NICs:
> phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument
> 
> This problem was introduced in the cited commit which omitted setting
> use_nsecs to true when converting the ice driver to use
> convert_base_to_cs().
> 
> Testing hints (ethX is PF netdev):
> phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
> phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0
> 
> Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Markus Blöchl <markus@blochl.de>
> ---
> Hi Greg,
> 
> please consider this backport for linux-6.12.y
> 
> It fixes a regression from the series around
> d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
> which affected multiple drivers and occasionally
> caused phc2sys to fail on ioctl(fd, PTP_SYS_OFFSET_PRECISE, ...).
> 
> This was the initial fix for ice but apparently tagging it
> for stable was forgotten during submission.
> 
> The hunk was moved around slightly in the upstream commit 
> 92456e795ac6 ("ice: Add unified ice_capture_crosststamp")
> from ice_ptp_get_syncdevicetime() into another helper function
> ice_capture_crosststamp() so its indentation and context have changed.
> I adapted it to apply cleanly.
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 1 +
>  1 file changed, 1 insertion(+)

This is already in the 6.12.42 release, so we don't need to apply it
again, right?

thanks,
greg k-h

