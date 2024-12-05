Return-Path: <stable+bounces-98804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398E9E5633
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70D91882AF0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663BE218852;
	Thu,  5 Dec 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="J67fzyO2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36051C3318
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404115; cv=none; b=L80Knwp2jFMRniuNmsJw2robYrnQEFx39QWftU9MPjdQzNXhXB8WF4m4sZqr1t19utTDiruQg4X0RtatgOS/HVnQRxdJWnP0wDZqdODEnA4N79yY3BQJZJBt6vn4OF9SUCGL9qKJ9mqRYjDnN2UagMPO1NFemxgUtE/m4Yr75do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404115; c=relaxed/simple;
	bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koWKDIzYbR+c7/5ETXgm1hhWB7GOJnIEuHSwK6rS/VFM5arA7NwBF8EYunmwALvU8Tw6YbHwkvmYYir8ZuFw4IQ4us8z9pw79yh70J7hCca794QRb26sujwifm5eAmTtaiBN7dWtvwCom+MsvYiZPiTisu7srrvPXZ/4srPWISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=J67fzyO2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so974543a12.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733404111; x=1734008911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
        b=J67fzyO2pzl+bw34BrVFOXnUH5sW2qKsviO2bEw08qx/AT21n53ZvZsQIZ3eRSjTS7
         k0bsTf1ex7HY+ASEQ2MKvvjoyiF/FiXKrFGpw5dDMWDFj0IuH3eKtjZZWP9XdPxV7nse
         Dts5mHfMji/IQoaIlrME7J/cUeWtG0ohGkkzhPvhg3AeY2vcYDZ5OJbeoqe71US4LeFf
         IHUrq27dGIo+4uu7rFScKZJtS9bHL/6HiP5cJ+5FSHOqTwdF1TV5wBezI/WFXmCep4Dc
         rNoFPTtOl6XKe4Rwt7H5GW/xnmaHHuaT1y7F0h7huec1OxEpL47sNkaQniTtVRjSS5v1
         e5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733404111; x=1734008911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO0mF8LdCGrgJfdas7Lv4J34R38TAYeyhCtnEGgvQB4=;
        b=P8ezbXF9kRVQBy8KJLZcaG4wW7HZ9aLl2cHLv1d+ddutWtVJttUNCuD+95z/yvyoB5
         zDIbLO06N7CisQGMfBjRuhmKUeXQLP8gcMCiZXh3XGliWCzlbQ2GRWy5Nv/ZYnErcJg+
         DeviDZXXyxs6BAuNuIQ0t3rXs8IW3TyNHwhbIrGkg53oA2lYx7H+lfD8ZeBSqxEozFkz
         6mvgWYU6e4RzZH4pQ8SikhY4KrM54QlTvrEEzBUZxDh5B1K2Ut+SIZIdkXtxJkG8m6gB
         ioASzSiHD/RFBuLiKegFZFwaL5VSBBw3k+NrzIbNG+hh5D/GdBBryNTk9Z0x7zqA7FF6
         iy9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgKGfGE88lx6Qdhe3o0tbC6/AKhNY1va+bWPr2i+nERbcp68HEujVTQPKQlcGDM7dhQ3d5UQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09xZHcsPPawLSnlWirq6s0RudnCWWmUF2WUExB9Naw70iom4S
	fkM0eYqigxI2YItXzhVSb1Ii+apKJO8azM0gakzf8UeG/XkGNiBEIMUXxhw4FYzAsRsrQXGCAMa
	b6cGu4grwB7wBZc1UzBjZm9OJFH0tfbd99qnNuD/3Argz7dyKoQw=
X-Gm-Gg: ASbGnctcgWEYvSQKiA8K0Zn1rjtwgSGV6jRpfOuziWV9R9OltsJCIutdm0UEhgCb2zh
	ZjQFInZ7MLhvzYe446BQ/Xg+qFZ7y4Qg4Dt8qaZZL0I26BqnSwtEIfILZZu5o
X-Google-Smtp-Source: AGHT+IE1i1dEiJ2JW6fMhsX8wvc4Wu6L3IBg3/PLCFzr4x6EdP9ApTo3j+43t9I+0jdn4XnELEH0WmNmNZQ3Bazp8Wk=
X-Received: by 2002:a05:6402:26ce:b0:5d2:7270:6124 with SMTP id
 4fb4d7f45d1cf-5d272706652mr1423533a12.23.1733404111185; Thu, 05 Dec 2024
 05:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
 <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com> <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
In-Reply-To: <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 14:08:20 +0100
Message-ID: <CAKPOu+-UaSsfdmJhTMEiudCWkDf8KU7pQz0rt1eNfeqS2ERvZw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:57=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> I will explain the process for ceph client patches. It's important to
> note: The process itself and part of the automation is still evolving
> and so many things have to be done manually.

None of this answers any of my questions on your negative review comments.

> I will break it up into three separate patches, as it addresses three
> different issues.

... one of which will be my patch.

