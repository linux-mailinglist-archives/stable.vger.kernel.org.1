Return-Path: <stable+bounces-267568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5jtF6QnOGrJYwcAu9opvQ
	(envelope-from <stable+bounces-267568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 20:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C76AB66B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 20:04:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l0YSS5Dh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267568-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267568-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A176A301F18B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AB23E320;
	Sun, 21 Jun 2026 18:04:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AE2E1746;
	Sun, 21 Jun 2026 18:04:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065041; cv=none; b=PxACMC6TuaQevwxe5Rscv18mPzb98gzUIyFdo4yvmG2QAXLOraHcjgJAjtl4+zfS2wrBSqSbFWmJCGBbGCt4HAF3O5l6bKkyTLML/BMmzku7Gnu6LdrpCVmx0m+feXNMkmtCGO/N47w+F/URvLVnOtpqnYldtlyIoKfVZ6j5y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065041; c=relaxed/simple;
	bh=urV3/Hya5bWJMcInGDRFF2WF7uruU9KgDFH488Jfv6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq+k3bA1+izlgqdZUF8ZHTk8sWpGM/2uuzZJwlRRXhxupz/BCHEQ/QYGLCyTxotW0Q6fJAopGlcG63mvv0T6oDrBik9CfXXVZNXGUCg0nRZQHoSMt8oFmA4IFqtg4S6LCTBCW3XmV8HlYbU9xzjqaVTO0WT3d/pXd4/xb8Wo1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0YSS5Dh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA0F1F000E9;
	Sun, 21 Jun 2026 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065039;
	bh=54TyF7XxWkGv+SmhhNpIN1Mr1dGEVPPbVs82yylKPaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0YSS5Dh6e/G7+zzbyorV8r97fLmf6IUEwf9ogcwCELprQUPx6gmVUJBhK/HXRoY9
	 LKPQPCvnZz8IsJgmWJBIMS6Fcy9C6R3oOu2zQ1v7xwOgL64Xu7Ito4qX+U0S195aB5
	 6X1juTWcf3xtoFh6B5GWEDcZRmoZz6fvC8kMuzoN5hlfpT6XFawpT3EzVGqxIAxGFd
	 w7REcOpnrH9uc/RNYlfP7MLc7SEi7Ncl/MOQ3oWmP3BXN4EfMKHU6+XWmXERQgWcny
	 ogQRLZzMMUgQkZZw0+bBoBjC5jf62bDT2uWZLlehFyQ/HmK3xDBAZ1X1sdN24e9MFW
	 KI3Z+FScSoCJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sun, 21 Jun 2026 11:03:47 -0700
Message-ID: <20260621180348.92118-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621154808.86431-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267568-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:akpm@linux-foundation.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B47C76AB66B

On Sun, 21 Jun 2026 08:48:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
> is set to zero by the user.  If the aggregation interval is set to zero,
> the function returns zero.  It is wrong, since the real maximum
> nr_acceses in the setup should be one.  Worse yet, it can cause another
> divide-by-zero from its caller, damon_hot_score(), since it uses
> damon_max_nr_accesses() return value as a denominator.
> 
> Fix the problem by setting the denominator in the function as 1 when the
> sampling interval is zero.  Also ensure the return value is always 1 or
> greater.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")

Sashiko found [1] another bug that was introduced by another commit.  I will
repost this patch with a fix for the another bug.

[1] https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org


Thanks,
SJ

[...]

