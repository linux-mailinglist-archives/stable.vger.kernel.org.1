Return-Path: <stable+bounces-92034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5529C30EE
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 06:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A021D281E54
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E2149C47;
	Sun, 10 Nov 2024 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jn+UOAQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BF323D;
	Sun, 10 Nov 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731215532; cv=none; b=LJzvC5vzjAIohE3iaiH/4hnlMawRbV0lB/2XXNVzW7oWD/iuDeKlN5DPsR2tcPYwvO8YWnnoaUoWxRSWCiM7tG2NLJq9gyg0ZjeW8yGlvpRGC5LJTUQAA/pv5gWIQkB58RTcs8UVixFI/7aRxb7buM3xOiFPafpoaWe/sYbvYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731215532; c=relaxed/simple;
	bh=A3mqV6PHUB2URWifQ6V2Gc1bNiij55Y6N0KVYnFZYeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGT0YXk32V7CmjLqO3fBpvVkhgoPj/MMDik9PTYlMt0zICmFwkIGaBL1SxmhZIMGH3/JzRxmbI12eU+wIO83LXaA6/n9hIMX/JzEgWFNl3yIh/DCtB32zDCwI8gziofYff5g6OdZ8G5oLM2tATX1dDZwVtnUpb67SA/4CitZ7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jn+UOAQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61C4C4CECD;
	Sun, 10 Nov 2024 05:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731215531;
	bh=A3mqV6PHUB2URWifQ6V2Gc1bNiij55Y6N0KVYnFZYeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn+UOAQ3YEgKCcw6Te03lAx5vw3f+IuFQCy4c1jjhGDrlVQGHZJXy+dQWTJdVbEeJ
	 dhoubIn1shl49hkq1XmnLKuBZRvc9GLdHAJdbUUQ7MOA3BixUO9eOdyyNrPBjTsWMb
	 Mo+gZcYn6B/Kvo4znuUZ6cqX05fyrPXCCL9qB8Qs=
Date: Sun, 10 Nov 2024 06:12:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, mark.rutland@arm.com, namhyung@kernel.org,
	peterz@infradead.org, acme@redhat.com, kprateek.nayak@amd.com,
	ravi.bangoria@amd.com, sandipan.das@amd.com,
	anshuman.khandual@arm.com, german.gomez@arm.com,
	james.clark@arm.com, terrelln@fb.com, seanjc@google.com,
	changbin.du@huawei.com, liuwenyu7@huawei.com,
	yangjihong1@huawei.com, mhiramat@kernel.org, ojeda@kernel.org,
	song@kernel.org, leo.yan@linaro.org, kjain@linux.ibm.com,
	ak@linux.intel.com, kan.liang@linux.intel.com,
	atrajeev@linux.vnet.ibm.com, siyanteng@loongson.cn,
	liam.howlett@oracle.com, pbonzini@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH 5.10.y 0/2] Fixed perf abort when taken branch stack
 sampling enabled
Message-ID: <2024111029-gorged-humiliate-f0bb@gregkh>
References: <20241104112736.28554-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104112736.28554-1-xueshuai@linux.alibaba.com>

On Mon, Nov 04, 2024 at 07:27:34PM +0800, Shuai Xue wrote:
> On x86 platform, kernel v5.10.228, perf-report command aborts due to "free():
> invalid pointer" when perf-record command is run with taken branch stack
> sampling enabled. This regression can be reproduced with the following steps:
> 
> 	- sudo perf record -b
> 	- sudo perf report
> 
> The root cause is that bi[i].to.ms.maps does not always point to thread->maps,
> which is a buffer dynamically allocated by maps_new(). Instead, it may point to
> &machine->kmaps, while kmaps is not a pointer but a variable. The original
> upstream commit c1149037f65b ("perf hist: Add missing puts to
> hist__account_cycles") worked well because machine->kmaps had been refactored to
> a pointer by the previous commit 1a97cee604dc ("perf maps: Use a pointer for
> kmaps").
> 
> The memory leak issue, which the reverted patch intended to fix, has been solved
> by commit cf96b8e45a9b ("perf session: Add missing evlist__delete when deleting
> a session"). The root cause is that the evlist is not being deleted on exit in
> perf-report, perf-script, and perf-data. Consequently, the reference count of
> the thread increased by thread__get() in hist_entry__init() is not decremented
> in hist_entry__delete(). As a result, thread->maps is not properly freed.
> 
> To this end,
> 
> - PATCH 1/2 reverts commit a83fc293acd5c5050a4828eced4a71d2b2fffdd3 to fix the
>   abort regression.
> - PATCH 2/2 backports cf96b8e45a9b ("perf session: Add missing evlist__delete
>   when deleting a session") to fix memory leak issue.
> 
> Riccardo Mancini (1):
>   perf session: Add missing evlist__delete when deleting a session
> 
> Shuai Xue (1):
>   Revert "perf hist: Add missing puts to hist__account_cycles"
> 
>  tools/perf/util/hist.c    | 10 +++-------
>  tools/perf/util/session.c |  5 ++++-
>  2 files changed, 7 insertions(+), 8 deletions(-)

perf actually works and builds on this kernel tree?  That's news to me,
but hey, I'll take these now as obviously someone is still trying to run
it.

But why not just use the latest version of perf instead?

thanks,

greg k-h

