Return-Path: <stable+bounces-116415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE4A35E85
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5151896F29
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5713263F4D;
	Fri, 14 Feb 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fSaxiOlE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DAAF507
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538520; cv=none; b=Qd+qHp8njocQ46ccxJR0EdRyYPYzqVdrw+WUAvRMN9mrda0T9/0rVZWwZw6UIQBgdREw+5EUODmHk3Jm+iNo1ggbBXJy6mqwuJut8e7bLx5uoNMEfWAyKS6NFPwYf12UkLxhR/mP8ntC1Bj081QQM45Aj1pkttJ5Lk6AI1NgbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538520; c=relaxed/simple;
	bh=neEm4+Cx/iEQVvb4iKsSOqlmD79lxM637n3ua8WM8qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reu9FJPB1VzdBCSnujPE993WAI9c4q5oUTLS0D6QHzqTLTMqiINPkQDVBgzpW6CraLC+08F9THY7r041T9ZxGObwzCMsLzB2fDljMsLw6PQCZUJBWQURx4UIwGCX9YSVs+ITKNS5+btmdcFHvdMNGrzlogxp9ZOQQNqJ3AB0fM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fSaxiOlE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1118837a12.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739538516; x=1740143316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=fSaxiOlEK7l/SvIlK0sQYJJfqn6g8Q9qkE9RA78PlgGL5rutY91dsdgq3RwNnksUcq
         PcxRjWWkaMJCbYOpMA/RsDkBIH6JPLmSI54PMRJBBhorvyu+6sOhRunv+3rphpVB73lA
         bdZVcxdB4bpfftnBtF5qc8L1D7oHuQ3vy7S757+rFbbX7+bBzJCTSk5EyeRm5Oh3i/iV
         lb7ag4YmsBBFOIsosKY1MfXswoP6m61AMTyvIOhugrLYWuKjjn3WFj3HquMm7wqyrY+T
         jpXgZzJ56RDdzZ+jSXTdMk+LoIjSXu3hSpFwdWwvAFP0kpAn9h+Dui3afB7nMRnhkW1o
         rgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538516; x=1740143316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=pQgFXst9Aekm/h8qzlaYdWWu4zXO7X5I5fapNUzjXDrg1ksUgNsxCHftb86i6q//SU
         HZiYh/iaQHHp2RJfwFDt8ykt8OJGPcnwiTUF6MqevrQ4F6wk16/g4t1a7g8RogNfBP0b
         s+mVryqq48mZKiBvrf5ePxkDiyVPVI234chQtsHIRgLO9vmXzqxvlkOXD3wT4jJl6YAE
         STDUjiFbrs2KrsdsSYu8g+7ww502Zwi9rIib6GOoTjfbyVa4Eow/MnhMsRCQwzOYrCXT
         uWoYvhW7w6wnyKmylBKK204QQLaVo47cBhAaScwTUXCQhB1wekeJNFu0E1A+Y9t12dk7
         Mwfg==
X-Forwarded-Encrypted: i=1; AJvYcCU4sSbkKAvllKKgysuOeVWN9N6yyPY9nHDFeZWYE3dhWlFYWJcIba0EhyR6IxxCnKorjMR4NUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLcxnVVpBik5nykoqUbfgkHcN2Yv05rqE2HgyEulKIX4QKFa+
	bOq5H3M7ez/n0kcB/B1LbC86H/7nVtVyYoT+87U/UmQGONT66/f43wFBy2f39smPpzNx2C6b96v
	god9QZcqxeFDABp9eEGq57t4MVwFTWIc84yZPZQ==
X-Gm-Gg: ASbGncuwDlpKpNel+4Vkg0aCICmlBTusN5A6FGVZJufl+QMLywmhwreeUbe4BxAm5XB
	aMGsLdbdBDSQsXqW9CqFrme01/mRhrjlTCSXbIIgPLyRsosbTd5k4MjbtTcMbAaPVmjHfiqKc3R
	+mOgiUkFhBHaIjLoeKD5Gt185lZQ==
X-Google-Smtp-Source: AGHT+IF50ioArXYzWdb9AwMM5Jd2Q6Gaky4E7wPQIfV+mgA5jj7trK1nfZmCALNES+0mGT+0rIc/VOt17oANdRVwXjc=
X-Received: by 2002:a17:907:2dac:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-aba50fa00c1mr561174666b.7.1739538516107; Fri, 14 Feb 2025
 05:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978535.1739538228@warthog.procyon.org.uk>
In-Reply-To: <3978535.1739538228@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 14:08:24 +0100
X-Gm-Features: AWEUYZnphr9tXHnNU_D4Lm2cTV5HRLCiurerIEsfzwR7a2ytXNxgP0imZ2tMeI0
Message-ID: <CAKPOu+8fGrCgzL6q0SA+WKesMTDEMWkOgTDb1AA_=GN4_k3abg@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Max Kellermann <max.kellermann@ionos.com> wrote:
>
> >               prev =3D list_prev_entry(subreq, rreq_link);
> > ...
> > +             if (subreq->start =3D=3D prev->start + prev->len) {
> > +                     prev =3D list_prev_entry(subreq, rreq_link);
>
> Actually, that doubles the setting of prev redundantly.  It shouldn't hur=
t,
> but we might want to remove the inner one.

Oh right, that line shouldn't exist twice. (Previously, it was set too
late, after the variable had already been dereferenced.) I'll send v2
with only one copy.

