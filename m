Return-Path: <stable+bounces-161494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D7AFF3EC
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA983A824F
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559291FF5E3;
	Wed,  9 Jul 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="RzZtrXwX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C836220F3E
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096611; cv=none; b=Xcmpq7pPKE/oqSN3jsNJ+domw2TpxS4+nzapf/r1DvAHJLENrf43566J1EMNSDROzT1nFd9GFyTAZDylNDLdPP3frPAJQ+3JyHWwhxiVS06v41pU0FMCOCSkwS8NHOIZVQIyEOfUHJCODCbZCs4Ya9RtdCNa68e+3O/OppcJCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096611; c=relaxed/simple;
	bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhSsIb3WaVQd2+qWFxpsyvvb0ckC9R/daaxuo346Zmjn+ozkbufp3e8Cpb8ABogE6JoK4kNz09C/ueO7tVjyak/RRrelREmhV2ySf4ABsdfr9IMqNjPe6PH7nKcP9qKqybN8SXYYskh3xgdEcQsXUwStwPlRsZ6SSkq6HcN7uXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=RzZtrXwX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-712be7e034cso4144617b3.0
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1752096608; x=1752701408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
        b=RzZtrXwXaWFkc8PpqifjN6S0EWAwtt7ceIML7jof7+WlGSdFBcfd12CTU3jVzKdOSS
         tl/0th9w1dNoRTPk4YN3FWtJb7bfwqHAhvraZRIG0AhratiRzT9uKnNcjKS7URdLRDqN
         y8MHsvRGyZNoTUOS+4YY3lvVm7wJKP9+hG4yhsT4ENLdiru1Qj6lvaiQWQL6r997pSjB
         lufQtNBHxEAJrXPGjEVPSqM6KKuseOfRu/U0YMQ39OPOwl4AOfraOH0fA0lDUfLnhnJQ
         5kn2GgteOfHxlaBFUt1RtOlqUlPsac4YGaavGmExU7j1XDsV/yMbwrxJgIKmQea0lwKC
         2aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752096608; x=1752701408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
        b=A5wauvJkcQK8nW4pymnPhnnGfaIQT0cOMQ3gTpVqQdkJGoFfXB3BFz42s/3C174KbU
         7cNr9Ov7+BEIIi8k4uZlbpkUN2g5/wTavItiC8tgINcW7Hhjkk/0QYYg1ef2RjAQX/k7
         nzxI/f7/sZxteA1y5AsEu5pbzUj1/7/+/94lJwtzkEYocpkh+rBDvh89s0m4XeZoOBN4
         WCzxVJn2rzW87vaxRdgCi4u2ItM+FhwvoP/xrJdWsgpB76qflW0iRJazwi4UJmLfMcIJ
         3agPfjuBQtRdoU4xfzFDqDKYC5adXy0gYfo2adOtzOS8KPGGwecaJVyb3N8R0p7HjonT
         LPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdhIzpZeOAYpdDv6iM+1CGAFbM03Qvf75yfhQ/0XATnHbplowpjFyeft32MOyKVo5BxdL3OcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQUWkAWdbAuFP2rxVnJrLLbva71dFlacD6QMN4NWsLtJg6qOk
	qCgzGtakPbD4KySnt5gPkzTqDF5IUGGw6g+h724bYSCOW0jNbQtb9wOoPK16XN8VPK5mYtpzCgM
	pYG4XAbZKrA8d54nNXJDgtfNnqzokSG3Kl6RPU9jj2g==
X-Gm-Gg: ASbGnctPKsoeaH8IhAx0yXQRU1V/uDqaOq2N0toX/+Ue44UwMHJsbcq6Tn8mnlKswhC
	auFIpFve9coFt8ERU5zBxFN+FfyKOTqGvmU1E3A1b+cdwznA7+Hr8SuHsWqTI8avjCKbPMjhDwc
	pa8b2Ip7d6Qf888G+9STozj1rRvLWgxymaWTR9xswVfA==
X-Google-Smtp-Source: AGHT+IFA/TyZV8EGMF9IO4hNKLPs7QqkYpSA7lLh6/jJatQA3DN6SKf0unViUObnrSN6U2H3b26xG3/2UTAwiVdEKWo=
X-Received: by 2002:a05:690c:640b:b0:710:ead5:8a95 with SMTP id
 00721157ae682-717c4652de5mr6850687b3.14.1752096608346; Wed, 09 Jul 2025
 14:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org> <75a83214-9cc4-4420-9c0c-69d1e871ceff@heusel.eu>
 <2025070909-outmatch-malt-f9b7@gregkh>
In-Reply-To: <2025070909-outmatch-malt-f9b7@gregkh>
From: Alexandru Stan <ams@frame.work>
Date: Wed, 9 Jul 2025 14:29:31 -0700
X-Gm-Features: Ac12FXwEdWtlHSc6c1BAt6plMlo5XE4LaJAIba1E3cFVgzAQ_-C7cnhnPzezAR0
Message-ID: <CAORQ5J5my3cd-nb=6wJ68s8wJ5BPi+JSu1Mo7JdHiLTD+XnB6Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Heusel <christian@heusel.eu>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, linux@frame.work
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Greg,

On Wed, Jul 9, 2025 at 10:20=E2=80=AFAM Christian Heusel <christian@heusel.=
eu> wrote:
> on the Framework Desktop I'm getting a new regression / error message
> within dmesg on 6.15.6-rc1 which was not present in previous versions of
> the stable kernel series:

I debugged with Christian a little bit, turns out that particular
device ("arch-external") had a PD/UCSI firmware bug (which we have
fixed since). Perhaps the new kernel just exposed some more of the
broken firmware behavior. It does not reproduce with newer firmware.
I think we can safely ignore it for now.

On Wed, Jul 9, 2025 at 12:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> And maybe if my Framework Desktop would ever get shipped to me, I could
have debugged this ahead of time :)

Stay tuned ;)

Sorry for the false alarm,
Alexandru M. Stan (amstan)

