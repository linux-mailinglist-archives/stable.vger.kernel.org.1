Return-Path: <stable+bounces-194638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BDFC54192
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C5E4E114D
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7E2DECBA;
	Wed, 12 Nov 2025 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7ygK/uf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D071531F9;
	Wed, 12 Nov 2025 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975226; cv=none; b=edGjA3CiHHDC4ZFgLm4SvSyt3cEZLoZqYU2HVAFGFMQMvK2+2u9GUOrWv2YTD9B5A4WgttQt6SWB4oTUaObUjEmXHA/mhymMu4CtIfia+JWigi2fU7O4AmMTTcdL406BjIzbwKUoiRrCoMdqeRq9dmI4ntBmcDRqKuf4ndfdQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975226; c=relaxed/simple;
	bh=ur2cS+QLNOUAUSvB+owXVT5Nsu7CC+CcpadZA0kWUcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7OPAGRTAQ9Geub7ZCky/ssHj4DpOFXw8uS/FiUdDDbRwur/EB/SzTlO+NNMeTHnvZm9OUVa9AjDKWfHdG1cPGkLRzABkCOYXXsM/0VYP3c6ShxoaN9vePzjacgk50ZV1QQV0st74gN1Z0v3TfFK7dEGHFi8nuoTDTW2quReO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7ygK/uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64377C16AAE;
	Wed, 12 Nov 2025 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762975225;
	bh=ur2cS+QLNOUAUSvB+owXVT5Nsu7CC+CcpadZA0kWUcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v7ygK/ufGTq6LRw8TCiMw//5NpWqYR+zQ6lppufDMewQqaY7fEetzUxOUPyKqmlID
	 GTLOipsXCGAHVR4h4EDoCkmv/1DoBWhO8kAqcxxN6pE/qfgPoYlgPbIrmXirs0P7c0
	 lbWFYAWMRig9DzNic2/O/Gg0ZSvTh/3ADeelZj20=
Date: Wed, 12 Nov 2025 14:20:19 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: hariconscious@gmail.com
Cc: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
	sakari.ailus@linux.intel.com, khalid@kernel.org, shuah@kernel.org,
	david.hunter.linux@gmail.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by
 snprintf()
Message-ID: <2025111239-sturdily-entire-d281@gregkh>
References: <20251112181851.13450-1-hariconscious@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112181851.13450-1-hariconscious@gmail.com>

On Wed, Nov 12, 2025 at 11:48:51PM +0530, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> snprintf() returns the would-be-filled size when the string overflows
> the given buffer size, hence using this value may result in a buffer
> overflow (although it's unrealistic).

unrealistic == impossible

So why make this change at all?

> This patch replaces it with a safer version, scnprintf() for papering
> over such a potential issue.

Don't "paper over", actually fix real things.


> Link: https://github.com/KSPP/linux/issues/105
> 'Fixes: 5a565ba23abe ("ASoC: Intel: avs: Probing and firmware tracing
> over debugfs")'

No, this is not a "fix".

Also please do not wrap lines of fixes tags.

thanks,

greg k-h

