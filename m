Return-Path: <stable+bounces-208089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66642D11F3C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B7C3300CB4C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1C320A04;
	Mon, 12 Jan 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb/PY5Dt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7502D0C9A
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214374; cv=none; b=ZdN9rdDIAZmyCerOPh7CmCSvOsXL4SQEcEYJnpTmp+36T5KZn4rdqzpu/QhUPN6gSlL0Bp473ayxgBGC/GHN+8R6K2Zx3RbC0169LAtXw5L1NNkzMbeIE3KlTTS6+sp3nqUfutv6DaErO85fIFnuV5LY2igrocKkIRbbFPxWGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214374; c=relaxed/simple;
	bh=6OLfkh5UQ34EfXttFXpwbbYEZ5ypLgAzC/JzzmCDSd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObU/iEQnETwA5B8UnSTQ3oaZEbKyWJlL26NB3U+E8q9UOuAUxuhx1yzt71KY5C5X1LWqIdk/wlFPcMpSdcsrfpagPNBAbsdOSCGWN1RBAYwdZUmlBRE/biHOLlK49KAKv6rNcVg5e93oWDmHWoyA80JyFYo4mB/RzBzUQbk9c44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb/PY5Dt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a09757004cso57697755ad.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214373; x=1768819173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UenKJW7FDUByZJnFEy7SwCkIKfj9EmdUi7nZ1uEh77A=;
        b=cb/PY5DtDCR5U6mxT9XeHD9deZijGsdjmjedEZ3eDL6vbL5KZ60WyZLHRtXgvEE1VV
         iGCM1r0n6yB07vglaROF+jgqJsu70pn1+g+/SY50xgiLye5aHPTX6VIfCNEN7q1SXlTy
         VM68mm/3/3yE/WhkIXwV/2EIzbaw0biamSKr2djZJ/4FjleySK0LAdxhAgOwAh4N8iae
         BnS5fI+DT8dSBnyu0AC4y+Cf9R1mmF9eCqu4qS7mL9FKu1FB8MCDG43NDxCfiZP/0ine
         6SK4qSa8LdTBaaLQImHV1vGSsxm3xTxD5cgB2cKz/atLwpvatlQtLqRvf9+cj8zoQkQg
         QWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214373; x=1768819173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UenKJW7FDUByZJnFEy7SwCkIKfj9EmdUi7nZ1uEh77A=;
        b=kTQII8Vu04rC0It4JLMij+iOIh27LPVJhnjZ/W9zsZvsUpYsX1djfKAwv6eivGWQgl
         lO5UC/cH7lWdAQm0mUryOCTElIbRAYe2A3QO2WoNKYHYVOSUHuot3mnSSozKbM4CsaVS
         5oL3VACdLAkapTBNqq4SOdU9Cui4SVJx4GiTbGGqkPRzfy7vhj79FENom4z3iZBI+7/V
         0AUD/vbUuBkoSKQdIGFcDhBZgzB11UrZyYScAmHfX2Ur6Vql4ResOfkxuQjNNyyTjZZ2
         43Q5ZsKYkUDIaCLIs4x87MIv2ORSLHMCDSaf/ayFZLqC4L374zHnRNSjjW91/VX7TDnN
         8JqA==
X-Gm-Message-State: AOJu0Yw3EjYEYyv/3ySFrxjVjiNj8zvDEbyyj5tWvJ655DXbQLjJZpm9
	F2iuSW5ElHD6UsskgOk1KfqBcxe0d5b8FuHy2hTtlRCjEN1i3D85zeGV/N0mV9RojggyFvlyibv
	HoHLR34XJ3iN5OyfJjHxorsXOWdAzwls=
X-Gm-Gg: AY/fxX7JukXChRuQZGXNhFoiENkvU2TTRNxWdVRspY702bL80AR6kfCBBkItwleLaWu
	G1X4YmT/F2ZlWY3EFB5QK531epFLSxJvlSwcP+2eBQMVnHtL6k5ONesW1GsWudoHTdpleNjTNH4
	x0ZjrOK9kdVjXr1u0SpxU9HWgWGMVdZaI6eCF2IknN1t2B6OzQnYHMavYj7PEMRyR50kLgZPcWr
	5QWlhiFZx+LrZgdLIr6LsJV+cdh9UQcNy1oZsXTNda17au5w986RaljBlYmyIVIBPQDTEOT
X-Google-Smtp-Source: AGHT+IESQjBmYnaEzEFjC8s1z9ZJGCxueQscFrM8SwiysrJN1Un45jUHXMSNQG4UqdhFoyrEcxjFx9EeXGK1zWLnc2A=
X-Received: by 2002:a17:902:cf06:b0:2a3:e7aa:dd6e with SMTP id
 d9443c01a7336-2a3ee48ac0fmr167548265ad.38.1768214372727; Mon, 12 Jan 2026
 02:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK+ZN9rJypDknnR0b5UVme6x9ABx_hCVtveTyJQT-x0ROpU1vw@mail.gmail.com>
 <2026011208-anger-jurist-a101@gregkh>
In-Reply-To: <2026011208-anger-jurist-a101@gregkh>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Mon, 12 Jan 2026 18:39:23 +0800
X-Gm-Features: AZwV_QhZhWX1GcqhyeVAsJ8yptjpLSjxIi-29yvJiNR1Vz04J6RwVOEBfvb8hvI
Message-ID: <CAK+ZN9pLcrmVHr+EVMU+e1GRPT=AB3Tv2VggLWFFm-xX7508ug@mail.gmail.com>
Subject: Re: [BUG] misc: fastrpc: possible double-free of cctx->remote_heap
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, srini@kernel.org, amahesh@gti.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,v2 will add the missing tags:
Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@vger.kernel.org # 6.2+
I=E2=80=99m having trouble sending v2 via git send-email at the moment; I w=
ill
resend the actual v2 patch as soon as SMTP is working (or attach the
generated patch file if needed).
Thanks, Xingjing Deng.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 16:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 12, 2026 at 04:15:01PM +0800, Xingjing Deng wrote:
> > While reviewing drivers/misc/fastrpc.c, I noticed a potential lifetime
> > issue around struct fastrpc_buf *remote_heap;
> > In fastrpc_init_create_static_process(), the error path err_map: frees
> > fl->cctx->remote_heap but does not clear the pointer(set to NULL).
> > Later, in fastrpc_rpmsg_remove(), the code frees cctx->remote_heap
> > again if it is non-NULL.
> >
> > Call paths (as I understand them)
> >
> > 1) First free (ioctl error path):
> >
> > fastrpc_fops.unlocked_ioctl =E2=86=92 fastrpc_device_ioctl()
> > FASTRPC_IOCTL_INIT_CREATE_STATIC =E2=86=92 fastrpc_init_create_static_p=
rocess()
> > err_map: =E2=86=92 fastrpc_buf_free(fl->cctx->remote_heap) (pointer not=
 cleared)
> >
> > 2) Second free (rpmsg remove path):
> >
> > rpmsg driver .remove =E2=86=92 fastrpc_rpmsg_remove()
> > if (cctx->remote_heap) fastrpc_buf_free(cctx->remote_heap);
> >
>
> Hi,
>
> Please note, stable@vger is not the email address to be asking about
> this, it is only for stable kernel release stuff.
>
> Andn do you have a potential patch to resolve this issue?  That's the
> simplest way to get it fixed up and to show what you are discussing.
>
> thanks,
>
> greg k-h

