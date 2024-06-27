Return-Path: <stable+bounces-56012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D491B2CC
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE605281FD8
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50B1A2FC1;
	Thu, 27 Jun 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UgfuzvJA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57761A0B1F;
	Thu, 27 Jun 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531164; cv=none; b=IMseFS0UfEYFiGLnwMOja75H3PuDMVU+saAKrvBMq4hM+DYvPQROYIarHjKqWqTuBgyfxSPD/28jCd18zJeNrdLSoNKj0Ol6dpFJtk2/Z1nX4Sa2W7OqZMkO+5I9I9rV41mbMDD5qxGXKQMSAhAoI+shY3Dzy1vUiSJ21J/FszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531164; c=relaxed/simple;
	bh=9dB+rvGb2K0CHL70NwGvy0XkmnZPJsRSLm8vafDWJ6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MjvbcuRN2dLfo3PEtIveHWQQcZpEk8mMmeNSQ7skSSeISm+Xs4Ek7kbs/vnxTO4+h3vgkXvQ8TzK4Ff7JKS6BnFqV2Qet0BNZbICnpiywhWpc0mDeBXfp8lKjWZeWheD/q2uOWOLmL567ZuKwYGfS6ltwFo87ixz2O66iVM0Oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UgfuzvJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288CDC2BBFC;
	Thu, 27 Jun 2024 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719531163;
	bh=9dB+rvGb2K0CHL70NwGvy0XkmnZPJsRSLm8vafDWJ6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UgfuzvJATgMXu9jg/0qc26PjyHiJisgzgmjJPG1ueIoegr8R6ylVc+dRzgCChHDaS
	 ryFJFpTy5dZjVSmbEo2qN1YrW85+TCE2kYy8eVb2zz633m7Pt15GdTegVnEuC0KWq1
	 O4AjOtDEIFUxnaCORLbKBJAp+G9RNz6xsMp4UB9E=
Date: Thu, 27 Jun 2024 16:32:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, yangge1116@126.com,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-Id: <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>
In-Reply-To: <Zn3zjKnKIZjCXGrU@x1n>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
	<Zn3zjKnKIZjCXGrU@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 19:19:40 -0400 Peter Xu <peterx@redhat.com> wrote:

> Yang,
> 
> On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
> > The try_grab_folio() is supposed to be used in fast path and it elevates
> > folio refcount by using add ref unless zero.  We are guaranteed to have
> > at least one stable reference in slow path, so the simple atomic add
> > could be used.  The performance difference should be trivial, but the
> > misuse may be confusing and misleading.
> 
> This first paragraph is IMHO misleading itself..
> 
> I think we should mention upfront the important bit, on the user impact.
> 
> Here IMO the user impact should be: Linux may fail longterm pin in some
> releavnt paths when applied over CMA reserved blocks.  And if to extend a
> bit, that include not only slow-gup but also the new memfd pinning, because
> both of them used try_grab_folio() which used to be only for fast-gup.

It's still unclear how users will be affected.  What do the *users*
see?  If it's a slight slowdown, do we need to backport this at all?

> 
> The patch itself looks mostly ok to me.
> 
> There's still some "cleanup" part mangled together, e.g., the real meat
> should be avoiding the folio_is_longterm_pinnable() check in relevant
> paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add()
> not try_get_folio(), and renames) could be good cleanups.
> 
> So a smaller fix might be doable, but again I don't have a strong opinion
> here.

The smaller the better for backporting, of course.

