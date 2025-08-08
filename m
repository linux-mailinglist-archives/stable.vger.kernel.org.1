Return-Path: <stable+bounces-166856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E9B1EB41
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0251B7B098E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B3283129;
	Fri,  8 Aug 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KUIblmlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03D281526
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665947; cv=none; b=GLIp/hB+D+2KovFLh5TZja9b5cQSA5worPcT52U9HtoWi8TqDhzZMoNpQBV/dUczFoN9VrWE1XEelsbHuAOeFP1VIBn4pb+/ItXHf+o+Zi7N+8P1DBvcj/+TvQcA9Mo4C+U9qdCE+kfCb91NNmJXPoawvMFFBdnppFxtd5tdf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665947; c=relaxed/simple;
	bh=ZxRKGIVUbjSraV5hBQcR8vq7j3X1Q8xvJwBOa/cCs3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbu5FQgbtxJOdor/q1qYZ5TN1seNq09mwU88s6Q+42TTJCB/GAtZh3V8DJDyh0jxL/Ra9bLm1o9uTM/AvuOaxeFWotTg/wsEfbWW6PPbIc3baCACN+6QmjmJ+p6WwWDxzhFhmHX3uQ+XqnmlfkLbbdG6e51Lu//c6Gegq7YLhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KUIblmlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0E6C4CEF7;
	Fri,  8 Aug 2025 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754665947;
	bh=ZxRKGIVUbjSraV5hBQcR8vq7j3X1Q8xvJwBOa/cCs3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUIblmlW7Tutv06pro2zkO9Eh0mI8JznHI9DaugQlkBUOkNfGsF1cYhiLsw2SN3iq
	 UVUbSEEK4cPtBy2ADDFMZRsU8viivVnVIi1wTCeRYvf8BefXAxjtkDojhTamWgaOde
	 6I9NytUD2G8x16Elu937djrUxp27V3aGbPhSVyo8=
Date: Fri, 8 Aug 2025 16:12:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: Fix potential Spectre issue in debugfs
Message-ID: <2025080810-putt-ungraded-d49c@gregkh>
References: <20250808111120.329022-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808111120.329022-1-jacek.lawrynowicz@linux.intel.com>

On Fri, Aug 08, 2025 at 01:11:20PM +0200, Jacek Lawrynowicz wrote:
> Fix potential Spectre vulnerability in repoted by smatch:
> warn: potential spectre issue 'vdev->hw->hws.grace_period' [w] (local cap)
> warn: potential spectre issue 'vdev->hw->hws.process_grace_period' [w] (local cap)
> warn: potential spectre issue 'vdev->hw->hws.process_quantum' [w] (local cap)
> 
> The priority_bands_fops_write() function in ivpu_debugfs.c uses an
> index 'band' derived from user input. This index is used to write to
> the vdev->hw->hws.grace_period, vdev->hw->hws.process_grace_period,
> and vdev->hw->hws.process_quantum arrays.
> 
> This pattern presented a potential Spectre Variant 1 (Bounds Check
> Bypass) vulnerability. An attacker-controlled 'band' value could
> theoretically lead to speculative out-of-bounds array writes if the
> CPU speculatively executed these assignments before the bounds check
> on 'band' was fully resolved.

You do know that debugfs access is restricted to root access only, so
spectre issues are the least of your worries if you have root :)

That being said, no real objection from me for this, but there's
probably a metric-ton of these in other debugfs files if you want to
start whacking away at them...

thanks,

greg k-h

