Return-Path: <stable+bounces-67549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEA950E14
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE38B1F21460
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F791A7044;
	Tue, 13 Aug 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wM+c5grN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBB38FB9
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581893; cv=none; b=RECQX4yCv1yp3AxXoX/etyopadFOczusSogBbr+vw4HM7TzqSbxXJf8j6UMmMXycb49lK/X8wcOkAiSJ7fVUqf0igUBq7W6AI50aC7OVQmduwEznwTS2i855+QqIfZ4EFduKP3s1Y3nItqC27CGJDZqWYefB7ImTOWUNhgY99fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581893; c=relaxed/simple;
	bh=ECKzDgCz9IoWysKEXPW2k+uVJ4dvFDtSy7YQki8P7yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO8sIkg7EeyfmyCCJVEFhpulzUTmg5RL+OWgOxGV1oFvaMC56Ds8iHCurL/YsackGkSwN5wLQDzbIRPP78izv1ysJanVreTEVxypP8/kyiIaZ06EhYju9MXVepz6UJnLlSd3QYbCv+pLMwjBoo3Xq82vXtmQYsN0Zu/d/rXOhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wM+c5grN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd657c9199so7145ad.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723581891; x=1724186691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzOYdHcbQ4qkmVC9mC4xP2gackFKbPgb5KsoSuJgF60=;
        b=wM+c5grNdVPsSbq9cYbuAsBdx4z3hZMzuC87KrzyHfE235aO9IPLhJsGVT/mBJDL5d
         LRzikj9Tqr6NCmvHKfZ6vnXMgdNBEXWkWASEAq3pXmOyQA5d4+ABvTPEjPmXaRIM/9qB
         FI7LRB4Ec/XzYMYmSoDq2BP8YflbkPvf+SqlwHj1/i7odGKQwiGDS4ZUeRm3fe49pPIO
         yAn77WNvflzbZD3AsBkHdrRY1/Y/R/AwuXpLjIzgixFMqW7cI5m6DCpDV1XCljPT/yHl
         vxuZHG2m89AX+SKEAcFQcV8o6vo0zOO4h/IVYi4nEhD8msINy37bcDoDl1JS7YYkC+g4
         j87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723581891; x=1724186691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzOYdHcbQ4qkmVC9mC4xP2gackFKbPgb5KsoSuJgF60=;
        b=i9fdDlf3gPYxuWijU/hHN/mR/iySOW+oHxIvxGbgCynYi7sDgvAaVFpj/9DdBXpqig
         E/xrZgcZpDlk5eMfrCoNQ3eDeVVgcWzx9saOmoGu3hKRWy51JMScwCepIg0c9NMFafMx
         fdKeT50Okwie4W9JkIt7qa1ULbT+ekzgTzuarTxLQfaNYqvzAH/5ryUE3F10FkKY+D1f
         /zit+jYrJTQSTMDPOw5z+6kWPaNVx3I0j2SKo09SGtVsc/DKyVoSUZqiNgY7WbU+B0VT
         fqE/L32YxBEFAHkkmetIdxO0ZSXH/s8i5j4rGkGKOFL4laGqtsTOMLj7m37MGWztvk1d
         R6qA==
X-Forwarded-Encrypted: i=1; AJvYcCXOg6KVkHaID4uBtwO36Y6AWX6cP171cxShvgq7L+Bfy0hE51+Ful+2NU19KuoWOHfW5kfD86jH9D2J6qAwJCXFknndIBzl
X-Gm-Message-State: AOJu0Yzqg+ry75LIEdV0y+hFikm5PtKvHZn59BI6CIdk8WRcWNoo+YZn
	NXeEwtcL5VLnmXCrnUbDPUqbvjaB6S7hA5MbhJIjaiZC8klrTkyxbj4n1eqlG6CReTm9MQ4qLPs
	HBtMJZlxYivZm1QMpMfhuJAoTyWDRaZI3xaXG
X-Google-Smtp-Source: AGHT+IG7FjgM0XjSRwoF713hjf6YHH7UGJXXqThlFBhcQwt97F4e4nky1QguIN89VfWGjn5she76+r8okzo458dgjVo=
X-Received: by 2002:a17:902:d4c1:b0:1fc:6166:da4c with SMTP id
 d9443c01a7336-201d929d42bmr32895ad.27.1723581890806; Tue, 13 Aug 2024
 13:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
 <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com> <2e14537b-cf91-479d-a665-c3e174cf2c66@redhat.com>
In-Reply-To: <2e14537b-cf91-479d-a665-c3e174cf2c66@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:44:10 +0200
Message-ID: <CAG48ez2P=k6Eezhu+E5OUzPLFpY5C4rCds1y842oyBC1ux3ocw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] userfaultfd: Fix checks for huge PMDs
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Emelianov <xemul@virtuozzo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:37=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> On 13.08.24 22:25, Jann Horn wrote:
> > +             if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(d=
st_pmdval) ||
> > +                          pmd_devmap(dst_pmdval))) {
>
> Likely in the future we should turn the latter part into a "pmd_leaf()"
> check.

Yeah, it'd be a good idea to refactor that as a followup.

