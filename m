Return-Path: <stable+bounces-192305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CECEC2F093
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 03:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318F13B9872
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CA325FA3B;
	Tue,  4 Nov 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HkBDPEAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637125F995
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224970; cv=none; b=IBMX2fX3wHukfHAQTelXwC8KTa+MwJMxavLfzswi6YdWPvZyVotymT1mV7ZohqSaZWNXhuacTlUkCckWtLKtfVYch7s5sTD64PksCnPI6tzNGtXMRwxqVo+Irwx6vezMs64zl3ps/TXVCm+CcIoHkU8fhwdG5M6zZjDa8IsF9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224970; c=relaxed/simple;
	bh=e1ksvYvy9wyyXuqNDd90pTrqbGM9/wp01OAnJwOLx+c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S+lI3QwGp7Z/HNxW8Dv1kHX/tv2/ozwnjRB3CSIyppw7ViF0LxYBj/65WxdL5lwBtJkF4MKoE6iX0Ublu0tSD3NSZeCyGTW2TI+stZBxVYkme7Ma3hq73UTWRFsOOI4g89oLoyN/76HbmptoGF0mek6id+GuzsL9oyrJAE3oA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HkBDPEAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A21BC4CEE7;
	Tue,  4 Nov 2025 02:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762224969;
	bh=e1ksvYvy9wyyXuqNDd90pTrqbGM9/wp01OAnJwOLx+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkBDPEAQOXrI3Gg9U2MfFvNROwTs4e6c15CvvnNlWvp6OmG+UR75ihDJP59ErhLj7
	 R3isc3ieoRdKgC/5CYH2t2H35OXUcMtE3LKn+ohLi7NxMu92fyg0Qx0r/ishxE0Ya8
	 coOlaNJScPuqfe0nULrIHQPszOF4l1pCP02wjz0M=
Date: Mon, 3 Nov 2025 18:56:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song
 <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li
 <chrisl@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages
 decrement in get_swap_page_of_type()
Message-Id: <20251103185608.84b2d685fe0ae4596307b878@linux-foundation.org>
In-Reply-To: <20251102082456.79807-1-youngjun.park@lge.com>
References: <20251102082456.79807-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Nov 2025 17:24:56 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> After commit 4f78252da887, nr_swap_pages is decremented in
> swap_range_alloc(). Since cluster_alloc_swap_entry() calls
> swap_range_alloc() internally, the decrement in get_swap_page_of_type()
> causes double-decrementing.
> 
> Remove the duplicate decrement.

Can we please have a description of the userspace-visible runtime
effects of the bug?

> Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
> Cc: stable@vger.kernel.org # v6.17-rc1

Especially when proposing a backport.

Thanks.

