Return-Path: <stable+bounces-192160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD9C2A97D
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 09:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4147C4E02DF
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87362E0910;
	Mon,  3 Nov 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br2j3Pyr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A02D7DC0
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159245; cv=none; b=aAipKhLy3la3mpXYjC3D8n+x1ZvTSR9KiP08JfEbgghC5Ubh69wuMJnM16ZAeaK3byxPIkxVz0M7bqjz+vWBrMXNgKDwJKj3jHbhj9bDdKBATRrw8wT5zRVOIsetnxoSv17Chisy/5l0nvxEDmqmzu5EYxfDpw4cJxsHuNR8xwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159245; c=relaxed/simple;
	bh=29HFx4zP5TuqH7uQu/O1fuNnD/tVpYqYDYodAqZeBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9o4MYdjeSPnLbqyW7eWj0a5fpyMRvQbvWBiXVtcCMx9Wn9DxhvHwhJgUHKNNE0kKRfINt2G3MGC4251ufFsQ2TCLK+GicV04EY9jkBVbD3eXYl6h85OLoA+2n8EudjVCA2Je9y+PfsEWUug/jksKMPEQLXR97ssQBIlhoe4QIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br2j3Pyr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7155207964so62846066b.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762159242; x=1762764042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rGUbe9xbBxnFtXv4tRwbVKKr3k/buEiL+8Ja5DgwC4=;
        b=br2j3Pyr+iIwYtFqWffaXsnBuGo9C+qM0u+YB+Ng1oj0wLL3Y4bRjOa/10dW/R3hN4
         lKQMfM5V1Q22cAldAQhg3Kfk+6azI3fhh/Rr7AoB1hcFE3gy9ka0WJ83XL7kqDO77yMn
         yMNXLHuYB1mFy+4scZrINNdUJJS9YcjhHQSGGeoOazwvloQAHrc179We4f3zhVAWW3c3
         fpOnjZiIcXElTm657+YKosK9ebQ7TaK14jcBEyQYaUlf2qwIs/Y4+/FtlWYzHABNqf+8
         ucVoQ1Yt3lhAYV3WvOYPEoPKdIGZjKrOIiOO1GzHilhEhkmTCfYUwnpoUlV+CL+y8WAS
         j/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159242; x=1762764042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rGUbe9xbBxnFtXv4tRwbVKKr3k/buEiL+8Ja5DgwC4=;
        b=ipFy4G37Q1vuJbEluRUuetg1fLGHNwo10dkWXDpA2BtTlo37j5RZRE8Oh8B6jILhMT
         80BZfDITODieyDrWIQi0ZwHtE9db1nWg+EP7dIiHzawE2ozLbKeb1FRpZhWC7ANwPrPA
         tmz5crLLchdk8bb9WEcIli4jmNerM3AVP65+elwVMC7R08/vlU7XDMOM3Gvkwx/FP9Dx
         NCvNBhaponH8+/YguhjP9jfb6vcNydbFGHgqJ+Iyb6ZHtCMeowLvqDjZ7odeDFGOHr2V
         tkQfQFa7FPa+XonY1UyAySpPeNnoACt0Up3Abe2/U6siYCEfSy0YauUhzHDEjThsmp5e
         9zZw==
X-Forwarded-Encrypted: i=1; AJvYcCVGa14U14IyLwRikuwGCcdUt7sKlSv4OXse0bihkhdqM/yy0spdYu4oRMM/a6fsJzS4VaLMsdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gK8MHCBef15lOn+JZ/xYTZ86y9TaiMZOA9ZJ/7TXVNF5eDW3
	s5V2/goC+o6aq1z2NAyP8VNtnIjwWs52b3fkQ2ymryHfkTnB3hE6Dt3f
X-Gm-Gg: ASbGncvaa2r3E7nk9rfgF2++bdaXjgc6g7hPZF5X/MgopRl+HaKmR4oGva82H5LYFPB
	Pg1dGa5EvGxrL/7T35dn4GoVaNdJZUkLYU3QAjzlVttV7hk4nX4apaBQG2biQx3F5HEzeqv9wTR
	cLRqZcREBi14ZutDmlokdeei/+ys8Uirp1sr/clxuWT5xGSaS40QZOshAoogYEPOjTCEVdQRa3j
	aCEiHvOCO8UXWJXVdzz6FaL0PV6/NT1/kX27pkpQmPPwtG+qCaN/6kQc3tsKjXWQwaz1TYg8wnL
	cV1CnOJRlinOwabC2sMnT7U9DPi6JDllLXt6PV0133aJ4ziGBu0MBicxCYODA9eTaIQgZ6Yo80w
	Ak1gJyka+laPtO6T5jqCTMhFKe1KGd72vlNzjw9chPrgd0h0MvNY9ixtFxWDHmXS/Q0QDZ9b1N7
	vER7XKOoI5Mo6v1ptJQsQrGgI=
X-Google-Smtp-Source: AGHT+IFpmxasMMQzw06+y85COr1wqLp8qW16dzYeDOlLZQvniK+scWKjZBeCw5HSwxFEJ0bUijUNZw==
X-Received: by 2002:a17:907:968b:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b7070848658mr1145584866b.60.1762159241950;
        Mon, 03 Nov 2025 00:40:41 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779e45a2sm967489266b.31.2025.11.03.00.40.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 00:40:41 -0800 (PST)
Date: Mon, 3 Nov 2025 09:40:36 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Wesley Cheng
 <quic_wcheng@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20251103094036.2d1593bc.michal.pecio@gmail.com>
In-Reply-To: <20250918130838.3551270-1-lgs201920130244@gmail.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
> kcalloc_node() may fail. When the interrupter array allocation returns
> NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
> and in cleanup paths), leading to a potential NULL pointer dereference.
> 
> Check the allocation and bail out to the existing fail path to avoid
> the NULL dereference.
> 
> Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d698095fc88d..da257856e864 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  		       "Allocating primary event ring");
>  	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
>  					  flags, dev_to_node(dev));
> -
> +	if (!xhci->interrupters)
> +		goto fail;
>  	ir = xhci_alloc_interrupter(xhci, 0, flags);
>  	if (!ir)
>  		goto fail;
> -- 
> 2.43.0

Hi Greg and Mathias,

I noticed that this bug still exists in current 6.6 and 6.12 releases,
what would be the sensible course of action to fix it?

The patch from Guangshuo Li is a specific fix and it applies cleanly on
those branches. By simulating allocation failure, I confirmed the bug
and the fix on 6.6.113, which is identical to the current 6.6.116.

Mainline added an identical check in 83d98dea48eb ("usb: xhci: add
individual allocation checks in xhci_mem_init()") which is a cleanup
that has a merge conflict at least with 6.6.

The conflict seems superficial and probably the cleanup would have no
side effects on 6.6/6.12, but I haven't really reviewed this and maybe
it would be simpler to just take the targeted fix?

Regards,
Michal

