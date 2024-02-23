Return-Path: <stable+bounces-23498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA5861637
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B57B22D96
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AC82C71;
	Fri, 23 Feb 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krTf4d+i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF387405C7
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703220; cv=none; b=BonoYT2Zrz0CGvxEUOoGX5icrjy+h8XiTJhyzH//+wkUiNkx6l31bToSjMh+2sCMkNgfZNS4RcW9fOQ/9LVPIURyDG57BPPgvcqtAjXfVmqTuouvMFdcgF5o88ClYHKc2FtQgS62dkGrjKkWQa7Izcfod73o9EUDVuOt5ST2MeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703220; c=relaxed/simple;
	bh=PqZePJECrkJent6xvcdyAH8QxPot4BxkQNPtsU706/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXtjs/GzAy8jcbcWxdTQLz3f2e4WJvTovnCn8NXHA+2hLL7RnaCO6zhWZisO7+g8GaMKuLTJFC8LyALj8Ky2+V6UrqOhlMwWzPjqD9H/fhsQBIFsomeQm/HJ1jtifv2NFDwSmoPNAlIolFLnpgCSIV8B3gbpDlmYuIb4kftmeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krTf4d+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2385BC433F1;
	Fri, 23 Feb 2024 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708703219;
	bh=PqZePJECrkJent6xvcdyAH8QxPot4BxkQNPtsU706/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krTf4d+iNezB/TtqLhDjXVikf7SZ+fNLi0xxJ+kXZgDu3SrK03h3KUlfzC6CkL0N6
	 1C2VhC1+hq5xY6sidGlQRslbw5dn3R/sx7hJmpfB0xhp82uKn6mM5UHFcZBhbosv0U
	 969Dm3b4RvmXadKj6ss6+CLAj4haEMCZXtuCCub8=
Date: Fri, 23 Feb 2024 16:46:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ["PATCH 5.4.y"] userfaultfd: fix mmap_changing checking in
 mfill_atomic_hugetlb
Message-ID: <2024022345-deserve-upright-22a6@gregkh>
References: <2024021850-vaseline-mongrel-489e@gregkh>
 <20240219152802.394860-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219152802.394860-1-rppt@kernel.org>

On Mon, Feb 19, 2024 at 05:28:02PM +0200, Mike Rapoport wrote:
> From: Lokesh Gidra <lokeshgidra@google.com>
> 
> In mfill_atomic_hugetlb(), mmap_changing isn't being checked
> again if we drop mmap_lock and reacquire it. When the lock is not held,
> mmap_changing could have been incremented. This is also inconsistent
> with the behavior in mfill_atomic().
> 
> Link: https://lkml.kernel.org/r/20240117223729.1444522-1-lokeshgidra@google.com
> Fixes: df2cc96e77011 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Nicolas Geoffray <ngeoffray@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 67695f18d55924b2013534ef3bdc363bc9e14605)
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

All now queued up, thanks.

greg k-h

