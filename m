Return-Path: <stable+bounces-8227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72281AFC4
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D5F1F251B6
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0C11734;
	Thu, 21 Dec 2023 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Al7AT0pd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDB168A6
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 07:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5427EC433C7;
	Thu, 21 Dec 2023 07:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703144811;
	bh=5hSX+XPv+q7yiis1G1YHEb59TzUNlCaKmmIDV780q5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Al7AT0pd4Soc+R7ATF9P5vC5biDzMG6J4aIy8Kt/8pl4quSMrrCS2Cq5zf0T/cNYo
	 lD0q9eOFVG7ubFMYU6PPZMtOvt8s0CxAz0FANT4mxUbGb/5/FPkZLV85J+tmayl75w
	 rcdHLkdd7CB68uWFPiwMkSXSMVij+okyUPO+Eofw=
Date: Thu, 21 Dec 2023 08:46:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: stable@vger.kernel.org, patches@opensource.cirrus.com,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: stable/6.2, stable/6.3: backport commit 99bf5b0baac9 ("ALSA:
 hda/cirrus: Fix broken audio on hardware with two CS42L42 codecs.")
Message-ID: <2023122151-unashamed-headstand-2f08@gregkh>
References: <7566bbf5-917f-44d7-8261-d17453f6e7f9@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7566bbf5-917f-44d7-8261-d17453f6e7f9@opensource.cirrus.com>

On Wed, Dec 20, 2023 at 09:53:29PM +0000, Vitaly Rodionov wrote:
> commit 99bf5b0baac941176a6a3d5cef7705b29808de34 upstream
> 
> Please backport to 6.2 and 6.3

6.2 and 6.3 are long end-of-life, look a the front page of kernel.org to
see the active kernel versions that we support.

> Ubuntu 22.04.3 LTS, is released with the Linux kernel 6.2, and we need to
> backport this patch to prevent regression for HW with 2 Cirrus Logic CS42L42 codecs.

Then work with Ubuntu, they are the only ones that can support this old
and obsolete kernel, not us, thankfully!

good luck!

greg k-h

