Return-Path: <stable+bounces-203061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B380CCF549
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8F5430146E8
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CB2BEFFF;
	Fri, 19 Dec 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRyTSpES";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+S5j0Xz"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474E2E2DD2;
	Fri, 19 Dec 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139453; cv=none; b=GebqK1cqChT5868Vxu+wwZBgSaYe43bSSzHRVcSuzkF6plnXrivIAesFQCySN/gf47GfmZEL1NxVOlswMs3/h87dZVMOS92NekOB7T3rrhxb5KcOoht/dFgRiL/oeKohkj0ydHUyLCYP5BXyLIIJsLsxdwDSbIVNQ3dL1oN+Evk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139453; c=relaxed/simple;
	bh=sIdzoNGrYBQ5rBXQdSUd7FSQhffKGK9FKpVF4sFTtCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mmQ+fAgk9IYJggrwZ4Y7uFv4PqWUXjKD4k79AwGPp4KXgMha5jVImvX4Ns46zAQvJD97omqWrFookJGIE8dy4dGb3XsMxuRzAcI8h87gOH5h9dg+zcICMji4aus12x5vdknkmCQUujS6+v0xU1isNg+CQ82nToKBEY3VpeLQ4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRyTSpES; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+S5j0Xz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766139448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDgUBTI096k107OrI4yb6Z7+ofeMdh5tKqG00iFY+Tc=;
	b=PRyTSpESpZUjNVSnP3YTtVlQiZzlna0sN0W1Yunrg+w0I3Phs/3TESYPKVknnabapwqThp
	oFOBCEz8bSIa7K7+AYAlUvVLe8JNhX0yGVAB7oHX87uhv7yG3Bm8G9OOQX2pXLvXKmf3V3
	kdDwyeY5WJy/KSsp00y2WmiDqrDPEXHjvUkt0Ym/GQNZFX2cZWwtTKXmd3g/ffJEQeykUd
	bBpBKuQ/y62Pl4ZxBaZyITtKb3jSQdtpcpI/zCgD0NtoL1OB/x9y6ube2e5We731heg3kk
	BU4ONS7nxHFiaqqjavCtkFVdfM+5j7Cz682WBGx5j8owH8M8u4hRZ9SB0e1lTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766139448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDgUBTI096k107OrI4yb6Z7+ofeMdh5tKqG00iFY+Tc=;
	b=X+S5j0XzdZ2td8GwJOwr92SOw7PhozMCLKPapOqSchd0eTGeAzNemsR/jLkzJ0pX2HlKxS
	+gVnmy0slhYaENBQ==
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anna-maria@linutronix.de,
 frederic@kernel.org
Cc: linux-kernel@vger.kernel.org, Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in
 tick_broadcast_init_sysfs()
In-Reply-To: <20251218090625.557965-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251218090625.557965-1-lihaoxiang@isrc.iscas.ac.cn>
Date: Fri, 19 Dec 2025 11:17:27 +0100
Message-ID: <875xa2bwso.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 18 2025 at 17:06, Haoxiang Li wrote:
> If device_register() fails, call put_device() to drop
> the device reference.
>
> Fixes: 501f867064e9 ("clockevents: Provide sysfs interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  kernel/time/clockevents.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index a59bc75ab7c5..94e223cf9c74 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -733,8 +733,12 @@ static __init int tick_broadcast_init_sysfs(void)
>  {
>  	int err = device_register(&tick_bc_dev);
>  
> -	if (!err)
> -		err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
> +	if (err) {
> +		put_deivce(&tick_bc_dev);

My brain compiler tells me that this was not even compiled. Try again.

