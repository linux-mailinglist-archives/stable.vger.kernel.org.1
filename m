Return-Path: <stable+bounces-71369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8503961DCE
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083E81C22CD1
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 05:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071214A4C7;
	Wed, 28 Aug 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmjeAq0n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F712E1D9;
	Wed, 28 Aug 2024 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821295; cv=none; b=efvBHiHhpjgiztxmwpyXyP8mPmhsoQ2Kaa5ikaipF9JKQOcf6eq6WEC2Cwjt9IGIT2YZNfNtHnCghm2nlrQ5GC49YEhivxLmKzIwBBLUq9rBq1MciMuBRQVkXNhJpVdjy8nOd5P3fBP/LL6GQc0H7CSwbZYsHyJm/UwP3exgVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821295; c=relaxed/simple;
	bh=PdiqneyM8iE8PXtWCYkdMmfe3vycXqgv6iFjUSeis2E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UPNVYUnpCW/yq3bjGZ5AHZpE68dZKuvD7a5P2VRYjL5qqZhEAYEwNoN1iB+e02HaTDJxVCEb9jBORqRre5irbHqXj+MjAjG95Ez6KgmmC+W7olyZZ3kl6Xbf3LqqeUbZT1PYDvU15wKNBeIlnyuNbOiGmNJg+eCd7JGjF+Iu0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmjeAq0n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5284076b3a.2;
        Tue, 27 Aug 2024 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724821292; x=1725426092; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1PBFufZFXO8pjeAWoGsRYBpwPpPunHh/3BSVN2umgc=;
        b=cmjeAq0nBTSZ5PX6x7km2Hb3b5SQbIy+sXqbXAoNjqlMIiL6tKDCjrXotkLuZ8knbo
         LwqJ9+Ixohw2D9H10PX3ZltCnNRoobpcTHloCdRQaL6cG2Dy10KTYM9t35gPmdiP88UQ
         TT/ifz6XLdbcxFMI4br9zWuZUfQ+hTMO1IBE0qBH3EbXi7ISFt91AXu1eqwi4FqJQU15
         EL7J7CuzkN0SYZuKgaspMMAaZGWOP50o6OojeRl4iP5RjGptrGW0uYtDEARs2U/gLKSy
         9LzfuskTFSGQCFO0Yd91QRKrflWEiHfvgEfszyJfKG6gkGDlzDFdfox6QmUw3xSe1G4N
         r09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724821292; x=1725426092;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1PBFufZFXO8pjeAWoGsRYBpwPpPunHh/3BSVN2umgc=;
        b=gyPnnhWgZW52SXVdZ20RqG/EBE9stLG+g32pt4Fm9NDxElUjDO+ka180qKmmlGmF4s
         stpybI7RtreGCMHuBvAhDXVaJA8qo+VO7vq3jqF4jb7jzgbvEgAlaOSz/cLv9aplbUhN
         Vt0sYIkd2fOwQOfaKc5zNlkHEwAJbYw7BfVV5gigt1a2CNpMSzR2eCbND2qtKgnOEqsc
         Mxo39om3edKZ2hplYsYAjjD1FhED59u165/TH09aNaiWOKg3RzlGGH+V8OboTLnj25mm
         GsYjLnMWWH78jKp5J1G8IkQeo+u3hiNQcpgNJBUrGJWQZESrTzuujKYTlpx1eIGl0581
         GjNw==
X-Forwarded-Encrypted: i=1; AJvYcCUgLe6Nr/zoqP6xji/WmmADpRez1YMcVHHQ+iyGUwdcMrh9nuyar+3mmmbCEtvEHEu/emdZnGsR8aov@vger.kernel.org, AJvYcCUsB7a4PnOQYPLaA8KFMexXyAZK7d7diRPqhbtK1kwFnuzdD51EfOiGZlRXX/Y21U+wFsRGp5vN@vger.kernel.org, AJvYcCX7fx7unPN8oi1EBgckfhGoa5+4kSyFZ1FpXU9lxGMDHLm0EoPU2zUBsNkK4HMC997xDU/T3PFDiIW/GEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx783kCHopIaK9RQ/62pk15Suat6x/lRwyoZZ0Lfikhfp1nDWa5
	4ExinbYoIYpiewk7SCzwWGwcKfPGGjqX7cahtXs4gXwbjGJB/Q049wLe7g==
X-Google-Smtp-Source: AGHT+IF2KgaD0NeJKmnO4N/sw/3XO0DoFTEUk+46Y7as5ee+90XLeTe1s1OjxM5p+jIzCRQphjCLNQ==
X-Received: by 2002:a05:6a20:9c93:b0:1c8:fdc7:8813 with SMTP id adf61e73a8af0-1cc89dbac1bmr16921128637.23.1724821291577;
        Tue, 27 Aug 2024 22:01:31 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84461411asm536131a91.24.2024.08.27.22.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:01:30 -0700 (PDT)
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, quic_asutoshd@quicinc.com, adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] mmc : fix for check cqe halt.
In-Reply-To: <20240828042647.18983-1-sh8267.baek@samsung.com>
Date: Wed, 28 Aug 2024 10:27:07 +0530
Message-ID: <874j75s0rg.fsf@gmail.com>
References: <CGME20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5@epcas1p1.samsung.com> <20240828042647.18983-1-sh8267.baek@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Seunghwan Baek <sh8267.baek@samsung.com> writes:

> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
>
> Fixes: 0653300224a6 ("mmc: cqhci: rename cqhci.c to cqhci-core.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it!
Small suggestion below. But this still looks good to me, so either ways- 

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>


>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..a02da26a1efd 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {

There is already a helper cqhci_halted(). Maybe we could use that.

static bool cqhci_halted(struct cqhci_host *cq_host)
{
	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
}


>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> -- 
> 2.17.1

-ritesh

