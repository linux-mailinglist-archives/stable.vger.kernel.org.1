Return-Path: <stable+bounces-121674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB651A58EC7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208E87A5E10
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE322489A;
	Mon, 10 Mar 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KgVfIna9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132FD2236EE
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597227; cv=none; b=TrP2Ypkui1KXKOtk9vwK2kw0kG4Mj0Ud1ugtv4EzOhiMRIbXkGpr0+6sZcCmi7jQ8oW2OkIzaqpbZsRXH/9tSJ2jWhKLsWo6xIoz1+DqxXLzaZhHJ4lfad1Y3ZUIbfeendTG4jTcV/JHuEGB2pdCg53cqgxCA9a5mkJt3EnMHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597227; c=relaxed/simple;
	bh=NHp7ZMafCgZi0KuBw/MuMMHbK0+r7tHwyaEpZyxsNAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D63VKMx39AiSRk+zNj/MBqAVsb+bPPT/5s899CpsjpnBgl6eIgHAyrlcX6YNgPpZuuCrJGFe8CGddr53y1Qapc9C66i1vKPv1P7yfQe3zRS7GdFuZ/Y6Uudi/HOL1fMlhutcgj3J2ddk6D+UZq5KB+/CjCwyAdb6Wq5XQ4u8RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KgVfIna9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25d2b2354so418688466b.1
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741597224; x=1742202024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Yuxxu0WAoN1GxBYvN/CmEDsSXx0gVMofLIggB5ihw=;
        b=KgVfIna9RS5dA1ZtLtH8NJW7++WytOfFkXrSk3Ou/bJMCIEthFC8hlr53HNDU6DriE
         lWpqIdTvHwswUigEsn74kaK0e9vD2S3zqH0VrMscQAjHpSg6vlpnx4n8OOvhBk7ofENp
         EgDJB63BnKiHerAqcLVjCLtPl+ILfeu2AX+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597224; x=1742202024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Yuxxu0WAoN1GxBYvN/CmEDsSXx0gVMofLIggB5ihw=;
        b=XiM3ZLRSsXL4Hb2Eaguup+uQu7n5rBmTioOyvOVkNTbaReI5bmnsE8cIyg6psAbD8/
         cT5a77m1exNBOxVWu3UndAt3PyCAAgdppLRMg6jk8JIHhHRXLMlmvL55w0+Qa6yHO8d5
         E6v0TlH82/kWLd6rRPsrstSxHRhj3/ckVS0omnjJbqUnybF3EG/VIUp8zucnwVNnDcjJ
         CCJBBsaEIcR8u9Km589nxprEcowNewvObIo1zEOxgLZbbMRMLct/z32cWdjBYGi5hpeu
         MuKLRCLkv6Gb4J+vydPQCkWCG1lUelDbLImP+hf4tBgZiffGTJqM5qE4QoxCZ/Ca2Ecw
         H3pA==
X-Forwarded-Encrypted: i=1; AJvYcCW2AGNWVndY8Dzankv90sE0sxah3Qcp75w1K05anD+3ZSE6V/EiV5xNrznGZNp96XHajTBd5dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo50J9MQmdmRrtw+zakgnPubtpQuJraX6JTDN+K1t0pnwuWtaa
	WAPCzddCce+K5zjYmYOVs9Y2ySzQViKIEmM0bsQypkDWVr+WAfcmwXfHbm6Ya61rx9sZmT2C7VQ
	=
X-Gm-Gg: ASbGnct9NxbwM678rCaODLxH61wVoAvckkaBLTJWv3qL0wm7E3qzp4tZS53/qNTUd54
	lwSS8/eWLs2+hJs+oVB5MYvJ1G+yNsEBCKnuXEYRQulvtmqD4r+00wh7RwH+O9UPnkGEaULDfVe
	ITAzxarCCWM4OZeqQX8Ioozix6SP+4mSHhP4zptOLfZUVSRDKiLzREWL/arE9khQ5jVoRJbmImI
	o+oWPDQIkEHgb1JRKgdeWsEgrAeGiRUxxAbzBu9kaT20awgXgYFRjaEu0j74uAGwzmiUeazXtol
	WA+LoDYTUh2vlzCFtttknlPA8qrX126mNgC1z8mDm6ykPbSxj+3trjH1ImuVnMZiopCEm7+vSMA
	UsCTz
