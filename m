Return-Path: <stable+bounces-155324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B1AE3977
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FE61896056
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E32309B5;
	Mon, 23 Jun 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="V9S+oWvD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9523026B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669676; cv=none; b=T92JTP3xNyNZFittcn+QqVWT9hv9UllvBasSHimDHMIaQSimYrOGrIlW1Iya1w7gbaGvQ1ee7axkzfPXJPhjeGwyu5rA1iQMgnOJ06nEn7P2bdn2dlMps7ND0PLeSz8AOvwYHL3qZdeKQurSLS+xDGkDgATqlM+0AZ5TfTe8deY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669676; c=relaxed/simple;
	bh=Pj+z8gwFIbhNFojb8EB8y1DDy2jPp8x0dfb8XJ06D3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUn8WEVP8OFAhLz7Ej51c2fzl+i8N8FCJM/jdN2wRJqg7h8z40lGPeMmOveK3+8JlI4pBDHp4lCnLbQwoG+FVQW6u8ysJ88+8Xkb+jUjd/OG5Pj/MSjW2kV5sPfgLNJgjOITF5Lof6ZcFE8PcU6rEbpwrmipzpE5+gzi1WCuChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=V9S+oWvD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74931666cbcso1085226b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1750669674; x=1751274474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYMfBDj7Ttw4B5xTPVIBAiP4tILZW/VRi+paXeUWu3g=;
        b=V9S+oWvD2Ar9lKFj+qHFHt42ojkgQ/DQu2TRC8wWpHWREhVYenT5l7+4JFnEB19wza
         Pfxvr11tQprS9lCGzjyJ6CvgkOBkGdhgU5MoSuoOy2oT5KskbwB3IjNMqTAXcJPKJXei
         OBa1W7PQwcqVhlyOudSfiBb2rWFDgthL/HMdukCtqPzFFHYXGEYwY2bM6tmGDjcE3+2P
         13b4B/dBa4UtIHsIerZtgri83v5uVx6EagAQfnToJHmIvZGmka/g9ijNYsz95M4/GM6T
         zGy3kHQJ0bxvza1CtUgtPpbnsHvNZ2D3PK6XX8iBCN9RIT0lW/gLVPBhX5qbBheliufL
         PqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669674; x=1751274474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYMfBDj7Ttw4B5xTPVIBAiP4tILZW/VRi+paXeUWu3g=;
        b=rRmQsd94gq6pYiRdMT4ZsIox1sGmC02M085DjPir+j5KquMIuWnJMdLlsLnz6D8ifN
         LXQImK2/G50jOGDomiXBNKhFZX+255beNVie/inNboTdpzos3Kh+4EP8Z+Nl7ptnV0xF
         +Bs0nSgfG+Hmx13t6dmjG717NFb0BCo06/oe/DlLNbUC55g7+c3mppP2vq0h/Wcjv6ty
         JIftjiGEjw7xo/rjwNfI7qlSH1zcOJRYPaw9bPX8csGgMIkx350DE2xojlkqTBCkwJC3
         sIPCoYPQVhiZQ3FSYMlg+SdvV8qmoiehFjxP6Ei/Dy+Hc90QwuF5WacUCAb/boSNO+Pe
         In4A==
X-Gm-Message-State: AOJu0YzVWBng2VDlfEcy8lTX9uJrx7Iafq1tRoXd06F0iLoWZdh3lkS4
	nhFyAIpjq7xlXLegXwUb+4rRkuF9wrcv3yaU12lJo9d/PWoNqex1htQViKc1vZbTy9TZJtN8xpX
	2o057RwMvNvAmWmP/xPUX1Fk1J+yetAyNgSDrR9Dd9EJIL8N8WUhB1XbgyQ==
X-Gm-Gg: ASbGnctwwmaF55WUWhc85s7pf3z8g5WsF0tLxyI/dskl/Y99RMkcmElzhknqRHyxVLC
	TfqPBsoV3nUT2hsdFNqnw7MjTK8W8Xz0VodJCB+UfXhsJAoKErxFSV1g3pPEw2QhJXeA0K2bQJX
	z9v1BVMp47ZWHXiTzQNmksV0ItHdt7m+QfeTYy0NoJp6I=
X-Google-Smtp-Source: AGHT+IE5CMFRyRNntO5oehWyrXROH1Os9ycBYYYLh0/xamUnQEM+9OwNpoeVv4a2sJxylUs9KEuE6kSQT/rtZfFstdk=
X-Received: by 2002:a05:6a00:4612:b0:746:3040:4da2 with SMTP id
 d2e1a72fcca58-7490d51ba3emr18855285b3a.8.1750669674194; Mon, 23 Jun 2025
 02:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOcd+r0Rg6JGMjwZnCran8s+dbqZ+VyUcgP_u7EucKEXZasOdg@mail.gmail.com>
 <2025062334-circular-tiring-0359@gregkh>
In-Reply-To: <2025062334-circular-tiring-0359@gregkh>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Mon, 23 Jun 2025 12:07:42 +0300
X-Gm-Features: AX0GCFsN_tq-RsFBsV5js6Bn22_36qVOsMSWjk-ADKGcUeuHLry7_PeiOYeBi3E
Message-ID: <CAOcd+r3C3LKPv-Jc1op5t1Xn5aijV9k-M4wm1hopARu=sy+fnQ@mail.gmail.com>
Subject: Re: stable patch 42fac18 missing from linux-6.6
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Jun 15, 2025 at 06:36:44PM +0300, Alex Lyakas wrote:
> > Greetings,
> >
> > The following patch [1]:
> > "42fac18 btrfs: check delayed refs when we're checking if a ref exists"
> > has been marked as
> > "CC: stable@vger.kernel.org # 5.4+"
> > but I do not see that it has been backported to linux-6.6.y branch.
> >
> > Can this patch be picked up in the next version of linux-6.6 please?
>
> It does not apply cleanly there at all, which is why we did not apply it
> already.  How did you test this change works in this tree?
Hi Greg,
Thank you for your response.

>
> If you want it here, great, can you provide a backported and tested
> version?
I backported the patch and tested it to the best of my ability. I was
able to test the part where the reference exists in the extent tree,
which means the patch doesn't break existing functionality. However, I
was not able to test the case where we only have the delayed
reference.

Please let me know if this is still good enough, so that I can post
this patch for review here (or on linux-stable-commits?).

Thanks,
Alex.


>
> thanks,
>
> greg k-h

