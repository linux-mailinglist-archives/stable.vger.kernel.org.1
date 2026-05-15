Return-Path: <stable+bounces-247677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJs/FWUJB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C171E54ED6F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F13130B6873
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C347D920;
	Fri, 15 May 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2zYqn3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E83C3422
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845497; cv=none; b=LNeJs+Le/rn10mSrPy1c9n1dAZD40goOTi5ufsP/ptHdAGhy1hSvSUx1sx7Mae3K1Y8RsutW2SR6WhaGC8mnv9O+gk043qn2PhmS6u9GW2l0IZnAhZUSn3XNwVTzfaJWe1yuApihH04oeNs13dVXPx1xqnq57BjnCg4A8RsHi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845497; c=relaxed/simple;
	bh=PE9zQaAn7lWPjucVTgHtv7aA9fxAoNNXlV5pSrMocrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFAOlJI3H47rKfhQpm5uYaeifoxG1QkTnQiUDcpc4vVyMvU6RntdqWjHH8+gMpYlY6PbVzOSAdAPBkEC91OyAuSy/7U8gFEIG0LyWEpT/53aPHfTgcPrdtxdEXPg2CUtZRKZ18PvnHckyPM+hXeXHLavaaKyOZILHCyrg8722VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2zYqn3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDDC2BCB0;
	Fri, 15 May 2026 11:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845497;
	bh=PE9zQaAn7lWPjucVTgHtv7aA9fxAoNNXlV5pSrMocrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2zYqn3wTDDVUCJZ2Sai/O/wF6mekPeiFMT93wDS/0apVZM2TppMjBg/DCJy+QboD
	 P3xxqEtoB9AqKCKcVTp2gJvnFKTeMl8r1t1xPecjZPRktoMiRnc8A/XF6JsI/Wb+Cb
	 m/FuuTvWMMkDqREi57ZvsGMUSfNu0fZ5BMTKtrq3jg6grdIgZX38TAUuMnxLwRsy9+
	 O1I01R0/hCzNzFD8lt+0NVnf/z5WQUqrhPbjOsn9iSpktZv8MKEJq3ebT9bZvlJWq2
	 ZpqW+6hXf0KQ21x7xBRx+lxeGQTCqvcHg5rtlyIvdbMBVh35JAE4Uo50nkcfXFp+Tp
	 iAJdzLt4JZHKQ==
Date: Fri, 15 May 2026 12:44:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	avagin@gmail.com
Subject: Re: [PATCH 6.18.y v1 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
Message-ID: <agcG2uKHhlt85FaV@lucifer>
References: <20260424211315.1072123-1-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424211315.1072123-1-elaidya225@gmail.com>
X-Rspamd-Queue-Id: C171E54ED6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247677-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Hi,

Just a heads up that I generally don't read kernel mail sent to my work address,
as I changed my email setup significantly and use ljs@kernel.org for everything
upstream!

Understandable given the original patches obviously used it but just FYI :)

Cheers, Lorenzo

On Sat, Apr 25, 2026 at 12:12:34AM +0300, Ahmed Elaidy wrote:
> This series backports the sticky VMA flags infrastructure and the
> VM_SOFTDIRTY-on-merge fix to linux-6.18.y.
>
> Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
> failure when VM_SOFTDIRTY is lost during VMA merge operations.
>
> Patch 8 is the target fix:
>   mm: propagate VM_SOFTDIRTY on merge
>
> The preceding patches provide required dependencies on 6.18.y and are included
> to preserve upstream behavior.
>
> Backport notes:
>   - Non-trivial context conflicts were resolved in:
>     - mm/mseal.c
>     - mm/vma.c
>   - Conflict resolution keeps upstream semantics; no intentional behavior
>     changes beyond context adaptation for 6.18.y.
>
> Cc: stable@vger.kernel.org
>
>
>
> Lorenzo Stoakes (9):
>   mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
>   mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
>   mm: update vma_modify_flags() to handle residual flags, document
>   mm: implement sticky VMA flags
>   mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
>   mm: set the VM_MAYBE_GUARD flag on guard region install
>   tools/testing/vma: add VMA sticky userland tests
>   mm: propagate VM_SOFTDIRTY on merge
>   testing/selftests/mm: add soft-dirty merge self-test
>
>  Documentation/filesystems/proc.rst      |   5 +-
>  fs/proc/task_mmu.c                      |   1 +
>  include/linux/mm.h                      | 100 +++++++++++++++++
>  include/trace/events/mmflags.h          |   1 +
>  mm/khugepaged.c                         |  71 +++++++-----
>  mm/madvise.c                            |  24 +++--
>  mm/memory.c                             |  14 +--
>  mm/mlock.c                              |   2 +-
>  mm/mprotect.c                           |   2 +-
>  mm/mseal.c                              |   7 +-
>  mm/vma.c                                |  81 +++++++-------
>  mm/vma.h                                | 138 +++++++++++++++++-------
>  tools/testing/selftests/mm/soft-dirty.c | 127 +++++++++++++++++++++-
>  tools/testing/vma/vma.c                 |  92 ++++++++++++++--
>  tools/testing/vma/vma_internal.h        |  49 +++++++++
>  15 files changed, 579 insertions(+), 135 deletions(-)
>
> --
> 2.53.0

