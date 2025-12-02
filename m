Return-Path: <stable+bounces-198096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BCC9BEBF
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2834845A
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1023D7EA;
	Tue,  2 Dec 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+VyfNuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762F13D891;
	Tue,  2 Dec 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688722; cv=none; b=sGTPkENOcDQrOnqq1ps0syUQF8ZlffS0EnRid3QHUkh21Tgo0Pa9xTFk4Cz7b8fzD3KkK26Ah2ePkrR/ckM3k+JIb7kj8YmmS5LPQ0D0qciWjKlxZFr1DnBrWlFlLwH6N4XQfVvG/jylOe4kuwqqV737eUJ+N3dHGr+uiAXPInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688722; c=relaxed/simple;
	bh=qbmJH+Y6AaiUoxrlO1VOQ4qf+8ySubPcHBqOgEH9sTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUehxpUvibFU7BXyVM/CHPOhMAv84UdohxunTnTCDG7Yu9MUCcHyvA1mkZutAvMP5OQW9cz38/RK9xOWSZ6fDAOO4QYMZIW44SIThj1w863WVgpLTul3xRjxQZ2IPTrVNjB3C330B0ylwhn6KnfuryZDdz1Z+DjPj/uzGzR6W44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+VyfNuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D2C4CEF1;
	Tue,  2 Dec 2025 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764688722;
	bh=qbmJH+Y6AaiUoxrlO1VOQ4qf+8ySubPcHBqOgEH9sTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+VyfNuOQXhNnh9z9Eq1KT87Xznzivxq1E2aHhiICcVoSWu3zLION/YJzd4r7BLcQ
	 v2R0+slolfoPx7rReLYlx+1KwOBwGMlOmc3c8ESbgPlGe59ONOSEwOeCsrfMrIMeIS
	 C33wpNLL89bbkNBdjV5iJgV97siqAw1Pr0+/NPPvZ9JKvEajliQS/CaBWf8vbi+gJY
	 N/MR1Cbs1BHLcaFL0g3tdA9R5NpZcqRn2AuQdVBUEPUnqDvWoS2PhhL7TGAq5sKQ/h
	 5TcI2U4g62SyBKY6IKd5JwZ+G4ZiGjpYdWOiOlzgQ+NMWIciOF4OUavGm52D3IfYko
	 j1Jd7etsLnA0Q==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix memory leak of repeat mode damon_call_control objects
Date: Tue,  2 Dec 2025 07:18:34 -0800
Message-ID: <20251202151834.68713-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202082340.34178-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Dec 2025 16:23:40 +0800 Enze Li <lienze@kylinos.cn> wrote:

> A memory leak exists in the handling of repeat mode damon_call_control
> objects by kdamond_call().  While damon_call() correctly allows multiple
> repeat mode objects (with ->repeat set to true) to be added to the
> per-context list, kdamond_call() incorrectly processes them.
> 
> The function moves all repeat mode objects from the context's list to a
> temporary list (repeat_controls).  However, it only moves the first
> object back to the context's list for future calls, leaving the
> remaining objects on the temporary list where they are abandoned and
> leaked.

Thank you for quickly updating the description and sending this, Enze.  I think
it is also worthy to add the real user impact description.

Andrew, could you please add the below user impact description to the commit
message when you add this to the mm tree?

'''
Note that the leak is not in the real world, and therefore no user is impacted.
It is only potential for imagineray damon_call() use cases that not exist in
the tree for now.  In more detail, the leak happens only when the multiple
repeat mode objects are assumed to be deallocated by kdamond_call()
(damon_call_control->dealloc_on_cancel is set).  There is no such damon_call()
use cases at the moment.
'''

> 
> This patch fixes the leak by ensuring all repeat mode objects are
> properly re-added to the context's list.
> 
> Fixes: 43df7676e550 ("mm/damon/core: introduce repeat mode damon_call()")
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Cc: <stable@vger.kernel.org> # 6.17.x

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

