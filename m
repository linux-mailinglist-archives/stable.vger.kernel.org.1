Return-Path: <stable+bounces-45613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6948CCB51
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FEF282616
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 04:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE29F537F5;
	Thu, 23 May 2024 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/1g6jTV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0271DFD0
	for <stable@vger.kernel.org>; Thu, 23 May 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437883; cv=none; b=gyhyE575yczG8D+hSrcC0hNSeEDd3CLYYiY0dRfGxBRWJOaNwcED7Xuemb2D0rPQIzP08TEVFTkhXFSJ3LLMTWVunYPskUCTgfI7UB4w1ZWc+DkLdqI4SUUTa61KGLPQNhnu9qBK6+rTU6oAhaebLCkG+4pa6EquNQ6JVkTN1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437883; c=relaxed/simple;
	bh=GbFSOG9GIAlbCFwXl3iK2a2xIn0SGwFHqJmyiZfbwpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi4dcKtwCr0JNKv282NJ7JKYhw+iEeo5kxWScALCst84eNU6AC2FAQpbQtY2YBrkGxWjbLZwGVhSTp72nVgjiv58HjYcJsnAnI46NkqXOb65NYhycj6KpXNZ7+J4oxzM8P+bV3/QOXxxJKY+W7sy0ZunpUBJoKLe48nDkDKqtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/1g6jTV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62036051972so61857097b3.1
        for <stable@vger.kernel.org>; Wed, 22 May 2024 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716437881; x=1717042681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=T/1g6jTVCCRt6ouxIhQs9dEpbf9g1f2gk+S68EarS4RXXoZOiNg+AGPM4tRd6Ulw1S
         /RN630nDTA1wAXBHaodeBKnW9ou8mVaD7TDFF+3Ar9yNNvLbNkIWCDfK/0zwlKx0ECZE
         esL2M1zgZ6BCihUcLDPW8tWzBJU/zA6yrXFMU3SIDb6U4OAvoe7Xp/IP8ixauf0DjmsU
         4N1LTGvhxFhxS+jjzkJ3HqJqaOFaF+KGkjD5gr1XUrxW1h1+7n7NIpql/4gJfe+37vDt
         3bW9hOJWXZTlOyGO2di/Uxp++SdBXiHIE6Art6AfSiHlywbWKjZy+gt3C5ptmEKhiqcM
         Bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437881; x=1717042681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=KSCGvKQPSZmI8PXIbOqwupY3MVjPMB6LnPp370ykMOA68/mUHoNNFXTvo85XSkOGO5
         i3Bi0F/QeMGTlD8gXSCkX5OZ5qRCh+MY5aYWDxtf24VysojvxWBHqcBhtgmOEDyydyWu
         VrfSbvqa4r1aVRj8JAegzqw7l/znxlaoFD5gJUOXbmYEq+GrJPEA8EPyxZzQ6EPRE/j5
         NQOB33mHo3QQBWuguY5dPpUKHC0+G/nWLJcb/BBRO//0HHZmqAhDA8kgOt2TxVSOicXc
         fR0ZXkHCBR/b+9pve8+Lxu486zkgBd1/rPRDLJtfzJNQ81V8gALjG8tH04k4xBgZdOMG
         PXgw==
X-Forwarded-Encrypted: i=1; AJvYcCVazRbfjxLPdjQmicSFIBBedqP2D4VKZUX9b34M4dSU86Ew2qGsJNQv2f2hEAwN4tEvp304BZ/Miu/Ylicrc7EE/lcWQPAb
X-Gm-Message-State: AOJu0YwUfo+gn3jXuES8t2yLRebsXBNpuKXIzhgdWl0NroXm+/Rk+sRV
	gdFFFc2fVXj1sqF8Y+F7d5pdZmNZbl0rpvKBQhrJAQ/s3Vj84YAveTEsngj5uRcBbDsUAVQfEUD
	M+ZZTmxGo/tapnucrC8TpjeJQ3b7+FsYbnxT1cw==
X-Google-Smtp-Source: AGHT+IECtJaV4ktOjw3xeRQOL27efpUlrVmDS3eWOWwjyesv2pFJSpT8QDS7HAip0CnL/cY7cSKZ5IEpz01Tke9lhTg=
X-Received: by 2002:a05:690c:fca:b0:61b:3484:316b with SMTP id
 00721157ae682-627e46ca8a9mr52170097b3.14.1716437881214; Wed, 22 May 2024
 21:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
 <20240514070033.5795-1-jtornosm@redhat.com> <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
In-Reply-To: <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 23 May 2024 12:17:50 +0800
Message-ID: <CAMSo37XsdqWZUd3ih+zSaMf7U5hSJ1=-4U2SLUwU7Qaru+J9zQ@mail.gmail.com>
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

On Tue, 14 May 2024 at 17:14, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi Jose
> On Tue, 14 May 2024 at 09:00, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello Yongqin,
> >
> > I could not get a lot of information from the logs, but at least I
> > identified the device.
> > Anyway, I found the issue and the solution is being applied:
> > https://lore.kernel.org/netdev/171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org/
> Ah, I was not aware of it:(
>
Sorry, I was in a trip last week, and not able to test it,

But the patch does not help for my case, here is the output on the
serial console side
after I cherry picked the above patch you shared with me.

Could you please help to check more?


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

