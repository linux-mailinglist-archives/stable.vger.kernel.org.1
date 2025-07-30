Return-Path: <stable+bounces-165547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B7FB16497
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E22B540898
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08F2DEA95;
	Wed, 30 Jul 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYhio+Qh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21862DC343;
	Wed, 30 Jul 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892877; cv=none; b=u1j+w0MJu5tlWJgPTgCUcICc+PFfQ5fmjQshvewbmeebulFHQFMrazRRx0EkTPH7p/7DtZJPPORPnR1us9TzACuyJo1RQ1rd4c/33tIAiBj6a8KpGpYqjhWGHMd04Du/R+FFgmbcEnBX54uoqRcK3HQBTgu0VG853VX2JYCb6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892877; c=relaxed/simple;
	bh=VDN1MKYrHnhKs8rJltEkmxfDO0gFuhaDH2a2kia8Czw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFvomjTdE5K8CnZUJ+67lHqad28LBRUEhV3GabK0mckbk0IuKY5/ZFL6Xt6AFH6aQl0InIHXrmX74SSsXl4TQW6CdGicVVO6agbAHAHBJfxbWVp/cxrwzJCDiVFIeYIwCvn6VCud7rCIb46oKz9FPMPCGUqSGDF7TeRLPJTebic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYhio+Qh; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-610cbca60cdso3653382eaf.0;
        Wed, 30 Jul 2025 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892875; x=1754497675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDN1MKYrHnhKs8rJltEkmxfDO0gFuhaDH2a2kia8Czw=;
        b=RYhio+Qh70tPxGH+BVl56ifH/1lwMA6R8eFKguF7SM+SMtPW+PICRZmelJxt79xM50
         tFHFKJ2CGUhIOYUR5m/h35uidtiUx2RRG1H2X+GQdlWRfeRSgqCTa2EhwC/cMjvlCU/j
         Ca+6VVmtlDLqi/XimTtDIMJ1OhidSrqCvkWk6dxvmvLnsy/cMky0YRMjmEdbmR6i0M5D
         RpsBhWR1Oavziuw25xdPwCynYu3BwanaPfk/3as8RJhV4cDMuaKPVTYjrth24pC//fUX
         dtxrtmDKr1PQt3fvbvinuFohKs8+DR9FHH5ir6reyM3mrE9xTm9efP6RPBALtc8kD+BW
         vYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892875; x=1754497675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDN1MKYrHnhKs8rJltEkmxfDO0gFuhaDH2a2kia8Czw=;
        b=v1KHQj1X1elt4cDHf3EbH73SGsdwqahK75ea9rXJZs6Vf5JEVO5KhcrS1o4LKSyW9y
         UQc5jzFq6aQ1vSe8FifxQNTqvJbewZ8gQ8vNBossR+k6c3bIlagBGzBsU7xcDC4PnEnq
         ucxXuEwFdlu7SpECGNiwx79wPhylCUYJylM3u95QvFWEF/lIDFERdW+lq6YW3Pzf8XuU
         0Qgl0d8XURODR9dtSyyG1u5KeMhFKSwq/F12bA4wjjeeefF8aELq9ho796aoA8rHwwxD
         cC9MBqlg4jJFccP7SkI7vopJDXpkv5/88OKRevHkvSCcKzmZLoaxlOrOH/FWM2xV1uQb
         iLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVaso2IhVgixsCiUTK6wQ6BN/3AaWlJNCQ4qWyBvWXlmkX/B6W3RdDOnaeq6fcyq52gFzaxj6iXqMq4rc=@vger.kernel.org, AJvYcCXdCGeEKZYojzcreVYD8UMvO4emPVN0lJZq5GHaSZFgjxM7h+o5FZ3KsUU0vqtObWe4BAGHU9PL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZH44NATzzzm0IB0QfOI14FrtmS8XMi4ldNjFE7jLFpK6wy6/
	hojhx+HvCOj6EdtGhCMCfVgktLHbwATxqt+27UB6CtBHExoqp6tB3aTqNAhd3ZX71+BOtzKvJLW
	kDShjPyfEFY8l8ViUhjDOisy+CVUe7Ls=
X-Gm-Gg: ASbGncvEQ3BIFlE/rgmPgp1MPL2NliK4XhmbTtJ9byXCpbXzlLmVELkI8BdtaJefCru
	GiHEr+EkN2wqSFawVJIx+OtK8eZOY5eZKipRY6Hw9i8v2/nudBT+bZs5wDEvgiW0UROkkZy+jKP
	gD5QLK7qwyosw5TKqxJN3m8dbF/VezoLSyobeyWbFvUmuHNyBtAy9rs4eMxmIGgh1pgY20fpLCv
	RmjUmMQ
X-Google-Smtp-Source: AGHT+IFJBBircmFlzkuiZxltpkb8UXxxVju/Ryi2aiX0HE6gttXxNEsyR82wLNIYdBYNG+mN1mHi0d2hU2BueLd1gHE=
X-Received: by 2002:a05:6820:998:b0:618:d339:1fe with SMTP id
 006d021491bc7-6195d2d2924mr2688300eaf.3.1753892874659; Wed, 30 Jul 2025
 09:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com> <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
 <834f393e-8af9-4fc0-9ff4-23e7803e7eb6@intel.com>
In-Reply-To: <834f393e-8af9-4fc0-9ff4-23e7803e7eb6@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 30 Jul 2025 21:57:42 +0530
X-Gm-Features: Ac12FXzlj5yWkI6eKhlg68DANwG9PzzG0U_nSEKVUez-tYk1CF6GB0jjskMMJpo
Message-ID: <CAO9wTFi6QZoZk2+TM--SeJLUsrYZXLeWkrfh1URXvRB=yWtwig@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	peterz@infradead.org, ravi.bangoria@amd.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 21:03, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> On 7/30/2025 7:58 AM, Suchit Karunakaran wrote:
>
> > Hi Sohil. Thanks for reviewing it. Should I send a new version of the
> > patch fixing the minor issues with the reviewed by tag?
>
> Yes please, I think one more revision would be helpful and reduce manual
> steps for the maintainers. (Likely after the merge window has closed).
>
> Also, please try to trim your responses to only include the essential
> context:
> https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying.
>
>

Alright. I will send v4 after the merge window closes. Thanks!

