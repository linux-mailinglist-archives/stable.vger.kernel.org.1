Return-Path: <stable+bounces-16058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1E83E8EF
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC650B246CE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A87498;
	Sat, 27 Jan 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vA9176tI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907D2F4E
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318546; cv=none; b=Ana/+TYvaz8/tWBH5ltFjZIfwSKb70vNkUm7ddmk07n/cT2L4Ak+xtgCvLTCqeCcRYTneBIh58HG9rC4DtpxpAhrB1rtnOQ/vkW1EIxNI7cxGHh7X3olE2J8kndEGjH62UOvnj+AAiQGkhbaAU/posdijULrQ5pJBTPUM8+BkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318546; c=relaxed/simple;
	bh=4Lj1h8wtxZZsJVFy2AJoHsXHZkGbjoUFk1CEbvA1C4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqRn+J5+adteFEZizT0X5mEgffvOZp66gyp1osugTedIz8p5HEsuNjngb5cVLYg0eniTaDYTgJujzaosi6avZN3K/FA53iqzdNkp3Hz4TbG1BiNJb9MUBGjMUcZJoKPX3P6XvdI3/Lu8QkPa3qZerHuDBDX5Q5ZDjHTmMvD4iG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vA9176tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FE6C433F1;
	Sat, 27 Jan 2024 01:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318545;
	bh=4Lj1h8wtxZZsJVFy2AJoHsXHZkGbjoUFk1CEbvA1C4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vA9176tIRKjLAWLO97uUkyk/51JGqR0Y5u7VHh/lD+PRBe0s0NBn3qvkrdXJhRbWg
	 5rJvAJ5Q+P7kjTtQgX4JI0MvB/eYIklR6VITomikdVhKnpCxKTdW/Gp4x+8HpgkcvG
	 zwFbuMP36fI3IOsGg8Jr1cDd0noaWjQbecFgZgSg=
Date: Fri, 26 Jan 2024 17:22:24 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Gray <jsg@jsg.id.au>
Cc: mario.limonciello@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.7.y] Revert "drm/amd: Enable PCIe PME from D3"
Message-ID: <2024012616-frying-unbridle-004e@gregkh>
References: <20240127010359.10723-1-jsg@jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127010359.10723-1-jsg@jsg.id.au>

On Sat, Jan 27, 2024 at 12:03:59PM +1100, Jonathan Gray wrote:
> This reverts commit 05f7a3475af0faa8bf77f8637c4a40349db4f78f.
> 
> duplicated a change made in 6.7
> 6967741d26c87300a51b5e50d4acd104bc1a9759
> 
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>  1 file changed, 2 deletions(-)
> 

All now queued up, thanks.

greg k-h

