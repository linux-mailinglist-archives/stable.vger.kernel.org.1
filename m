Return-Path: <stable+bounces-142779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D59DAAF1CF
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 05:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEE1B68025
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 03:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F931F0E58;
	Thu,  8 May 2025 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdiC7YSb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660D17D2
	for <stable@vger.kernel.org>; Thu,  8 May 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746676046; cv=none; b=dxnEOk0jWlaQky/bFwVsIB5SEW/6LQw+PJogdWF+zY+HIIca0YBb9vcVxz2Dt4L92hidFnlu/wE9nVybdTT+wT5t/+j7M/t9M+sgFebfKWYfnhJE36I2elPffgWBeLFjv1po5dwDd3604vsCH1BvE58DrZIUk0LoEU7i1f/Wauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746676046; c=relaxed/simple;
	bh=gMvqmUDQloM/OGi8vQ9oaLiFubDBuCvPI4E4jN9iTYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz4WXj7WPfUy6SV2YP4cTqeP3MheMqVvQuGyiMnrEc66xINy+r6QoAqwUQ+1T8UI2lGj3SD4bcaEn0KGv9sOz6aBhSQChvZRKXwEtwDWtljx0NwIQv1RBfbVLTHtgzf2I+bPGZSqBJzyRa/T7i6euWto3lFDmf42bMNeqQZG8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdiC7YSb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e6a088e16so4351825ad.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746676044; x=1747280844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajwTuAXKGu9zIQucAwG1LBx8zev6+XMsQE6hj821iRA=;
        b=WdiC7YSbT0gO+yuQ54FzHmEEWfEJeB7xpCmD75sMK38l64VJCzVfLcikwmDxkD8vg0
         u3d2HEyC0pLhoKGDDnVPqY/lFC79uBR1MYQUd2OoxiDemlcxzisuo5+h1LjbAoDozfeZ
         XEhyO5doG3AvctrR3Jae0QS5m5LMZgonyX+0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746676044; x=1747280844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajwTuAXKGu9zIQucAwG1LBx8zev6+XMsQE6hj821iRA=;
        b=ayAwITE/g4/8WttbmrNVBtVqSvB+JRS3Pxz2Pb0Yl0RMcHGRjINZYS3RY/yXVmJsCK
         wWysZdI3vKJ1TzlfX4ASN2fAg/+hZWJDyHwIqIf63dLVfAZzQOm2tINd4sFlbb6aFiXE
         gERAAYR6TtHTSS0WaRvmmHXABccn16ODxdpc+655dJACi2EpGJYJE6Hu/gLzU2M4UvyU
         RzzGZ2WAp2othO29tv14T3RwPd6GP5eOCNPAoObGYWfnyEAtVzbOZ6TmSHxU8ZjvuvrI
         IhkE9QXcPa6IEnY5csS13AB53TrNKGFrP435/Ojs+h8r8f5LIYIE2DTHCCnTF1wjyk3o
         /81Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq7y70/IMQkqEh2UmbhuCku5y198MlzRb6Ytjm9zyt2T3TDsMMx5aby2dGbCUAMiFuMcPn7IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sywHksdiRDtowfsYic71DxEvCVwnplx5xZllOBGT5x+9copW
	bnXQmQvO0D1eDdXiMS1xJ37ZuFQ8R9yR6j1pv/pFKU8wW75g8XWr4L1+9Wuh1A==
X-Gm-Gg: ASbGncsxY7t7A2oyJiPt7ca95h8xvVtSiGs8U2YhebKGXTV/cHj2hLverU0Tr1J87au
	vfty7Xaml3fINL7yX5xn13REov8EZf5HCcQztKy3kYEu9t6s1YnpfgRrXFp7BXoZNT4Fh/P7mEk
	KmYW9Rmrc+l+jtpQpG/+sfYNJf66PZcd4nblq1BK7/BO377GyIZLsa64l3EOBGv1GuoqrNoURCP
	RPJSWTopHXyFHiR+yKFWBNKUFAB7KNAksLz2H2eLC4qdbvrBRdiunIhIhDhRbQnVfew6N/coxwS
	dPQytb5UKQSJkA6oa6shIFpFKUxHnFw4gvh8lxSS2Agl
X-Google-Smtp-Source: AGHT+IGcl17l7VZA4rVy6AOSJ6DC+M8PTTH8SKwAHZrFUgJBfGe+LwYpbZdpVLRwNYkh8vHIu6cVwQ==
X-Received: by 2002:a17:902:fc8d:b0:22e:457d:3989 with SMTP id d9443c01a7336-22e845bcb87mr29979685ad.0.1746676043927;
        Wed, 07 May 2025 20:47:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c794:38be:3be8:4c26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522916esm102263245ad.196.2025.05.07.20.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:47:23 -0700 (PDT)
Date: Thu, 8 May 2025 12:47:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, 
	Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv3] thunderbolt: do not double dequeue a request
Message-ID: <ojkrbtd2kpweo5xcfulfobdavj5ab3ysxxle4kr5oa455me77s@p2o4jdwsr3m2>
References: <20250327150406.138736-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327150406.138736-1-senozhatsky@chromium.org>

On (25/03/28 00:03), Sergey Senozhatsky wrote:
> Some of our devices crash in tb_cfg_request_dequeue():
> 
>  general protection fault, probably for non-canonical address 0xdead000000000122
> 
>  CPU: 6 PID: 91007 Comm: kworker/6:2 Tainted: G U W 6.6.65
>  RIP: 0010:tb_cfg_request_dequeue+0x2d/0xa0
>  Call Trace:
>  <TASK>
>  ? tb_cfg_request_dequeue+0x2d/0xa0
>  tb_cfg_request_work+0x33/0x80
>  worker_thread+0x386/0x8f0
>  kthread+0xed/0x110
>  ret_from_fork+0x38/0x50
>  ret_from_fork_asm+0x1b/0x30
> 
> The circumstances are unclear, however, the theory is that
> tb_cfg_request_work() can be scheduled twice for a request:
> first time via frame.callback from ring_work() and second
> time from tb_cfg_request().  Both times kworkers will execute
> tb_cfg_request_dequeue(), which results in double list_del()
> from the ctl->request_queue (the list poison deference hints
> at it: 0xdead000000000122).
> 
> Do not dequeue requests that don't have TB_CFG_REQUEST_ACTIVE
> bit set.

Mika, as was discussed in [1] thread we rolled out the fix to
our fleet and we don't see the crashes anymore.  So it's tested
and verified.

[1] https://lore.kernel.org/linux-kernel/20250327145543.GC3152277@black.fi.intel.com

> ---
> 
> v3: tweaked commit message
> 
>  drivers/thunderbolt/ctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
> index cd15e84c47f4..1db2e951b53f 100644
> --- a/drivers/thunderbolt/ctl.c
> +++ b/drivers/thunderbolt/ctl.c
> @@ -151,6 +151,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
>  	struct tb_ctl *ctl = req->ctl;
>  
>  	mutex_lock(&ctl->request_queue_lock);
> +	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
> +		mutex_unlock(&ctl->request_queue_lock);
> +		return;
> +	}
> +
>  	list_del(&req->list);
>  	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
>  	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

