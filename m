Return-Path: <stable+bounces-135246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C6A98137
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E531884B38
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2352690C4;
	Wed, 23 Apr 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdI+zYqb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85401267392
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393883; cv=none; b=O5HXgoUy+oAmEfabRTm0cBNnyIFPMo6Ae+772Z1fF10IVrFQfFwog9mDFZlS/Oonwh6x63fZrdiQRO/mWd57w8i8xqUKstczjybRo8Z9dhlGngbBY8dLOuw5vni8KP2sT7N9URvYXJ7jODDnmENN3/k9JBe+xqm51hdNKSIFg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393883; c=relaxed/simple;
	bh=teol8+j7T+KUdmAwLstc1ROAyK3EMfIdRvJ3znd4Gr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7K5wsBATc9P9PMxpY0mGpCubiqlx/J+IW/8aWY98YF1NzljoZ2MRHBMlpODBV9L5q7l2468VQci3l40D40HVEzGXK9htI7HvhvGtJBrBcwXu/P+0mPbsG0cTDbuvemp0rHi2rYHhnXTyWBvNsM9djL4mIsH5R1CDq3wVP3wao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdI+zYqb; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so706582276.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745393880; x=1745998680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teol8+j7T+KUdmAwLstc1ROAyK3EMfIdRvJ3znd4Gr4=;
        b=bdI+zYqbP2e6zMj7EnWNFVhdTAM/Rp29tKI7nZx40zP9VOfNqa33PdamTRNXR6p5a7
         98sWj4/1YFvpKVt2jS8dfag2XIuBumW8yMt1Ew1RNJ3BS2aOIMs3cVa54B4oAhV0pthA
         APB/W/i1Von9xtS/eQVlXnadrlnkRgrugbgGQwrvarkbToaq1ArlkMiKuNPoiikJ5in1
         AnmxwSvxHI2NdsLvhdtJLcFu1yX/3Q6AFgOO2yS8PpWmIBxw9T/L82WOnQlxg1SXTj72
         bsPi2quiUX8RgxCEZDN0w7ulOyupR2xXwGaqRkqnw/5x0H33z4dOBL6RW9SUtfPrINMr
         +LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745393880; x=1745998680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teol8+j7T+KUdmAwLstc1ROAyK3EMfIdRvJ3znd4Gr4=;
        b=t8HI+2VIfiBQ+1gYymOd9x3YYJqA6uHoFPldj1aqQf0eDf1TuRyUIVoZFB5QKo/9CI
         rA/72rDBb7qxFx2QomAY1SUoJRR3IRHmz0g/AsQroXdzKLoGPlAZv9eFJ0BYO20VN+AK
         8LyRGICjYHXaAyg0uz2e+x8DGVnZnRVTKOAmeyQphEMiN3fHIOnzFlN8BTB7IIUtjhPO
         AemNM8BNbOJWgCtZSDn4IceUlp6b008hdP2jKyD/ankO8RxR3qwBnW/nVpAavwQvNWXU
         pNpF2r5jPDnfG7/2WIGB15j7yn2Fz92Jc09ZDZ81qquP12XW9jZ9FEbc3DQMmjmA7IvG
         9qGg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0wovvM9rgE0OrOm2zUra6ynu4l12v14MdBfEPbR9nQKy2N0BuE5dIQzY0FZGEx6vqcmaNgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBP8Pv9Z9TpXWZQ65i3nLRWh5PHIBEfKespqhGeDoXKSjOhaK
	WF9v8Y9I2J0tnB2JLtcyoBDH7bnYbcj8cxffzMz4Hx7zo0kH0DmDoryWBpYUVohCuPoQXhLzbOw
	ffiWMonSDH2ZxGoQcWY6bKGwqHuY=
X-Gm-Gg: ASbGnctv8bHOBsX+rt8H9HE+2/4OzX775kttvRZVtxrG4jhBpxwEhcuPkqIlbEPH5LG
	CYcdwyFwoHg0rd60Zne4ktLjQNRUBT6MDScofjfSZ0LLpJ2AhdBAu0GGodslAOlTfTN255UvNjc
	wdMZYaVaeAiJ15GDlYrFPQbFXlHqiWeCrS8biM3g==
X-Google-Smtp-Source: AGHT+IH5RrmcAdxYycNKU6x3jaRqkUSPGz0Qo8C5MXeEjk52EB/IWpIlrFx+DoZC9JfrZ1mNE7GXEaAr+yIJuok2Cc4=
X-Received: by 2002:a05:6902:5412:b0:e72:f64c:26b4 with SMTP id
 3f1490d57ef6-e72f64c285emr285024276.22.1745393880324; Wed, 23 Apr 2025
 00:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh> <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh> <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
 <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com> <CALW65jaLXR3rjcTZN-uojuym6uCT8pMRnTHoY_OqCWJ+Yq0ggw@mail.gmail.com>
 <2025042256-unnerve-doorway-7cb7@gregkh>
In-Reply-To: <2025042256-unnerve-doorway-7cb7@gregkh>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 23 Apr 2025 15:37:39 +0800
X-Gm-Features: ATxdqUE3cGgo8cxtPKLqZH9GZn5l7Y5RiENn4kSMGj6oiaPyvPU19GLnQeY51nM
Message-ID: <CALW65jaXh=0+MkkNWHG9PpcDA88zBR5-S3j=pYbMZVcQ19hvag@mail.gmail.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Liu Xiang <liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 8:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > >
> > > The commit looks harmless. But I don't see how it could fix any warni=
ng?
> > >
> > > I mean, we replace two !list_empty() checks by a single one ... and t=
he
> > > warning is about list_cut_position() ?
> >
> > I have no idea, actually. Maybe the double !list_empty() confuses the
> > compiler, making it think `sublist` can be referenced out of the
> > scope?
>
> That is odd, are you sure this isn't a compiler bug?

I think it is a compiler bug. If so, what should we do to fix the warning?

