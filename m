Return-Path: <stable+bounces-152491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D5AD6466
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84389175EB8
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 00:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D0C2E0;
	Thu, 12 Jun 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nMz0+N96"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAF11CA0;
	Thu, 12 Jun 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687592; cv=none; b=Ghgx8qMLkN75WdzmIXJZhm2VbihTzAeqGJPz76kpU2v+aLOZdXJbEdHRzDz/1Fez82+5Nc4MN70nx8mWgBAV9qZTDxl/taa/J/2X9P4s/YzpjPnUAn8lgBMClTqjhkeeCjjHjaPagc9ulSHUY8/kO48Rj2Bt+vHmod1106ef1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687592; c=relaxed/simple;
	bh=VZqOpPmT4TvdLJ2ytMBmjSVSDf6chMQN9Xwv8DyGtDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KJAA497fKwiqx5LNFLv92CaGO/n1vwbfIhDmHd2zdWqVj3mjRGBr4auAdABCG4rEPOtsevonRjcuIivEw+wSXDEuyKNoOFXC84mXkuM3SExDuI3hYB6EecSUbFXn/LpIJiVLgre2rofoIN6EM8wFpLFC5REXidxJLHuR02m0t98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nMz0+N96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD21C4CEE3;
	Thu, 12 Jun 2025 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749687591;
	bh=VZqOpPmT4TvdLJ2ytMBmjSVSDf6chMQN9Xwv8DyGtDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMz0+N96ip5jDNcW5D7tFlS/EcACY8E6gFUYn28kyxMnHSAwC12q3wo7xFCjnDqoe
	 wLuAFuzSwvjWR/aiU/js5BUQ5glu3K5yC+qX5L4Iu/4QK2MH7Ceh5f0QX3hHZTCNWV
	 hZ/OCcB4Ltzt1tLPIYv4F5n1yt/SQpZd04Ms/QWM=
Date: Wed, 11 Jun 2025 17:19:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, Barry Song
 <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, Suren Baghdasaryan
 <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, David
 Hildenbrand <david@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and
 swap cache
Message-Id: <20250611171950.5cb2d563c2935a93f5c7bbc0@linux-foundation.org>
In-Reply-To: <CAMgjq7BhLdQNKs7aT1Eopvgdwug3qEU4tP7xgj4VTjHBE36dPA@mail.gmail.com>
References: <20250604151038.21968-1-ryncsn@gmail.com>
	<CAF8kJuPoJrYu30YPqze7oSPBm0qJ1Qutpw3=cQMQeSmboGnQKg@mail.gmail.com>
	<CAMgjq7BhLdQNKs7aT1Eopvgdwug3qEU4tP7xgj4VTjHBE36dPA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 13:16:25 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> This commit fixes two kinds of races, they may have different results:
> 
> Barry reported a BUG_ON in commit c50f8e6053b0, we may see the same
> BUG_ON if the filemap lookup returned NULL and folio is added to swap
> cache after that.
> 
> If another kind of race is triggered (folio changed after lookup) we
> may see RSS counter is corrupted:
> 
> [  406.893936] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
> type:MM_ANONPAGES val:-1
> [  406.894071] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
> type:MM_SHMEMPAGES val:1
> 
> Because the folio is being accounted to the wrong VMA.
> 
> I'm not sure if there will be any data corruption though, seems no.
> The issues above are critical already.

Thanks, I pasted this into the patch's changelog.

