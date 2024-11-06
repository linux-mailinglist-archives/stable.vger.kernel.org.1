Return-Path: <stable+bounces-89942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8E9BDAED
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC391C21893
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820315E5B8;
	Wed,  6 Nov 2024 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5YZj37e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C01B815
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855357; cv=none; b=c8EOgw9EERD3li8opJs3vNzGC0VdGRN8SbyHbt1UVdZoCANboZR7YHcRKTXrZOUhPHP3wrbGq6LUVvzhFW9hal07e4/XtgGRX18kkzCYAPAulTYSGWkgpoHAPQ3u0gcpnb6EXbRVWkiYgM5Es5oQaHKwFqxFpiesoJnJFQF49gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855357; c=relaxed/simple;
	bh=m1jPRgvwaVt0Ji0K64vPZOJS/AW3EobWcVHaJ+6e92c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u3vu87OsvYLi8/eIFL0Zv7agC7LpYSI3IXGH4Fi+PtbxRapUl20O1+hPB/UmyGfjoqL2pPz1sssj9Br7wXLngfO+VT7dR4UWLorddkyF0QWWlk4tLZm16aZL5glY/V8KW2kjJGUuuzBKjvFaW52ipCRfujOaXG9RGaq21po7XoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5YZj37e; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaee07d665so6512599a12.0
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730855355; x=1731460155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM/JOg5R9b+FWm0W8b94lT0depobNUxyZ6mpenVonLw=;
        b=F5YZj37etMbDFkfq+xPkgdawXcWhpwlf09vsOXLU5h4XV5+HEdNpH+9t8dagp4Kt7l
         acfHh99oribWtl67RAQFqFIOMmFWBGTm8alpJltgHhn9qpi4jwdAhGwQUQsybgdMb1wZ
         d7YsVyyoTrtR//KP1TEMnB7qltSI4WDhNFy0+4VUHoY/qiY0yLLJgEIMYPufiduzzYbh
         zQ935BI96vcnkyWVChDaRdTvOEu5ziJzi9yceHXHwhKPhbGMtYoJkS98eFFbRUrvDzzM
         2ynCpwWDMWe8upF0JMJAYRtaFa7M3oTvGFm8Z8uHmn2fdxzfmPaMDVrXPGiyfLFAaHEw
         2chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855355; x=1731460155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM/JOg5R9b+FWm0W8b94lT0depobNUxyZ6mpenVonLw=;
        b=i62wF0EQR5CSspyxnytYg0i+uPI2PGF0167oNUakAiMIafcBwCNAXyfKfQ+rEk/l6h
         89xkGgah2zBe7BGRgzwbEB3RzEKOAQeXgGdgrHYiKsjw9Kf/CRcR7YYxmM6XIW0D6Unc
         2jGBgtbyLyW0MRQwv1+vaJREIevgQB9w1T7um7C/9jg5tFzbSNB8XqFnP+WgCbXm8EWe
         nCttnzGeSSoxVz3W1lVkWhAg+F6UjQK15qQbhRjvRn+l61PjQwVogxlZ0B24Z+I8k52E
         9tADdwE8VJH81DbKp0fLp+k5ZuUZcFdm4ehsfSREDi3zIgj+ZR34fYQwbUu3BoyqKu1G
         kYYw==
X-Forwarded-Encrypted: i=1; AJvYcCVWbeTEP3aAP/63ekGGrLEBi9/Z1gyFtcEowxkIjqrDKN6bSlKy51dNG6PNtkjtd5kl01JQLBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcHYuvnQokadjBHi7rsTNDdnjWgC6fv4HBBwTK/80JZR0tpDI
	sJud6roTQPpK2M59HMkN+FrW22XxyWJwIstkQYsoYRWS7VXSCbtmKRECeFgv/wLHM4J44Sv8cAM
	RFw==
X-Google-Smtp-Source: AGHT+IGwBu+onCDNn0Y32ZVpfpCe4rwxG/l9NILnSH55nW3/1oRdipH1Rgb6zMdW9xSxMW4+/zY3xYf4thA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:448c:b0:20c:c9ac:bd0f with SMTP id
 d9443c01a7336-2111aef735dmr281325ad.5.1730855354521; Tue, 05 Nov 2024
 17:09:14 -0800 (PST)
Date: Tue, 5 Nov 2024 17:09:13 -0800
In-Reply-To: <ZxcK_Gkdn0fegRl6@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com> <ZxcK_Gkdn0fegRl6@google.com>
Message-ID: <ZyrBuZPBjJi75gGU@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
From: Sean Christopherson <seanjc@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 22, 2024, Roman Gushchin wrote:
> On Mon, Oct 21, 2024 at 12:49:28PM -0700, Hugh Dickins wrote:
> > On Mon, 21 Oct 2024, Roman Gushchin wrote:
> > I don't think there's any need to change your text, but
> > let me remind us that any "Bad page" report stops that page from being
> > allocated again (because it's in an undefined, potentially dangerous
> > state): so does amount to a small memory leak even if otherwise harmless.
> 
> It looks like I need to post v3 as soon as I get a publicly available
> syzkaller report, so I'll add this to the commit log.

Today is your lucky day :-)

https://lore.kernel.org/all/6729f475.050a0220.701a.0019.GAE@google.com

