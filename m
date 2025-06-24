Return-Path: <stable+bounces-158439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97862AE6D47
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551533B0F5F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67974C74;
	Tue, 24 Jun 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc4lPfKA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DF26CE07
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784872; cv=none; b=pqCzOLumO9WwAjveMTD9suQZETh+fbDkggS/OYPNPki7bzCguIbsJSag2F9S1TVsX1gkQ1JhGoaKdK2rdwwr/sD3PgOg5eoYsWpvv6nAS7NF7LSR8lLeNzTOtjivi6B2mG2xa+db2ApBsg402DYbngWZrQ145kDsUBwQpn5AHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784872; c=relaxed/simple;
	bh=jgwDeGMT+xli/uBXRwHQe/v51mMPAL9t5lAp2ox+Wes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u651sg3EH06MBqK8aBEs1aAgq/2k8V2KM5i4CPkHo5lHiqP33uIRzL9/lndmdZ5uoUUU2b+iHJNwEQUNEA6vpJ6qsxyr5+zk4nsqL17RvF/z8DbhJjAh1l02ClHmawjPJRb3pg7F6U6mb2v897Zk1B1TQp1qdOwmv/qPQHRja6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc4lPfKA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso487a12.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750784869; x=1751389669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgwDeGMT+xli/uBXRwHQe/v51mMPAL9t5lAp2ox+Wes=;
        b=Rc4lPfKArM+MHXVRQ5jFE5KWxCMKr1sYfCuyfaqKm1ZftaiAUEeehcVt1y5rh94us/
         oWt5bhOCE2bZmeeGd4SxhChiyaeF1MlC5DZhITMUN18eyf2617LvJusEG9rAmGUv04Pd
         wvXsDmR/I1jndB2xyh4dme4u9zRn7wVM5WyAk9r4hiSB8CJHSmwigbrpvjdsa/jJYYEL
         w1ZWPpswO0w+8r4qSn+OSqCa/xUvUY9MHfoojjewTHqqW0TL4YbQLL3Tr0nsxo/Ko0yg
         Pw3Mp2+z2V96cZWoCP8Ihs42m1dqwGmYCxHD4XB8kK2kGoIRiC2LeNHC3aELwXWeF6rd
         pVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784869; x=1751389669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgwDeGMT+xli/uBXRwHQe/v51mMPAL9t5lAp2ox+Wes=;
        b=qvtd9WxSAdpHfGYCSjBrCrmbMzd9Evxc/EHYFk1damGJ7xQFk+5+6fO15SNPbrgRXk
         sRMufDLG/7O+i2j4JW6NeTjLY7dQQpEcKQicLacC+N+b9fa/++RO/mHr26hE07bzCsfP
         XUILim036Xnnwis/afvfs0G4y5U2dno72odGMwqcqqYQJ+rFkrmPcg0PZ1l8E9Ky2MNn
         uAWI74ENsKIqtIyUvCucQ85NIcyIeUNkb7VTBaedsR7DoE72cdXwhAAOHtOxOyCx2Dd8
         KQUHsLDmtzWouQ03CbQodHIHdTsKEpS0eMVgOwmm8nV+HC+vLK9rRJEduLSK6rWR/04o
         brBg==
X-Gm-Message-State: AOJu0Yx24wxmnVav7AEHPO3pLoR4to24l8Q2hi/M4RyPMKrPmxyZtG89
	I2LRrnGG7CG4KnHIdlPOlqmnEVst1IC4nxKOyIjUYgK3QFnWpBdvUeEKMaC6r5jrwlgehRBcjsv
	9jyJHkebuV6uumb5OaH0rO/7LW6s2GCnADsFVoJ18
X-Gm-Gg: ASbGncsYpN8ZDJlS0evVnya479PxciriT4athF1iBASdCzCNuAqbYfJcA2w51GC8Ob+
	cOVnCazRTzazO6emrZLI1UF2kC3znI8vmaogf8LJCFbeEGqN3uKUCiNVWms65OgeQVY0dtPC0Dk
	rgyapOCmJOnxIKLYo0K1nn+0fYWxX6zOeWGL8ZoIT5YaNdpYNugwc5FgrlkAAQPUIPOpydlrI=
X-Google-Smtp-Source: AGHT+IE1zagAjllO9S8j8FAi/iAGTKUFHC+xoj3hF+4rUmILCXqnInb/uZKM8JdNHSEVilNnN4S9qD3OjZixAFV76k8=
X-Received: by 2002:a50:d7cd:0:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-60c303c8c54mr91183a12.1.1750784868941; Tue, 24 Jun 2025
 10:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620213127.157399-1-jannh@google.com> <20250621052841-2e82f10b66fe127f@stable.kernel.org>
In-Reply-To: <20250621052841-2e82f10b66fe127f@stable.kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 24 Jun 2025 19:07:12 +0200
X-Gm-Features: Ac12FXxFrWjwGIaFDpZ7NqskrbHdhnKY8n6azmNscVztnPNyMHfIsBjXYodBuDE
Message-ID: <CAG48ez3hLGiYzXq05f9AyCu-0PzoL-hYU2G1WFTmuGmM5Odf4A@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: unshare page tables during VMA split,
 not before
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:15=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it
>
> Found matching upstream commit: 081056dc00a27bccb55ccc3c6f230a3d5fd3f7e0

Whoops, sorry about that, I didn't realize "git cherry-pick" needs
that "-x" flag to record the commit ID being backported.
I see you fixed it up, thanks!

