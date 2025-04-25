Return-Path: <stable+bounces-136672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4AA9C0CD
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5913C1BA5FF3
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA923C38C;
	Fri, 25 Apr 2025 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8KCNbjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA623BF9B
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569081; cv=none; b=syUxTrvgnqwqipWEjtowe66gjpnSl0rGhbl7GZNbpSHYVwku+/0BaGu7ApNAFxJntgAiT5RX02Rl7sXlaUk2ARHJptPB87xEZOqU+LEPZ4/a44TCSQWTNDR/1zJqNMZAk4de7iI3JhEZUNk5wEWEjH9ea/frskx4dh07q/p5GAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569081; c=relaxed/simple;
	bh=ockCoErXJYNNWIE4F1OGfTdTciM14pc2rGFj8KF/fos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZi9iDYFKvJ4LIxL1rbhYHpdH9L2JmeCBS8XXOs/NiT04bPIURNJbhyZ7lXtE/GdSmRNEsF+1rI/b390AGB6H7rKwSNWbaHXhAL0AmHdkVnk9nKKtUEOrtDBNPpnTCwxZMNlv1aSoQIkzKG0Fn34pioQMKUii5DQFIhdth89JuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8KCNbjb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so13908135e9.1
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745569077; x=1746173877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIik2Dicc6zrNNPkgRyVhu5BjNjWoGlcqMwS0QNX8Sk=;
        b=i8KCNbjbmdKc4sIjtJQPP7WgaU8u7kgQvvJRDHolwlBVdzQNI9ZnLo81t6/elcoa2k
         NUlaEF7k01WJT916nRHvbKnszFcNNlbw4nove37EEIIoXPLw0S1h0mJH8J4phPb1gJWx
         Zku/gMC7L32R8ibcJfkj+eBWyLn8Pi3MnTJaD8XIOEkBoP/VKl2cA+/9OSwvILIi+mjn
         fBW9W5Utg7nbmYjM3S2POgZQ9q3w6nsPAsh7LvqS1oNUGJe7cOTruTBSDuzPveswgDoz
         td+zByLQKPBhOzRw1zB+EAhdDTeJJstKvhOYG8JF0hDcUkSVrjefeA5c1msW6+gwu+w0
         hZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569077; x=1746173877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIik2Dicc6zrNNPkgRyVhu5BjNjWoGlcqMwS0QNX8Sk=;
        b=uQ68uKToXTYrIdkj8GQVn49+9+LPZt1oAXiowIKo6d9zYr0EhkfML8cDhb44eNa9B2
         O8dxVP+I/RCXNAWR/pNxdqdwQp76Hb5gMHrLs9j1VwXQpY5rVZ76LC8jiKq5u57J6msr
         KscH6ekcrmWqEsKRDNA90L74v+NH13Zsg/gn0VQmQDpFI7HPxT2xC0ulfWMr0ROKNXw/
         06NIn3BbT5XftiqnWJ7aAluGFCm4FXhRkwm9noDL/IWO3mxBmVI2fmAwtlLj8XBZg/dq
         bywl5b8WokkukykZeyeJgLBmmWM45emruDtNRp0VcU1749xBs+sORveJr0yPp7NyUaCF
         5KqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXpV1przmja14R96EDqRPk3DPUq1NApXqveYHtn7ZgfSXJl8Dzs2ygXRoFy6lBOf7ewUVBR0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZoeJL/5NS95TNvUFnSMuTJm9XcCxgHjFTSlc69kpTxd/KRW2O
	eUCe3+JGD1YHQbjALDck7WRV6ZLgX0fHV0tysSxvpEb0wPAbAlme/1sl3xvhUtQ=
X-Gm-Gg: ASbGncv+4tqTLVsvYATXuPQ9iEWm1xrWU3LbT0bhvaS0Giq2nJuP1BYEjMX2mZUFoi7
	5Ah4SGnVG+nVJCibmh3LTIbMoHql2uVGTmBFeeEqWI17uRAMNudTfSMq3WOTos+LAcmkUt2G4RL
	PPkf62fEnFcoVHRx6IbFgm4ak4Zt0fyr22WjE+w+JJXovWnYPKPGXgOOSRjkbKAkc3mfcY5DpfX
	etLNW2aGIfLsuDPwaBGkIBhB5QKArnE+XtOz+xGsdYTkA7P5qk6kt3D0qkd10GsvIQYLAhTh5xu
	1zOvapFAifzrRmF2uHbn/7VLB1RS+sKpvW31tsvks2borA==
X-Google-Smtp-Source: AGHT+IFtIhw338SCwM97fT8DE36JSktmwAws0V+m2whiTCc2WvjhYcfxYH8N3RZVkd/V19BgPW5uag==
X-Received: by 2002:a05:600c:3d0b:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-440a6346aabmr12093055e9.0.1745569077572;
        Fri, 25 Apr 2025 01:17:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073c8d1a5sm1671072f8f.13.2025.04.25.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:17:57 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:17:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in
 __qcom_smd_send()
Message-ID: <1cb8c180-a93e-4d5d-a17a-6452dd154801@stanley.mountain>
References: <CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com>
 <aAkhvV0nSbrsef1P@stanley.mountain>
 <CA+G9fYu1GagoVWnhNFnknWf0_zk-O+5XQXDiL-XUdt8knhJYaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu1GagoVWnhNFnknWf0_zk-O+5XQXDiL-XUdt8knhJYaQ@mail.gmail.com>

On Fri, Apr 25, 2025 at 11:36:24AM +0530, Naresh Kamboju wrote:
> On Wed, 23 Apr 2025 at 22:52, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "ret" variable isn't initialized if we don't enter the loop.  For
> > example,  if "channel->state" is not SMD_CHANNEL_OPENED.
> >
> > Fixes: 33e3820dda88 ("rpmsg: smd: Use spinlock in tx path")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > Naresh, could you test this patch and see if it fixes the boot
> > problems you saw?
> 
> Dan, This patch fixes the reported problem.
> 
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 

Thanks Naresh,

I left off your reported by tag as well.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

regards,
dan carpenter


