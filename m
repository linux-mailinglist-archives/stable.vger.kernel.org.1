Return-Path: <stable+bounces-98793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B389E54DC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E596283091
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4E217729;
	Thu,  5 Dec 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="COnSVc/I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B6217704
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400143; cv=none; b=tqwxl6y6itn2rJyhBN3jPffBTl/BiuA0tK6k+awY14gdWAQCiG0C4W1SMsdrp+VDwWKam9tZEA5b8RZ49tDqbKutkAcB4cagQWcbyR/yJRxQfn1YG6ob87Ui3Ro5HUz7tyGUgHHhQOh+/+i5P/zOaYpHINX/n5h8w8MI+3Dg0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400143; c=relaxed/simple;
	bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIHpB5BrsI0uNjYBZjT2QxTJ3l7YjuG9tPzxCxNrLvVCwsm3YBgmOGp8cslADzNyJ4FK+innoYDYYqH8Y7Qy+UXZhPVsASXANadKAS2jOqQ0Ccfk45K94/WuSE7HR2a1TfANxTJq6uT+/MctcTzu4tY5y6Dcgz98fXcETKCr0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=COnSVc/I; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa55171d73cso369985966b.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733400140; x=1734004940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
        b=COnSVc/Imj0aebKx+Q/QZcP/abJAbERCNVw0vdInpdnuFupObDgXwxboolpmU/MVMe
         6Cp8cqQTsnGBa52W9NXCI8FmAOdwkrQ2pu28/1LOUgleQvWeMUu+3gJ4BpwDO4fW/V19
         lWmOPzlyZ4s1X2jj1md2eSmoc8jMfs9f3Zdp0OxqWyXc9sNQJPQbZDtfqAXTtEA7aT3+
         Q64kY495kiT8cXwNbZzBPrHqJPLKC7cBI8tdn0HgJzNAPizLmtlgvwGxoJ7RnFZQHEqc
         5ZhHdkRO6guQn4fSfyAKtJjogX2HcVUZgfBua2YSDmVelkXjdK3Qvz+s/953R0cenqfR
         1GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400140; x=1734004940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyfEByJLaXEI2J7PmhW3DYY/suyZlc64UiioSv8hnSE=;
        b=FwwVZC5CLdTHbTsxBvwoUBAK32qQcK+L5oce+Mz+IAyrgDRy9c4q2phW4QOY8xZHmK
         T7biTVvonibEWjvirqrAR55+UzXDHy8V/Ttch/37vx7/04RDzURX4WKllyk6W9jxRwn9
         57W44l4lxQczJu5YuU1ZNUzf0tDGSy6f03dHrOZZEHp4oIccSD4lQPrYd6z4p//eW7xO
         Xmw1WW4OJ6hyNdhlhe+stcFqnzHcCkb479XxmKesrhip9ugTY1hIy3AiJgcUccTi9/yy
         Q/vYvIqLJDm/jHXwTj8Z4VCrDpB8+/IARJHYL0mYElrGUzOUQ6oMhzNfD/izrrrlLuL3
         cntQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0NccVfW1yATGFAp9/rMa0szsNfq0yyGwwq61ui2UUpwgK0UXo8vdjfxUZjVEZMYCS7GGauyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSeLTvTjJKdTJo6JmJgKY4fawEvkbY5DGuIQtAl6PBK2o3ALd
	TaBHZK5KtUo8wkR/hqEYUL7U1vN5Ba3SnewxEIB+X58bIX2zxlBWmmDraiSN/SwCmdO3IMA+yE5
	8g60z9BeRuZGeP6K1gqueW5b3FF5jBbigI1olpw==
X-Gm-Gg: ASbGncsEcsxbF5uouG5vPBDlHvOqWSYJzkU26daUZbnl8tosTs5BJJC7tUsul0WMHYK
	RkeVbKGFGygdXl9lCrZaS/0p5+ZJo3FtVG6afzHZh9Buh/EW02jUwih6M3Cyu
X-Google-Smtp-Source: AGHT+IFP/wTYLryFFk8fTdYJy5qaJwWOgpmG9awKpo+rmgz0NzwBMJtXwwZap8har7hG0jmGiguupw0DwGkLQ1i6mfw=
X-Received: by 2002:a17:907:7e86:b0:aa5:4e27:4bbe with SMTP id
 a640c23a62f3a-aa621a3da23mr246213366b.27.1733400139827; Thu, 05 Dec 2024
 04:02:19 -0800 (PST)
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
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com> <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 13:02:08 +0100
Message-ID: <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 12:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> This is a bad patch, I don't appreciate partial fixes that introduce
> unnecessary complications to the code, and it conflicts with the
> complete fix in the other thread.

Alex, and I don't appreciate the unnecessary complications you
introduce to the Ceph contribution process!

The mistake you made in your first review ("will end badly") is not a
big deal; happens to everybody - but you still don't admit the mistake
and you ghosted me for a week. But then saying you don't appreciate
the work of somebody who found a bug and posted a simple fix is not
good communication. You can say you prefer a different patch and
explain the technical reasons; but saying you don't appreciate it is
quite condescending.

Now back to the technical facts:

- What exactly about my patch is "bad"?
- Do you believe my patch is not strictly an improvement?
- Why do you believe my fix is only "partial"?
- What unnecessary complications are introduced by my two-line patch
in your opinion?
- What "other thread"? I can't find anything on LKML and ceph-devel.

Max

