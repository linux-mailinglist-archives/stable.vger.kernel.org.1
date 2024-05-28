Return-Path: <stable+bounces-47575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC448D2016
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C56D1C21A27
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5C171650;
	Tue, 28 May 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZ092uL/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F716FF47
	for <stable@vger.kernel.org>; Tue, 28 May 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909314; cv=none; b=XJtLsBYsKbjghuc2V8V3Lic8W9KmDxqGqeQ7+YzWkgrCH5Ov6YKtjKCmwGRBCfPFscqVfSlCKuvZFw6uogtqYozuo8yH37RhIUx6UNAQdKCYQjKj8OkKwCfE8zcStSGd+5Wu75iIBioXB53HTlCmYVh/iDiQ7CbK1uPEECqbjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909314; c=relaxed/simple;
	bh=tqLiPN5amlvHA7fWTBc4Bily8zs9asXJlXwi5CKHC2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOtFNx1n3W6N47SffQZqJb9DJ7SDVDsDWHTj55+IKkgERMtgI240mLkchki8iHmaZxcCWrxyBzqZl5CDsj9czUftSFapD9Tlz6i5RSyWoDr5L41uCQtawiMqNkM50WXR/XAYb8aDUaQIbcV13r49agv8XacH7ZwtP+37K7swnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZ092uL/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df4f05f4cc8so992921276.0
        for <stable@vger.kernel.org>; Tue, 28 May 2024 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716909312; x=1717514112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZlgz6rpKv8RDjntoQGkTFXF4S8SzOpaXSeRL3rg2Vs=;
        b=jZ092uL/ktNAxltzv+uss3nbb86PxxbCer1Qztc69hNlVsnvdrNkyd8VXeok1U03xS
         ICGUEwxnVSMgzgM8pYI3bkvravmkWJNd++XhBxtLCRBsV4iW78yd/v+zDM+3PeSMlv4J
         h9s+MO5/x2g2er9R3wY4F5OLX+xlDJCR3OegzgbYorNPuTkCDODBCC7wAQe66QZ4zLOv
         ojQEIPzFXKdk7MVnn01EzGKAyMQq8Nk+3awa8Te63YKQMdJzLmYJQ2Gs9fQ/KM21ciyp
         dTlDCTLsh17NzEbdhy9PWgnfAyNIMrOCtZIrM35uITDc7VRoKfRykRigVY1xVzjRlOAh
         tE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909312; x=1717514112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZlgz6rpKv8RDjntoQGkTFXF4S8SzOpaXSeRL3rg2Vs=;
        b=Zx0IAbHqL0i49CEiRrVUdlUGhWMTxyHaMyTbhSbElR1myp2BecRKGjW31vKpiUcJlt
         N36XDA9xyGF/Y4liceWwr/jCPxwcgPTpxlhCEIDHVutuKqqwrtHlcdR9y5tDficG+Mdo
         9CXqyx0wkdQyXMYfUefYwmdS/rExxkX1U6XnRQNnS4o0GwIJZ+IRKZFC2+vti7pV+x5t
         MVWiROYeh1UbOHm+me+L9HufwPi78fqz0CwooJrUeuv2c8nHmsveCSwvrh2Bv0DAEXs+
         PHTi8HNRai9YDp7y/SttpR6UcO6s3CGVWjy7MUEfnav472bS5EhQjMAy0DvLvdXaxdcr
         9kUw==
X-Forwarded-Encrypted: i=1; AJvYcCWolKaAvdsk8tidWwNEvw9O2BK4TdJ8ziKFzWMpIjd9KQfCZeiTxLLlfUUMkxj0I9ggwBH8DrTl4cVI85udcEOCC7i81WSo
X-Gm-Message-State: AOJu0YxvmJkry1uuifmiZom8CURCRW8T2oIx9lt8qe+OQrCeqIyZpmHo
	95lT3/huwdckT1zkG8ZMtNXoMLeONFW85doCOpsM6t8NNFmhukVzj4Hq/AOrFeP8xlmB/BzWWcq
	Ds65cyNA6NuFIZlfpEzOm/vwY5geh12pG1RdcAw==
X-Google-Smtp-Source: AGHT+IEKk+jMfb4UjQ2vLhkVRwJcPbBfG+1IZvWjYuTzuxuXisQPVm0zrHIomjE5POF4/tmNCe9LlwLUsAzYUZawgkQ=
X-Received: by 2002:a05:6902:507:b0:df4:d692:93b7 with SMTP id
 3f1490d57ef6-df772266789mr12143479276.44.1716909312385; Tue, 28 May 2024
 08:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
 <20240528091831.13674-1-jtornosm@redhat.com>
In-Reply-To: <20240528091831.13674-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 28 May 2024 23:15:00 +0800
Message-ID: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 17:18, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> > When I tried the down and up operations manually from the command line,
> > it worked.
> > But it only worked after I ran the down and up operations after the boot.
> > It fails to work by default after the boot for both the fresh deployment,
> > and for the later reboot
> Ok, so it works as well for you after the initialization.
>
> > One thing I noticed is that the following message was printed twice
> >     "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
> > after I ran the up operation,
> >
> > Is that expected?
> >
> > For details, please check the log here:
> > https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b
> That is another thing that I am analyzing, to clean those spurious.
> But they are appearing in my case too, and I am not modifying anything at
> boot time.
>
> > The scripts are simple, here are the two scripts for Android build:
> >    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
> >    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh
> >
> > Is the one to run the down/change mac/up operations script.
> >
> > Not sure why the up in the script does not work, but works when run manually.
> Ok, I am not working with Android but it doesn't seem spscial, the only
> doubt is when the script is executed, if the driver initialization is
> complete, ...
 is there any message that I could check to make sure if the
initialization is finished?
or like with adding some printk lines for some kernel functions to hack

> Anyway, I will try to reproduce here and analyze it.

Thanks very much! And please feel free to let me know if there is
anything I could help with on the Android build.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

