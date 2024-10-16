Return-Path: <stable+bounces-86427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D99A0092
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 07:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06801F2214F
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 05:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53818BC1A;
	Wed, 16 Oct 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkPncwBE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D518BB91
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056382; cv=none; b=uJw73GIWZXbV6EGXX3Zw8p0GpZJDd20YpCcUBhaod/Ep8x6vRatdB8kCUkvQog2nv/0FV9dYzyGnB/sP4SqrYUI029XQjjeD2u9e2bl85uwRPUrbdAVYGxHfyfVr/pQWWBqnRlf8RTfeh7U8spnjj7l6IjDzRKU7nxGFn3SK+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056382; c=relaxed/simple;
	bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZXLrGmET8ygC58bzLBjV1xF3+1tr7gP0XeVy6eE6M+OAfSzHLkI9r6Wil/o7ax8ZrqFMTHal7cPuvBIZpPOslVH2LTwkZHsIQGfI/aiiD/e1fkLK9BW94aKVXEFXJvI7Pat60healNKhbu2A2lRPd8M5hxoYye8HPvSDRZEgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkPncwBE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729056379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
	b=dkPncwBE4mCDZ30/3qrokocBgFEd/hV70K7lbDUuse9uPj6qCc3JXp9MZTWPoyggQVBxj8
	ovkOmL1H7G8bKRQYcPIrXkhhjqRnsx1EjWhL/ZlRSmOZvpC/v1zQAs56Ysw+dNTBujr1mh
	hRKuoQQR1gb2ZmSCDU1K7DbJzAQbYMA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-JsGMjY8XN0Cdgj5Clr7A2A-1; Wed, 16 Oct 2024 01:26:15 -0400
X-MC-Unique: JsGMjY8XN0Cdgj5Clr7A2A-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2887dd3c2fdso3127339fac.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 22:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056374; x=1729661174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
        b=DBVcNzCSppHkaI00IkcQ3Ye4c5um7GwnhTsvD+2Gl+RFGYLXmanWP8J90oravtAb53
         jY1F8tLl45fCpnqE4L+rkXIE1HvaHhk3cJrt4A06ctiAUIdvHRnTEa2PLgnZjCbSoccE
         rfFSetybn+H0/1FPfyBQfTzPYShbzKIFGC/HSDa1XWuN48XfR46+7TnkJ++MzTKYX3eL
         Vt1Jys/7X/yrWpV3jX8TSsYy2Kx/g/jFM1onaHua5SDgeXbyctIdplfM10WQQsRneIX1
         LNP0ArZmkqslbPjPZrjK8FXdqeETZ+sdSyCf0YOoOXyns458jj8vqlArquU9H9iW28YA
         gD+w==
X-Forwarded-Encrypted: i=1; AJvYcCXGYKeqNlnIcGl4vhuk6Tt5Krt67CbIeiIFrDa9Y5khTsYFuUbQ0IY8bZ/fRO8P6LbDdoI+/FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZ5Az9X7y0YuWM8FNMG6t/YesB63LfqiCBSFOAMTi2rhJKtsE
	oW2mL3kLWmi2w2Si4m502XY+HD8dWCBWLizA1YeCUBBuLSgblPHUGeJCrw7GaqXOukP1Fd5ZH1o
	ZgoLhjq5tUQ+IyZORgk+kM1LDTMtVJFDQQOQaAL2G56KJqrxuG7836i/h+LKV+JZc/o/Y/mW7ov
	zRt9xH4dG+fRBb+bj2yFjaUryONgz+
X-Received: by 2002:a05:6870:3295:b0:277:eea4:a436 with SMTP id 586e51a60fabf-2886dce9923mr11714435fac.7.1729056374285;
        Tue, 15 Oct 2024 22:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHiwn4RE3PioCKXl96uz0dXLqcSvrhpM0cdTcTe9wx/x5I/zORO0z5prrIEan+L0+LNFhQwIPGrANg5wAyQEA=
X-Received: by 2002:a05:6870:3295:b0:277:eea4:a436 with SMTP id
 586e51a60fabf-2886dce9923mr11714422fac.7.1729056374017; Tue, 15 Oct 2024
 22:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072749.45006-1-alexghiti@rivosinc.com> <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
In-Reply-To: <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
From: Jason Montleon <jmontleo@redhat.com>
Date: Wed, 16 Oct 2024 01:26:02 -0400
Message-ID: <CAJD_bPLcKX+U1k60mgsB_==qrQE+jnLMXSotq3rMrH_o+FtOQQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:05=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 9 Oct 2024, at 08:27, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > Early code designates the code executed when the MMU is not yet enabled=
,
> > and this comes with some limitations (see
> > Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
> >
> > FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
> > as reported in [1].
> >
> > Reported-by: Jason Montleon <jmontleo@redhat.com>
> > Closes: https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9H=
FkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com/ [1]
> > Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> > Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the co=
mmand line")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Is the problem in [1] not just that the early boot path uses memcpy on
> the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer from
> the compiler=E2=80=99s perspective? If so, it would seem better to use
> unsafe_memcpy for that one call site rather than use the big
> __NO_FORTIFY hammer, surely?
>

I can add that replacing memcpy with unsafe_memcpy did also work for
me. Once it was narrowed down, this is what I originally did in order
to boot.

Jason

> Presumably the non-early path is just as bad to the compiler, but works
> because patch_text_nosync isn=E2=80=99t instrumented, so that would just =
align
> the two.
>
> Getting the implementation to not be silent on failure during early
> boot would also be a good idea, but it=E2=80=99s surely better to have
> FORTIFY_SOURCE enabled with no output for positives than disable the
> checking in the first place and risk uncaught corruption.
>
> Jess
>


