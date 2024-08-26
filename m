Return-Path: <stable+bounces-70141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3C95EB46
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218901F23583
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5C1487EB;
	Mon, 26 Aug 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Fv2niWjd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95F13B286
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659165; cv=none; b=ojXVMkpMHX+xkNm1bzikbzAmX8VOyH963/kvlL7XjNEIDhthKgmGm0+qsDd4ApcHRJ3vacM8a3AWlEtswjYNCEzlKC4wLsmvFsoqVh0i4Th/rfjTAm0Ga8kPiY8Yb2rxLuT2FXdS7NPdAb5zGU+HRWnS1IYIcwoVkm5/6ESygDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659165; c=relaxed/simple;
	bh=TwwCG1O/BTtho9CI6PmPRJiYQaq2et7h8vIt7s5RcX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QsU2pJQ0WA9aJwSKnEcfh5MUq7qBbXceDA540E1Y0FDvf53oK4AlTRu0etCqkAmiLJB8NCEUybklkv/WXZAn/WZbMn0pZreaf3dsNOJiy1XTbYNbEDEhd6PdZg8zxxGQqtKH7J8jDnDMG9sSANdOD8D/h2zRXGnKTlQAbVDEP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Fv2niWjd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5344ab30508so313869e87.0
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1724659162; x=1725263962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2hgwRmta5vM0mozRmIDBR0h1uowbLIQCJHdIg3QS8M=;
        b=Fv2niWjdm8tkYiUMf5dsX2xksXETCtY/RXdKBSIDH7gZwON9daclEGGfmOykGMVhXJ
         Mlv7almea8DerILsyORtEJhBZZZwV/56TbS9pp+ftNXyQVdQ9p49HmTrCvcoEZy5hxCE
         K6aaq4AMVUYZDSDe4r9CFxeSU+yFFBEPMVyjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724659162; x=1725263962;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2hgwRmta5vM0mozRmIDBR0h1uowbLIQCJHdIg3QS8M=;
        b=FYQvH8dxTatOrKAiLNaCWRvNWBrwonBpP8ZCwbt6M83kUx2YTbzxIRgylo7go+X+lW
         06WBilOvMtJCo19srjywOS9fFp9s+g7XDm/yRGMU0PCZwVAFrRNBj6h03qIWBrdYKSCT
         mdsb51LWh1Q/C5tnvfFmP3hYFHgWqDwX97ZGhAvKB0hwGi48JQnm/JDBM/uBqnD+6P1A
         sdw21X10Mzlfx8mTIyqx8KvNUuYikomnoCrdylyx1i3OQStOVXyrT1/rfSK/4DuANsg6
         JUKWbQ+AsTrFG+aTwNx4mHxN8pcEMHHsXB4LxkxsMblQG53l5kbkIpn22dY/fPq+sOMu
         6qww==
X-Forwarded-Encrypted: i=1; AJvYcCW7FcZVKeFZKWNhZONYVvvirSSIJGsuMQsyvNCeaJP8KOAExyE6LC5hkVx6RCYtEAQCb8daDt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZ1g6/F8UDLO13iJOZ6gZ7AY3+8nWdXTcFX4VKwkuFau1FsW5
	AYCSnDcJwJqKZzd7dDN3Cu3hDn9sssj2FmtBZSFqYcRl6k1hSzIA2QnnihFnwkg=
X-Google-Smtp-Source: AGHT+IEeTyQw+xuzUzvD+dXczs6daRR4gze16Sc+7M/BWDbSDW1pNlYvqgudmE3/tBexko8/9sgT2Q==
X-Received: by 2002:a05:6512:33ce:b0:533:4108:a49e with SMTP id 2adb3069b0e04-53438719a02mr3152188e87.29.1724659161041;
        Mon, 26 Aug 2024 00:59:21 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d635sm1369164e87.193.2024.08.26.00.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 00:59:20 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Jann Horn <jannh@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Russ Weight <russ.weight@linux.dev>,  Danilo
 Krummrich <dakr@redhat.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
In-Reply-To: <CAG48ez3A=NZ9GqkQv9U6871ciNc+Yy=AvPfm3UgeXfMyh=0+oQ@mail.gmail.com>
	(Jann Horn's message of "Sat, 24 Aug 2024 03:34:20 +0200")
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
	<Zskp364_oYM4T8BQ@pollux>
	<CAG48ez3A=NZ9GqkQv9U6871ciNc+Yy=AvPfm3UgeXfMyh=0+oQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 09:59:23 +0200
Message-ID: <87seurd89w.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jann Horn <jannh@google.com> writes:

> On Sat, Aug 24, 2024 at 2:31=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
>> On Fri, Aug 23, 2024 at 08:38:55PM +0200, Jann Horn wrote:
>> > Fix it by rejecting any firmware names containing ".." path components.
> [...]
>> > +/*
>> > + * Reject firmware file names with ".." path components.
>> > + * There are drivers that construct firmware file names from device-s=
upplied
>> > + * strings, and we don't want some device to be able to tell us "I wo=
uld like to
>> > + * be sent my firmware from ../../../etc/shadow, please".
>> > + *
>> > + * Search for ".." surrounded by either '/' or start/end of string.
>> > + *
>> > + * This intentionally only looks at the firmware name, not at the fir=
mware base
>> > + * directory or at symlink contents.
>> > + */
>> > +static bool name_contains_dotdot(const char *name)
>> > +{
>> > +     size_t name_len =3D strlen(name);
>> > +     size_t i;
>> > +
>> > +     if (name_len < 2)
>> > +             return false;
>> > +     for (i =3D 0; i < name_len - 1; i++) {
>> > +             /* do we see a ".." sequence? */
>> > +             if (name[i] !=3D '.' || name[i+1] !=3D '.')
>> > +                     continue;
>> > +
>> > +             /* is it a path component? */
>> > +             if ((i =3D=3D 0 || name[i-1] =3D=3D '/') &&
>> > +                 (i =3D=3D name_len - 2 || name[i+2] =3D=3D '/'))
>> > +                     return true;
>> > +     }
>> > +     return false;
>> > +}
>>
>> Why do you open code it, instead of using strstr() and strncmp() like yo=
u did
>> in v1? I think your approach from v1 read way better.
>
> The code in v1 was kinda sloppy - it was probably good enough for this
> check, but not good enough to put in a function called
> name_contains_dotdot() that is documented to exactly search for any
> ".." components.
>
> Basically, the precise regex we have to search for is something like
> /(^|/)\.\.($|/)/
>
> To implement that by searching for substrings like in v1, we'd have to
> search for each possible combination of the capture groups in the
> regex, which gives the following four (pow(2,2)) patterns:
>
> <start>..<end>
> <start>../
> /..<end>
> /../
>
> So written like in v1, that'd look something like:
>
> if (strcmp(name, "..") =3D=3D 0 || strncmp(name, "../", 3) =3D=3D 0 ||
> strstr(name, "/../") !=3D NULL || (name_len >=3D 3 &&
> strcmp(name+name_len-3, "/..") =3D=3D 0)))
>   return true;
>
> Compared to that, I prefer the code I wrote in v2, since it is less
> repetitive. But if you want, I can change it to the expression I wrote
> just now.

Maybe

	for (p =3D s; (q =3D strstr(p, "..")) !=3D NULL; p =3D q+2) {
		if ((q =3D=3D s || q[-1] =3D=3D '/') &&
		    (q[2] =3D=3D '\0' || q[2] =3D=3D '/'))
			return true;
	}
        return false;

?

Rasmus

