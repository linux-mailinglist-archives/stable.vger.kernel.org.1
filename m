Return-Path: <stable+bounces-71460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D057B963BE5
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9031F25370
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC3171E4F;
	Thu, 29 Aug 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ukbTNf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D515C13B;
	Thu, 29 Aug 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914077; cv=none; b=lrRtEnaftrjfkrljCsAVgBXfCceSRI+b8+FSQ2ilx1x/coeLOcQhR5aq1CVfkqtt/en1+D6mcsOeEC8WybKt8IMdYl28SaQ6ODrXODGbXhUT7sGgDg/5BypA3zYtEq8VXDuAYzXYfd96cKQi/Y0I5Z13gJrUiKUSKnS0SEWltJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914077; c=relaxed/simple;
	bh=RwGVhIZnmH5hVkjFS59zgY6bUnXaJSwr3btkIi7WpGA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KWizrHyQUyiYi9nloQTfYhwSe36YgUEQ9jbHE0rsjRw4NqXYDZDeas7Y7uLRJMBJbHSHW6G+gdIQud+hx0hTBdiJVSDquH+pz5HJWAGsJYppmDdVWW9bQgg0nWYIcIR9QNIfoi55nEE0BO761SG3x6kNrW9ioKBl6/RCFitRHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ukbTNf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715abede256so235768b3a.3;
        Wed, 28 Aug 2024 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724914074; x=1725518874; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PYxpAYtTTI+Kh6hik2WKBJObh4hf97WSPXYdSgryVn8=;
        b=T3ukbTNf0UUfCegJkenNon39zfTDdy5Mk3cENaRW68e9T4VJAJJNteRDU+KQyqNvAk
         IkQi6PHC/jmCgBm4hpkguq0y0BHaYJ20BL/0mQGQVCDDjFSIt7DM454IlzmKhB3vBqnB
         XrMbze7Tb1+MYfA1tbcRDmfcjHLSLGlCbOIaHkafMdLRxmkixcV6Kv0o1EVVzUwuZtka
         CD7+iols0DwinlQOtCwzVB05miup2KcVplAWQ5pHxYtuwdBy3Ee9kcvv7dk6S9lOEZY4
         Nxg2wWk6KYisQLreM4pV7aWWysEM2BfQEnM/5xuKh/KM2tbMo5J9uCZB3unSsMuxbl4o
         4zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724914074; x=1725518874;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYxpAYtTTI+Kh6hik2WKBJObh4hf97WSPXYdSgryVn8=;
        b=OIAPZWRPKCfjM/0a4iSJ2gkF83Qc4dX0eQCA9R4kfZpNbChCJA3gONayYi2yuZSLG9
         Uae+cKq5+wSMElKtM2DmC2fXBG5AswuddMF5rO7WG1ecek3oMelnlcnKUxBnTJTzJ9j9
         IUoxmY6MJ6RpGw8C8SpeVTLez7S3DcRjCbEJ2pmjTW79CuWew9sqWE28IxYzJKhJgvOp
         9ryDblZvjf8Y3/8mca9AituF/TIsE3K3Enc3SPyPIIrGgWgySxGVu8ycq0+0WEcOFOd+
         YbTLWJqbhwB+MB9EjCvVJLro47kxHk4GTUh+0IIKS+pEqHDVvVFFFkYxjbAVp0R++n1w
         bHXA==
X-Forwarded-Encrypted: i=1; AJvYcCUANeXZnq3wn9AkaAyp2DLPlhvvLuP8O7gbVXa8hYgHh30p9Ti5vVsAnZJMXwgK5F6RRGvO2+2b/nTL2vY=@vger.kernel.org, AJvYcCUygUeY+6YGL/qt4P7T786QpS4gRZT8zJInoac/UZjWgWpO/S6vE5g4eBdPOOd7RqjP7FRh9RBK@vger.kernel.org, AJvYcCW9FIsEKDHBWiakHmVcgcjplg88gdun3JE9kOFDXGY/9ee93uacu3wrMSOrdlxPaDoPy/OX4WlSDdE9@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNYgIsmm1xqtq56qoeVY1beVdsJsQHD3DhUg/Sql02EqkUUHj
	d9FS5vs0wpg7VF5EwMbxhBmyH6IQOAbV7xJq7sCs5N47j2VORnjd5grdow==
X-Google-Smtp-Source: AGHT+IGY/wFUk8Z28N0GuC5tafnu0zdAtysTY/rQsOKGHJQBRx7CXk/z5ZZJSOFbvzYJ7iYPy/27uw==
X-Received: by 2002:a05:6a21:164a:b0:1be:c86e:7a4d with SMTP id adf61e73a8af0-1cce111c7ddmr1941907637.53.1724914074451;
        Wed, 28 Aug 2024 23:47:54 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d7dc5sm451026a12.77.2024.08.28.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:47:53 -0700 (PDT)
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, quic_asutoshd@quicinc.com, adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
In-Reply-To: <20240829061823.3718-2-sh8267.baek@samsung.com>
Date: Thu, 29 Aug 2024 12:16:40 +0530
Message-ID: <87seunrflb.fsf@gmail.com>
References: <20240829061823.3718-1-sh8267.baek@samsung.com> <CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com> <20240829061823.3718-2-sh8267.baek@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Seunghwan Baek <sh8267.baek@samsung.com> writes:

> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Thanks for fixing it. Please feel free to add - 
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> -- 
> 2.17.1

