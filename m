Return-Path: <stable+bounces-210155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0CBD38EF2
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BFFF300670E
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BE221277;
	Sat, 17 Jan 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VISbBxTT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E771D435F
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768659037; cv=none; b=QZS8pvauh1RxoSlGzajLnflDJ5V7DyLAcWm7No6nIXYt5jabmc6jIxIlkReQwkk/8Yd5/NXmb9zQ7jdeoN1o8IU3FfE17FUjsuM31THHzMMP4uY0Y554mteOv0chb+NYJplwZbRfzENwdjIeAGBSxBzRtdyQCc6yKM2TN2rkZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768659037; c=relaxed/simple;
	bh=ggGuMBrgaqbq+UPiEjkf1AMFsj+/KZ7MQE36wg1SOx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQxf+QKNiCBfF+H+0ysQbt1YBtbsHKV48imRzvtGZxHu+i8zlZHmQgPQ9Y8eXInY63PMcnc0gOuUYieZxS3TtxGJyHItexp1PEynx8YGqbkMShdD74CrvO5xvvQkYcVH2+gBKLd3cC0BZG/3Sw55RYwZwBKrjQsGrSG6m+z9qt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VISbBxTT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d67f1877so19569505ad.2
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768659036; x=1769263836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LS4zezA5zWDHI1TzJGTvFcU5cfzTeVoC136inl8tl/Y=;
        b=VISbBxTTtEUA3jhPXHOTSuRrFDPwboTyDRFbYX+oCZwAIxhVIkTx4VySamNHUSfMyO
         BPwLaCrmChT5Hx+cKEagM1VJFd5thTktXSpnQyCzackkZXeeQSQ/3wP7PZ0MyPOwBM+M
         eIC1krH18uRL8fl7NJZwkc9zptKkIggykWslT36aPh6DX29wCgkmrJLikkMKhFOlh9hO
         JLxRiLrYBZEtLfmaRrjCER5LwrlPdtGAgP7/sJTIY+1IGs4qmQEGFG9fbb1TBl4y4wot
         G0joEszdXaBAVfZIdPuMzimHYqr/zcVgIvAv95o1mfLGEyTqs71n75ChHPF3mv9XzrpU
         9YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768659036; x=1769263836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS4zezA5zWDHI1TzJGTvFcU5cfzTeVoC136inl8tl/Y=;
        b=TIhsLYSLKfmnNL+v8p/60UPUIlkZZ4J58mYf9RT2/oisncNnNAKw1wduGfu7BvVdDu
         D6gmScJrG7BFU7BIpDiYHV14ymsgVS8JOxj59i6ULzMrB7BYV7HRxsLk0MpNOYDY6WU3
         tAAJx8fhgpbYsIVNBJl5yffex4G/8z705mHcZS+6h8XOKLzMaFTQxefhpmb7Ugqkrf/G
         9qXJ5X5iVtY7D82ZFFpk2sI9lR7a9Tz1ScMgxTLnobVgucxftU2VmaI8R+FxR3cEnyD5
         mRDqSoOk/uD8/wFWqIzGAVVtJTi2OLF5RC0TTUD/auiw1+Ep3p9AFbRX0WRn2wVRbYGJ
         kKNA==
X-Forwarded-Encrypted: i=1; AJvYcCWV4sPPIlh8NeTqaw22r7Pv+wD/agKsYhVZ+nL8GDy8eWIj8JN/LSXvm5m3CFdN/xRhz7qZgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlSfXA7s3w7jxz1v3Ga+igyJyyseOBmLF8h0h4VOq/uCA+vTQ
	66m9Ey9c/frbgrCe5+gI4Nb0OV0pwbrslx63JgphphpS4/bOmZxvzF8m90smqFxRddMhd14Uemo
	90Aq9/Ko4VYGOlqxQQtW42AZlryGroFM=
X-Gm-Gg: AY/fxX5i+OwgQp2mmi5OECjn0LOSC0yZD7YRdCW3bHcMQfwFy/OM2tWdzYeuf/z9LtD
	MLTz0OO7wwRJF8tGdoO+0izhmR4NiFUu9swgtFgah5w8t2it40w33oecJZYJ5eECZbaF25bEOiJ
	L68FdEUy0KV7c7wIME5JzjQD4fddQpaZcOP/7gZHafEUfcMSY6QfcEDZMpwWDDYZDKPIs76MbqO
	Iq+Fmn23iRe+XhbpLbN9RaqyOHYup8r15Vsq1/xvIjYUFqfjo0iP2roq9NE+RbzZ44edd65V/U+
	ufBn
X-Received: by 2002:a17:902:f601:b0:295:fe17:83e with SMTP id
 d9443c01a7336-2a7188a9654mr56251115ad.19.1768659035580; Sat, 17 Jan 2026
 06:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112123249.3523369-1-xjdeng@buaa.edu.cn> <2026011650-gravitate-happily-5d0c@gregkh>
In-Reply-To: <2026011650-gravitate-happily-5d0c@gregkh>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Sat, 17 Jan 2026 22:10:25 +0800
X-Gm-Features: AZwV_QiTCXCQyKNQnGgsaWolDN840KiArFFxTvmYD37MsiVp_TLVyXDoiyw1nEk
Message-ID: <CAK+ZN9riLwTU7C9GZrjsrUNh69oTeF=5C6xg+2ifFz=0E+4H0g@mail.gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: possible double-free of cctx->remote_heap
To: Greg KH <gregkh@linuxfoundation.org>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I have released v3. Thanks for your help.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=BA=94 22:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 12, 2026 at 08:32:49PM +0800, Xingjing Deng wrote:
> > fastrpc_init_create_static_process() may free cctx->remote_heap on the
> > err_map path but does not clear the pointer. Later, fastrpc_rpmsg_remov=
e()
> > frees cctx->remote_heap again if it is non-NULL, which can lead to a
> > double-free if the INIT_CREATE_STATIC ioctl hits the error path and the=
 rpmsg
> > device is subsequently removed/unbound.
> > Clear cctx->remote_heap after freeing it in the error path to prevent t=
he
> > later cleanup from freeing it again.
> >
> > Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> > Cc: stable@vger.kernel.org # 6.2+
> > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> >
> > v2 changes:
> > Add Fixes: and Cc: stable@vger.kernel.org.
> > ---
> >  drivers/misc/fastrpc.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> The version changes goes below the --- line, otherwise it ends up in the
> changelog commit.
>
> Can you fix that up and resend a v3?
>
> thanks,
>
> greg k-h

