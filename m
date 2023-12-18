Return-Path: <stable+bounces-7818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C004A81796C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758D01F23BFF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91971470;
	Mon, 18 Dec 2023 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGZ72ACc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1E7145B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3365752934bso2747677f8f.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702923178; x=1703527978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58Gih+1cCKEZtQE0H1FBbNtfytht+MijzbQmXiqk8UM=;
        b=CGZ72ACccjhI9v5eQG7wMlOy9WWgDTX1dZDwb5gqSjAIbyekQBrcZqui83JcwqjE/Q
         6COBJxUoiFA/RqbKYHtpW5pzeu/4SlODv+CEUN2gSqtGXN0gvGaWVjfLu63qIerD9uWO
         asevW9xHtRApXDVXkoUk4Qt/zKBIoBTmZGC9NYoMDe8r3f9Yb0buhUS1tmhkphcCOO+y
         majQuFctBuIVu66mOmLa4rjyy2eHiiSUPlGiI0dgqpX9W9u30uy0Ck1n7Iv3VvMl9nRy
         +/LSOXLVmifqKdfQTJlk5i19Pzsf8kfH4NzAMP1bWbbNAJhVHRb8JW1PatQDsJ0q9QRu
         JtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702923178; x=1703527978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58Gih+1cCKEZtQE0H1FBbNtfytht+MijzbQmXiqk8UM=;
        b=goxVvlEVc3FPQT34pm2udM5UmYnJciqgounPLC0eFzZ7YV9pEyzdXURuJ2FzN480U+
         Wmd4PixpsziEo5S9Sh39BfEled+jeaZ+rudWVgU3Qrbny9IgeDWCCMKmKLxWzb4p7PIB
         v2NdjBcLc7/bhkYoD3Xb+xX9TNnV/qAbRKSdqmHItffqD+GH45+VvN+nI8Hu1qUHcXC0
         kZlMz4Q92KXg5Vb2fTB4V0mlaUqG4yWYQEErLUQrxn+0UT/EVcYGAzU03kDMriXlmy5c
         d+AdKBHVi23j+amgY8HFgJLl2Ai5dukcq+8y9TQZSotdxG986jkHcr0+Bt1IftNOYCj5
         QevA==
X-Gm-Message-State: AOJu0YyVFBC4LYJ74DIsyoTsti+nqjUKvOdsJLtgR8uCl9kl7MH4Yidz
	1hS1H2PBDQUTu7dCKun29a6jztKanocPmv7YJOlS1NDJeyJLnUUsRQw=
X-Google-Smtp-Source: AGHT+IGmLFD33VuUhi0zqnM2bFziedIYJ4fD7kPUt/umy/ZWTGtN+dBDcc0C/PdmEp5pzBWN56Juwctap62aoUlW2RY=
X-Received: by 2002:a7b:c4c6:0:b0:40c:2766:5424 with SMTP id
 g6-20020a7bc4c6000000b0040c27665424mr8680729wmk.171.1702923177648; Mon, 18
 Dec 2023 10:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023121132-these-deviation-5ab6@gregkh> <20231215021507.2414202-1-royluo@google.com>
 <2023121855-uncommon-morbidity-cb4c@gregkh>
In-Reply-To: <2023121855-uncommon-morbidity-cb4c@gregkh>
From: Roy Luo <royluo@google.com>
Date: Mon, 18 Dec 2023 10:12:21 -0800
Message-ID: <CA+zupgxoaDSi_hSoyaGTJQnskO=qj87xaTWt5SQVHtZdR6+gBw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] USB: gadget: core: adjust uevent timing on gadget unbind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Why just a 5.10.y backport?  What about 5.15.y as well?  You can't
> upgrade kernels and have a regression :(

I was waiting for the 5.10 backport to be accepted before sending the
5.15 as this was my first time sending something to the stable tree
and I wasn't sure whether I got everything right.  Maybe I was being
too conservative.
I saw you've applied the patch to 5.15 as well, thanks for that!

Happy holiday!
Roy Luo

