Return-Path: <stable+bounces-15856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0683D21F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818B3B2233F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 01:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9104EBE;
	Fri, 26 Jan 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrXUIH4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DEEC3
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233020; cv=none; b=hxptvyWaxXRGb6BZXQk6cwdWOCkbe1vscYg9vPF1K6DmtyqXu7uMrxS1TxM6J1uYk12kdYM/iezhKvjRMdy4QXX3/RkhHxDDwvkEMUajcGYdkFHUS9kmEAwtafDr5UNdk1FwayQR2uFFB03Rfte3qUFto6NLZZA+tBwbWM4sR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233020; c=relaxed/simple;
	bh=4upX5FhtSgManI3U3NWwTBhiNaVl3llCkIcIgOHyV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCxXfo/ix7R3YFDWevKoktPU3LchP2vHAOBzRdPjNSgqlYL8+eYFcSko/FFX+sJoY4V4R6UJYinUyBsQIR9gHM1gKmLttjSYOhH+YoPN3eGcqKeeQtLq3ZOHzQh02zy/cC2DxotMZjMcHrO3/FsrI+RujgDcATpZYM5pM4hnFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrXUIH4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F9C433F1;
	Fri, 26 Jan 2024 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706233020;
	bh=4upX5FhtSgManI3U3NWwTBhiNaVl3llCkIcIgOHyV6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrXUIH4dvJQQZQ8UzBW9rxEF9If+SM1le1tBIw5eXBbusOWsMxYDgP1FL0te30Y+G
	 gsIjtHupAQ0g3sVOpnsrYmiBGxApvoFzvkGuWmmqdXhJNEpS3cHS66uz+TEacJAGVY
	 FLELUswFVdYsH2YTQBc4SvY2ZcJ7IDfHi3jb6erQ=
Date: Thu, 25 Jan 2024 17:36:59 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
Message-ID: <2024012537-pastime-bobble-8a7d@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
 <2024012246-rematch-magnify-ec8b@gregkh>
 <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
 <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>

On Fri, Jan 26, 2024 at 10:25:36AM +0900, Namjae Jeon wrote:
> 2024-01-23 8:28 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> > 2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> >> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
> >>> This patchset is backport patches from 6.8-rc1.
> >>
> >> Nice, but we obviously can not take patches only to 5.15.y as that would
> >> be a regression when people upgrade to a newer kernel.  Can you also
> >> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
> > Sure, I will do that.
> > Thanks!
> I have sent ksmbd backport patches for 5.15, 6.1, 6.6, 6.7 kernel.
> Could you please check them ?

Give us a chance, we just released kernels a few hours ago and couldn't
do anything until that happened...

greg k-h

