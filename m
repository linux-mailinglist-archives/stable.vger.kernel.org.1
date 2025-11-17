Return-Path: <stable+bounces-195001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B49C65924
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53AC9351983
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AE304BB7;
	Mon, 17 Nov 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcT5GEj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A383019A6
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400699; cv=none; b=oUHJ8pv+FdGZkac3NBiYKI9fPiz362lObAydQuOq5PYy7gRZzXquvz8URzKxPXlFmwDfujkbN4WMHa7Jlja7jBVJ89HquXOHlgTeV6BayZc/HNgi7wK7n/LqCKWTMKm22+E9T1Ryt24JLyfNVGcz2/R97uza7h1cZT2r94ESwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400699; c=relaxed/simple;
	bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmrwx2w9TA/01ybCtd6NiYwoaPhJP31bAEJVKTVF+6CUNB5HH3sWBd6MnTPqA1+IxHERK8mjU+dN8ukqwVVVqEybDaJUVrXa3w/JLyH0EHbdySUJ1JA+BaBe+O3436liU5TfltfSUrSwcoPgrVyQ5k/W4zAhe/I1gsp0Iw7o2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcT5GEj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so234975a12.1
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763400696; x=1764005496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
        b=BtcT5GEjHAi82OkM7vnyPINxTKMwDZ++r5ATRIEObYT4pT/+Ax8pZRr2WtiXpICVJ1
         K3Iv9bZOWyOOISAI1Q1A5q1o4NZ8FwN2th1ci5lx9PVJWa9rHkx5OQ2kyWBi+6r3VSGx
         M+KtkdiqQaNI/IR3coe7n/dLAcOTb83fk85ClADrK5JD/nRWC4tFGfi5mYVBhOl/bZox
         XUk2sjISJb1M1dqG5QE93IWX+Bqwru4pEPRX6wFlJATOZcc6LIY3ZZKQMrIhNVFF77uo
         ahzMkpbLS8mjfnd9GfREqny+kGY+H8A2z/UX+MQ9YtJnKpLHC9y7+GEiu5WmZXGYGrUN
         yvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400696; x=1764005496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV7KJq3JWbWy4X8KgHXwI0VdrSU307t+6yjEnmz/ZNg=;
        b=Zwzjs5mBDBSN5SGqSuCdU/zVbNd82NmUY6bH5/D3eSJnViTNRh1X/POISmLgg3V9SA
         ChKwobgkl221VmTDxjBKrqPxJZfdqHJgy0Mhcpev+WxZko1Igwiw7uMi+5uUU5rqgknJ
         CLwl1iBZSQ1r68NY+sV71Ial8LxayC2SKp4MFKDUa8R+7kfOp1SRBC5lumJPPRgwWvPN
         Z6TfHKmXiR230qyGYunp9n/OQaLYqJnxHjhplU19rTEfgAjdQjhV5bMSV3zQ4V89lJB0
         kMb26xEfyQbKyEBrszyOO7uS4r2SLBQLwCzLEw5r84lGWxfSUt7n7mWjQAXBdfNjvr9R
         uuxw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0iR2rqm/srXpL6ZroORTOSdcdzFL341rt4yAtollqrZGENtJ0M3pUy/RZnbDSWFASXQEEkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobO83TrN/zEk/acFvnVxuEit+NScW7WX82LIDvwVXRF12XJCT
	vkW0YQuzNO4ynJBLDWGZFfcTYb5TaccZhNgFbw3kkKqHJoqXqyO4y6zymqsdFuCJ9ioaUmVZEyg
	293LgsgUwbetXZTu01ag32H2xOoqYIQ==
X-Gm-Gg: ASbGncvcdU9+1fygXp8NM0q7mQtdTSbkh4TuI49IJZqteXovPeVETpumAqNVZ/MBQ+K
	3SDIEZaneFdi3KVypaAXa2sTTzS8BM3PCNf05HzasohXz5oE7cTa7ovTGFOAnoPs+r7CB4VDOSA
	NEolCqtgBapdtq1VadJ/4RfTyxOguQufz7k0cquUJHZaC5a4xLj2U67xaqDZPNVjlKN+751USGo
	Rk37JURR6HLlTnSrIizxySQD9xRECMfYv7vUnc720Wqcdc8wHQ1GEX7F5Q=
X-Google-Smtp-Source: AGHT+IFVNP2uP6Q0JshZHVUTd8X1+5WDmG7OavAZHYwuqKhkIu2hA2v7ot1RIcdD+T6gGeIwMDW97WO+/8hkBclFsrk=
X-Received: by 2002:a05:6402:5112:b0:640:a356:e797 with SMTP id
 4fb4d7f45d1cf-64350e2092amr11284922a12.13.1763400695483; Mon, 17 Nov 2025
 09:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113034623.3127012-1-cmllamas@google.com> <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
 <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local> <aRXyxWeh81-aTHaC@google.com>
 <b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local> <20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
 <9d30836b-9ddb-4432-aa39-85e32c2ea645@kernel.org> <20251114143909.14ecee31b88f179bc2858e30@linux-foundation.org>
In-Reply-To: <20251114143909.14ecee31b88f179bc2858e30@linux-foundation.org>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 17 Nov 2025 23:01:22 +0530
X-Gm-Features: AWmQ_blYT_0n6-EoSgb5vkK1TfvHayH6Eh8aX8bnaH1niORp_lD21yGSPt8taXc
Message-ID: <CALkFLLJP7J7fUsUuo2TYseeDd+4JeC8pqJN9PwfhKFS3jd-TFQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Carlos Llamas <cmllamas@google.com>, Peter Xu <peterx@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> vars into struct") moved some of the operations previously implemented
> in uffd_setup_environment() earlier in the main test loop.

> The calculation of nr_pages, which involves a division by page_size, now
> occurs before checking that default_huge_page_size() returns a non-zero
> This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.

> Fix this by relocating the non-zero page_size check before the nr_pages
> calculation, as it was originally implemented.

Thanks for the fix! I never tested with CONFIG_HUGETLB turned off. We
now need tests for tests :)

Reviewed-by: Ujwal Kundur <ujwal.kundur@gmail.com>

