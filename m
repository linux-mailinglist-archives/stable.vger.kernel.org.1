Return-Path: <stable+bounces-227643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ2UHgPtvWkwDwMAu9opvQ
	(envelope-from <stable+bounces-227643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 01:57:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F62E2B60
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 01:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65AC5302DA2A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107A3290D5;
	Sat, 21 Mar 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkIh9jNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434F19C566;
	Sat, 21 Mar 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054565; cv=none; b=Bpq36QFzAcPWtHkRZ+aaSHyHW0+SvhicKI4BmmLtQalG9bYhAbabw8HTcGtitj30rV4oSylyLpU1PnxTmk8Ht2RD2DCwS9Kt/3YQda4XdqYr2b55ChUjOSnFNusnDlvM3/CEbrr34gA2NpD1pkwhbG3VYAba0BPRdeqWQChqvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054565; c=relaxed/simple;
	bh=0D3OTJrPWzODN5QWUFPsyWLRAxDzzOn8mYGwKppQME4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llgknMIA0vsXUB+ys8898oWksCQ0GF2QIKoRQ6XUophhwRukEPuATYvHQyFASy9KRsEf+xGgZfGEG2TWchV4mmNevtJsBlWgcafbpof0GItZk/8DZaf+ja6XOGVCGGcgsuciLOvYwXiEm1LLC5SwvRV61YtiLTSXtEknPrLoZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkIh9jNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08735C4CEF7;
	Sat, 21 Mar 2026 00:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054565;
	bh=0D3OTJrPWzODN5QWUFPsyWLRAxDzzOn8mYGwKppQME4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkIh9jNMiAvcbN33NpKoDi56RcVYsRXjQG/Ly1q8S3pHiaXEGQxOFSqoh0+d1GdKD
	 UHrA1YDqUJABPT8hof8l0MC4jWV5HDykfaVhcZT0KfaRGtEVYhLuviyOJOEqsWkq1h
	 0TuLyXFjrEVc/1XbB5nqDVtT1KV4Ulxdw1irqGLnThOLiCIIq5tqprTAW0fzzjGA6+
	 YlTiig/kGz4rxORLizt5DXihS+mLXcmZzEDZZUozFOGla7UZWZH/gIHZ//Gsf6bmKo
	 HBH7OxOLmLcYbwTwfpgjOw/9Y6rS3A/1X+DCL8Su2uWzQDqdAkkx8bZmDhbJkKw6p+
	 LkgQcfNpl4/vQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Fri, 20 Mar 2026 17:56:02 -0700
Message-ID: <20260321005603.81086-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320163559.178101-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227643-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: CF7F62E2B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 16:35:57 +0000 Josh Law <objecting@objecting.org> wrote:

> When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
> param_ctx is leaked because the early return skips the cleanup at the
> out label. Destroy param_ctx before returning.
> 
> Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Josh Law <objecting@objecting.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---

From next time, please add patch changelog here.

[...]
Sashiko is adding comments [1] similar to those for the previous version of
this patch.  I replied [2] on the thread.  In short, it is good finding but
orthogonal to this patch, and I will work on it.

[1] https://sashiko.dev/#/patchset/20260320163559.178101-1-objecting@objecting.org
[2] https://lore.kernel.org/20260320020056.835-1-sj@kernel.org


Thanks,
SJ

