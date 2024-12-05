Return-Path: <stable+bounces-98848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58899E59F7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5697169DC4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8021CA1D;
	Thu,  5 Dec 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bRy0lif+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC32F85C
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413366; cv=none; b=g2I4WNKuppkDPK+aNRxw3XTXdhjbtP5tpD1RHm1w0gaxmnR7tPUaA9pCMgDQHCTpgemHy9AAvDQC3aE6fZuCj1Fhl6XXnZjLA7xfKQxNk2VN09AbTMV3qjp6a3YmpYNVynxGj+wgEC+97DK37XaRjOJwCJWVVNh/pkXjdcMtKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413366; c=relaxed/simple;
	bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPfLiZ3X4rVssIYYcA5bH6CpGeqrQYeILjIVjaj5a1xgL7or4BzH1kUM5lKncIO8Vq6kwGF//3fY72SGrAzjvpdxMLVAHYNvMeIsU+NL24tnHlExAaGvgFhh5nZ5o6d/1G3cuAAeedvEzYheFegeloqPCQ2T7t4l9A2B9+YskrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bRy0lif+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa560a65fd6so186331366b.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733413362; x=1734018162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
        b=bRy0lif+SnNj2nq40HgFJekJuJU+SvFrX+Cy2J3Q00z9vUhCAWBo0Ja6jN3E9h28lN
         SkArcnss03+gQ5oH3ii89Plmsd0xNar+sOK7w3uL1FH/nHS6XSO/FPbTB7tnpJKh+Ghp
         rG8JkLiAhXbCXMIeh4Y/zlnK6MhpOla0e/mnEEnJ0Fi0mEwtUSAiXjWFu92/uBT3OiF6
         SehkBwdB3F6hbwFtDLFoqV9k6trUiWlHogzrGCzfXKqhu9PF4odTyICeg8/QfIFpXnXd
         q8KXvDR1blpVlw7EiicMKLLVP2odDO1TjQ8JEc/9cK+QnUFyoRIcpLl1cxiG0+47zExC
         f2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413362; x=1734018162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QooC3WdeOAD0e0lYcAEtRhgjyLoS+4sHCp6vodx3A7s=;
        b=imcpCrD9k21fzr8na8YT4qblWNv8YkkMc2jyYsDF3RWEiujs+4yyMGukS61t+gAZTC
         dAd7jf/TTzCnFlGc09LB1yz8VTvmPz5cMztea1QILnRuUQIMjOJb4I+7GJ3O55GdOLRv
         GmKorOoKEz9g7VxtUyt99xyKBCbAm5koTyZPgcmgzlWANsjIB0OWKCImKnMe+oChzWka
         g6FKSBYurfDQpW6NiQpsDVwekkWAhsbPjX16eAPMycZZSnABBAWgWbeZSFj9LF1n2cng
         MeW3CbGK6UGNLUH7Lp21gTKVwo6lvLBzi3Wn5RTQVJI6QKKnkfwl8DI4CEzRK+quBBUQ
         R8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrU4YE1wSh8mN8MGnnrnvDn7xmynA4M1wfEZx6hmy9t2vy9IhLDo9dkNvQMbgE037kIOXhx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0mMH2AUjtxchf2fAb5+8Hl6ymBo2/CpjqVv7IUNkr7M3Y6T2
	eFLrcSNbvyFvhHFqvl5XVsOcZzyQe70dOst1/qKXiAkj7ztP3nw/S/H8f6B3lVWhAUvBajnQ9fO
	5fBAx+Gm/OKAu/2xE6Km7LjpqgQ4H1wdSgteJGw==
X-Gm-Gg: ASbGncvLtpYB1F9N6r8VMCdAbgwQcOoGLBlE9a9dGB+9h8fyzUZPkNDwu4Z7WkJqi9n
	e+8NoSvmDb1o959v4hIP7pYFYek2Vey5lUAzrzAGUOZq36JR6445KsKaAZpsO
X-Google-Smtp-Source: AGHT+IFRIZj39BqksGePaUik7a+kIHoLqLeLpwrOobFeFWewSYsxmbm4qW2oqzvnqze4KT6xrlgNWJQIXaK21ap6IUY=
X-Received: by 2002:a17:907:1c21:b0:a9e:b08f:867e with SMTP id
 a640c23a62f3a-aa62188ef0bmr348632966b.16.1733413361757; Thu, 05 Dec 2024
 07:42:41 -0800 (PST)
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
 <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com>
 <CAO8a2Sgjw4AuhEDT8_0w--gFOqTLT2ajTLwozwC+b5_Hm=478w@mail.gmail.com>
 <CAKPOu+-UaSsfdmJhTMEiudCWkDf8KU7pQz0rt1eNfeqS2ERvZw@mail.gmail.com>
 <CAOi1vP8PRbO3853M-MgMZfPOR+9TS1CrW5AGVP0s06u_=Xq3bg@mail.gmail.com> <CAKPOu+-CpzPaY28MH9Og=mZTYmu99MUFTs+ezDZvud0HVb9PAw@mail.gmail.com>
In-Reply-To: <CAKPOu+-CpzPaY28MH9Og=mZTYmu99MUFTs+ezDZvud0HVb9PAw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 16:42:30 +0100
Message-ID: <CAKPOu+9D4AozS0SPJEm0bNh8Y8WmQ-mYQeC39bMNefi8+KYErA@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:37=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> btw. Alex's patch
> (https://github.com/ceph/ceph-client/commit/2a802a906f9c89f8ae4)
> introduces another memory leak

Sorry, that was wrong. The "break" only exits the inner "while" loop.
I got confused by nested loops.

