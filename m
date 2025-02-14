Return-Path: <stable+bounces-116376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E6A3586A
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EA188D32A
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0B221710;
	Fri, 14 Feb 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GtpCyaVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433541632C8;
	Fri, 14 Feb 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520321; cv=none; b=WFc+XXBwiseFTGsZfUX8KbKXCC8AQsNp8gvtc7Tsd9WlBb2t8uxwSh569fbruQMgg3jisUmVtWM84rnlkuoka8jv0Ka5/9/lof1/mY3bxm1yt/mUzPF50UeEJKTYyHEwKLF9A3R/a8VbAG6nhuDYmFFxu4xC/uzw432/Fbr2L98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520321; c=relaxed/simple;
	bh=nwjaTMq570ei9hLgL50S/G+k7/RPwCxJ1+sRDDarSek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p05eIrTvp/nySO8BCV5UeanZdkB5wR9LgR+SiY9Emgv8urD7fWDDSYpqsJ9BoShPMac958cTRJSvH7h/v61OMJ0SV7S5a0Ho3dUwMmlAhWIZvbo90UFLycgbC3bXliS65Oo/mYxjLBbt8FhGqXUZkuhbq7fuBI5N7kDldUE+y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GtpCyaVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867BC4CED1;
	Fri, 14 Feb 2025 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739520320;
	bh=nwjaTMq570ei9hLgL50S/G+k7/RPwCxJ1+sRDDarSek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtpCyaVHdSPzoOvmYxxy/Tf7wswYglPZOZxES/zomcUpwSg3K78W/l1VKMpjFzYq+
	 Dsk3/bY4HxL3eMI9r14N0TtBT0bavyCMKwV21mfAYX8LGsHrYaQSoz0CozbjI40qfY
	 cqwUuVehO7XDmScepR/+Z/Zdc2jOuWFGxJHlx6IU=
Date: Fri, 14 Feb 2025 09:05:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: mathias.nyman@intel.com, WeitaoWang-oc@zhaoxin.com,
	Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	h10.kim@samsung.com, eomji.oh@samsung.com, alim.akhtar@samsung.com,
	thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
Message-ID: <2025021402-cruelty-dumpster-57cc@gregkh>
References: <20250213042130.858-1-selvarasu.g@samsung.com>
 <CGME20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d@epcas5p3.samsung.com>
 <158453976.61739422383216.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158453976.61739422383216.JavaMail.epsvc@epcpadp2new>

On Thu, Feb 13, 2025 at 09:51:26AM +0530, Selvarasu Ganesan wrote:
> Fix the following smatch error:
> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'

That really doesn't say what is happening here at all.  Please provide a
lot more information as the response from a tool could, or could not, be
a real issue, how are we supposed to know?

And "unassigned" really isn't the bug that is being fixed here, please
describe it better.

Same for patch 2 of the series.

Also, your 0/2 email was not threaded with these patches, something odd
happened in your email setup, you might want to look into that.

thanks,

greg k-h

