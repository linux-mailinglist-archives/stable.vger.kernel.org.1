Return-Path: <stable+bounces-89230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851079B5014
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3061F2290E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415D1D959B;
	Tue, 29 Oct 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvQrpHPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E1D6DD8
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221583; cv=none; b=PRNMZUTjbLBsbRfHGRYr/k7Eo2kRN5uw7azd2p3ncmSO+vtFiriRTHlhpZCdp7lOZ8SV6vY+WWAMRSIbkzDWI0c2C6gROKsQ5h661NfuAIyJtxmpjzPH0C/LPuvVITUgBAzJLl1Hh97CqeWqZ0TdBFzN31frKQXE0doSqMHO2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221583; c=relaxed/simple;
	bh=ynacYz6swHjZ02f11a+UlbsVE/1P3vOR86gVEDQ9s+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHuA56Hf4qX4ghK0MDVfDmmBJ9zOzAHHZRogxksPsUTrelVqqL1KxVbIiv78q3FwoMkBJaysHvPNx8GLaUg6NiRjEw4M6XWEq1Qb8jAkGz2k9Di5rVw/E9a/iYZbw4P1rzzzTbA6pQ/lLbDu16vyeogLn9UfUH45NNlOOpSS39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvQrpHPW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so10081cf.1
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730221581; x=1730826381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynacYz6swHjZ02f11a+UlbsVE/1P3vOR86gVEDQ9s+8=;
        b=TvQrpHPW48i2cLaPlDkNbBUsNhaYyMrxXKXWevivPFK2jnFePvrHgn7ZvsunOtYP+4
         ctR98C6cQs2yw3Em1oh56wUtUCQHhYoH30c/CJqqkeq8kuOw3iMvdREV4Vu1U/1L9VM2
         BN846jc+J5iWKBbCRlTIYrY/F5dHpbPUEyFpa6cVxsnKTm8m9+aDET3Pd4DkVeMU0GNj
         sSXcTxg4ERVCy1V8qHPbAS6Bt7uN0mmcHrK72L36Y7NmaNU7LfF9WkvK0NDK6+XHtwhK
         f2uVpISbqtmP6hx9ZPX5Zg/5yF/c2WIrT0R6uF3r17FgJJ918rnCRSVdHFf7hwMVWIgM
         +DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221581; x=1730826381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynacYz6swHjZ02f11a+UlbsVE/1P3vOR86gVEDQ9s+8=;
        b=a7bCOXUjbANQl+OfABLPo1fUPX9zWE6+6o6axEw3B5ooWVRQvaCXln6wn1xJPU4Eys
         oewhqqv3shQMD9YOiBBhcQAYLJbiZOTPj6R8mUyvFKzMDYPI6hjVkHAqT+n2qJlyisMe
         oullcMoVSDgDQxxG8KPUsAPBRs0kh6xtzEyN6w92OBs28FTUOLZ/WF4wnqiEJEfTeK3X
         Z40Pyp+M6ItMWy/qDRrlooyw7U9CXpdKJzsQyuiG03+IwOpugMIJQgSqvR/lpShUGrly
         BG+YAV1c1wZbiNExMXycOKn2Q6Ntsk18DeOwP2WyRwDkU4I2S2iWGDKl2j/lYT8z0OVc
         6d5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoafHePAOgGmK+tLWCN/3KD4VHN0C78WSYymJf9eXyKMJRy+nF5ueJ0SSMwsSMzLuFatr0c3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblwFWRZQf15nFjJfMP+okHTrcFuRJ/MMIdylLqPCLfcyPo1WF
	CS8RP98fuxdcZYpWUuWDqanjIdF9Vh9NinYHTRCHhLXJCFAv4YNLe2GjYUVp2KTX7ZwT5h/HHd1
	ha8SrCmxm6tRqmECFj9qX373dChvMPlVWlA3n
X-Gm-Gg: ASbGnctHrzStazHj9wI/Xjt+1PfiJKVFo6mECRBrYMkKA2QcPTr/wKmiIG9Pe5SDPZR
	/1Jelx4RX9cXHoevgaE0CtsmqekJYSUcIP8HTHiwdJKKts54yXvpbq62g4g4lgfkk
X-Google-Smtp-Source: AGHT+IERQ2wd6YprqS4eYvnnD7z6rw6ImUej3A/vL1S07gFistJ64iydzViz9z7fnItMS60psPXdYpEjxesagiZuwK8=
X-Received: by 2002:ac8:5dc8:0:b0:461:43d4:fcb5 with SMTP id
 d75a77b69052e-46164eaa58fmr4706231cf.2.1730221580720; Tue, 29 Oct 2024
 10:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028234533.942542-1-rananta@google.com> <868qu63mdo.wl-maz@kernel.org>
In-Reply-To: <868qu63mdo.wl-maz@kernel.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 29 Oct 2024 10:06:09 -0700
Message-ID: <CAJHc60x3sGdi2_mg_9uxecPYwZMBR11m1oEKPEH4RTYaF8eHdQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: Get rid of userspace_irqchip_in_use
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:27=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 28 Oct 2024 23:45:33 +0000,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> Did you have a chance to check whether this had any negative impact on
> actual workloads? Since the entry/exit code is a bit of a hot spot,
> I'd like to make sure we're not penalising the common case (I only
> wrote this patch while waiting in an airport, and didn't test it at
> all).
>
I ran the kvm selftests, kvm-unit-tests and booted a linux guest to
test the change and noticed no failures.
Any specific test you want to try out?

> Any such data about it would be very welcome in the commit message.
>
Sure, I'll include it if we have a v3.

Thank you.
Raghavendra

