Return-Path: <stable+bounces-28715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC4887E35
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A921F2100C
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229D19BA5;
	Sun, 24 Mar 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuAyntQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295817BC7
	for <stable@vger.kernel.org>; Sun, 24 Mar 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303401; cv=none; b=cTlnYZgxPCiVDX0EyKVOOpAE9gAK8NetoOhcBLuHbSatip2I9z7rZIBRAirvAMsow0oWYBymFZzLHiTzzMqoVhZNLdsGEfSpzykviLJzGb0IFOv0I02OAGVNX7Si2nfkARXzWLlJ/XURdGpCj+fKDqUSVIkGrm90hDPkX0edBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303401; c=relaxed/simple;
	bh=OY2mAZcQJqMuuIQI8Y/Hbhi2CFUnbzZ3gvIFNkjerL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFVngPC4LfXZZkv6YuQYeHzisrhiGGvIblg34+qXd7UXYGzL2lwVi8MJyQzbCi162ymqAyZW0d8K4Ldzb9iKRVEFY9VnzRizZhsFfXtlHzPHErq/m8qiCuJMwoq1KpEgpVq39YUuDacxEDuknSgSAOGYpGtcNU+om08CPVZy/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuAyntQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607B0C433F1;
	Sun, 24 Mar 2024 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711303400;
	bh=OY2mAZcQJqMuuIQI8Y/Hbhi2CFUnbzZ3gvIFNkjerL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuAyntQ/L931KWOnDwYtwRKb7YLkKp34atNU67y+8cfGdUoN8WypKic0H6S3ZcC98
	 oHnSdM1mnrVMTIJHQwwQVbv8ZnioXXAnvMijDb3FefHGLnxiSvrXsYjJGYJuZcnMWb
	 bDEDG+wInWgJuBBta05J5/4lwFCrs2R8VForpLlRhW/Z1iW2GtjVELTIAQayRgGZLW
	 Q7qz+BmsxFmvW//TmnyC0QtfCJEBm5VTtc2p/Uhaut26qylWiuabihzxMiOykvbR9r
	 TG3lqerKjySDhEwlVlTeqlk1WV7mefg+JLsyrcKTw/iIf/v5lZLs4ROxsMGX3EvliS
	 ULk94zQYDWM1A==
Date: Sun, 24 Mar 2024 14:03:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: backport 'regmap: Add missing map->bus check'
Message-ID: <ZgBq5-kGAEUsjWa-@sashalap>
References: <lrkyq7chufceu.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lrkyq7chufceu.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Fri, Mar 22, 2024 at 05:40:09PM +0100, Mahmoud Adam wrote:
>
>Hi,
>
> This commit needs to be backported to 5.4, 5.10, 5.15, it fixes
>possible null deference from the following commit 'regmap: Add bulk
>read/write callbacks into regmap_config' which was backported to these
>kernels in the latest released versions (v5.15.152, v5.10.213, v5.4.272).
>
>Commit 5c422f0b970d287efa864b8390a02face404db5d upstream.

I'll queue it up, thanks!

-- 
Thanks,
Sasha

