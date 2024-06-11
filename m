Return-Path: <stable+bounces-50169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B96DB903FF8
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569AB1F23C06
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96C23774;
	Tue, 11 Jun 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouftaKNP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97D224C9
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119739; cv=none; b=GnFgrZmgh368pEUSna2UANHYqLfY8vISdVCNJhxnx7adYOWU3B/Po5dfnMuMSB3+jiGhAFaZul+jOByg1WL3qL7NNFhaDZ2JVa2EnOB05K0JuTa5zS5wvInC18MMTB34bxneBGEklB+BllanWPTNCBd3/LeU8Zz7opdSAyu3jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119739; c=relaxed/simple;
	bh=2WrLQnRkJJW8PIvN+lSkf9M7nln0JfBNhjWZYvJKsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aISZcd0WeFBhyeeHlEoxqvOWiLUygOU+5wXErQBHkyzcotBCugw2mfPk7O+COEPPYLAmh3qJ6MwGibujrpYRTj93UfwwZ3JcB/VSkF2aW4HrJCBJW6ZXgitAcHMuhA7uN16z4XqulaIYk9vux+M4mNCmmNVsWaymNFQKDvZTz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouftaKNP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso1018098e87.2
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718119736; x=1718724536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX66emLSPsiCozjYEcIgCjpS44vD4TxBAyFyr2wQO6Q=;
        b=ouftaKNP7UxCOE4g6sSn40JDBRbIK0YL9awoFAbYsdjwKS/hhDYcHouLxtKcQRf/qM
         E2fDhUjdidGA9FEQ9g7KOX0htmyuOygZSmXU+ok9HuODZdxExOQGc5xI2FOi3xK7xfTb
         rmwsPDg7+/k9CZSSi+T0SxSmKUa2F1UBbLnMUsauFGx3RbcAoqZsdwMUiYYKsDBVfJne
         PmkwpZHAupjL9SouQgOyuGGIYLCZzqZUTdxkpTBI4NVmUV6D+zzzL7+0lH0s5TOVxfLD
         o87O2DJgVvc2f/0CD1ktq763UTtavEG1MhYA8dVa4sVMaxL8i+D7Q9JwXYlKW396CEat
         l1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119736; x=1718724536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX66emLSPsiCozjYEcIgCjpS44vD4TxBAyFyr2wQO6Q=;
        b=XsS1gg/ZiDd6kBqNcI5E3KdczD1C/UmEBci8wTJD1Lv64O9iqas2Zv7NtpslXgYuBG
         g40Bp3idiyXlQU5crV7bT3K5Io4SxSPiRprVzRWYhPmQ8L9y9BNpQbOATc6Emq29cYdV
         hTBLkBkdOZ11p+6mRt7jCz8pKSzMHr5QGJrJM+oJRv07kaUTPNDrETzX78lHiD06Zvf7
         gw7Bt1gVKmPZQ6aWR93mS90C0R76waGDpze7VYzxZ9YJvfnNESdUZXarkZ3Wt0BH92V5
         OKwMykOoEyy/hBgTeYLOooxjHCiR7gH7bPL8Xsw+39EkjXm4C1j0k/49M8bj56fk5EF1
         MBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmoexwZI6sTEQaGZ03pJpwNTo9u0aiBDU5QJEpJ9aJNVnBls6g2ra9HXqzZtehq+hX5hYKs+j9cBn9Mbp7BEIeFglINCLt
X-Gm-Message-State: AOJu0YzkHbabCx+izZeP9xEufjhvT3m0MlRL/SslZvKxPbYvgxV+fCKD
	K/rRND+n7SHPucphTYjWX2vqhj4cnoeYfqtn79WAKQgOsgKizitZRPRywzeZzos=
X-Google-Smtp-Source: AGHT+IGvxWpypN+Q4GZLa8CZIb81/7RUuQZpYfehnYfxA1SgUhq7yrpOBlMV7ZeMcH30jRNwKRSigw==
X-Received: by 2002:ac2:4644:0:b0:52b:c10f:995d with SMTP id 2adb3069b0e04-52bc10f9afemr8727418e87.67.1718119735587;
        Tue, 11 Jun 2024 08:28:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c7e8fsm182702335e9.38.2024.06.11.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:28:55 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:28:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks
Message-ID: <b730de08-6d92-4667-810a-613d5f2855b8@moroto.mountain>
References: <20240611145524.1022656-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611145524.1022656-1-joychakr@google.com>

On Tue, Jun 11, 2024 at 02:55:24PM +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> meson_efuse_read() and meson_efuse_write() call into
> meson_sm_call_read() and meson_sm_call_write() respectively which return
> the number of bytes read or written on success as per their api
> description.
> 
> Fix to return error if meson_sm_call_read()/meson_sm_call_write()
> returns an error else return 0.
> 
> Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


