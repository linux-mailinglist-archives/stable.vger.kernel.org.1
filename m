Return-Path: <stable+bounces-253646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJkbASeVD2o1NgYAu9opvQ
	(envelope-from <stable+bounces-253646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 01:28:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CC5ACB2A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71053302962E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD3358369;
	Thu, 21 May 2026 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N500jdmu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77933FE05;
	Thu, 21 May 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406116; cv=none; b=mERhMTNzjq39+OgesFuUy1jaAzP+Da480Fy6E7YyXJcSuG9PAZB+5cSLr5falaDmb5uLQ39rbJXUUZXwqybY1tVFHfwrsu6qc3bpyFzA5h2bNPHy3DxZwAGtk7N9hLso8vkABPWzDCYuY5amy65RviGj5n1r4LIvIhpFt1l6Lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406116; c=relaxed/simple;
	bh=F6azzIOJrOeFiKt5ARIaK2Jxe5op2gHsaY+coK5PJqY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hEktl9AQpwhTJlQYgQPaC8zFGZFt9kZ2VoTJi439Zxwvtm+5vWeqMEBrLbF2Ru90LGCOPxGq14KMcKS7qbfqWzqT9F2DvAlv/c1+KNlWokNNfjBjcb6bF7kGkX4LnWHY/kfycobwBWgBZeW6o3Vn3ee+GDfE4oh7maAiY/E9U7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N500jdmu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D581F000E9;
	Thu, 21 May 2026 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779406114;
	bh=DXwm4Z+lOKTf5jJnND+DA1ISntGmioZE3tfITHlp0PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N500jdmuy2l3Yh1vlBN6mN19yeYCQxZGfi40jmvefZyO5xqJP+LzquyrEG+DoEL31
	 8Kqi3SrUGx1gfYXmIEpE3dOA9CH31yE1UDk2BAdrIdQ+6AWkO/f7qmWO8sBXkIm14d
	 WrhZE93/XqBOnaT5m36LnW9Q+bs8pd4h4G9S9UGI=
Date: Thu, 21 May 2026 16:28:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: trace esz at first setup
Message-Id: <20260521162834.d119e280e3f9c20cd596d197@linux-foundation.org>
In-Reply-To: <20260520150311.80925-1-sj@kernel.org>
References: <20260520150311.80925-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253646-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 756CC5ACB2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 08:03:10 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON traces effective size quota from the second update, only if a
> change has been made by the update.  Tracing only changed updates was an
> intentional decision to avoid unnecessary same value tracing.  Always
> skipping the first value is just an unintended mistake.
> 
> The mistake makes the tracepoint based investigation incomplete, because
> the first effective size quota is never traced.  It is not a big issue
> when the 'consist' quota tuner is used, because it keeps changing the
> quota in the usual setup.
> 
> However, when the 'temporal' tuner is used, the quota value is not
> changed before the goal achievement status is completely changed.  For
> example, if the DAMOS scheme is started with an under-achieved goal, the
> quota is set to the maximum value, and kept the same value until the
> goal is achieved.  Because DAMON skips the first value, the user cannot
> know what effective quota the current scheme is using.  Only after the
> goal is achieved, the effective quota is changed to zero, and traced.
> 
> Unconditionally trace the initial quota value to fix this problem.
> 
> Note that the 'temporal' quota tuner was introduced by commit
> af738a6a00c1 ("mm/damon/core: introduce
> DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was added to 7.1-rc1.  But even
> with the 'consist' quota tuner, the tracing is unintentionally
> incomplete. Hence this commit marks the introduction of the trace event
> as the broken commit.

OK, but...

> Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>

The patch is marked for backporting but it assumes the presence of
"mm/damon/core: make charge_addr_from aware of end-address
exclusivity", which is queued for 7.2-rc1.

We can either redo this against current -linus and fix up mm.git's
"mm/damon/core: make charge_addr_from aware of end-address exclusivity"
or we can queue this for 7.2-rc1 and you get to deal with fallout when
-stable maintainers hit issues backporting this.

Preferences?

