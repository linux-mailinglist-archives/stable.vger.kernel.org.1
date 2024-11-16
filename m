Return-Path: <stable+bounces-93623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5E9CFC07
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 02:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD669287BBF
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F1161;
	Sat, 16 Nov 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJotF72q"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780567485
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731720703; cv=none; b=U7Ya/KyqZWCGjjKM+aSWVTG4Npjsm/QyVDRxxH5bzkPIUc3Qzm083Cyh+w7qSynOrURmFzr5eoLhy8lLdDZssDHRGoakht+A0+zWryh+MVMxqB0OhGjOyzIeAKaz0aacH3KFExTNfO6dITATvbfZr305WhvU2+fBgNWaN8S5IHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731720703; c=relaxed/simple;
	bh=UyhC43pZiyPSP9M0LAH70oO3s1X/Nxzx97WWOngNUN8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bX26rCjMyaECkxQINzB8c0vcp+fuXCOJO2HnaDWO18AVWSJgPpdIR5S2ebcEEagFY5Wk1d02u+QP5M8LC0FZ9T02ovMEf+d7Er2dF99r9cJlzP82K5tVI2b6Ai4zpJbY5Mr8QIwHMdWMcUHmcAsXmzplISARTUJ5qrcwYUY0my4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJotF72q; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e6104701ffso1445340b6e.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 17:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731720701; x=1732325501; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5G9v5idvngpVVbVWYeTOgnhwaczVG7ZO7E+ci5v9gPk=;
        b=DJotF72qlPjlAo9DcrcdSIYEKApMwfNe4QC7KghldQrTxyXSn1Hjwh1h2iJJ+2IYhw
         4Jl+/OhMF5fNOgLha9+DBRaoCpr24SQgg7P30aOixT80nLZW9wdMzJ6/3alrfmIdmNDm
         oF9Rmk1MC2T6++8obPvweRCfE24JFFoavx2JaYDBg96Nupa9fShl7PaGl2BJvjbf/RVT
         PP+jVaZPo5pX9syNsxK1Ag58Q8bW5rmxOi5CZMiVSAjWVDx5MJYtOZ0/T+ufSY6qvP3Q
         cye6LKd0QrHp2CjYxloD41VfY4BWks2dxVhSZjjN3S3SYGwFaOoPmBor6fWJd1SkeCK+
         /r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731720701; x=1732325501;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5G9v5idvngpVVbVWYeTOgnhwaczVG7ZO7E+ci5v9gPk=;
        b=kcXhxYsBozcxWABQ7A/dAgV1PuGdKZ6OmUa+l4VPV0SuIDfVIlAvHzpvYnXlt7WxnW
         RatVMHctX560YC3wcZYi3BrzU8pDd8/tqbaVAIvjNfRDTcH5tEQ+8MZNTSeO+jDJEmNP
         Sik1wLIz+kkIoECdddlGJTy7IdeNwWQeeW7heIui1qGYa2iG/JADhKLmhkcyCvIBk/ji
         S3px5intmfeSjb4c/8CMfsI25bztxM7vp5nM5qvIca01lVSvnYdwJo72PFAwkPEmb3Uz
         120GOBnYVt0lmpTq31t6FLLnqB29g2esuAXFr6i47ztRMEq+i9kcaPEJhKBAoX4cGYN4
         fzcw==
X-Forwarded-Encrypted: i=1; AJvYcCWaHaxcvcpTVEoUqmxOmKAUxCiPRb0xdy73lzT8I0gzX9gVCwO9qK75F/B6f2zzbCZcBDbpgds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYSI+U+lMSa5+Yr3fwlSadCIGW3pkGYIQ/HA6v+OBA/me1WTL
	8nj7tqB4h7M7/KGAt2Ylf8fYpNWf7//G2VXpJP+2x7WuGOwbS5hUwSp7397xLg==
X-Google-Smtp-Source: AGHT+IEWc+wlunTzrsI5c65XXRyz//87jPEgvtqfK7vhTML3CHq0ByVXCrQTL8TaORbfZcuR68uHxw==
X-Received: by 2002:a05:6808:1b99:b0:3e5:e72e:17c8 with SMTP id 5614622812f47-3e7bc7d31e3mr5511067b6e.21.1731720701418;
        Fri, 15 Nov 2024 17:31:41 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabdbdb0dsm1006415eaf.42.2024.11.15.17.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 17:31:40 -0800 (PST)
Date: Fri, 15 Nov 2024 17:31:38 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Chuck Lever <chuck.lever@oracle.com>
cc: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org, 
    stable@vger.kernel.org, regressions@lists.linux.dev, 
    linux-nfs@vger.kernel.org, hughd@google.com, yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
In-Reply-To: <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
Message-ID: <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net> <Zzd12OGPDnZTMZ6t@tissot.1015granger.net> <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com> <Zzd5YaI99+hieQV+@tissot.1015granger.net> <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
 <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Nov 2024, Chuck Lever wrote:
> 
> As I said before, I've failed to find any file system getattr method
> that explicitly takes the inode's semaphore around a
> generic_fillattr() call. My understanding is that these methods
> assume that their caller handles appropriate serialization.
> Therefore, taking the inode semaphore at all in shmem_getattr()
> seems to me to be the wrong approach entirely.
> 
> The point of reverting immediately is that any fix can't possibly
> get the review and testing it deserves three days before v6.12
> becomes final. Also, it's not clear what the rush to fix the
> KCSAN splat is; according to the Fixes: tag, this issue has been
> present for years without causing overt problems. It doesn't feel
> like this change belongs in an -rc in the first place.
> 
> Please revert d949d1d14fa2, then let's discuss a proper fix in a
> separate thread. Thanks!

Thanks so much for reporting this issue, Chuck: just in time.

I agree abso-lutely with you: I was just preparing a revert,
when I saw that akpm is already on it: great, thanks Andrew.

I was not very keen to see that locking added, just to silence a syzbot
sanitizer splat: added where there has never been any practical problem
(and the result of any stat immediately stale anyway).  I was hoping we
might get a performance regression reported, but a hang serves better!

If there's a "data_race"-like annotation that can be added to silence
the sanitizer, okay.  But more locking?  I don't think so.

Hugh

