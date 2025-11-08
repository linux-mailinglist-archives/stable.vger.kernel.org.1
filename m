Return-Path: <stable+bounces-192762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5EC423C3
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 02:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2584E2738
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80280285C88;
	Sat,  8 Nov 2025 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxvIE4QE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AA2638BF;
	Sat,  8 Nov 2025 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762565122; cv=none; b=UKgkQlkMLa5IwZSuWiCszXNacubjdKujLUNJTeKQfbYG+fQFI6/WCFoHpREGcPMwE0gZUWJbBvsjOX9VmbgpQsQjv7om25NKKFEW7Xz495SDo/C7wh5PHsJWNXwSQQHT4DHH1KqFygESf8ChrYDukDP4mEgGmRfk0BaPNfNOQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762565122; c=relaxed/simple;
	bh=HFqy9+sugDJNVeYugxR+2GtT8WmbbDFqdufH/t5a178=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InNHQ8TZsKlD7JcH837Cl0ImorS18qLNudPM4V70df+9KcMeom2X74AVR11Gw4VR7eCPDEeFLoGK148o2CP7WUOlX2rmJuAxqUEsRephyrwHoHbytwmDlYF82frKrDOg3ngLdQgEOgw+2sNHKIX63ioXJHOTkdjZ4FRWLgxKItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxvIE4QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643AFC116B1;
	Sat,  8 Nov 2025 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762565121;
	bh=HFqy9+sugDJNVeYugxR+2GtT8WmbbDFqdufH/t5a178=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxvIE4QEkeEFegixK+2SNwHkJW6pHMfRCDyAFzJDKk4iNBbOMMf82agUQRMuf/ilh
	 K/SVUfwmx2FU5sdgyn2SOc8+IKRxdwn5vap6xNccD9/iWWIc5uXV7/QwdZeWRV1r4O
	 01hGq5zOPIY72ZiWL//zBzPQgVhTvjyR+LmXrnhA=
Date: Sat, 8 Nov 2025 10:25:18 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, linux-fsi@lists.ozlabs.org, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Ninad Palsule <ninad@linux.ibm.com>
Subject: Re: [PATCH] fsi: Fix device refcount leak in i2cr_scom_probe
Message-ID: <2025110812-armored-squishy-6822@gregkh>
References: <20251107032152.16835-1-make24@iscas.ac.cn>
 <0bc22da4-8e86-4e15-9aa6-38cb9d9f6b4a@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bc22da4-8e86-4e15-9aa6-38cb9d9f6b4a@web.de>

On Fri, Nov 07, 2025 at 09:50:43AM +0100, Markus Elfring wrote:
> > This patch fixes a device reference count leak …
> 
> Would a corresponding imperative wording become helpful for an improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc4#n94
> 
> Would a summary phrase like “Fix reference count leak in i2cr_scom_probe()” be nicer?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

