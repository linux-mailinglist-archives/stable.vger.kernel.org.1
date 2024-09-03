Return-Path: <stable+bounces-72774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B729E969687
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734351F24D29
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77337200117;
	Tue,  3 Sep 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUfXVutr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBC1D61AB;
	Tue,  3 Sep 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350823; cv=none; b=HxMrpBEJaLiJqr6S42VrKAHP2lhw95LiWIDsRpE3Qn3NUxN/Na3GULjMrryqK/JKW11RiCLDPcd3oIW9R55YaEFBIUcFmKuBPGHsyBExtGIfiOc7FankaeFZxpFztHfssn0pvQOrHMYjmqnCffVBPpDvulNj4TyozLXOMDyVB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350823; c=relaxed/simple;
	bh=X4UK3YIRDKdGN7VInf5F624NqDQKUAQ265vVfjMiOZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWqEaucpwKcU7PTsbDIfJkItK4mX+KwOsRrl/775kw/zbKEaBeQBuGV3NOnFm/ZttMpv1lstrCWsmFeWFWW5frKzgRFeP037djV71jeICVD2RzeZ0nD6HrG/Ys76vKoqjQegJopiazXPiFIBo0MeyCldmF1+AX+6Fv0cccjQl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUfXVutr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0FC4CEC5;
	Tue,  3 Sep 2024 08:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725350822;
	bh=X4UK3YIRDKdGN7VInf5F624NqDQKUAQ265vVfjMiOZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUfXVutr8k2yQrknZ0NIxgtcvLF+/DsK2Ntu62okq7dOvueFgKgKNaJtI9vLek+3a
	 8xK1bE1Rt0LWnFWYQXuOBFUZvlzNtLSltVsQMJj3AxwTQEdMPndJSYbbe/E0KjFx1A
	 WBWOSWTVhw55duMxbdugGL7FUe09oazHnD600WUc=
Date: Tue, 3 Sep 2024 10:06:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix cable registration
Message-ID: <2024090331-confiding-preflight-a260@gregkh>
References: <20240830130217.2155774-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830130217.2155774-1-heikki.krogerus@linux.intel.com>

On Fri, Aug 30, 2024 at 04:02:17PM +0300, Heikki Krogerus wrote:
> The Cable PD Revision field in GET_CABLE_PROPERTY was
> introduced in UCSI v2.1, so adding check for that.
> 
> The cable properties are also not used anywhere after the
> cable is registered, so removing the cable_prop member
> from struct ucsi_connector while at it.
> 
> Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++---------------
>  drivers/usb/typec/ucsi/ucsi.h |  1 -
>  2 files changed, 15 insertions(+), 16 deletions(-)

This doesn't apply to my usb-linus branch at all:

	checking file drivers/usb/typec/ucsi/ucsi.c
	Hunk #1 succeeded at 965 (offset 54 lines).
	Hunk #2 FAILED at 941.
	Hunk #3 succeeded at 1203 (offset 52 lines).
	1 out of 3 hunks FAILED
	checking file drivers/usb/typec/ucsi/ucsi.h
	Hunk #1 succeeded at 465 (offset 30 lines).

Can you rebase and resend?

thanks,

greg k-h

