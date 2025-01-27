Return-Path: <stable+bounces-110919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF44A20155
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584281885F46
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 23:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAD1DAC95;
	Mon, 27 Jan 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XsWAPrX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D02AD1C;
	Mon, 27 Jan 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019057; cv=none; b=bIKu7l6Hq/f6aZuUpafbbbubdsK+vEp/SJj8r/yASLHp11xYnfEuOAVeftAXp06hiDAz9SKD4gphi3oAph1Qjb5U4N0wFweuFvRvoVpd62ULFOeYQ0zNKpD7w4OXF+0VuL4p+s3s6Aui6WCkt5FgprYghLqRyhB9GS+r5clVXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019057; c=relaxed/simple;
	bh=uVNDsHFhS/Z00h0YDHX4jxsFOnQKIB4Pp4MJrTUG3Sg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rZmqW76kYPYSTbfRU0d1ums4mS2iqalzwPIS7Hz4y66XqdomETGFxp9u9NDWgaMpl/t94iAC7gqIkN70u428yIxhX61WsFdH8vxQDhpryAAFck5C16qq52Gx3n5BJDuiZZlKtl1yixAqaTbNWrei3qGLqjy6be3xexSOLLPyiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XsWAPrX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E4DC4CED2;
	Mon, 27 Jan 2025 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738019053;
	bh=uVNDsHFhS/Z00h0YDHX4jxsFOnQKIB4Pp4MJrTUG3Sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsWAPrX1FWdMbgD1IubkRCk8QPqD5wz4ZD8jSAba0MtfCu+qysJOiW0upd7bTIyCb
	 Ght8zfo4wSt30oSO/HU16rKifbratUA0zlY3j5cFmhropouw5Piw2V2ep9WowROhvg
	 SqXKr3t6eQZ1zttDFYcPRZJ4O/tLT+CrtTX4ClNs=
Date: Mon, 27 Jan 2025 15:04:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
 baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
Message-Id: <20250127150412.875e666a728c3d7bde0726b0@linux-foundation.org>
In-Reply-To: <1737717687-16744-1-git-send-email-yangge1116@126.com>
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 19:21:27 +0800 yangge1116@126.com wrote:

> From: yangge <yangge1116@126.com>
> 
> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
> simply reverts to the original method of using the cma_mutex to ensure
> that alloc_contig_range() runs sequentially. This change was made to avoid
> concurrency allocation failures. However, it can negatively impact
> performance when concurrent allocation of CMA memory is required.
> 
> To address this issue, we could introduce an API for concurrency settings,
> allowing users to decide whether their CMA can perform concurrent memory
> allocations or not.

The term "users" tends to refer to userspace code.  Here I'm thinking
you mean in-kernel code, so a better term to use is "callers".

This new interface has no callers.  We prefer not to merge unused code!
Please send along the patch which calls cma_set_concurrency() so we
can better understand this proposal and so that the new code is
testable.  In fact the patch has cc:stable, which makes things
stranger.  Why should the -stable maintainers merge a patch which
doesn't do anything?

And please quantify the benefit.  "negatively impact" is too vague. 
How much benefit can we expect our users to see from this?  Some
runtime testing results would be good.

And please describe in more detail why this particular caller doesn't
require concurrency protection.  And help other developers understand
when it is safe for them to use concurr_alloc==false.


