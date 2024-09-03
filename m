Return-Path: <stable+bounces-72832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A3969DBB
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90F91F23051
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC91D0952;
	Tue,  3 Sep 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSHOxEmR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C311D0940
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367074; cv=none; b=Y8nTJxB92Mr/5uYV4AJtp6y1XnS94QRJOrQPTZ4N4m1ThHAlzYkHOCpHYUBbzGRRFqfNUnqymVGwYvrbwUwrVNYZJmFvxky6uBBuFcX+DxFQ9uNE0swfOl7HfWfwh6/0NRrJk/UhlKkWSIaMrO0KvaRTFA/vtZV4xU1QBZvS7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367074; c=relaxed/simple;
	bh=vAJYUB1JYAdTSCX3IiQu6MnRzSD3ZDq0H7nrMseKveQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay2uaADvYuHN4ijW95gvvFpk43cFRI3mNur5JFVh+fm0hTMj2+VmZxjwsrVf0Fo9zCC8dGT5k0xKSmkiV9UQffWgN/ZKjEf06J5WJwMB7vPyziwO5JfBCR5fGdyD7r5VEHTvlyzoPj1FbAy7aV3pZG1lEFQZlF19dhcnnHQc31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DSHOxEmR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso2837119276.1
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367071; x=1725971871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=DSHOxEmRM+WOqbDOk8xdSm/1Rg8Rdt4NVzNc5xWfnTKdbAscy4IchfB7kEvG4/BXzT
         Z8kEnjYRDRJvr1kQvAxLvNJ/Rkhtv8odHEeLM15wHFZrjVGbRtuB7fY1gp5ipUQELxMc
         lWkDZVkYhLSnLxMXy3UvZL2g3OqC5AlFS16L0a4bvXNs/Z+Erasrclayn5VxJc+lbrGR
         aFsvrIO79DyOFJNKEWVq3bB2Oy84bfp7UdlP/9YQYrI3yK6KSDuqEQbX9TOfiSGYekLR
         5SssdRf9nRrOY0jzzeaM0E1uYVNWTTFjyPwrevp7dw8A/7Sd+DnvPbs7NUKrOqIvUGbq
         OCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367071; x=1725971871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=EaQhDHVDn1zKok9iyn3cYoLq+aiGeAUWUR9XI4CnzUVRtShbZfGbaErpBSzjrEqYOe
         ap0fyuoynzdHGpEIzIpZZRicK9y3ee8mOuBuY9kLOSW9h+be+wd1z7TLXntQ/l8f47Py
         4Jbvh7uArbuFShz7EXN9MPqPUPjCSSSrefNaVGJUwkhyH6QCjBLanWAwI+HH74W5j9f9
         fUIcxuo619gSC25ogN299Uu9XlziUVUeV4B9mdrgwTDLkPb9UZWiW2wPYG82WSvaEU2m
         fjKtAvViNlZfi83/d7+h4mpc7DldaWSR5i93q+86hAwmflOswLea/5uB0QSqKFA9jkkB
         xAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmxwbArpEdaaAG2LE0JwaGPkTVV9a9IO3sr2SELnhnojBPQrE9sCAUe+UMT/5RqahTcA9w6g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvT7FIotrco2zIaBWF9Pgth762YGVs5ihsnew1D0WVyQLzfzMC
	cSH1U8B1wLlp3cHGtjuotmgMDI1mAyZQPFn1qERKJetzPp5bCEkraQnllJ8YMsUJoPyQBEunNmU
	4QT3NZiJxUaqeS+z6xEUqF6uNr5k8oIpuGWUlqw==
X-Google-Smtp-Source: AGHT+IG7wVWvBwVm8d9fEbO3Oflgii2VupDav0zWIgeWSdeL76IOqUTeZJcnUewS4XpCOBcCGjv00I2YWnT5Qsdy31k=
X-Received: by 2002:a05:6902:2493:b0:e11:7850:ac6e with SMTP id
 3f1490d57ef6-e1a7a1d0785mr13896773276.50.1725367070896; Tue, 03 Sep 2024
 05:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com>
 <20240829061823.3718-1-sh8267.baek@samsung.com> <20240829061823.3718-2-sh8267.baek@samsung.com>
In-Reply-To: <20240829061823.3718-2-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:15 +0200
Message-ID: <CAPDyKFrpLoV_X0cp4ycEeEj_Vhv0+1nmQ87+QVNV-o+Z0YEgmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, quic_asutoshd@quicinc.com, adrian.hunter@intel.com, 
	grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, 
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, 
	cw9316.lee@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 08:18, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..a02da26a1efd 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +               if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> --
> 2.17.1
>

