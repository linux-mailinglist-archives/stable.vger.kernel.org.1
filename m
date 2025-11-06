Return-Path: <stable+bounces-192633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DECC3C991
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E44FCAC2
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13A321F39;
	Thu,  6 Nov 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km9IMYtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF28248B;
	Thu,  6 Nov 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447863; cv=none; b=cwR3YJmbG4ITNwhIQK9W799YBN7T01jxvoA+NsKsFOQpPOD122QnOao5r8rj/PReWC5dUSHlTzEjesV3We1DwE1uXuP3ynrC+IcODBwtUJWO3QFVPR1VvdY6TNXBG09o91uv7GyKKrE1KTc03mBNXZ5sHbQF2vmAwTL3fZ2TocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447863; c=relaxed/simple;
	bh=zu8Qruplip3NAIYuHb+Fv6PPfPXYa3mEC+hEN1rm+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQiqD/tDsovg5kl3UyFqRvzlamwwXdGJmPbk0CdMhMvPsPaJzZyZoV/DqKRY4xyoXne6xSnMKuMYMcT0mSzyKd0zCiNkcHianBA4/tB071XzgdKGk4FFEW0QFL4neOohikZg/UXcNmMIeRVX6Lt5gQzKgB01VB2xlze8BCwK+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km9IMYtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F82C4CEFB;
	Thu,  6 Nov 2025 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447860;
	bh=zu8Qruplip3NAIYuHb+Fv6PPfPXYa3mEC+hEN1rm+9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Km9IMYtGCUuRz4+ME8Yyy9Rk6Eh8otlghSUYz74vXG72AbtYRdjoVC24EySy9+4fC
	 qdCnZ5YYxTAvYw7EKGGI/6vv3UZFUf+z4lTjs1tulLLi0EjPsLVNClcRItcql6tf7v
	 tjQfwB4vABP9REIrsP8Ow+oZM7qSY0YaFB3pqnOB3DOjEilRzEJ/ejbUIgXtd8SQ0i
	 j5k5WJlZc9S3SIDprgKeXHoaNA3ZrfDD7NWL6wE4KmfjDSHCgWjkoZqi7tQH8KG1IJ
	 nf6kwFpgMoYzBmQVdxsGFkbDc4mKqKYwdrKz9JVpYNEWpOmsHzDipq7BdfZ+qc8iy0
	 pDRv/Vni8Gl/Q==
Date: Thu, 6 Nov 2025 16:50:56 +0000
From: Lee Jones <lee@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thor Thayer <thor.thayer@linux.intel.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: altera-sysmgr: Fix device reference leak in
 altr_sysmgr_regmap_lookup_by_phandle
Message-ID: <20251106165056.GB1949330@google.com>
References: <20251028041042.48874-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028041042.48874-1-linmq006@gmail.com>

On Tue, 28 Oct 2025, Miaoqian Lin wrote:

> driver_find_device_by_of_node() calls driver_find_device(), which calls
> get_device(). get_device() increments the device's reference count,
> so driver_find_device_by_of_node() returns a device
> with its reference count incremented.
> We need to release this reference after usage to avoid a reference leak.
> 
> Add put_device(dev) after dev_get_drvdata() to fix the reference leak.
> 
> Found via static analysis.
> 
> Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Looks like Johan beat you to it.

-- 
Lee Jones [李琼斯]

