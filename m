Return-Path: <stable+bounces-208303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01732D1BAFF
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 00:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A69302B777
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82D3557E1;
	Tue, 13 Jan 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jTxaJJ24"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B727145F;
	Tue, 13 Jan 2026 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346575; cv=none; b=OBzW/EpLRDg++vpYrN3yqt6Wh1kT90jN2fp6Xgh0s1dnbs+IIVau42/hnYjvPDbUTgzJQULaC4e86kyWYccg+wemmTxWbyi8gUkYkR3TEHIIGAO4u53vuVOjnnxoABhcjwJZ41lrjdjkXohmRQIHPdcwoydEIAOUIls81attOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346575; c=relaxed/simple;
	bh=e71X0tIjU7zryKdUaL1J1tb5+Yoiu6mp6t3H2YfPClA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cFmOHCjnhUE08ptk2PwQZu1Pn59Vpy1xNONW1J5kyqPsgPuRRtT48rq6zltjE0nFJFr/VnnT5QUZIXXCc3bNox9wY6bKQfkZBHfRZzTHbL70p4lT8/skoE4hS27Y8nW6zGUj0BUeTZfyky+7Q7EPCBIhk9z8uSwCsGjTBhfV9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jTxaJJ24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1926FC116C6;
	Tue, 13 Jan 2026 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768346574;
	bh=e71X0tIjU7zryKdUaL1J1tb5+Yoiu6mp6t3H2YfPClA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jTxaJJ24ijFv/MNlUgUXfxgJFteRrTLE6DQOhP5HrCTGTvow3568VtcsEETBKNG0S
	 c/pRhjcEiBl8+ZWGaHP6IXAFCFAehz28ufYRNvJ4wSmWhTQpnqQj+jwoPlzCSTMVo0
	 I2SDBvXlIJi6GnmE7EO2aj5Z1abNXjU8KYGTlRqU=
Date: Tue, 13 Jan 2026 15:22:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, linmiaohe@huawei.com, jiaqiyan@google.com,
 william.roche@oracle.com, rientjes@google.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, willy@infradead.org
Subject: Re: [PATCH v4 1/2] mm/memory-failure: fix missing ->mf_stats count
 in hugetlb poison
Message-Id: <20260113152253.4438f2eece9d01c64888c25f@linux-foundation.org>
In-Reply-To: <20260113080751.2173497-1-jane.chu@oracle.com>
References: <20260113080751.2173497-1-jane.chu@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 01:07:50 -0700 Jane Chu <jane.chu@oracle.com> wrote:

> When a newly poisoned subpage ends up in an already poisoned hugetlb
> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
> is not. Fix the inconsistency by designating action_result() to update
> them both.
> 
> While at it, define __get_huge_page_for_hwpoison() return values in terms
> of symbol names for better readibility. Also rename
> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
> function does more than the conventional bit setting and the fact
> three possible return values are expected.

Thanks.  This looks rather different from the previous version so I
moved it to the tail of the mm-hotfixes queue for additional
test/review time.

