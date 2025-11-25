Return-Path: <stable+bounces-196925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D2C8655B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE32734DE88
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B532ABF7;
	Tue, 25 Nov 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2c8jz9L"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259B32AACE
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093336; cv=none; b=GlTpkIkiH/Pv92V1FXqGwj7fj9zMVT09bC+HlNBQ01GP2h/boUVj1ULgNL/aUmcxgW2OkxuVTzB3PmulJ5BBvKSG+U01qB59cvkoJqZlqC3Dk5GSvhOHPALl7GJJfh6h+2WAfYSfoi5+GfRGip390mZhaikGYhd6vGCc1IyRBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093336; c=relaxed/simple;
	bh=lN8BCCnqT3Wd3NcnC3cPNzMope6nEFR0R5sLWtXZA70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKL3ofuc4NqcwpHrYmgparKiCnLhWX8ykeWjqYkvj1ONoAb/2wnagwjYojNYkgp2sMD63UT4+kbnh2A8nMZp3S7E7JgSTxBWL//NMBDLFE0Hf5YeF5Z/bikGmbF1zN01x5w5iZNJp/xiCakE7wZthDGuR2k4pd+lhnV9OfP5DcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2c8jz9L; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee147baf7bso6251cf.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764093333; x=1764698133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e7ikYYU6YXqF011B7IJ6XJ528xbD5kEc8RxMicX66Y=;
        b=R2c8jz9Lh0QGnCeWZDduQ/LTIsr5VGWIMWWxVox9LE618sLAVjjeRXD5+sZ82ju1ND
         nHaZ5F7A9kd9XGfOH/81baOhXjMiNEWem4HGqOPXAWydI05jFyeVNXi+bSjzRo6/S48t
         DsUIexcKtaBvqdYOv9dvbEBELtW1rNJgmJvpZtfsVbw3QMn0YxYe0HehbEaH6x5Hx38p
         Iii02u2y769YLaAoaOKbUQzoMH/TEXos/oLXo0cOq6dmwjs0a8wNlGEc2ckxNwiG6G+f
         +RIdob9TAdFC8wee3YtR5xYjjMMPXM8JKAvfSgElOsZopaLPpH3b2JTS5mmZdwXbE4Uo
         7p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093333; x=1764698133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6e7ikYYU6YXqF011B7IJ6XJ528xbD5kEc8RxMicX66Y=;
        b=ghtF5icEjsg7XEPyYkMWx3co3YotEoma2dOfXnOeoMlKHanUW5dMhDxvOQgHglikVj
         tKB2fsYU1Dl2+W8/T749QPUEu3b/oIVfNsbrRzKJSPlgytY2mh4i59GMWNQ9EH12s6z/
         ByaXUbfBJ77GV8I5C4Cm5p8OcXkcF4YsH9LkQXkOoLRBt/4WJhTjSUfP/TExrqP0nDCQ
         S9EsT5tSVU/4zZKKk2Ck46PY3WI0VaEKYpKh5ohhIkdPy2MEj+rjMkNdZ/p+9O/XUwb8
         ksbfu6w/4K+B0c3DsM7r4c5BQrydJA8Y4lU6u3fNdTTlvKdaLTDnJ6ZNC4mGJDQWYwDE
         W/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXxNUph5OB866HeOZSDdw0aqW99Rhi/0enZB/sC6VbN697m0DPCh265+aN/o+Sg7+HfQwwFFr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82Wq49+Uc80VBuzSSWanHZ5749TaYDYN8t9YpFJQShhzpueS1
	A/brY4pwKrc2E7ofEV3RwHu7XP+V5a/pkx4VHQVphM+8/JXv6MM4jkNx65pEH768uB5TgYKI8c+
	/FLkD1SErseOGn8UMqgnouayHbvEgWPokg7FSJBq+
X-Gm-Gg: ASbGnctS8nWKsGgvSI7IjmW0J3rXsWme0V0WK5fGDGvjZhHK73AWkYAY4hVt31t6Z54
	uz6yn6SWtk7E5lKeAefLLicxbJ+EKVlffM2/cyZn82xzdf3CTfVzIN4D52Jo3wNKqL+WeFlqSWT
	os18bNKThgk4osN+oLNMF1rHZmlbFe07C3P47kvkwrRfAoYtwEU+APHtLG3xU1A0SiCgf850EFf
	2jgdJEW48a5OLEKn7kGLsN0nZ6bAMFKzLIvPntcbl3zeCmdkNO3L1aAciw3T11Qzocq
X-Google-Smtp-Source: AGHT+IEM4ncBGhabhck0VEgp5huaHnFdTvnBDas2Yp/pRMACKTCergSPsMXUI2rUf/+E2hgoV51gOgPNfrhANRmmFR0=
X-Received: by 2002:ac8:5a8d:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-4efbe89004bmr4856761cf.14.1764093333084; Tue, 25 Nov 2025
 09:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125101912.564125647@linutronix.de> <20251125102000.636453530@linutronix.de>
In-Reply-To: <20251125102000.636453530@linutronix.de>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 25 Nov 2025 18:54:56 +0100
X-Gm-Features: AWmQ_blR3tzOv0HD7whMMyQViK-Vzttn3TgcJWmaRLi6QkavZimxcsp0XtyRVac
Message-ID: <CAMOZA0LB1UEEib1WWpUW0X-5+LKx28Ko9eGLi5ZSvU8d2yXkBQ@mail.gmail.com>
Subject: Re: [patch 1/3] x86/msi: Make irq_retrigger() functional for posted MSI
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:20=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Luigi reported that retriggering a posted MSI interrupt does not work
> correctly.
> [...]
>
> So instead of playing games with the PIR, this can be actually solved
> for both cases by:
>
>  1) Keeping track of the posted interrupt vector handler state

Tangential comment, but I see that this patch uses this_cpu_read()/write()
whereas the rest of the file uses __this_cpu_read()/write()

Given where they are used and the operand size, do we care about
preemption/interrupt protection, or the (possibly marginal) extra cost ?

cheers
luigi

