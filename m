Return-Path: <stable+bounces-189001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB7ABFCBCD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFE73A17CD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0CB34C991;
	Wed, 22 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL/8yhpO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7734B19A
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144844; cv=none; b=LpmIcmHXdQVXXl6aAL3eKNSTiQh/S2wmCd2amUEI6S4CyOWG2/4Pdeppvour8xFYa4THb3KZeSIEE3Y7X3AqjqHOPix0n9OaZsnSqXPfJ+8UjU0pslomT38Lk8S5YpoOp8/rtpO+uNCAEGeXOcnbZvrXf4VMZUH9IUbX57so01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144844; c=relaxed/simple;
	bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBX8fSPi/Spmlauw32ve1DYue0RkXUZvuF6gsyL8hX4CJp06RYHP03RyRtBmfAGhBIr1q6sZfcAlPUMOrPXVJPISXAb1jPlRGLoAcepwZSzkPMItjTEObVWgakQNMTncDN/GbQBt7fR4nC1heetxk8CxvlKqma6heHBb7Wi9FSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL/8yhpO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b4557950d23so125320266b.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144840; x=1761749640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
        b=AL/8yhpOqQkpiE/+WJdMEYRlOKeqUqHddQ5y9TgWJ4mfVmJzEBxtfWI5erMBihdD2J
         XKH83fUX0x9DgFIwQ/jErQ8lKqPk/Izt8tkNpZmmKTMSqgpDCFQYDmnECOOnebnW6ZEw
         lL+0H28uPPY64BJaSpC3f7OycjeVYQ2cdbaUnJCnwy+28EXMg+Szcj3Q0LaATsekWysg
         JszZBSnJ3xWexLcrVIKDc1vQDMbmgVRqQZyi9zswePHLkRUeEkZoDPxuT1BOkrI+0vPI
         dAagkhoAf26tOkX23HDkW4jPq5TCuep+sC7zM5qWmao2+p7vzVHsgHUe8UpE2mAqn4NG
         Ddpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144840; x=1761749640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
        b=H5bTu8siyAiWHYVjIyAuV53rAY91NPuqRj6PfU/XqOxBqcn8hjOt1b8e2M3jU8hwBb
         FJoUgVqpb5+cBfavtrWCEw7mwvPXsEWE/GS2NLg5J88fY1wgK8W3kczCiVgZyCU7fMND
         4ziMJI7IdlwDCL8JypCEUU8aDYyfz0VJHTWF7x04zavRCBeJhKjKGMMBvJw/FAV9hIdC
         uBTqloZ3IT9rWmjBjFwXljlcEKrgAoIFzcrqVbKyVln8VELfvBlVWowLTe/1Yi+B03Di
         QOQegGdgU+aGlqouI8A9NWaWkImsdxsx/sQ6yYy3IzTF1Sv9TG1dHKsq3Fj1mFRMvJ5V
         v0zg==
X-Forwarded-Encrypted: i=1; AJvYcCVBqj2cd84pFPrL1x3NEInVM2HB+BVssdoY8TKmnT7OHrKHJNe1OxTgl570P2cxkWu99Gi/GEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHizPr27Zkh2RZLIBkmoiQEeHRPqlS8gdjloWezgJ1eYDtTBp
	2SptZ3g/BGBIVFJyaonc9jH6+cZYxvzaX7/LYCZz8+dFdR3Zm5NLmi/W066Z4L2TmdOvfHkh6B1
	RZy3qI6rTItlyqbudcQOBTOMQZGcDLV0=
X-Gm-Gg: ASbGncuhmOGky//6Dxa5ycuVYk54PyqXmeYisOt2v0XaSYbB67qMLtpQCtKJqeo5Mlc
	JkW6HU8UJhw3Q0vyTzU7LZfLWN6/dCZ1lkzQO1yxR6Fb/g+i23qXoCAbWzUiHWQXm7Q3FynhxrS
	9JgCy0NfnCQM5nphanxWUk6f6EfHIAK/463d2qhx7SgDeD0XqcsOQEOYbVPtpkitLjEf+hmIp8M
	3qlLS1UDUOhWuNWZ9bWuNI42U12gIB1LIk9OQvuIjHdJLTgnoA8YwPKX+8xIg==
X-Google-Smtp-Source: AGHT+IG7h7TaFxHTuDY8AWEs3DohBAFF5ntTu6CWIe9+nZpuje6ygTxavGcJ/i05b9VtLfcssN/cg/UG6AHp/Ayc0iQ=
X-Received: by 2002:a17:907:d90:b0:b6c:55b5:27a2 with SMTP id
 a640c23a62f3a-b6c76fa331cmr460806666b.6.1761144839990; Wed, 22 Oct 2025
 07:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025102125-petted-gristle-43a0@gregkh> <20251021145449.473932-1-pioooooooooip@gmail.com>
 <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com>
In-Reply-To: <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com>
From: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Date: Wed, 22 Oct 2025 23:53:49 +0900
X-Gm-Features: AS18NWC4GzKd1xEuugd--eot2ZHrwZpDIUjy0AlgxBnilTm3xbX4azrPGMl_XLI
Message-ID: <CAFgAp7ixLZLXGSN6tOmtNj0f4b-z3pnMrQg4Avnb6tOvj3h3KQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: transport_ipc: validate payload size before
 reading handle
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae, Steve,

Thanks for updating the patch. I=E2=80=99ve reviewed the changes and they l=
ook
good to me.

Minor impact note: this patch prevents a 4-byte out-of-bounds read in
ksmbd's handle_response() when the declared Generic Netlink payload
size is < 4.
If a remote client can influence ksmbd.mountd to emit a truncated
payload, this could be remotely triggerable (info-leak/DoS potential).
If you consider this security-impacting, I=E2=80=99m happy to request a CVE
via the kernel.org CNA.

Thanks!!
Qianchang Zhao


On Wed, Oct 22, 2025 at 3:39=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Tue, Oct 21, 2025 at 11:55=E2=80=AFPM Qianchang Zhao <pioooooooooip@gm=
ail.com> wrote:
> >
> > handle_response() dereferences the payload as a 4-byte handle without
> > verifying that the declared payload size is at least 4 bytes. A malform=
ed
> > or truncated message from ksmbd.mountd can lead to a 4-byte read past t=
he
> > declared payload size. Validate the size before dereferencing.
> >
> > This is a minimal fix to guard the initial handle read.
> >
> > Fixes: 0626e6641f6b ("cifsd: add server handler for central processing =
and tranport layers")
> > Cc: stable@vger.kernel.org
> > Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> > Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> I have directly updated your patch. Can you check the attached patch ?
> Thanks!

