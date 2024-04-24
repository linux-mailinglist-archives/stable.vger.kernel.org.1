Return-Path: <stable+bounces-41370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6B8B0CE0
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1287B28B61
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06E15F31F;
	Wed, 24 Apr 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVk2EGW0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F15EFCD
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969711; cv=none; b=VS+19uRV9orNpv132JJxajfBYrN+S4QrAsUh4jOrhOe7o2+cU5JUqUTl7nYWHMHojjtzeqABYBpQBSYZbAEf8Vaa3TpyG6Gg9PvRogL1XUaawBWT+agCUNVI5/vJQSvkP+FVpxsVlb9UiGmdEajKsiQm/TEeiPLGNU2SkyS9OwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969711; c=relaxed/simple;
	bh=o4G1IlS2c92A7xZpKBZLgrT4nuaWkzsQtfe2H4G6NNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hynqWqW7m5ude/ymTBYqOtMxFgtjvag4NyGqJ91XbpYv1y1DtyAbvHI2Cdjg3bZtnran7I9YczjUUbxDZkJ5SeoP6NiXgNRvSKInED6K3Q8DkguNzdPhe/hZRtrQ1vknQkbBSwCnWA6hHnHBryaW8qpWV+L31IehxqiU7CLb5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVk2EGW0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b09fb205dso4793155e9.0
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713969708; x=1714574508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m50BZowf3VvLGMxxV1yPQiC/7bewXFEYHZX6cdzCaac=;
        b=RVk2EGW0dS3nXzyb+QQDO8AfKQG+mu6uJYrfxax5vN05Lm9/HHIOPq4yPDtMhTu2pi
         TaR1c0KMvv035byrLYqUTx/M5D3E5uVXcaB0dMPf2fMKka69tA7siBBnzf01gixi53Nf
         CEe8c5YDnrkG5Axeg8Trei1ZBwNaylWc5nkIiOxeZ0wxcpFmYDxmSnwHMmBmKyyg6y6N
         YiZQMqElqc8mp95sriv9zFSu/6eBzGj38aPDkc+aPUfddP7e+5iWuejfPcfM7NeB1nQr
         nhoxU08Alm0+vexwZmHegESMlTx7LdX6y81GIvMY6ZqIMW9SqeofraRSF2+ZVYHjcW4X
         78Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969708; x=1714574508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m50BZowf3VvLGMxxV1yPQiC/7bewXFEYHZX6cdzCaac=;
        b=fGRMTuFsZom4J7ezWL6NRDEQrfxlUda6R2Q8TCG79EsWZMFQWAVySZ/FG38ixq6+r2
         CEtMiDzvsVAq3YKgNewKR36+XVGgzQtbEqbNwqpOopSrKrPLSK4R+XLvMVmHMBA8yDqF
         GetiIeNzsvFb0QiTZQcwuRUo+A6MQWPzSWtlr4sgUBCOveFwA78ZKV/AGfz3+utf0+bf
         /iKQmh0lQcYO0AgG7gxX7KHvUytY9FSNrgsL3MVwVyiqWkH05RJqZWFYJ0Up1qrsFepH
         8Lojm8ogmEDLF/0LNFdZ2pft3fOJ9Kuiz1PTbKv9JjnC8Q3SP6mx9N3vk0iWqgtbmgs9
         Lcng==
X-Forwarded-Encrypted: i=1; AJvYcCUnCgnOsa/qI3WntHMq2T2Z/NF7CEfcIUTz5pQXDBRxKS25ADt5fsONDMEZhvnv4luaYhWFMp4fvdTywhUZhnwcP9bf0E01
X-Gm-Message-State: AOJu0YxYQulOrzOsAECTudcEp74+TB/HpbflSqYYNKyFfakcKmBXySRw
	ZilrApy0MhvTr1ODyTecGTWT37nrEFy5rPW86nGTcwoM7Vr5+kPcSMZylb0b318=
X-Google-Smtp-Source: AGHT+IF1ZExQbb5QlgplAUJ1QcT8BsIxXi0XPTxmAFTHxOmU37La4HSAL68b7oXipJuFbAsjGSbzfQ==
X-Received: by 2002:adf:ed81:0:b0:346:758e:5f29 with SMTP id c1-20020adfed81000000b00346758e5f29mr1839754wro.60.1713969708288;
        Wed, 24 Apr 2024 07:41:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d4a4e000000b0034625392416sm17295468wrs.104.2024.04.24.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:41:47 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:41:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	petr@tesarici.cz, Sasha Levin <sashal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernel mailing list <kernel@lists.collabora.co.uk>,
	kernel@collabora.com, skhan@linuxfoundation.org
Subject: Re: stable-rc: 5.10: arm: u64_stats_sync.h:136:2: error: implicit
 declaration of function 'preempt_disable_nested'
Message-ID: <e81229c4-2f17-45a0-a0ab-f918f2f16524@moroto.mountain>
References: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com>
 <2024042307-detract-flammable-d542@gregkh>
 <7dc1b-6627e780-5-39ef3480@154053587>
 <2024042331-pusher-snowfall-2e23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024042331-pusher-snowfall-2e23@gregkh>

On Tue, Apr 23, 2024 at 09:59:58AM -0700, Greg Kroah-Hartman wrote:
> > Build Logs Summary
> > Errors Summary
> > include/linux/u64_stats_sync.h:143:2: error: implicit declaration of function ‘preempt_enable_nested’; did you mean ‘preempt_enable_no_resched’? [-Werror=implicit-function-declaration]
> > include/linux/u64_stats_sync.h:136:2: error: implicit declaration of function ‘preempt_disable_nested’; did you mean ‘preempt_disable_notrace’? [-Werror=implicit-function-declaration]
> > include/linux/u64_stats_sync.h:143:2: error: implicit declaration of function 'preempt_enable_nested'; did you mean 'preempt_enable_no_resched'? [-Werror=implicit-function-declaration]
> > include/linux/u64_stats_sync.h:136:2: error: implicit declaration of function 'preempt_disable_nested'; did you mean 'preempt_disable_notrace'? [-Werror=implicit-function-declaration]
> 
> Again, very odd, I do not see that anywhere in the patch queue.  I've
> updated the -rc git tree, perhaps an old version was in there somehow...
> 

Yep.  Seems to be solved on our end as well.

regards,
dan carpenter

