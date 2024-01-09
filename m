Return-Path: <stable+bounces-10345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DBB827C44
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 01:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F09EB2112E
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD186818;
	Tue,  9 Jan 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+FAXg9q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D264A
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da202aa138so2014963b3a.2
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 16:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761422; x=1705366222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3+61FA9oGcVpWil/qQMpG+S6yBzLyUIJg1hxskdQAg=;
        b=i+FAXg9qz8mhk2bOvk4QnXsrFQbLKdxHMSMDYrI7t+1PYIf3K5XQPfqmqvRQMEPgu0
         +enimzYiBOEFK20bDVNEl9dQASKFP06xB3DyQ10K+SDOfmWTZ+6OGje2eOGJ+6+hGNJH
         RgD4vJqvGvoAG+MO15MY/TFR+aFIhlvn+7yMEipX41/2reRqyLY665z8X6Ba5dn5nnyC
         wD1z3tluWn8fY2NxLN1irdhhtwOMuAOj3Tt4r/KWzV0FSvA1AfWPn3w363X5/+ECRu6H
         HtkjiSP+lBgF3xNzLey1HVkaMMHUDXMVJAztI/aGiu1Xor0q/I0ahBFxPwhB0lCHPmhD
         irSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761422; x=1705366222;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3+61FA9oGcVpWil/qQMpG+S6yBzLyUIJg1hxskdQAg=;
        b=J9H4wQyolChkdw5v2A9+sseu5MezUIimP/APFybcUiP8+MgSIJluhdyWO2FPv/MZ4o
         PpkRMWvY0zw1EemSC6yP8fW/ZWdYfrpG/qUjwTJwMXQUP+L2X0DiY/z3suEBoAyfJweZ
         ebs7C+xsQwdt+qaeMFZuZLtHuLZhLOtK3yYy8QmFRLKtiU9BiS0srzej4hG93x/JaB5f
         xj/apXhO7WC7uKUpgmQSU2hm4Eq1ZmSh3L+/6sIJNMG68btH7WjMrI4dXwy2+Z5qdIPM
         G3B3eptimMCCRvD9t1q9gqTjdwaY8i1TgCpKdrRe65N4uFpj4JIhBOTo3wDdqcVoffLW
         V1GQ==
X-Gm-Message-State: AOJu0YyLNjLMP+pFAkuNbunmc87BDrByYNbFVXaS16OMioy0EaruuurE
	iVzKxWEeyIU9FUvNM261FeE=
X-Google-Smtp-Source: AGHT+IEfE2uWtMlu2PLmVIQ3wivjzGf0GdtYZxVZBX+m4bQS4/KqKFX2ZlYtGKztTvfEDFbnFMJbQg==
X-Received: by 2002:a05:6a00:21c2:b0:6db:564:7b2f with SMTP id t2-20020a056a0021c200b006db05647b2fmr1011085pfj.65.1704761422509;
        Mon, 08 Jan 2024 16:50:22 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79d90000000b006da24e7c16dsm440672pfq.186.2024.01.08.16.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:50:21 -0800 (PST)
Date: Mon, 08 Jan 2024 16:50:19 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jann Horn <jannh@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 stable <stable@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Boris Pismenny <borisp@nvidia.com>
Message-ID: <659c984bb4200_a3a72084@john.notmuch>
In-Reply-To: <2024010822-clinking-kangaroo-e8fa@gregkh>
References: <20231214194518.337211-1-john.fastabend@gmail.com>
 <CAG48ez36YXSjKWMfpLFUj9RCRg13WzQG3dHC-cyUtyJLmZQ-Aw@mail.gmail.com>
 <2024010822-clinking-kangaroo-e8fa@gregkh>
Subject: Re: [missing stable fix on 5.x] [PATCH] net: tls, update curr on
 splice as well
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman wrote:
> On Mon, Jan 08, 2024 at 02:10:31PM +0100, Jann Horn wrote:
> > On Thu, Dec 14, 2023 at 8:45=E2=80=AFPM John Fastabend <john.fastaben=
d@gmail.com> wrote:
> > > commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.
> > >
> > > Backport of upstream fix for tls on 6.1 and lower kernels.
> > > The curr pointer must also be updated on the splice similar to how
> > > we do this for other copy types.
> > >
> > > Cc: stable@vger.kernel.org # 6.1.x-
> > =

> > I think this Cc marker was wrong - the commit message says "on 6.1 an=
d
> > lower kernels", but this marker seems to say "6.1 and *newer*
> > kernels". The current status is that this issue is fixed on 6.6.7 and=

> > 6.1.69, but not on the 5.x stable kernels.
> =

> Then can someone provide a working backport to those kernels?  Right
> now, this one does not apply at all there.

I'll put something together now and run it through some tests then
send it. I'm not sure where I got the notation 6.1.x- to mean <=3D6.1,
but I don't see it in the stable-kernel-rules.rst at the moment
so maybe I made it up. Sorry about that.

> =

> thanks,
> =

> greg k-h



