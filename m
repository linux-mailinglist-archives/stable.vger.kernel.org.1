Return-Path: <stable+bounces-230480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNCNKsNLxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:07:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848D337458
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DED8A30FC073
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06153FEB04;
	Thu, 26 Mar 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Q6fhSe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CB3FE662;
	Thu, 26 Mar 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536839; cv=none; b=lVcZGNfFmdxdj8Gw1GyzLdafiDQbgccq4CNaNUNIEps+VqcsntlTI09vXOF2656qBqikCJAp1bFZYP+zlU7y93kiQJSfWcdFiUwcJohJMlFyeS79uqvtJPO4CbuGhIivGQG48DQU9gXK1+kM6idUnuscWjvNBow6Br59mN/ESwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536839; c=relaxed/simple;
	bh=BLR/RJhF/jZELhqDin2ZuSm044v9f2wMVcye1L7PlfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV71XWOIlysj7vjkv4pbtnX6IRlYfOg4xaAw59BIXwzt9wMDOoHv4LIV6Zrrnbo6z1YguCqAc1YUyvfcZAZucs9jxzp+g+LWj62BjBYVm+XkucOdfD/8fffkjVWs6hoV+88V1T6xEnN9HdYAedLupG4/S5rOd3s3jf9BAefuwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Q6fhSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B2C19424;
	Thu, 26 Mar 2026 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536839;
	bh=BLR/RJhF/jZELhqDin2ZuSm044v9f2wMVcye1L7PlfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7Q6fhSeG14zhc+CXBstEdP4CNpqQHZqzkK0i4Le3yB6kKm+tha4a1dgM0ckZUuGJ
	 jGr8AgqQQH6BZ15/N8bxNVB75o/l171t7qNjMFKJXFVzCQ1CyVB4t2gWKmq757gpYK
	 eXNZPhZFwFyrERS7KB2mn5abR2FL7EnWEkGYHQJ6NVHWx+jY5u8rgMTsnU8GxRdg3D
	 D7FwODquU+jZ2iq20B+hAtLYrTeezP6A6UTHEmcFdf/TT32BQ3+cW27ucdgb1WlyUi
	 kgZmxR67nCIjPF5qf/0+VX/0spUnKkwUzs1utSfQd3teaGJWlYSHgYcT57xwdlTdTy
	 p/wjkgh01+YWA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH 0/2] mm/damon: fix damon_call()-related leak and deadlock
Date: Thu, 26 Mar 2026 07:53:56 -0700
Message-ID: <20260326145356.92319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326134209.90377-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230480-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3848D337458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 06:42:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260326062347.88569-1-sj@kernel.org
> 
> - [RFC PATCH 1/2] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH 2/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

The patches are hotfixes, and have no reason to be one series.

I will send the first patch as an individual one without RFC, soon.

For the second patch, I will go one more RFC round.


Thanks,
SJ

[...]

