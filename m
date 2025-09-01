Return-Path: <stable+bounces-176833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EEB3E0BF
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4C3A7AA3
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9432F8BE7;
	Mon,  1 Sep 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYqS4Fin"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCF78F5D
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724337; cv=none; b=S+ji5KEz9l7iPMaiSe+WCmYnSwyD8CZY6WwOa23L1Lmzv1jCsZPINWL2QaqtldYItTCjYeAe8O2M8NZZlVGQlx46CMKbkMm1E19WGAvkHo7ifsM2mRuE2JDTBM7EEZ5tLn2tvMzxUWz5nEclP+N0MnsGs7TDE0K4wi8GK1rjP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724337; c=relaxed/simple;
	bh=bGzY2rJAtHroiO2Pc45fRLjqCEj4luqkO+iLLyoK8Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsywwzVaKGPpvO7uHfkIrQQnMd/Jfap3VXUVatIn8FSR8TGFlJIsIgeLhP59NLE10Duw58wJujvUKzYm9yKTDl+xMVNYVsLBCsQycwi7v/I82vD0JOhlyPu9fE6UZ2h/P4/n3hld565Al4VWRV1F1MRxQH+pjVkUEAMqXKdluKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYqS4Fin; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c869b4623so11175a12.1
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756724334; x=1757329134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGzY2rJAtHroiO2Pc45fRLjqCEj4luqkO+iLLyoK8Z4=;
        b=bYqS4FinlNij4GBxQoT9RaqC4ZJGH+KAxcFGZqMqGo5thZWMRgJSbAhj7mz6RbSaya
         DkKg4gO2ix7GTqgij1poX73Srj26MsU0rMWudjoO9KgHtCuRraoTYxDgDlOkh3WDZJp7
         BOS1CbyhJP2em5AoWPpp4c9DajK/WPc/3opI9hWbAAMPJOp4z78XC/h7rLUoW+J8Z3uY
         6oMecOVCDofhlgeTCrhbwMGZqz17a3cHuooP4Fplh+4Ua1wdAPsAGCvN9AblMNxpKbAz
         wW4bkFUw0+n8FGRY8FOcHPPe3mgNHicNs6HS/ova8nsd/8lRJlHU4kSXA/wQcHX9+Gpz
         ScSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724334; x=1757329134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGzY2rJAtHroiO2Pc45fRLjqCEj4luqkO+iLLyoK8Z4=;
        b=JhTTDjqDYJC37zA27YEf1W5GzaoMaRyoQR+XOPWV2VAJtUxEtofNzKYi32itC6lpIt
         CJuR2cBA6J0YIGRseOBcCIIUtKGVGbEXAEF38M+P4NHl3eFtXiw/4aoJ+YTg8BZ8qsrK
         SPyCpTFiJxr/qEW4ZTMLMQuPcC7Ve9Qrf497m6iQOwfRYMtAtkF3Bg3j5Gz0s2eQyJ2Y
         R9HGTkgDbyDNDaC8tM6WcDOTZx6nJjUaBdO0eSCsfrqhX3T7w1VL3oD+JhrTS3qJgxLI
         CJiKs/yTl5/5bV2IgfL2XIo05w8/6RulApQZq8+VjsqcT6DlIud+HjfkWkh0U1larxJ1
         DbRg==
X-Forwarded-Encrypted: i=1; AJvYcCVlt4McbypFa1N4XxDcuy0y27CTs81Z+aj5pDiPlBgGZyTW5tU5fCLtsfWPufcceYU5ptTbYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFPlCbyZhj2WmStfbGUGKDDSrlFxnEuRgy5YxCT4uorMF5b7g
	VGs1XsJSOx0tvWybsvqHEgaKuQaJAlMrHlN5JrTdJTGRIBVc15f33lw+88wExLECYkfvYJLMzOa
	kVg3fPm+x/9/RWhphv5YVNhF57nPeaCq9lZlqyrmI
X-Gm-Gg: ASbGncs0oRtMdFHXpavTPxvRp/6RG4Z4NOrgVh54UA9MLYRr4q0CVtpMBSJ6t2FEumF
	1jcjY6aT8KdnvynuHT8d4vB5Tn7MLJUxiNHNTHaOGxeH5dfVWDxxtVAaUckaI0p+v2W8tkLZ2U6
	PbNhfuSvG4glQ/xzsBvH7dbCqASPsrnxhLgmLqW9oO8p5v9nU24rCfydlo5Ji0YDxifsPLom0ta
	Dw+xZ3zcoi7o0X5HPWP7ycaACe34psl8UWJwtG1Jg==
X-Google-Smtp-Source: AGHT+IF0MF92OSwKaT8dc5btdbuZi/r8ljMshHpA2AY42cVUTtJEdepEWI6viiscm0IxrNVSYHmOclFXiQuAPZEGy/U=
X-Received: by 2002:a50:cdcb:0:b0:61c:b5f0:7ddb with SMTP id
 4fb4d7f45d1cf-61d21f857e2mr112703a12.6.1756724333786; Mon, 01 Sep 2025
 03:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
In-Reply-To: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
From: Jann Horn <jannh@google.com>
Date: Mon, 1 Sep 2025 12:58:17 +0200
X-Gm-Features: Ac12FXxH-Oq580f8g-P94YE4nrs0vUiHqAcrNQ9oEvque40YtjNbTm97qjqbxe4
Message-ID: <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com" <trix@redhat.com>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "nathan@kernel.org" <nathan@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"mike.kravetz@oracle.com" <mike.kravetz@oracle.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"liam.howlett@oracle.com" <liam.howlett@oracle.com>, "osalvador@suse.de" <osalvador@suse.de>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Aug 29, 2025 at 4:30=E2=80=AFPM Uschakow, Stanislav <suschako@amazo=
n.de> wrote:
> We have observed a huge latency increase using `fork()` after ingesting t=
he CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: =
fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of m=
emory with 196 cores, we identified mmapping of 1.2TB of shared memory and =
forking itself dozens or hundreds of times we see a increase of execution t=
imes of a factor of 4. The reproducer is at the end of the email.

Yeah, every 1G virtual address range you unshare on unmap will do an
extra synchronous IPI broadcast to all CPU cores, so it's not very
surprising that doing this would be a bit slow on a machine with 196
cores.

> My observation/assumption is:
>
> each child touches 100 random pages and despawns
> on each despawn `huge_pmd_unshare()` is called
> each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_rem=
ove_table_sync_one()` leading to the regression

Yeah, makes sense that that'd be slow.

There are probably several ways this could be optimized - like maybe
changing tlb_remove_table_sync_one() to rely on the MM's cpumask
(though that would require thinking about whether this interacts with
remote MM access somehow), or batching the refcount drops for hugetlb
shared page tables through something like struct mmu_gather, or doing
something special for the unmap path, or changing the semantics of
hugetlb page tables such that they can never turn into normal page
tables again. However, I'm not planning to work on optimizing this.

