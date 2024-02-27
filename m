Return-Path: <stable+bounces-23842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A7868AC7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0AA1F22CBA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB77867D;
	Tue, 27 Feb 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDMdmr3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299077F2D
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022702; cv=none; b=fmtHqayQCCoUY6GvVUT/N2WrCCqSwFo5WdfLvD7+TFWl72J+O1hvkrzAkVS35Apk3alYmve3uE4STjRevOFhgb1ol/3lTWky+GBFEgPXDylHUoYyS/NhEFitVulvSZa6B+AbmG1ponJCdJnYIvZwg4imCwKy0Rjcwkhf7/76uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022702; c=relaxed/simple;
	bh=jDcbjm051a2tWQp8mL4nW0pJ4OpF8SkO3jnpo60IyWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1hFY4Jsiyi8CmLbNvtUvT/k+KWWqpIBrxR/JoUbWiOy+qfC+coJDxybGGhR8Wg+bXw3uXuCivITRVOzMm72iAVfnidx/gE7n8C42T4lpXnYw8hrC1RX45Z0l13ryDhnOlKvXJopad6F14/JC4gXBmLyRDfv6Iv0oFzHhQ3tqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDMdmr3K; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so435881166b.1
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709022699; x=1709627499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWWjdMDDlRbFnAQIhSeSTyA3KAYjkYko4A1TtZtt+H4=;
        b=FDMdmr3KSIObla6tr5cpWU8/WvK6jUhXBFd4fZ4PKjVrz7m7KR6REXxNEG2jm6r6ff
         h8q8NvTaxF7SERE8CMYtoE9FQxSRtIRSn40uAeBtZIqPjfhltezD+3/DQu2I4MqAlmw4
         J2ADb1hZT8SyrHVmtUnQHqjuORE7w+BgWvjQ0tOCGGjv3IdhVjJbGe5dO++mCJwH7yqG
         BpaWcN+WR/kx9V2yCg+EA7Fg8Tmlx9j/Ht2dM6jAWQ1AKxST99qPZHzPD/e9TJaCYE2n
         KRwHdw4NUAvTKM5dc3PtKYBHct8U4ob5tb49mJ3kkM2iZz/fchdarjVnTDsxGgYBJs4o
         PdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022699; x=1709627499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWWjdMDDlRbFnAQIhSeSTyA3KAYjkYko4A1TtZtt+H4=;
        b=mii33Iyt6Io8RNNLb3j4cimchihjFLxpzUPvToB7DfgVIDSoN3hA2HNGbYiNKibBFh
         dyhkgitW4ylMvtRlJKAzWKP+M2TyJnOkqgl823OmMJlJwGboshv32YuX/VmcgranufHk
         kD+F/UwGzICM/z2yEQ9BnmXlXi0Ac4q/ql1jjg8a6jnBiH4bM/EjceTTa2PI3iiVPQ4g
         r4lIg9XW4AkmHA3D0l6WhfUQPYOVgAmcoyj01q02ftPn05VLcqLgjaJouarJeFojBOmP
         JZNj4sXVibCl2YYbe7TskUg6T94XuFpuf9DhZ3GXFAzSnqhPT76/MXp5dmngISnklZa9
         uRGw==
X-Forwarded-Encrypted: i=1; AJvYcCXBPWDDCb2GOiivlzP4A5lMdHLusJ5FWNslUN9AAF7LTCrNeY5S3tRklgV8XRGw/e5NiLUyraZ3pcKhyJ8gkAmhiTUNg/4U
X-Gm-Message-State: AOJu0YyotGQQzVKsFHfyepXn7eWYaQFbLtnuc3y3NgwgFpgAt1Ov5SdN
	Fw5e5xRAcdsWFZAQO4vtAQzvZ3G7MQlcm+Wicm2xOV/5/d9H/lMYzcKOE167hrpIzAo3je2Xk5P
	tprKmvuldyaX+RftP/rauuMdxFf3c/I+w+UBosYfX1j88yj7YOI4o
X-Google-Smtp-Source: AGHT+IEywMFCEF6R2EVKftvTDUWpnQPHNLoR6/60VpqwpXfH1fWVVUY+TrWJGh0aKLi+cUFG+WVi9V07kMYmfjg2/r8=
X-Received: by 2002:a17:906:7243:b0:a43:a628:ff31 with SMTP id
 n3-20020a170906724300b00a43a628ff31mr909690ejk.26.1709022698526; Tue, 27 Feb
 2024 00:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh> <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh> <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
 <CAOSNQF2d27vYTtWwoDY8ALHWo3+eTeBz7e=koNodphVVmeThMQ@mail.gmail.com> <2024022737-haiku-rental-5e7b@gregkh>
In-Reply-To: <2024022737-haiku-rental-5e7b@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Tue, 27 Feb 2024 14:01:25 +0530
Message-ID: <CAOSNQF1_7p61pgGBcb0QWmCLCBfNAk2-gQ4qFybfbbxON3n5pw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:02=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 27, 2024 at 12:27:09PM +0530, Joy Chakraborty wrote:
> > On Wed, Feb 7, 2024 at 8:33=E2=80=AFPM Joy Chakraborty <joychakr@google=
.com> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 3:04=E2=80=AFPM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > > > > Userspace will see a false error with nvmem cell reads from
> > > > > > > nvmem_cell_attr_read() in current code, which should be fixed=
 on
> > > > > > > returning 0 for success.
> > > > > >
> > > > > > So maybe fix this all up to allow the read to return the actual=
 amount
> > > > > > read?  That feels more "correct" to me.
> > > > > >
> > > > >
> > > > > If I change the behavior of the nvmem_reg_read_t callback to nega=
tive
> > > > > for error and number of bytes actually read for success then, oth=
er
> > > > > than the core driver I would also have to change all the
> > > > > nvmem-provider drivers.
> > > > > Is it okay to do so ?
> > > >
> > > > Sure, why not?  That seems like the correct fix to me, right?
> > >
> > > Sure, I can do that.
> > >
> > > Is it okay to change the if checks on the return code to "if (rc < 0)=
"
> > > instead of "if (rc)" as a fix for the immediate issue with how return
> > > value from rmem is handled which can be applied to older kernels.
> > > In a separate patch I can change the definition of nvmem_reg_read_t()
> > > to return ssize_t instead of int and make corresponding changes to
> > > nvmem-provider drivers.
> > >
> > > Does that sound okay ?
> >
> > Hi Greg,
> >
> > Sent a patch https://lore.kernel.org/all/20240219113149.2437990-2-joych=
akr@google.com/
> > to change the return type for read/write callbacks.
> > Do I mark that with the "Fixes:" tag as well ?
>
> Is it actually fixing a bug?  Or just evolving the api to be more
> correct over time?  I think the latter.

It is more of the latter i.e. evolving the API to be correct but
indirectly it ends up fixing this bug where positive value returned by
this rmem driver is treated as an error in nvmem core.

>
> > It affects a lot of files so might not be able to easily pick to an
> > older kernel when needed.
>
> What is it fixing that older kernels need?

It is fixing the handling of a positive value returned by this rmem
driver which will be treated as an error in older kernels as the nvmem
core expects 0 on success without changing API behavior.

>
> And do not worry about stable kernels while doing development, only
> take that into consideration after your changes are accepted.

Got it, thank you for your input .

>
> thanks,
>
> greg k-h

Thanks
Joy

