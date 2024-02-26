Return-Path: <stable+bounces-23776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070486838B
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AB91F241C3
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D73131727;
	Mon, 26 Feb 2024 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6XQ6D7A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17A1CA91
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986050; cv=none; b=fgavA/WTYe9NX2UwOIi35DGJ1YN9SVx4Wl1a+4xtegzwlK0RTxVadp2vAjCamL4+jedE9YHlBB8by4CqHGK4Oa6LEZT4OyUkLDCoOkdgFUnS8v3FncLBEf6lLLmRpIiefVfoJhrek/elpus+Glaf6SzYsDSmiM30yaJWd1zMrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986050; c=relaxed/simple;
	bh=bZiewjkKyoI1VNjbs+gVvxkAZ91q2NEcq7cOr1xVGQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqDIre4cGh8CmOqdd5y+fTKGNXsaOT1Gh2B1KFIq4sXU61LT6YfS4kv1RlFPoTIx41R13H4mi2HoW/EdAdsHp0gdLV549YzEiW/ar5sQ/sl0LV+SGU/5XFcWcBGam9qPkNcInbE01a3HnyuRJvn0ZNmLshQL8uq3q/yLRd9G2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6XQ6D7A; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so57757337b3.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708986048; x=1709590848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLGj/vWqoWzpFMdhYd146ux4sOGKtuB9qfym3YSmqwU=;
        b=D6XQ6D7ALc/5gsyf3uwWlxOV+6yEjUt8uMBPuZlUFBLT8/Wu3DyP7WodirGg5+aOsM
         5Oi/fAcwMMrmT5t8yZdItaS3aZLmLXrLBzX4CMep+TfJH+9EZpLnZW55UTVonBU2r4/H
         oCz7MJZdnpXRSIy7XfVcY5jrNmb8Kr9wvg0cTadI78UHNZCL2i2wcBnYEa+9Dxjm2Zii
         UK1Qg01Nk9icXkoZK/knLdiR3AfE+vE3EDWXfGCSzijti4MoQxdJX4fb1KgRbhscT8B3
         8sFZ/7AVZusLp2RJfZa3pCkwrv3H+r70sr0pCZGSAu0RjJ8TgL+sH+luxUP3O26Mw76K
         2AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986048; x=1709590848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLGj/vWqoWzpFMdhYd146ux4sOGKtuB9qfym3YSmqwU=;
        b=gHScyoa7D5bC9KBoRgxhVz21VKsrHp7c7rFoY4rEv4MOgDd/27FrxkbzVvAKhnT2yW
         Hvq8gheq86lhplAg+wj0Cm3ZgnsYGYQOPQfdkzP0FJyHnMY67M+8vMB/u3ZBJHMVppJN
         lWnljfIcjhgYz5rG5CS7dRaW+GbuDt4zWGYj5aAa/jC+GmGB82EeXt4VBU+0uFgAMSG3
         JtPEJdE0vELW+amB0bvjdGg0NClkC04nYhCtk3d1cmOaDrzYJ9LM7T3Vp+jaJq1LdlJY
         MUFmtNafO1vIIotbzmzgKIZcwgDKGlUJ4quLqB/GIBdn4tAU0minA0WpzK28QKDPpJun
         STww==
X-Forwarded-Encrypted: i=1; AJvYcCXy64UDfYnqFDX1KEnMlcPXrVRAkwWFGz7RxKl6UvXBYfhOgySSIFxEy6TmKQSjLDXuOzX3eowtVx5+7oQxnhoJR4iezjV6
X-Gm-Message-State: AOJu0Yzm7mDDTJwGdgvRCd/Za4Z+dXAIT3Kf72krcBtNyqfwrbwkpEnL
	+DMMwTfcYaXZXXl3DCfPR6PHzqUb9Piy+R2DxF5WvQrgB1YmMWt26EFj9myaF2rG4WK3J97PeZq
	jnL2gHzyIwX4wQeh9lw==
X-Google-Smtp-Source: AGHT+IFEwLifcYjG6plJCVhw0gAthEbt9JRycSb71KUD7ihsX9C2j6aqKXZSkoyEaVsZ7sjSW3YYAFJL93AogzXO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:d897:0:b0:608:5367:a508 with SMTP
 id a145-20020a0dd897000000b006085367a508mr103533ywe.2.1708986047852; Mon, 26
 Feb 2024 14:20:47 -0800 (PST)
Date: Mon, 26 Feb 2024 22:20:45 +0000
In-Reply-To: <2024022610-amino-basically-add3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024022610-amino-basically-add3@gregkh>
Message-ID: <Zd0Ova7x3114k9_Z@google.com>
Subject: Re: FAILED: patch "[PATCH] mm: zswap: fix missing folio cleanup in
 writeback race path" failed to apply to 6.7-stable tree
From: Yosry Ahmed <yosryahmed@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, hannes@cmpxchg.org, 
	nphamcs@gmail.com, stable@vger.kernel.org, zhouchengming@bytedance.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024 at 11:30:10AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.7-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
> git checkout FETCH_HEAD
> git cherry-pick -x e3b63e966cac0bf78aaa1efede1827a252815a1d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022610-amino-basically-add3@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

First time sending backports to stable. I think I slightly butchered the
6.1 and 6.6 patches. The first one has an extra `Change-Id` footer and
no additional `Signed-off-by` (although my original one exists), while
the latter has no 6.6.y prefix. I think I got 6.7 right tho :)

Greg, please let me know if I need to resend the backports for 6.1
and/or 6.6, and sorry for any inconvenience.

