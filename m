Return-Path: <stable+bounces-196761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB85C8169D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE47F343C3A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1036295D90;
	Mon, 24 Nov 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2O28snd1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074225C838
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999224; cv=none; b=adnPXrv7Drjw0D1qltZ/8hfiTk3usw7wH/Hh1epGk+elMXrug5rS3f/FaU8XpJZChzMRWrdXWdDgpG8YtZgikemMXvjYasPY67Yx/eguxr/ejqHSkmWZFWFUMrPE3f+lxQV+PeduIuEywHd3XuavpHhp4r5Xw7tFmHf6hlQXMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999224; c=relaxed/simple;
	bh=y5fWLWO05yj01xf5arPCCPVKFRW07yJwIUlUf7AG9XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LskN9Vw5VS5QPlBzwypvdiBDxTHf5Ezf5PnrBMgTQmNol/6L2C5rFL63TdCWAwZkUfIJyFM9OWVXLYMohWOob8iCOJiXwlA/O6pou1qgr9e0zurvpzEUoUhRzNemI5ouzgVWGD7m0oqriLSi4/OQ3bFTlljKaJQS5OcI7+F5QkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2O28snd1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3438744f11bso10987000a91.2
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 07:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763999222; x=1764604022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3pw4iRfFqotQRBkODd6b4yzBMBFxkJIN/wR40XoVY4=;
        b=2O28snd1umb7mYbT9TyjFEBOGU1yLRZs/jW7OuIMNlGmkLE3AktceFJUnosti6EyxQ
         mcZIoYjZj96/kVTScmgnrq2n/8/mwsjG091edenYYK8HkARthLhENBQ9Cxr0seGtJ0BU
         oxXBR2Re51IkdL/ARNj/OpZmrJwwXwgNQED1YP7uyEpDbtanzfXuWlt7Po2aoAvWYl8B
         fTQM/wc3DUdNJN3G/ziNry3Omk4eGExQPadWOFF+J1jgQw4Yk3YP0tKqFEjcRP/YmkaQ
         ffKj7ZlE8GPTrVmI6aFEuZ8v6iFkolieM/chk6ocMAvBw+ycd83X5e1z7Dl9iaitDIWU
         6INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763999222; x=1764604022;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R3pw4iRfFqotQRBkODd6b4yzBMBFxkJIN/wR40XoVY4=;
        b=NUMyy6hb4OtvSkoJWsIkPeOe16LM6q4rrvvSQfhlRkKEJrAmMxPsbaKQRmo/qg9o5e
         DlfJvUMPOWhcAmo67hSW1Ei+a3HWEp9NZmXRSex9Smte++MGcTmzpkYm5kA2pJM/C6YX
         6G8gn6gAR89l4EBV8fCtcKu+J+WyAnMDqe0ydXtxUMPzJotGp1mBG35hbl1s/3PqDJA3
         CRpj2yI3Esvr/+aozYdj4oYJKdBeHze8fVRGB8ugQKH9kW14XRSp8XXBDzJyuyKir7j+
         3lvs786+XH78sC1sR0wgpDNs1/UnBl2lUTv7OFGRWa+l+Yr+2YDMn72emwoXjmrLRUKa
         PXOg==
X-Gm-Message-State: AOJu0YxUmaJMBCYcHvq1cxsVZsCIJi4Ot8mk4hk3I+uFVeLUF32ebEm5
	/gv4jMHALrYCHaBm4zkVJQyzgj2Rd2BDiK4fNNZdF4QeNZoYQSaNp0aFlNfiy06eU+tFjIITRWt
	lZ2Wkag==
X-Google-Smtp-Source: AGHT+IHSd3gSKA/XbMVnGqnUDMkcwOjxMBudpFulHjFii1YLA8mJ6BNUbA3ZWSfVHhRc/YFcZqC0qNUOj/A=
X-Received: from pjty8.prod.google.com ([2002:a17:90a:ca88:b0:340:c06f:96e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c3:b0:340:d511:e167
 with SMTP id 98e67ed59e1d1-34733d506d9mr9573956a91.0.1763999222151; Mon, 24
 Nov 2025 07:47:02 -0800 (PST)
Date: Mon, 24 Nov 2025 07:47:00 -0800
In-Reply-To: <TY7PR01MB1503836F91731DC7C6D4A3E12F6D3A@TY7PR01MB15038.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121055209.66918-1-Sukrit.Bhatnagar@sony.com>
 <aSCrRoe3fcBgLo8W@google.com> <TY7PR01MB1503836F91731DC7C6D4A3E12F6D3A@TY7PR01MB15038.jpnprd01.prod.outlook.com>
Message-ID: <aSR99JOY-BjAKapl@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT violation
From: Sean Christopherson <seanjc@google.com>
To: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025, Sukrit.Bhatnagar@sony.com wrote:
> On 2025-11-22 03:11, Sean Christopherson wrote:
> >=20
> > No need for the manual "backport", commits that are tagged for stable@ =
are
> > automically pulled into LTS kernels so long as they apply cleanly (and =
obviously
> > don't cause problems).
> =C2=A0
>=20
> This commit did not apply cleanly to the 6.12-stable tree,
> as notified earlier by Greg's mail. 6.17-stable seemed to
> have no issues.
>=20
> The function handle_ept_violation got some changes in v6.16
>   c8563d1b6998 ("KVM: VMX: Split out guts of EPT violation to common/expo=
sed function")
> which moved the code from vmx/vmx.c to vmx/common.h.
> So, v6.16+ is ok, but not the earlier ones.
>=20
> I think this manual backport commit is needed.
> Please let me know if my understanding is not correct.

Ah, your understanding is correct.  I saw that the commit was queue for 6.1=
2 (and
landed in 6.12 as commit 3010739f53438) and assumed it was a clean backport=
.  But
I missed Sasha's Stable-dep-of magic intervention[2].

So this backport is _now_ unnecessary, but was necessary when you sent the =
patch.

Thanks for the backport and follow-up, much appreciated even though Sasha-b=
ot
stole your thunder :-)

[1] https://lore.kernel.org/all/20251121130150.019304053@linuxfoundation.or=
g
[2] https://lore.kernel.org/all/20251120181940.1924069-1-sashal@kernel.org

