Return-Path: <stable+bounces-66548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1494EFBA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32482282F41
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0818132A;
	Mon, 12 Aug 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVAIXTZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9627F1802A8
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473427; cv=none; b=dLXKKEhCfBiifUUT7gZcTqpseatdfG+pghgzFatEbT5pFGzdU5T/rc/61Ug5KGLptXcrdCD7LZUssNp+ymLiimBUleY4iSpGBRxw2Gt/ByMHMA+SSFa1mTd6Abz96Ds5ZiiEjHkM7YUnxlyhx+ywSzstze+06fBifecs/WbWSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473427; c=relaxed/simple;
	bh=+QJNAmpXeXrMjj/F77VosrPUGAzQ3GOmpFswvKp9RU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieeeqnieKpaoyZSwpB5Dm+fp1mB38lnhIPwE+CDvQ5hm2s2BpWibhATMsqjygg4Rs3F9vjMnBSCHgHJJ4vtNUc/5fqfs1dSORb7740ilQvAGuwYVoOG+WjvN3REloRQ4Gmaagr7LC87B5elyCWD+jn1JG/w5FzHO7M8kjVpvaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVAIXTZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5366C32782;
	Mon, 12 Aug 2024 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473427;
	bh=+QJNAmpXeXrMjj/F77VosrPUGAzQ3GOmpFswvKp9RU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVAIXTZwQPqIyX0UF8BP9eINeBoBQ9FtK0D9YSgCG1sUpsJhTnculU6RmUupNVZFA
	 YFZvVh9kixX93P0Vf7ItXafH+uIxc5CthqMADHTL5p+VlvB4Cubp0KQaeqI9L3UGBJ
	 RUC23ggREpPuNW7uRcmnALvEkcBcdaw6ofWPq12I=
Date: Mon, 12 Aug 2024 16:37:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH 6.6.y] nouveau: set placement to original placement on
 uvmm validate.
Message-ID: <2024081257-smile-moonshine-d6a5@gregkh>
References: <2024080722-overlying-unmasking-3eb7@gregkh>
 <20240807160341.2476-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807160341.2476-2-dakr@kernel.org>

On Wed, Aug 07, 2024 at 06:03:42PM +0200, Danilo Krummrich wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> When a buffer is evicted for memory pressure or TTM evict all,
> the placement is set to the eviction domain, this means the
> buffer never gets revalidated on the next exec to the correct domain.
> 
> I think this should be fine to use the initial domain from the
> object creation, as least with VM_BIND this won't change after
> init so this should be the correct answer.
> 
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: <stable@vger.kernel.org> # v6.6
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240515025542.2156774-1-airlied@gmail.com
> (cherry picked from commit 9c685f61722d30a22d55bb8a48f7a48bb2e19bcc)
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

