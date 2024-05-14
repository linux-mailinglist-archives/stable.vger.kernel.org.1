Return-Path: <stable+bounces-43757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F98C4C52
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 08:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AAC1F2193A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E4F9F5;
	Tue, 14 May 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5DNN69z"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E8193
	for <stable@vger.kernel.org>; Tue, 14 May 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668213; cv=none; b=aFXBPsLyAd593ya6wRC8W/VbVV17BVd0/MBDlumEuxzo8oPo/FnavOoYuKIqxpOopWvTFhDc5mPAdQ8SOCgai+IrsTRgGP2xw3B3e/PP75tFHW14v63jZxezlWhGFFr51/or6VapBFqsfRWNwcY3sXwk+V2o2ZJAuHLI7XdUTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668213; c=relaxed/simple;
	bh=ZfAjRDouTO7ZvYghB+NJtnhbR2ZdJwmxgXE8P3wfpQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i03ETR3Spcf4/bwJrpOcgtzr2xJbkFdfrbMtT8aBokvAnPTaukZP3FZZ4wSI1QFuBuZnm00X2Xq5YolQ+R4DQKLi1qUdPg4Svup7p9UxtKHF8h/g+9eCMsO5u9QL2h6HSeHLdexRYtj4Xbmf/IhTHLZARNhkYBj5SVcffW/20DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5DNN69z; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61bee45d035so53536407b3.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715668209; x=1716273009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RL/HT373iFNB5/gmrPBbQbaIWBxFdiHHF2SpPtkNj6E=;
        b=g5DNN69ziRlus2VeNnifNs5kjD9k5PmggkgQY0giZsCWMvS6W/onDv5rPWHJvV5y29
         J89koFeZjn57bDbv56DRTcH/gFV/HvOthC7xvf70w95CP+dIC4IG3n+iH8oCfzNn7keS
         0TTbNKrv3MVEsnoPWHGclVTPk9B0nR/Auj4+t2A7zdiuHGEGQHX3tZziMTEgvmYnoETX
         +buCp+6EskM6IyF6nzoyxO9UNAEIHQIFYTMliQl7OSJHQIGq2hBAUj9IIwtUga3+KQ71
         /SllDw4L3JCKbpLrBHmU1xqmCj2htLIGrLNLgPASku0taSTAhh3zn2zLgtCf03uz2z6Z
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715668209; x=1716273009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL/HT373iFNB5/gmrPBbQbaIWBxFdiHHF2SpPtkNj6E=;
        b=tzVjfYn/7olU5OmpuS4HNNcWN2sMgkWhmhuKt5sGlMXpT2LWbmpcTxMHAAAtRUUKDF
         V4+gn4SJNVQH8tzfqN+WJu2vCqg08HU1Ei0t6Idq08c5pSHFE094J3US6BWFu15PGtd6
         gCLvznWY4a6qgUphXv9wf4EgFcjSeyF4oauJFVQemmbxpM/wQkwDVwFsvwXRqpHNUqNJ
         0K/1oQ8/9+uZedkpbKjFacNBqTg/xCNuv99O2+ynAsdlXaSa2LkLFfVZGr5QgnlFPEwN
         ioOPjd8hRoC8Gc6FAo8uAy9gYohZQQNgvc/um/IXL2b2BXP/1EaoZdPy9H5psQ1BPJSu
         Egzg==
X-Forwarded-Encrypted: i=1; AJvYcCVpYXEb9GximAlD6Ks7CH/WN5mLaJZpbJnLoalwMqdfJIEzP5POYvGJNdg7e9erelsQFY3rrgMBhAO4oJyMPWOgZ8LBxo0+
X-Gm-Message-State: AOJu0YzbFm6RacoPgQz9hc24vi3gXtJzMMiyQcI3Gpi48xkROZvXwjzd
	1EyDF5r5+2xXz+q8TzpabiP94zf6mqoYWLCxPmqg+aF8xu2KDAJsKG2D6t/yCUcqPy4VoXbWbZm
	+HrzE4yYoGBEV0ZgZd5MfM6/31cUftHUiocU04w==
X-Google-Smtp-Source: AGHT+IEmSQRtsmi9qrBir2bfVjCB/SQEucaaV9YGbI3BoFMzakNXhdNYP6vrUbPSuXDlSiSULIWHOWNxXgTkE8klnbg=
X-Received: by 2002:a05:690c:60c6:b0:615:c96:1a8f with SMTP id
 00721157ae682-622affe1b3amr131034567b3.17.1715668207682; Mon, 13 May 2024
 23:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
 <20240508075658.7164-1-jtornosm@redhat.com> <CAMSo37XddAvE199QpA_WR5uwQUjzemF8GxqoWfETUNtFw6iCrg@mail.gmail.com>
In-Reply-To: <CAMSo37XddAvE199QpA_WR5uwQUjzemF8GxqoWfETUNtFw6iCrg@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 14 May 2024 08:29:56 +0200
Message-ID: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Wed, 8 May 2024 at 12:41, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Jose
>
> On Wed, 8 May 2024 at 15:57, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello Yongqin,
> >
> > Sorry for the inconveniences.
> >
> > I don't have the db845c, could you provide information about the type of
> > device and protocol used?
>
> The db845c uses an RJ45 as the physical interface.
> It has the translation from PCIe0 to USB and USB to Gigabit Ethernet controller.
>
> For details, maybe you could check the hardware details from the documents here:
>     https://www.96boards.org/documentation/consumer/dragonboard/dragonboard845c/hardware-docs/
>
> > Related driver logs would be very helpful for this.
>
> Here is the log from the serial console side:
>     https://gist.github.com/liuyq/809247d8a12aa1d9e03058e8371a4d44
>
> Please let me know if I could try and provide more information for the
> investigation.

Just want to check, not sure if you have checked the serial log file,
or do you have other suggestions about what we should try next,

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

