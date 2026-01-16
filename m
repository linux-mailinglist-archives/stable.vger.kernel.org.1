Return-Path: <stable+bounces-210116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C985D387E4
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFC64301D67D
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A130275F;
	Fri, 16 Jan 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YF2dio7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B32F0C7A;
	Fri, 16 Jan 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596351; cv=none; b=V6XggHa2J+dXkku0bA5/ZnyXkWSW5sQY0vXL/M+ZEMaq4VjW4WnT8ZXJc7fX+SewcTZPGzDP5oOUZmx9cz/8OE8iS1yYgeuvN2UHes/gzfGwsfPa+70MAkWeG6qA1uq/E1Z4x1lHvVfRuHXUZhe+99Iqtp0uZdq940jLhNI7Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596351; c=relaxed/simple;
	bh=bOImlsGNmjiPGX0PpDpbExJLn8/h6ObYP4NuVrw+4UQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FaEQwashcG5gs/du6OmUHoqqy1czn5xj5cIKw32mPxnCQzhISY1AGURDa1qogySzbRaxp2PiScCJZ2x27S4e0+AXPmHmEqdqGhzx5SsFHSoz8iRSvQAAQfAYawbuEHt006hECAaSsuWkGTawfbZRKx0q0GVJiSBkGdNZ+guoQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YF2dio7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A21C116C6;
	Fri, 16 Jan 2026 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768596351;
	bh=bOImlsGNmjiPGX0PpDpbExJLn8/h6ObYP4NuVrw+4UQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YF2dio7IHemM0ABIjiE+Gmc0RLoPr8rGsHC06ooOYb2vRssBLtSsfT9QKrfvsDfoy
	 g5Q+HjnVbPhcy12AgAvivvkzBTM/1NAaEvemOOVH5Tvdf7rNN25h5UsiSmxGZIdIRw
	 iMAaeAtaWAuqipCFRipaXp+6WHrVnEhanUctQxyQ=
Date: Fri, 16 Jan 2026 12:45:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, willy@infradead.org,
 sj@kernel.org, ranxiaokai627@163.com, ran.xiaokai@zte.com.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Docs/mm/allocation-profiling: describe sysctrl
 limitations in debug mode
Message-Id: <20260116124549.db884e094f093340c63aafbc@linux-foundation.org>
In-Reply-To: <20260116184423.2708363-1-surenb@google.com>
References: <20260116184423.2708363-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 10:44:23 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> When CONFIG_MEM_ALLOC_PROFILING_DEBUG=y, /proc/sys/vm/mem_profiling is
> read-only to avoid debug warnings in a scenario when an allocation is
> made while profiling is disabled (allocation does not get an allocation
> tag), then profiling gets enabled and allocation gets freed (warning due
> to the allocation missing allocation tag).

Cool, thanks.

> Cc: stable@vger.kernel.org

Documentation/process/stable-kernel-rules.rst tells me that -stable tree
users prefer incorrect documentation ;)


