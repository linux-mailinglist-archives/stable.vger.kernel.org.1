Return-Path: <stable+bounces-75842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892089753ED
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36A7B27A60
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4C194080;
	Wed, 11 Sep 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2O2tWTfd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F02190667;
	Wed, 11 Sep 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061376; cv=none; b=ftg1EZjpoYCIF6PrjnYdW+F9NDjL8W4KRfJQxEirSit4sgXVtABL+wLM2DBD+T4RRT+CfMsI7qqIpDaTjE1jknAJCBNUq71huTwAgEyBgL3qBsGsYklNi7BgtrUyA+DijZ/elE4m731V7EYdRi/lC8h/jIIsewtsfZaJetWYbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061376; c=relaxed/simple;
	bh=c2N3N5ofava+mbFCf7vOwTGfK67dX6Kp62Jacnr2MPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcS0GgUBu1QuqagCu4vDTQ+JJMJ3Z9MBSQ/NYRBYuoyRurpr8rvHBaQaTpzT979rYmJMX2MXMENig/FPgKwOxdjHlSVog0uWl1XBtpb5tlSJ0WNFhTk6rx3lXrU/2B53kE3dkRqaEI3pvItgB+k/m8SVUwbqmQnMdcOreZH8MG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2O2tWTfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A79C4CEC5;
	Wed, 11 Sep 2024 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726061375;
	bh=c2N3N5ofava+mbFCf7vOwTGfK67dX6Kp62Jacnr2MPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2O2tWTfd6ahS2acsI5zvGQWyv3FjlUDWVo016GUcgrUDrXmBadl3WbLCVuXDISj9b
	 Jui9MfnszPOT3zKWIj7SJ8AMhOhGSys+axdKnd9lvpF6YwGoFEi06qM5OiVhae/oOw
	 6MHtnPkLTNhOsEl11bpGA7uzzZuXJuR20C1c8Ek4=
Date: Wed, 11 Sep 2024 15:29:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kyle Tso <kyletso@google.com>
Cc: Thinh.Nguyen@synopsys.com, raychi@google.com, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	royluo@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: Runtime get and put usb power_supply handle
Message-ID: <2024091114-armful-lure-1725@gregkh>
References: <20240715025827.3092761-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715025827.3092761-1-kyletso@google.com>

On Mon, Jul 15, 2024 at 10:58:27AM +0800, Kyle Tso wrote:
> It is possible that the usb power_supply is registered after the probe
> of dwc3. In this case, trying to get the usb power_supply during the
> probe will fail and there is no chance to try again. Also the usb
> power_supply might be unregistered at anytime so that the handle of it
> in dwc3 would become invalid. To fix this, get the handle right before
> calling to power_supply functions and put it afterward.
> 
> Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/dwc3/core.c   | 25 +++++--------------------
>  drivers/usb/dwc3/core.h   |  4 ++--
>  drivers/usb/dwc3/gadget.c | 19 ++++++++++++++-----
>  3 files changed, 21 insertions(+), 27 deletions(-)

Did this get lost somewhere?  You might need to resend it now that Thinh
is back from vacation.

thanks,

greg k-h

