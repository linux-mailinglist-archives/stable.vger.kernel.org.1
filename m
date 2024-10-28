Return-Path: <stable+bounces-88273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E59B24B8
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FFF1C20C50
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A918C903;
	Mon, 28 Oct 2024 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9ECzhmQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E17C220
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094888; cv=none; b=Qntf2rXFcNPU9Hy/aNISujyzsMsM9VDNP1ir+QTtGcV5lZJrvWW5M97gxipQO82iFF1VP5w9CMlHrH/hexZt+jCc4OHJlCcPIK9cPSTJJHeAv+au3f5x3dHG5jfnfaXd/umf4oB1m8OtW6m4Wd+khU6E+5MbvLW59CYvYFucytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094888; c=relaxed/simple;
	bh=m8hvZ3/EvDMx/mOZNHZ5Q1pycGgb80f65QvkXMbI2RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm6khNknyHiWxOv1SlJIK3gz7MVcz5QvyKmpm1GHZ3VGYzL+ugpDUMb+5BcwbWrz5l/1PYr7Uau8nDgTLvss2vILwE3gi6pXZ4QqHf7ueCu8qSzcx3hjNd7PtkxWdLBx6K/NvoA6R3ok/g680CTGn1WFspRIZ2tBPRboxVbYDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9ECzhmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC3DC4CEC3;
	Mon, 28 Oct 2024 05:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730094887;
	bh=m8hvZ3/EvDMx/mOZNHZ5Q1pycGgb80f65QvkXMbI2RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9ECzhmQIUw9WxsvJJ35iJh6cilbSCd4535Dab9EEmTuNEgR6OhAYPWT6Mx3526zF
	 r88exmmsQCTh9kUifWAWpeEhBlC7ua6pYeLeuvmhFJhL1QesY0ttlwhShM3cIO4hH6
	 1cD5ujwCAkZOuPMFx9CSZAGiQkLAy5WBAayMnWCI=
Date: Mon, 28 Oct 2024 06:54:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gong, Richard" <richard.gong@amd.com>
Cc: stable@vger.kernel.org
Subject: Re: Add 2 commits to kernel 6.11.y
Message-ID: <2024102828-ideally-maternal-d579@gregkh>
References: <481fc86d-4ff1-41aa-9476-11be73e6cb45@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481fc86d-4ff1-41aa-9476-11be73e6cb45@amd.com>

On Mon, Oct 21, 2024 at 11:43:47AM -0500, Gong, Richard wrote:
> Hi,
> 
> The commits below are required to enable amd_atl driver on AMD processors.
> 
> 0f70fdd42559 x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70
> f8bc84b6096f x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h
> 
> Please add those 2 commits to stable kernel 6.11.y. Thanks!

Now queued up, thanks!

greg k-h

