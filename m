Return-Path: <stable+bounces-180372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA769B7F3CD
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4B4803C0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0111F4192;
	Wed, 17 Sep 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afT0B43C"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F41E1E00
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115409; cv=none; b=FePAHzO6Gm3O3FzqLsUXkxN/JBfZXwGGJsrAsWMVPQjgnoxVt2sIlOqSy3ZzLyt2ijTlYUTVLquEUbSlzAQt2VsoKfNy1lxDBhXH6NwNoaYmpiiPbjtjLpufMHwguCI8t0U3BayfyTtDi0rFKB5q8PooUQTFV4zeZ0aRLDcw5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115409; c=relaxed/simple;
	bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUPq9I9BtOQY0/JvJB/XVyun3WLIsbryQY3y15fxK0RRxVQOUKakFo3qUt77P3+6OZhSG4ZBr66A2UsRRIsV/jV5H3k9a1RAqRGH0okT11CVvprNqxlxCIlO6sdKKRUKuglW6Eoyman3A0CiUoDzXkXYkbYU3oTl8KnDyVcKpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=afT0B43C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f6b1fd718so2319329a12.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758115406; x=1758720206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=afT0B43CvjU8mP41nVb7aQ4/cWPF8eoH5vQ2co/TkR8VIt5m2LJr1KcxXLc7y9A9lz
         xULcQEjfwW/IE0p0nE+FooBcuWtKoWqw11cUtfZHGQf8MZbui4Vm0lRNoKzMRHEdC8Md
         IgBTPi0tXqSkSEcoHy4nBWDHhesEk3SdvZg015+EFZyn/ErE4lkQYlet0E/ACXdyiZse
         82uKO3P88/Yvk6DX4UCScmcZIZpQEZdMhTlXtxUNHE+Hw7+s4upz6v/KPzgfq0AgG85C
         Dnq1aywf5AJy9ZxA7CcPFJT+egOYj5ZAzKB8AC71bO6CjeDQdVgMOKvXbs6mSpHY/3tg
         JQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115406; x=1758720206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=p0jWYQ5CxZi/z1km6Wi5uYvCbW+LFl9G6fQB0O5u49SlHA5/bHrmRe7/BxwQhmprBV
         vZgc6H/FiQkLFXNQu71zJDVj1yXpCFE5udc0pA9Ym1IgJZ3RsKqV61Y4uRw6L8CRpF8J
         Nec1H8UX/C5Lmp5xbDr3xL1sua1UOpoW7U7rNWt/OOCyWJlKQV8OUBMQR1zA8hzb7ASi
         hPd0d3nB/obEpW5S3SWieUK33vJFO/g8HEuwlUIGEAEF4/k1ePkmMwe+PoCvSfVZ7n12
         5Ss8N/x4zLnV3WhlAbhn+dOGfCBfK00gUOhpbNgulLguP4QAB3SByEWqU++oWtcj4LG8
         HQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCEPeATt8cJGAPGoDgyV+L/N1Uo48l9srWe0dNbAkmZ03okLnwmXMBXJMHhUrqjFSS6JiPJL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgE8YORzOYNkng94oZSn8xN2m/AD3HeTUWbSwJfT8a5TjZRKC
	jayfScZoAOoGKqG45H/IcZDSt7kOycLcz8jDNpfD81BYgiRcd+8RdzrnAIIxwzGFAO0vq7TfiZk
	P99MN85/zAJFSVH2SPvHRnfUhK7JTneSUSZnRhiXUFA==
X-Gm-Gg: ASbGnct5FskMgRn6opWeYHpd0RbFwZFghe7yCFfdbvmdw8YRWl1t9wbYdDRlLBckmF8
	BFhCzI5PWYBwyv0X71aTR0YIH2i2MLQjYVIPZM/GBH1htVE+09rM6oBuUqmdPXp5maD+E26tqmz
	LkEjXx2uQV5VrirUVOSUp5Jftu/G1hPHwDbIyzLpN2ViZJs7YbszT6G8q0kBN/KPeBZ2hdiaZSj
	L8ppx7R11kFHqfNauSwFcY7Oz1/L27uaNbuNJxil2F2+LY=
X-Google-Smtp-Source: AGHT+IEgewShkTB3IO6iy5D1trv7nKdXbV9WtwtBpgyTEh9TZKuca5Qb4ed3HJ87AvQ3ZW2yo7J0WCyjmW8j05mLxIk=
X-Received: by 2002:a17:906:7309:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b1bc1ed67femr266992466b.54.1758115405633; Wed, 17 Sep 2025
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:23:14 +0200
X-Gm-Features: AS18NWBL5l4pIlkCFqkI5FbYZctT10PlbPlrGgAIhMPZCsLLpTd8MK5AI9j4JqQ
Message-ID: <CAKPOu+_EMyw-90fvNXXRHFpbi8FDc=fd1kGs21iE9+M4ZZSWeQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Given that this is a reliability fix I would forego optimizations of the =
sort.

Thanks, good catch - I guess I was trying to be too clever. I'll
remove the "n" parameter and just do atomic_add_unless(), like btrfs
does. That makes sure 0 is never hit by my own code.

