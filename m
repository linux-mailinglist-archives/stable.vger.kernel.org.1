Return-Path: <stable+bounces-116556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470DA3803F
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE93164D6D
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D492165EA;
	Mon, 17 Feb 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vws2W5Ps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33E101FF;
	Mon, 17 Feb 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788366; cv=none; b=rp82nUM3GGb3PHzNAm/mTxjzu9ywqEzwdHndu3G5+tmJ+g/1WdnYP71M9qo02hFUSzomrmj0w9ZoTkxyqirsSCaj4Xw+lnQ/rsTI5SpzCWnWzSDf8r3gzZGhholr0exnfMlz/m7ew3pUOVMFPd658KpOfwGJysiTlwJ5DJab2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788366; c=relaxed/simple;
	bh=mr5XtlwlHqykvXGNQxLZB9lSz3mPoMv4DXO1bz9Od3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Yv+S1nzvcOUC4ohq+7RIZdK7bPi36SJ9oCb+cGK45LFL4c+UUBUqeeCX7/VbMVl34cmQFL0S50SD3tJYhv2XyrLQwoKVUr9PbZmGklrCg0CT6m5K5HezRFhe/DCGMedM13cJXwhxovsmcqwHkO4a6i2p6bCb+mV/KsMHXxiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vws2W5Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBFC4CED1;
	Mon, 17 Feb 2025 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788365;
	bh=mr5XtlwlHqykvXGNQxLZB9lSz3mPoMv4DXO1bz9Od3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vws2W5PsD+NPh8Jq9mb40nsCAgrztsyX5z4GHJ4JhozK7elQDSHGOzkM0TBwZCGq5
	 wqfnl288kXG64Y1dftYvWTo+FfpZdgljp2vPlFx+4fZCnab9Dd9+n09otajDAA+jdh
	 5k5PeNwDQtUq6vKUrNoVDxNhhn3TXW4JZ7A56utM=
Date: Mon, 17 Feb 2025 11:32:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <boddah8794@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset
 operations
Message-ID: <2025021713-panhandle-eccentric-777a@gregkh>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-3-boddah8794@gmail.com>
 <Z636e6Vdr4FC7HbQ@kuha.fi.intel.com>
 <iuqvnem6m6okpxmto5uscj5bzgkrzszc3npcf23zus6luybhtd@mztr62veakdb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iuqvnem6m6okpxmto5uscj5bzgkrzszc3npcf23zus6luybhtd@mztr62veakdb>

On Mon, Feb 17, 2025 at 01:18:25PM +0300, Fedor Pchelkin wrote:
> On Thu, 13. Feb 15:58, Heikki Krogerus wrote:
> > On Thu, Feb 06, 2025 at 09:43:15PM +0300, Fedor Pchelkin wrote:
> > > It is observed that on some systems an initial PPM reset during the boot
> > > phase can trigger a timeout:
> > > 
> > > [    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
> > > [    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> > > 
> > > Still, increasing the timeout value, albeit being the most straightforward
> > > solution, eliminates the problem: the initial PPM reset may take up to
> > > ~8000-10000ms on some Lenovo laptops. When it is reset after the above
> > > period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
> > > works as expected.
> > > 
> > > Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
> > > system has booted, reading the CCI values and resetting the PPM works
> > > perfectly, without any timeout. Thus it's only a boot-time issue.
> > > 
> > > The reason for this behavior is not clear but it may be the consequence
> > > of some tricks that the firmware performs or be an actual firmware bug.
> > > As a workaround, increase the timeout to avoid failing the UCSI
> > > initialization prematurely.
> > > 
> > > Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion timeout value")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
> > 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thanks for review!
> 
> Should I respin the series or it can be taken as is despite being
> initially tagged an RFC material?

For obvious reasons, I can't take RFC patches as obviously you didn't
think they were worthy of being taken, hence you marking them that way
:)

thanks,

greg k-h

