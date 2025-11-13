Return-Path: <stable+bounces-194696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9793C581BD
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E480C4E03B8
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715EC2E62DC;
	Thu, 13 Nov 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYgZo5a4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE42E5415
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046094; cv=none; b=GUInZZnKJUNf+Hn7TzlPYUX26VAbpVPztzjZGM/OdSgqBUCc9+ocxgiYds/dcv12/s4ypkLYWZV830BROHbVwqGaw3IzJqtZmXWd22IJjSD+kSnJcxca14/wrPvgQY3lRcBkEVTKQotKLwZFPw+i4CapS9tyLHz6r8gGu3HuafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046094; c=relaxed/simple;
	bh=dXd4PrP+M4ZkZTjQ91QC0jeAdSuL5P8/tUammlUtrPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H955PEuQfed0JXLQgyJxtt4Cv2Y7lQXdiUWnfHjmM2lvEIJTDzk1POKD2WXPJHdz3mR835F+Wk6/mvLO8zy3cSFEirDuLJHFDsUEDyyEu7bozXcqlJQkBjXyT4J0s6q8dlWobjSO2QbbpANRpi4ZzdXAlaYru82BRWop23tSecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYgZo5a4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29852dafa7dso183035ad.1
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763046092; x=1763650892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SziGgu+jV7pu6XCcGhbgmOS9AguhsMW+n+l2AM6CI=;
        b=xYgZo5a491KRNaSZCmiA51VIoWHaUSoEXXq8Z/bsfz6amdgX/ctLoOkxCfpvkyr2ce
         4pIxaoQz4whPzqLDih0pb4if6sR+coYc5grEQeA6yyCYt50kc4wlRZqVNK8ZyhdjCTE2
         NymkQ37p3MD2i5Beg5xDm81ybru21zqtUhWW4JyoA8UjAiMfwBvZ6LCEwiJqUkPI4yWd
         LColjANHGazq8CYeraxAUofl8P1RiRc77WPc1VOOuwzluyX5zjIkdT8sZrYk8KZZlbaF
         mfo8E5tYesy/twPqXBHPomOQ2HoX8BZcfhU6eqO5idffx8NitV4JA5MjF5oCvOQqfNUE
         ZXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046092; x=1763650892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/SziGgu+jV7pu6XCcGhbgmOS9AguhsMW+n+l2AM6CI=;
        b=dtnhiufvmC1q6rbxxU+zqFOy5lBiKDNhlDrRCkqNTkVBJ/sN3QVZOVpRwdhqyd4eJO
         0OShca7if4bakF9Ci2SUz6iGdyP9xKDLNmmXEj83+6U0rYMaqT2MkxandCos3AMrS2Y1
         7lfm6gmDdaoh6Nuc26v+fDIkIKP6W7AEesSuvf3xbofUu7jmNTm6ZqibrEABJCbE1tej
         RUEVaN9WBnBbBNF+q8Hx8qETSpdgct3LYPPKFd17Zjk5qRqmYWfGnS8hCAsU6/+q5Q4U
         KjCO/2iwdO0icTPH7lR8fkiPiFO2iqmD/4uonn1U2Tsd27XePovRwPLR/VkiYbkuyBly
         JbDw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6Kt6XepUaaG1djm5l/z8j4C0fiVd2t0581Bja5kifWTYrP16bsj3c/bcGqafKjtOPKZ8lJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPOF2CTbU7QagHML4anUQqYHU5kPuGv8LTttzVU5Y/lRsusze
	3wxwmP2YAake0lxnWwMOdjZHz+OPRD2fY+ZO4P39jJ+av4sOP4zo0LgpV3O/mCHSYhrHM7j0B/X
	UcdUUfQ==
X-Gm-Gg: ASbGncvJc/hB60r9zat5X6an+EQ+MIRGS13Bfdbds03jRo0YbyzBdoiLN7tbLDKXvKI
	aqbOnAdPsepEAqr7qaxDJZ+OfArUv95xpsuZEOXP7V5lYfrd7yrhPzGwqaQhaX2+v60hxDAaZ8u
	Qx8sTfJno8Bf4JD9L6zaKn7NqA7PR6tvwICXrFNhpLJB9s+pzylvnRtUBhdc0b803zx94pIvktd
	2ejAghKUYt/CB2daPQ75xfI1/w5/gCqnuMrABsLaxAF8IJ8Nd2YEAuR7agmd56eAnFVf4gkrN7h
	3+bblUMJB/fDMgPvzGUAE1H4f7ko/kIGNAGjfpFfQWmwWbxHS5nio/30Yie0TOoLsAZ/TVucTTR
	/cawzsew09Zu1z9JZeZlBUDqNGTydS6Ak+bdimsvIRg3o9cvrenS/NDnLl8GSbuEi0SaVP+iYAJ
	o1RltVI4fGiAgtRcnK3s3c7tHTbJ8AuRhuYslWK9C/i64/pLR7HlgGW+8VYWqSLIV9khKKI08H/
	AZPxQx8OXd/AjKeJGHtGOq0uipvXf3tagkVCERVGYEKpyk=
X-Google-Smtp-Source: AGHT+IHdr8Ij45kQ70mHUK/k9cB73vb7jVTWb4ZvM7UlEaVt90l+E+NrBr9d5OiWsFGMZC1NA0oARQ==
X-Received: by 2002:a17:903:41ce:b0:297:eadc:3cd5 with SMTP id d9443c01a7336-2985c45434amr4335235ad.15.1763046091379;
        Thu, 13 Nov 2025 07:01:31 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f8asm28347325ad.37.2025.11.13.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:01:30 -0800 (PST)
Date: Thu, 13 Nov 2025 15:01:25 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Brendan Jackman <jackmanb@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-ID: <aRXyxWeh81-aTHaC@google.com>
References: <20251113034623.3127012-1-cmllamas@google.com>
 <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
 <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>

On Thu, Nov 13, 2025 at 09:54:37AM +0000, Lorenzo Stoakes wrote:
> On Thu, Nov 13, 2025 at 10:06:42AM +0100, David Hildenbrand (Red Hat) wrote:
> > On 13.11.25 04:46, Carlos Llamas wrote:
> > > Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> > > vars into struct") moved some of the operations previously implemented
> > > in uffd_setup_environment() earlier in the main test loop.
> > >
> > > The calculation of nr_pages, which involves a division by page_size, now
> > > occurs before checking that default_huge_page_size() returns a non-zero
> > > This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> > >
> > > Fix this by relocating the non-zero page_size check before the nr_pages
> > > calculation, as it was originally implemented.
> > >
> > > Cc: stable@vger.kernel.org
> >
> > Do we CC stable on unit tests? From my recollection, no.
> 
> Yeah please let's not.

Oops, I keep getting confused about this Cc stable thing. Please let me
know if a v2 dropping the tag is needed.

--
Carlos Llamas

