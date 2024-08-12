Return-Path: <stable+bounces-66551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A694EFC1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47FE2839FE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482B18132A;
	Mon, 12 Aug 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgRChiat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749841802A8
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473570; cv=none; b=PahnqNpG6g22PDtVnqgwptnhqCUlkzGWHr51HuiFYsbebKv91pFhyfNm+Xr2R9FIxnbTN/Y4MIbN+YR6SsUgAeyzU6EI85+9IasIAIw87SQtMgwMyBQ5dHVSHN2AANdOA2WGNn48uYHXgRQAKg4cHMmETjqKGDMiV/AKrsRr174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473570; c=relaxed/simple;
	bh=Vcqd0IImPP2z7TQayj1QKO5SRSv+oIQpnDTA9yDyuro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjx8h33Z8u+f6pToStEzYsLoAIz2qGaxC2+eKWg/nKzk0qFvA0a4+lCFvste19CdMLwwDkvLrBbic7aInPKm/BHfJ9/dhNtPxuCJJY1AJfBqi0qcHU8SZr7k0oEfTo0jMC3LQzSgKFu99pnE9LLEjK0isdcOSNff1CdCQlEwesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgRChiat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23FC4AF09;
	Mon, 12 Aug 2024 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473570;
	bh=Vcqd0IImPP2z7TQayj1QKO5SRSv+oIQpnDTA9yDyuro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vgRChiatQuv9pjovw75l/LFSX8+uErv5rljNXjGrKH1JKcYXehrVulDtHy8/0WqSu
	 /nvUBw0db5zcaJRHMj693k3KSub1f+YqNbq0tdvnAPKHE0PSF1iwXePL2LF7z15zqZ
	 cb3FGLtkX8+Lm0hfUBdvNes60BT3JYSDYuthU7wM=
Date: Mon, 12 Aug 2024 16:39:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1 0/2]
Message-ID: <2024081220-uncurious-anthology-fa82@gregkh>
References: <20240808225459.887764-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808225459.887764-1-bvanassche@acm.org>

On Thu, Aug 08, 2024 at 03:54:57PM -0700, Bart Van Assche wrote:
> Hi Greg,
> 
> The mq-deadline 'async_depth' sysfs attribute doesn't behave as intended. This
> patch series fixes the implementation of that attribute.
> 
> The original patch series is available here:
> https://lore.kernel.org/linux-block/20240509170149.7639-1-bvanassche@acm.org/
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (2):
>   block: Call .limit_depth() after .hctx has been set
>   block/mq-deadline: Fix the tag reservation code
> 
>  block/blk-mq.c      |  6 +++++-
>  block/mq-deadline.c | 20 +++++++++++++++++---
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> 

Both now queued up, thanks.

greg k-h

