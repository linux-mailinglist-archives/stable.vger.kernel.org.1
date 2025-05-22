Return-Path: <stable+bounces-146100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE3AC0EA6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257BC9E14ED
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5D28C877;
	Thu, 22 May 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBCU4rzY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DF1F94C
	for <stable@vger.kernel.org>; Thu, 22 May 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925277; cv=none; b=J6OA9GwfrFzydD/ePVsPv90Y/BNt10468rZjpeY5CYphcp/oBRiVp5MkYxMG25eFZ7FwspcOk9iGf+Hj84oKN0fgn0Mqk0C401VnjHX7ufkQunhrjXofdWa7hiuP/ZfpXyooAO1AWduw6lQIr7mmHIn1yZRh6QigPjdruUAhA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925277; c=relaxed/simple;
	bh=CSsSHfl39dvzw3cAIhZcsGAqNS/b3pZ0v69mn2DAeOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPQ07XwhX6a/tJZ52r3rnUmzOb/NBpZaKRoETQS2g+qixNw+P6701fc3zehJrOwKrcDjKjXn6aRWJPgvrvzWHC1FOMBOg8ACJdoanJj1M4AKq9nMCjepn2fpIh/YjX6jUXfogs5/+Vj7gyFtJVbZy3wuZvqWE3YI1QcvGkr42f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBCU4rzY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso7965454a91.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925275; x=1748530075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z1fJZAnO5gbEdE9pm7QO/Ig7e59PsYGFh5eZL9ezsU=;
        b=wBCU4rzY8FAyQcxLPAi+lZkNEPsfzQAEdI6CXToqa5fMegOxAI70MMHULs4H9p1YGR
         746qSOuJejwR1suwG3gph9THZ2KWGr14xnzt9zFEk6cOTEuyChnFY1TqeKRYerfqEzcH
         2TdlcB3rLGkPgeWmMyeDofdw0CUvA9lYsSoXmvZ7flFaTBTtQ73VAJN+gbfiJZB5MbW0
         vGcc2m1rYrmM8gLcyoXm4eNf2l7Ftu3uuScKOx6cC+GEpW5GWsfQxByH3tyFKa2rEEK0
         8AVxKcFOIO4zU5qoT7QtA3TqHjwjDp28tBmEtmezm+FcD0chVKVxHsC4U5hXSwGI8UYx
         6Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925275; x=1748530075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z1fJZAnO5gbEdE9pm7QO/Ig7e59PsYGFh5eZL9ezsU=;
        b=RcirO5BWRBot5DHi1CWsL3CMxpJue36ghSteTkA6HILgr0fAJ6U4C3YbAwOsm/o6PD
         4JKv7i2hIH7vMFAckGse0Au+zz4k+5DHfmmEeV+Mv+GVUURQOPV4k8rKaQdPcL2KhSfJ
         68QU5smBiKIZEZ8PpnZ80jC7BVzxOCrQ9JSeh+nCJl/F5x3FbYP1F4UPY4d7Zg4+aS1e
         uLIghWpMIn0ar+Xigy6XGbxlLH+3+w3Qys/QEYYZk6Xd3kFaMK5D5AmCm/bmBtOoycVL
         tkIMx7WyVO+mqgH0z8T0FabCoyczU/xfBWhzbPwA4q2mZPFbIvy6PdPkW/aG4E0Dnm6x
         ylng==
X-Forwarded-Encrypted: i=1; AJvYcCUzy0QwcZCY/9h/Vml6Fuxav+nh6OPPqHGMPCHAOXyxuC3o3usUenUP/k+N73PFZA5d9QbXKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnkxQmLyqiyELbX84gTq6z3C21EQGbHkzffpPbjRoxw03Ohi/
	L+aip2bGpN9yuw+RS5JYcR6ZgpyAo+B9AmcZJuo/yi35vzTvsKXfKsJD9nEAYmlqOuM=
X-Gm-Gg: ASbGncsklvxoU2zk+IYmKv0FwPM9lS14/2wSwQv7mqUlktu1JdaWDPSnQGUCU2StMH+
	DkSNhvcMQ6D7vCxECu+7lhmzBY0k7XC4iHBDc/5/5h7hWhxrwFkXzpMTMFXIKVA4973LQqWRcla
	cbysia4cL5L/Bf4LGyTB4raSzK+WGhKoaipAPdmH2E7bp0vdWgnLQoQNPT4lvqvrb2wOrvk3paK
	7YT8TRFV1p+9X6Qt3UHLB5Jj7bkPFPsNhUd1qI6THNnGktSFTIG3k4+9sTAp8Jg8NEOXnGcTrG2
	ln9hMQNoLIiCn4zsHPLrmCUd++F+tjXSFOiSj6xs+ByujoCKNHH/z8c=
X-Google-Smtp-Source: AGHT+IG5YDZqJMGCNUR1bl3lh55nwJynldcZarNJfaMbRBZQnBUy0qDHzLUmT4VJ7H8G0EhPmNRC+w==
X-Received: by 2002:a17:90b:33c2:b0:2ff:58b8:5c46 with SMTP id 98e67ed59e1d1-30e830f7b18mr38271134a91.8.1747925273816;
        Thu, 22 May 2025 07:47:53 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:adb8:3fc6:e0a3:9f52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36365d9esm5641713a91.7.2025.05.22.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:47:53 -0700 (PDT)
Date: Thu, 22 May 2025 08:47:51 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andersson@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: mediatek: Add SCP watchdog handler in IRQ
 processing
Message-ID: <aC85F1Rua2dn_qTY@p14s>
References: <20250521142404.1077-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521142404.1077-1-vulab@iscas.ac.cn>

Good day,

On Wed, May 21, 2025 at 10:24:03PM +0800, Wentao Liang wrote:
> In mt8195_scp_c1_irq_handler(), only the IPC interrupt bit
> (MT8192_SCP_IPC_INT_BIT) was checked., but does not handle
> when this bit is not set. This could lead to unhandled watchdog
> events. This could lead to unhandled watchdog events. A proper
> implementation can be found in mt8183_scp_irq_handler().
>

As pointed out by Markus, this changelog needs work.

> Add a new branch to handle SCP watchdog events when the IPC
> interrupt bit is not set.
> 
> Fixes: 6a1c9aaf04eb ("remoteproc: mediatek: Add MT8195 SCP core 1 operations")
> Cc: stable@vger.kernel.org # v6.7
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/remoteproc/mtk_scp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 0f4a7065d0bd..316e8c98a503 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -273,6 +273,8 @@ static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
>  
>  	if (scp_to_host & MT8192_SCP_IPC_INT_BIT)
>  		scp_ipi_handler(scp);
> +	else
> +		scp_wdt_handler(scp, scp_to_host);

I would much rather see a test for the watchdog bit than just assuming it is
a watchdog interrupt.  And while at it, please refactor the bit definition to be
platform agnostic rather than reusing 8192 definitions on an 8195 platform.

Thanks,
Mathieu

>  
>  	writel(scp_to_host, scp->cluster->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
>  }
> -- 
> 2.42.0.windows.2
> 