X-Google-Smtp-Source: AGHT+IE/P1SCd/QwTsKwRvvu0nZS+oTcepVXDbSfm26uSJZBJCKlr350kAA/3E6A/7TBiZDoaGXgGw==
X-Received: by 2002:a17:907:94cb:b0:abf:40a2:40c8 with SMTP id a640c23a62f3a-ac252ae1b6emr1288164066b.28.1741597222165;
        Mon, 10 Mar 2025 02:00:22 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438117sm721793066b.26.2025.03.10.02.00.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:00:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso9246a12.0
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG83zkcDqDh8r26wC34yoXRwLEHHVS/vWiPsmn08KayuTw78EJBVyNBNT1whzTiDmsiLSMT2Q=@vger.kernel.org
X-Received: by 2002:a05:6402:95a:b0:5e6:887f:6520 with SMTP id
 4fb4d7f45d1cf-5e6887f672fmr62677a12.5.1741597220471; Mon, 10 Mar 2025
 02:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
 <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com>
 <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca> <87wmcxs1xw.fsf@gmail.com>
In-Reply-To: <87wmcxs1xw.fsf@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 10 Mar 2025 18:00:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A70T2iaN17X2Jfk_6fCKRYZdKpreb+9i76n5WMYNEt1A@mail.gmail.com>
X-Gm-Features: AQ5f1JowVCHSCv6zRQDIlGrshBtBzEUT-W75FlZzOuUhz9aDBR_F5KxVvuObz24
Message-ID: <CAAFQd5A70T2iaN17X2Jfk_6fCKRYZdKpreb+9i76n5WMYNEt1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:52=E2=80=AFPM Mikhail Rudenko <mike.rudenko@gmail=
.com> wrote:
>
>
> Hi Nicolas, Tomasz,
>
> On 2025-03-03 at 10:24 -05, Nicolas Dufresne <nicolas@ndufresne.ca> wrote=
:
>
> > Hi Mikhail,
> >
> > Le lundi 03 mars 2025 =C3=A0 14:40 +0300, Mikhail Rudenko a =C3=A9crit =
:
> >> When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> >> commit 129134e5415d ("media: media/v4l2: remove
> >> V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> >> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> >> no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> >> introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> >> V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> >> no-ops, making cache maintenance for non-coherent dmabufs allocated
> >> by
> >> dma-contig impossible.
> >>
> >> Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> >> {flush,invalidate}_kernel_vmap_range calls to
> >> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> >> buffers.
> >>
> >> Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> >> V4L2_MEMORY_FLAG_NON_COHERENT flag")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22
> >> ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> index
> >> a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7
> >> bc888a84a95d5 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> @@ -427,6 +427,17 @@ static int
> >>  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >>                                 enum dma_data_direction
> >> direction)
> >>  {
> >> +    struct vb2_dc_buf *buf =3D dbuf->priv;
> >> +    struct sg_table *sgt =3D buf->dma_sgt;
> >> +
> >> +    if (!buf->non_coherent_mem)
> >> +            return 0;
> >> +
> >> +    if (buf->vaddr)
> >> +            invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> >
> > What would make me a lot more confortable with this change is if you
> > enable kernel mappings for one test. This will ensure you cover the
> > call to "invalidate" in your testing. I'd like to know about the
> > performance impact. With this implementation it should be identical to
> > the VB2 one.
> >
>
> I have re-run my tests on RK3399, with 1280x720 XRGB capture buffers (1
> plane, 3686400 bytes). Capture process was pinned to "big" cores running
> at fixed frequency of 1.8 GHz. Libcamera was modified to request buffers
> with V4L2_MEMORY_FLAG_NON_COHERENT flag. DMA_BUF_IOCTL_SYNC ioctls were
> used as appropriate. For kernel mapping effect test, vb2_plane_vaddr
> call was inserted into rkisp1_vb2_buf_init.
>
> The timings are as following:
>
> - memcpy coherent buffer: 7570 +/- 63 us
> - memcpy non-coherent buffer: 1120 +/- 34 us
>
> without kernel mapping:
>
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_START|DMA_BUF_SYNC_READ}): =
428 +/- 15 us
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_END|DMA_BUF_SYNC_READ}): 42=
2 +/- 28 us
>
> with kernel mapping:
>
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_START|DMA_BUF_SYNC_READ}): =
526 +/- 13 us
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_END|DMA_BUF_SYNC_READ}): 51=
9 +/- 38 us
>
> So, even with kernel mapping enabled, speedup is 7570 / (1120 + 526 + 519=
) =3D 3.5,
> and the use of noncoherent buffers is justified -- at least on this platf=
orm.

Thanks a lot for the additional testing.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

