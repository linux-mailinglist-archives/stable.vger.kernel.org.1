Return-Path: <stable+bounces-35926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB58988B4
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12351C25C13
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D1127B46;
	Thu,  4 Apr 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sr3RWkXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6418AF6;
	Thu,  4 Apr 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236959; cv=none; b=b7Fzu6k6Iy9B2DW24HVpCIUU6zW+9u+iDhQMPNq3CFkdsurj50Nef/mYM6aUOR4blwkQRmop+YnKONCyEpHYSXgOvlYUwkYhb9kRm0azm6TpDMZSKuyDLjbqYjm0LPWJRMkzO3X+Zl1iGlrL0iKY3ksmAmB014LoH8Idk4/hJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236959; c=relaxed/simple;
	bh=vJFS1OOOBDTIVLiOBBvr9XoF4wFwhB9JAXs15apE4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usxOW9ZfBriQzAP5ZSCI38fyBuFlHd5ndyxMSqVAIlGzhoQZI3UuZ7bYJWRmnwU4ZMwiLbna2KApIaRRlCAPDtTgCvffHjkDnjqsLV24fn6oWHTypYxu6BWzYzytTfwjwX8j3Ok/6pLG5Q+YpIh5x5mJu2BZEvJ1u/KGj+eHlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sr3RWkXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC8DC433F1;
	Thu,  4 Apr 2024 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712236958;
	bh=vJFS1OOOBDTIVLiOBBvr9XoF4wFwhB9JAXs15apE4q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr3RWkXOhMotYSn9pOpI0QyDa5A606/aUsbPgOWx94TF7ptXcgT4nJidzNL7L0cmb
	 8FjS3+ALowu1kwAdrfTRhtD2LVv7ZZgj5Uf+5zseDG5q+ZoIcAJUojUyicohBWCqL7
	 U18QeojUpw5pwqUW6AjVEUuVSZ94Q70d9XTgK4CM=
Date: Thu, 4 Apr 2024 15:22:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Correct the PDO counting in pd_set
Message-ID: <2024040417-ice-decal-b37e@gregkh>
References: <20240326151909.440275-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326151909.440275-1-kyletso@google.com>

On Tue, Mar 26, 2024 at 11:19:09PM +0800, Kyle Tso wrote:
> Off-by-one errors happen because nr_snk_pdo and nr_src_pdo are
> incorrectly added one. The index of the loop is equal to the number of
> PDOs to be updated when leaving the loop and it doesn't need to be added
> one.
> 
> When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
> the size of the local sink PDO array to match the Source capabilities
> of the partner port. If the off-by-one overflow occurs, a wrong RDO
> might be sent and unexpected power transfer might happen such as over
> voltage or over current (than expected).
> 
> "nr_src_pdo" is used to set the Rp level when the port is in Source
> role. It is also the array size of the local Source capabilities when
> filling up the buffer which will be sent as the Source PDOs (such as
> in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
> level might be set and wrong Source PDOs will be sent to the partner
> port. This could potentially cause over current or port resets.
> 
> Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v1 -> v2:
> - update the commit message (adding the problems this patch solves)
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This fails to apply to my usb-linus branch :(

Can you rebase and resend?

thanks,

greg k-h

