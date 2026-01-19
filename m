Return-Path: <stable+bounces-210416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E1DD3BC02
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 00:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C464302C21E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0210277029;
	Mon, 19 Jan 2026 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sm7r/qNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410550096E;
	Mon, 19 Jan 2026 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768866408; cv=none; b=LLCVDvFv9HxqF3HR/Fjp9GSHlCA4XZsBdEGOEV0R/A5bDag3UWB9xQtfqGaueTefhvQ0JyaozknpJ2RcVsgyuzQ6+RHDvcrYi5ni1Zvy8JjqJVG5/227+Pdf5j1Mhxm6Zv/cfAIo9YWdnf/pS3DSc7POOHeOSEbNa4+y6He0bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768866408; c=relaxed/simple;
	bh=oj1/TCjCnyYoBaDuVYtbtuYpQZhZOchHgnWQznhAiL0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FgL1RtTkG29uyp1GK1+PoEHKHdIIHaEdcBUNiYbGIlEinOyS8NBRGp0ew2nhuy7lToMdWoaLUn9GMfSUcviAjawMTAUK1fC8zeGjVAqIS9V7Yzb2w4J+A0hGQxmFmVkejeTLD6XZt1gSslJ+PdGejowjSFHIIq2KjWslmIVPCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sm7r/qNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A138C116C6;
	Mon, 19 Jan 2026 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768866408;
	bh=oj1/TCjCnyYoBaDuVYtbtuYpQZhZOchHgnWQznhAiL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sm7r/qNNtAMUO5PZ9bdUbvUMhdi20UfI97N0SZK497TXsclj9SXq/xzXuunvdSU82
	 aYjgCLoLz0UOXSxqlRECr+orOCnnL4Ckh/cHX8ZEuXLNgZUsk0tRfTsEpuyYYG7cwt
	 /4g9AIEzH8nEWh+me6OsHKvd4/JidlLik0L2DF9I=
Date: Mon, 19 Jan 2026 15:46:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: replace rio_free_net() with kfree() in
 rio_scan_alloc_net()
Message-Id: <20260119154647.74488dc43aee1be8cba48135@linux-foundation.org>
In-Reply-To: <20251217091548.482358-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251217091548.482358-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 17:15:48 +0800 Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn> wrote:

> When idtab allocation fails, net is not registered with rio_add_net()
> yet, so kfree(net) is sufficient to release the memory.
> 
> Fixes: e6b585ca6e81 ("rapidio: move net allocation into core code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

> --- a/drivers/rapidio/rio-scan.c
> +++ b/drivers/rapidio/rio-scan.c
> @@ -854,7 +854,7 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
>  
>  		if (idtab == NULL) {
>  			pr_err("RIO: failed to allocate destID table\n");
> -			rio_free_net(net);
> +			kfree(net);
>  			net = NULL;
>  		} else {
>  			net->enum_data = idtab;

An existing issue I see: if this error path is taken, mport->net is
left pointing at freed memory.  I don't know if this is a bug, but it
seems sloppy.

