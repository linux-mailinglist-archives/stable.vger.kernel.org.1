Return-Path: <stable+bounces-60621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F379F937B59
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 18:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2501F22BE1
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AD146595;
	Fri, 19 Jul 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrqI6YEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35B224CF
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408168; cv=none; b=Ud6LbtdMWVuw35mhYh/pXlOuaY6hPvXhU3barYjpBt3Q46xyePAjzdLMxFgt7jpbTqJsSpbRbtee5BG3joqqlguFzC7nkWvkBhPQPjDr4kIhEVcShgJCiESlrL6Z5v3wv5MI8voV4bqePAbSAlBr4c9Fy5aAdmDQIm5+HG8v8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408168; c=relaxed/simple;
	bh=lvF0GLCPiwi0BQoWDbKetktKLFHXyf7ys/QdtHkOMSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiJj4Rv+ZqLCuZUQeZtmtFSuf3Un9nRr8VHAkxM9xziorg0nMLndzMOdUdcohPmFSe2hCt6xCxXsVs24HLtDIPHMeFS2j8vE0Y0Gtv/G2MRWkWrJdmOaXeBhuPaz0OTdpUP4I2RGBb7ryXDRtM8mEPbhlsKo1lLbLethbBPlHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrqI6YEs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44e534a1fbeso251331cf.1
        for <stable@vger.kernel.org>; Fri, 19 Jul 2024 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721408165; x=1722012965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz7r7VOBQSyS/Yh1U0qLh5mLC8osHvrAJ2HWM7JAv2E=;
        b=NrqI6YEseZQ26/QRGkviTF6eK2bavWD+pbThcjJDrOZ6b6F2qORsyIIomqVdQahrwk
         hsDw5QsYU35LcWGYvamDEDSzU5rDYJCMGLoBE8pdGxRT2mZSl5c0ORYGvSFkoDWVQ8Lu
         Swmb/RxCz3pIvb3ErqG326v2dpjL5UJpzGQv+TM3WkpHTphgti7iJTTSzZZlCstg6jJd
         YGkrqHvortW0DtHGBRD2noFaOE3T7+gYzvqjXYxdlckVPl3u5h71AxdMRUYwDmMK4CdU
         nVAK5MCmSXPmls5LMxYfKeIdMRM+bq1tV7IJUvWGjjqJnTo76sBpCOPCUD1RD7LMm0yy
         KUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408165; x=1722012965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz7r7VOBQSyS/Yh1U0qLh5mLC8osHvrAJ2HWM7JAv2E=;
        b=O71cqDNGQ+350j2AqF8g6TRQLOxETN9Y8lN2LReMkHTgdwwOqRfdoYwrkwR5mfoWGO
         9aVe21rkxiojVZHFI739mlphu7U7kp0iY3nCeppjoXyvbshMqKNeUlWu4fA6l9QXACun
         5k2vj6d3STrzyNv5qcYMIvf7AvKtRXXwnet0ck8VbLW+R/4LeqchvCx44z8hzWqq7vKq
         ujlIr93EZHoPf/t85RIL0Y3/alog3PSpedF9+wqNXYYq4DeLqlfIlMRMza8IAgXHNS+X
         VsieUPM5IHuw+g689v5OSF9RhG0k9bsoqNJAx3skW815XrVTX70ExP0lF1L5rDmF5llw
         0V0g==
X-Forwarded-Encrypted: i=1; AJvYcCV94kUypUg/QVMXlmfTcsqxyK7Ss2a5rkWFUuEB4V/x0tX2rzjupv+KVRPwvqQpPU2Q5C4yR2i+RCyK2O9rzziO0EumBSop
X-Gm-Message-State: AOJu0YzZqT83IJvCk1D11hNV6jPfbAyx3jU8XHsKZ238Q42/ygXvv1ac
	kGQfFLWn+fhqCufqUjFs08x9t0rEuGkmgFUxVx/bXfAvlvhTMn48eF/d9iiZnsc/P5e2Jq9kR0D
	t4bQ/k1M9C/CojSzRHAFOCoD5u49KMt/sLEzJ
X-Google-Smtp-Source: AGHT+IFfrlXPybbsHIi0McYmW+Pz3rbO8+XcQVpIL6HS4WwCDLCVYi9b5Bgbnm/lzf/27Uayqr/Rx0ABvBU9SQjgnb8=
X-Received: by 2002:a05:622a:400b:b0:447:cebf:705 with SMTP id
 d75a77b69052e-44f9a8819c7mr3522231cf.0.1721408165401; Fri, 19 Jul 2024
 09:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
 <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
 <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com> <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
In-Reply-To: <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com>
From: Bailey Forrest <bcf@google.com>
Date: Fri, 19 Jul 2024 09:55:50 -0700
Message-ID: <CANH7hM4FEtF+VNvSg5PPPYWH8HzHpS+oQdW98=MP7cTu+nOA+g@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, shailend@google.com, hramamurthy@google.com, 
	csully@google.com, jfraker@google.com, stable@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:31=E2=80=AFAM Praveen Kaligineedi
<pkaligineedi@google.com> wrote:
>
> On Thu, Jul 18, 2024 at 8:47=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 9:52=E2=80=AFPM Praveen Kaligineedi
> > <pkaligineedi@google.com> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > +                      * segment, then it will count as two descr=
iptors.
> > > > > +                      */
> > > > > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQ=
O) {
> > > > > +                             int last_frag_remain =3D last_frag_=
size %
> > > > > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > > > > +
> > > > > +                             /* If the last frag was evenly divi=
sible by
> > > > > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then it=
 will not be
> > > > > +                              * split in the current segment.
> > > >
> > > > Is this true even if the segment did not start at the start of the =
frag?
> > > The comment probably is a bit confusing here. The current segment
> > > we are tracking could have a portion in the previous frag. The code
> > > assumed that the portion on the previous frag (if present) mapped to =
only
> > > one descriptor. However, that portion could have been split across tw=
o
> > > descriptors due to the restriction that each descriptor cannot exceed=
 16KB.
> >
> > >>> /* If the last frag was evenly divisible by
> > >>> +                                * GVE_TX_MAX_BUF_SIZE_DQO, then it=
 will not be
> > >>>  +                              * split in the current segment.
> >
> > This is true because the smallest multiple of 16KB is 32KB, and the
> > largest gso_size at least for Ethernet will be 9K. But I don't think
> > that that is what is used here as the basis for this statement?
> >
> The largest Ethernet gso_size (9K) is less than GVE_TX_MAX_BUF_SIZE_DQO
> is an implicit assumption made in this patch and in that comment. Bailey,
> please correct me if I am wrong..

If last_frag_size is evenly divisible by GVE_TX_MAX_BUF_SIZE_DQO, it
doesn't hit the edge case we're looking for.

- If it's evenly divisible, then we know it will use exactly
(last_frag_size / GVE_TX_MAX_BUF_SIZE_DQO) descriptors
- GVE_TX_MAX_BUF_SIZE_DQO > 9k, so we know each descriptor won't
create a segment which exceeds the limit

