Return-Path: <stable+bounces-89339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83379B66C9
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58138B22FF4
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFB1F4725;
	Wed, 30 Oct 2024 15:01:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6ED26AD0;
	Wed, 30 Oct 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300489; cv=none; b=B/KnEuazEvYzeS2wpaG+2uFyfsbCq5aKyzHTbtqSBNeyATgXmpfmUJuRs7YikNIlHYcU2KwC2HepeU6bDidb0w3c8d++A16LvVB28VB3NBq++oHj6oTTfM/L7ZwCRc5sWGWyp0IytCmPDhX2NWuDBLNj73uBCobfI1ZVdvAz+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300489; c=relaxed/simple;
	bh=s6cBiL9Hq0Q20TzyA2dVWFduhAA/rN8bWvy+wmTLmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu5TaWNLp0f9lS9XQjuvqI/mJitHx2vMueCnMPb9N7GerFFxjMJNXu4TjdFfJqQFyPB36Tw9BMCFj/8RWPx3foALgV+1g4UajeKcJyei3h2/EnC5tqST0hTOLb2lYe64emq78t8ChWCyKmbPL29jN5d4mtExSoV3XctmICtfMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso1018207766b.2;
        Wed, 30 Oct 2024 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300485; x=1730905285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcefwH6DwVLO3jkdi4UJLGk29QViGQKLdm89K+/T0Ig=;
        b=vhgBvwji8qXctqO5PlTXltxfk0wtni8iqu3I2/L03nm1GppS5EXigdKKGGPNeBXNvq
         QaPt+vKL9PGsqbbLW1HpDdzn/qzQ5wev1FIIdpYvrCuMYfb+Uj4j/MyyZCJX6HpM6WoH
         /u/9/higLE5A0kkV1g5toh3uP11wD7DRD9xvt6Xs+f0ogfJvFifOcX6xfPBBdWAuWjtl
         aAqSOnnm7JkZYQB6UksqYHT4BFYHLkwH9BrXhYLeGcDjXfn8Othnb/d9FGKUQsVWQULs
         wTtQx21ehbdy8QQ8vqb+n/UxmawRmC69AAH0CxTtAZL0GjyLN8tZspjQ732dBejAW0Gz
         EaMw==
X-Forwarded-Encrypted: i=1; AJvYcCVSxXDAi+4BPa+0B/tQkkDVgG1ZMKN1UUYXdP8eFiY83nV5qAWnHIj0dWrhwraxOprwpZ1nfLZ2XDDYx6g=@vger.kernel.org, AJvYcCWPqgm/cKutWfmoVSczqCTdxdtijCMWiaFUcfxyB42OYhbZ+M3XX2K3JEQgrFdAgMJk9TT2xXWt@vger.kernel.org, AJvYcCWWYxPg/x9TMVzW+CGWZ/vH0K75/AKx7HBOlP2NKKFZzTIfMh1chJDD200pFGC8C/u8gnjamqq5@vger.kernel.org
X-Gm-Message-State: AOJu0YywTXyV7kKnuNQL8cJAC4qVq70P/QcMHQ0jnuRr7EU7i8cBiZT1
	wa6VTCX9F4ItkDY40fl+3mXa2HYgPrDkL+L7Kh8PU+iMFxVBdkwE
X-Google-Smtp-Source: AGHT+IE0mMeXCQD6h1yd6THZC/eiGg3fCLvdBgMNwVez6Ft/Ssxur1UOrug1MDpyzVlJbd/JIZBSlA==
X-Received: by 2002:a17:907:1c22:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9de5c90d49mr1630487766b.11.1730300484919;
        Wed, 30 Oct 2024 08:01:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631af22sm4800577a12.77.2024.10.30.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:23 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:01:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vlad.wing@gmail.com, max@kutsevol.com,
	kernel-team@meta.com, aehkn@xenhub.one, stable@vger.kernel.org,
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling
 mptcp_sched_find()
Message-ID: <20241030-hospitable-sweet-chicken-f71faa@leitao>
References: <20241030140224.972565-1-leitao@debian.org>
 <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>

Hello Matthieu,

On Wed, Oct 30, 2024 at 03:45:02PM +0100, Matthieu Baerts wrote:
> Hi Breno
> 
> 30 Oct 2024 15:02:45 Breno Leitao <leitao@debian.org>:
> 
> > The mptcp_sched_find() function must be called with the RCU read lock
> > held, as it accesses RCU-protected data structures. This requirement was
> > not properly enforced in the mptcp_init_sock() function, leading to a
> > RCU list traversal in a non-reader section error when
> > CONFIG_PROVE_RCU_LIST is enabled.
> >
> >     net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> >
> > Fix it by acquiring the RCU read lock before calling the
> > mptcp_sched_find() function. This ensures that the function is invoked
> > with the necessary RCU protection in place, as it accesses RCU-protected
> > data structures.
> 
> Thank you for having looked at that, but there is already a fix:
> 
> https://lore.kernel.org/netdev/20241021-net-mptcp-sched-lock-v1-1-637759cf061c@kernel.org/
> 
> This fix has even been applied in the net tree already:
> 
> https://git.kernel.org/netdev/net/c/3deb12c788c3
> 
> Did you not get conflicts when rebasing your branch on top of the
> latest version?

Oh, I was testing on Linus' tree when I got the problem, and net was not
merged in Linus' tree yet.

> > Additionally, the patch breaks down the mptcp_init_sched() call into
> > smaller parts, with the RCU read lock only covering the specific call to
> > mptcp_sched_find(). This helps minimize the critical section, reducing
> > the time during which RCU grace periods are blocked.
> 
> I agree with Eric (thank you for the review!): this creates other issues.

Let me comment there.

> 
> > The mptcp_sched_list_lock is not held in this case, and it is not clear
> > if it is necessary.
> 
> It is not needed, the list is not modified, only read with RCU.

Thanks

