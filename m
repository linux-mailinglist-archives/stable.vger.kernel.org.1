Return-Path: <stable+bounces-148088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEEAC7D46
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEDC1BA1466
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C82749F3;
	Thu, 29 May 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyCRAU/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CE1F7075
	for <stable@vger.kernel.org>; Thu, 29 May 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518758; cv=none; b=pcRk7PKEkkai0l0Nr2euhk/f5A6Z9mtT+cZ7uJHdDOD9H1kQ6xD2LVk9N43qyULONQTt2IjSW0aHiGNfVcNXJrj/dT0SWH7FhHgvKzbfiVgUxRJeENr9fjxvFarHYSm5yVe3LLBT5q/cqKZkgKUkK3ulB5SDsxxvjr2lGfxdB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518758; c=relaxed/simple;
	bh=2R1BhhiAHINoDPG5WaOcIHYwHSWWcMxdfpQJFlY36bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxREACOyn+82W5DtHcBx8rxRk48WGCukpJVqpCAAJsMFA/t3z3V0ClMgLX9F7w4F1Owu0dEk2odA7riz8JrK9hcZpdyDG5wjE5FYqZj0Elf0CLQkceCiXY+9IwFcZ9xr3MwNx0KIfKqsCcLTojzFD1SXYG/sAiTRU65mAb3ui5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyCRAU/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1D6C4CEEB;
	Thu, 29 May 2025 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748518757;
	bh=2R1BhhiAHINoDPG5WaOcIHYwHSWWcMxdfpQJFlY36bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vyCRAU/Ey7JlfmwgtIdkxOSMCSuL3P44hSIz21UD7d3LhvhPuRqBemBOzJmIhlwkq
	 JtoETrtr31f13Ty3/aRzRVIr4sBDD3Ldev+OXu+tGKUJK59tHmraREwsIXWXIwPr4T
	 vezxDfEtv19um4R9vdhJyVSY1EvL81kxQvdJ9GSE=
Date: Thu, 29 May 2025 13:39:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wndgwang4 <guangming.wang@windriver.com>
Cc: stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	Zach O'Keefe <zokeefe@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] selftests/vm: fix split huge page tests
Message-ID: <2025052957-recolor-upward-a8a3@gregkh>
References: <20250528085440.818430-1-guangming.wang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528085440.818430-1-guangming.wang@windriver.com>

On Wed, May 28, 2025 at 04:54:40PM +0800, wndgwang4 wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> [ upstream commit dd63bd7df41a8f9393a2e3ff9157a441c08eb996  ]
> 
> Fix two inputs to check_anon_huge() and one if condition, so the tests
> work as expected.
> 
> Steps to reproduce the issue.
> make headers
> make -C tools/testing/selftests/vm
> 
> Before patching:test fails with a non-zero exit code
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test | echo 0
> 2
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
> No THP is allocated
> 
> After patching:
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test | echo 0
> 0
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
> Split huge pages successful
> ...
> 
> Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
> Tested-by: Zach O'Keefe <zokeefe@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: wndgwang4 <guangming.wang@windriver.com>

We need a real name for a signed-off-by line, you all know this :(

