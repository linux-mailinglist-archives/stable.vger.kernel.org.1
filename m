Return-Path: <stable+bounces-124867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B40A680ED
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 00:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860DB16E1F5
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2364209681;
	Tue, 18 Mar 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a8U8Q71/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F01DD0D5;
	Tue, 18 Mar 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342022; cv=none; b=J2AEsUfS3bSpO365UlwOmfpNSpIJVbrXe80ItyRSNR+anmlWWmxLH2WnmNABjiZi+KpYtohPG0HdZXwQixw0E7b4Mk27PFRybOFlQZX9aTn8qE1/tc9rp9FavhRyvKvCAClh/eR41F04cyxbciSM1ChQvDLBpoMaAQS4hsxS2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342022; c=relaxed/simple;
	bh=NVf4gY837bXDZ5MUvzQ0r1SFMk8d1gkn1QaLlqmi7fM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EF/AtzrJbTJ4xbdApAwTg2yZ0hUWVd1NZQA4RMjP7g4hRVmt0LAfcAeErkcr+uAaKfCI02aFjCV/N6je9lfvii4vRM4P9w+rEP64ltr7tAZYOxZcuxpB2MUjnT8+ol2tHEVXuS2/TPJhAn3pLADqTrdaDDC7r4BnLqcBwpYrJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a8U8Q71/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4295C4CEDD;
	Tue, 18 Mar 2025 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742342021;
	bh=NVf4gY837bXDZ5MUvzQ0r1SFMk8d1gkn1QaLlqmi7fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8U8Q71/911bdd71b88DWxLSWQ5+lnPiNum3mzq09Z/B0A95BZCDBFIRkeiCYNWEm
	 ztDwiPjnNf03GimmKyl8b48fv8BDq8txxR8J7F5G5Zn4Q0IhiwhZV8SfpWKvOobEOH
	 vPU7/Jr4aLSkHSH7Mkcr4EuCjQkO301SbZsNonBY=
Date: Tue, 18 Mar 2025 16:53:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org
Subject: Re: Patch
 "mm: shmem: skip swapcache for swapin of synchronous swap device" has been
 added to the 6.13-stable tree
Message-Id: <20250318165340.bd86004687ceceb03cccfe7c@linux-foundation.org>
In-Reply-To: <850f7c3f-26f6-9d60-ac46-ccaf20661cf6@google.com>
References: <20250318112951.2053931-1-sashal@kernel.org>
	<850f7c3f-26f6-9d60-ac46-ccaf20661cf6@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 08:28:44 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> >     Cc: David Hildenbrand <david@redhat.com>
> >     Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> >     Cc: Hugh Dickins <hughd@google.com>
> >     Cc: Kairui Song <kasong@tencent.com>
> >     Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> >     Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >     Cc: Ryan Roberts <ryan.roberts@arm.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Stable-dep-of: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> No, NAK to this one going to stable.

Permanent NAK to *any* mm.git patch going to stable unless that patch's
changelog has an explicit cc:stable.

Why did this start happening again??


