Return-Path: <stable+bounces-144290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10C3AB619C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84181B4463C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F41F4177;
	Wed, 14 May 2025 04:33:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D11F1921;
	Wed, 14 May 2025 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197223; cv=none; b=ODyMIGlT3kEcxaYebtYv1LxljH4y1tV5jVzZ66Scccrx0NJdGmphhEg65iqYDhU0unKYbmReUK1uzCyUqkzD0agNnSU+FMZft7Np5Efq3c3c4znWDfRYEJNqtIlvZcxLJEs11C9JNFYMM8yc4leiv0Y8CpO+P+s09H+qvC3C4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197223; c=relaxed/simple;
	bh=A6RnKORevZid870HTtZcCFA2jySe9hzw8ZnSSBzZ4sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0rUH/0VL7hqqg5i+tFJW0/ieAsGsQkoUudW5yX7m239ZTfhxP3YupcUa/wcJkKSpTuCtom2dQsgC6H6jZDmKak/l7ZVSi73neEXadj+QuQZy1STPsCI5LhBChF0lUrI+f6JqZlc4Omc5o3lphcWmxS2DfzF81ojuPwNmguBRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-77-68241d1cc1f5
Date: Wed, 14 May 2025 13:33:27 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	osalvador@suse.de, kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>, kernel_team@skhynix.com
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <20250514043326.GA4318@system.software.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
 <20250513175633.85f4e19f4232a68ab04c8e41@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513175633.85f4e19f4232a68ab04c8e41@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsXC9ZZnka6MrEqGwdXnohZz1q9hs1iy9gyz
	xctd25gsnn7qY7E49+I7k8XlXXPYLO6t+c9qsWznQxaLM9OKLLpn/mC1WLDxEaMDt8eCTaUe
	E2Z3s3ls+jSJ3ePEjN8sHgsbpjJ7vN93lc1j8+lqj8+b5AI4orhsUlJzMstSi/TtErgyLv/o
	YSroFK64fm0XUwPjH54uRk4OCQETia5Jz9lg7Ja+tWA2i4CqxMebD1lAbDYBdYkbN34yg9gi
	AroSq57vArK5OJgFNjNJ9LbvAGsQFkiRuHZgG1gDr4C5xK6Vu5lAbCGBKol/k1qg4oISJ2c+
	AbOZBbQkbvx7CVTDAWRLSyz/xwES5hTwlvh9ZyUriC0qoCxxYNtxJpBdEgK32SSmTNzBCHGo
	pMTBFTdYJjAKzEIydhaSsbMQxi5gZF7FKJSZV5abmJljopdRmZdZoZecn7uJERgdy2r/RO9g
	/HQh+BCjAAejEg+vha5yhhBrYllxZe4hRgkOZiUR3utZQCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2Mrlsm3X9+Y5WfEJ+39KFODW//xj8mz78rr/my
	cLbZYxPtba/U1XsXy2zX5WEwSTNZzHdKzH+ua/7iCPtJM/mWs76fJVpQMaWv5FH+9fina5W3
	dCxyv+rH5rRipegxI9nI6WrXzDjWi9x9kZ/51WzzQytrpQXP/W9U77bQXdsziZd54h/haIdT
	SizFGYmGWsxFxYkAEwi5WIoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC5WfdrCsjq5Jh0Lqe22LO+jVsFkvWnmG2
	eLlrG5PF0099LBbnXnxnsjg89ySrxeVdc9gs7q35z2qxbOdDFosz04osumf+YLVYsPERowOP
	x4JNpR4TZnezeWz6NInd48SM3yweCxumMnu833eVzWPxiw9MHptPV3t83iQXwBnFZZOSmpNZ
	llqkb5fAlXH5Rw9TQadwxfVru5gaGP/wdDFyckgImEi09K1lA7FZBFQlPt58yAJiswmoS9y4
	8ZMZxBYR0JVY9XwXkM3FwSywmUmit30HWIOwQIrEtQPbwBp4Bcwldq3czQRiCwlUSfyb1AIV
	F5Q4OfMJmM0soCVx499LoBoOIFtaYvk/DpAwp4C3xO87K1lBbFEBZYkD244zTWDknYWkexaS
	7lkI3QsYmVcximTmleUmZuaY6hVnZ1TmZVboJefnbmIEhvqy2j8TdzB+uex+iFGAg1GJh9dC
	VzlDiDWxrLgy9xCjBAezkgjv9SygEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU
	7NTUgtQimCwTB6dUA2NooEmhb5/RyfvpRRLu6qVdkzrX7C+e3Lr92NmNfF78HfktVy03c+3M
	DE6+3x+/Icb+2q2pWqY3vjllTDonaTTt8Y/zsWIzM2Q3H73vpnHv1KIPdh8K3CYenxymNMPq
	CNPbsI45LDvsE/6Y/P30yURy4spZT58t3F3nbTJ/sVe8nqDmso9zu5mVWIozEg21mIuKEwG5
	eAQ7cQIAAA==
X-CFilter-Loop: Reflected

On Tue, May 13, 2025 at 05:56:33PM -0700, Andrew Morton wrote:
> On Tue, 13 May 2025 17:34:48 +0800 Gavin Guo <gavinguo@igalia.com> wrote:
> 
> > The patch fixes a deadlock which can be triggered by an internal
> > syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> > [3] in this scenario:
> > 
> > Process 1                              Process 2
> > ---				       ---
> > hugetlb_fault
> >   mutex_lock(B) // take B
> >   filemap_lock_hugetlb_folio
> >     filemap_lock_folio
> >       __filemap_get_folio
> >         folio_lock(A) // take A
> >   hugetlb_wp
> >     mutex_unlock(B) // release B
> >     ...                                hugetlb_fault
> >     ...                                  mutex_lock(B) // take B
> >                                          filemap_lock_hugetlb_folio
> >                                            filemap_lock_folio
> >                                              __filemap_get_folio
> >                                                folio_lock(A) // blocked
> >     unmap_ref_private
> >     ...
> >     mutex_lock(B) // retake and blocked
> > 
> > This is a ABBA deadlock involving two locks:
> > - Lock A: pagecache_folio lock
> > - Lock B: hugetlb_fault_mutex_table lock
> 
> Nostalgia.  A decade or three ago many of us spent much of our lives
> staring at ABBA deadlocks.  Then came lockdep and after a few more
> years, it all stopped.  I've long hoped that lockdep would gain a
> solution to custom locks such as folio_wait_bit_common(), but not yet.
> 
> Byungchul, please take a look.  Would DEPT
> (https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com)
> have warned us about this?

Sure, I will check it.  I think this type of deadlock is what DEPT can do
the best.

	Byungchul

> >
> > ...
> >
> > The deadlock occurs between two processes as follows:
> >
> > ...
> > 
> > Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> > Cc: <stable@vger.kernel.org>
> 
> It's been there for three years so I assume we aren't in a hurry.
> 
> The fix looks a bit nasty, sorry.  Perhaps designed for a minimal patch
> footprint?  That's good for a backportable fixup, but a more broadly
> architected solution may be needed going forward.
> 
> I'll queue it for 6.16-rc1 with a cc:stable, so this should be
> presented to the -stable trees 3-4 weeks from now.

