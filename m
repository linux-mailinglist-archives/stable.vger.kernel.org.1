Return-Path: <stable+bounces-230033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKGhFA/YwWkaXQQAu9opvQ
	(envelope-from <stable+bounces-230033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536F2FF7EE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8963F301EFB6
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF139191F84;
	Tue, 24 Mar 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFN5xPhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D775FDA7;
	Tue, 24 Mar 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311305; cv=none; b=Pqj9fO6lilJnwpoGCGMAaga7r/YYi7Zzmf1WqJTewIcHXh00FN7h7CJ44tZBqkjMrcK0umUHFFDaWZIrB4QhvdBCUgaGJUHxrNHvS18lorhXyAkYdfGLDhvZcnVFt8c/M6nktlXQK9QTba+ztb4VK7oaGbo5s2gxPOHPF8GLHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311305; c=relaxed/simple;
	bh=bL5TsY3mZar75uq4cPHULH9KGrxQsAUm5BHcGvhJ0RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt3c1MZhBq8Ac8lzXWD3B6vmHGgxBqeOS8ajgv1Ko3DGRXnYPYoJuxr3c+Kt3Vr/6YhcHut1NTs6sJdBLwvZN/P7x8d1ynEH+fwXTLlE7GbxXCBu0keS84itFN79Ry7CsNEBzBsGs8l5tmzHzjwBL5pSf1wmLMURX6KmoH74rJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFN5xPhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E209FC4CEF7;
	Tue, 24 Mar 2026 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311305;
	bh=bL5TsY3mZar75uq4cPHULH9KGrxQsAUm5BHcGvhJ0RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFN5xPhVG4dpXaXm5iu5UF1N4xq5C6EUOpBzXqlbHMjbHJ7lNxLvm9Mf4aInb2HYd
	 68LkohmqQ3deRRVz1JGYGW691klI6MwF4FD+8QBUB1yDoMxiOSt2nw1K+HhzTIMe4M
	 2YeywJbauLPzC0pEDfScmvpDf7r3LAovvuP3CqMivbvxcCVyuwB4Viz/2JPoQiMVNq
	 j86hxvcDO8Mhd9DsJ8Vq75y8hnpYQofWtDcZywr/YlNCUMJ1zGg5ZPVpRKylqBWko4
	 V1BYUIc/u+8nP3FxhJVwIa3y/ZuXLG/aS23uwkJsZVNh5K85kknu3XECPuveZWK8OS
	 Bdu30t26WKk8A==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Mon, 23 Mar 2026 17:14:59 -0700
Message-ID: <20260324001500.86247-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0E185D9C-311B-47C5-AF28-06F8D1235926@objecting.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,web.de,lists.linux.dev,kvack.org,linux-foundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230033-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5536F2FF7EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 16:48:19 +0000 Josh Law <objecting@objecting.org> wrote:
[...]
> Also, unconnected to our topic!
> 
> 
> I've tried to backport Damon to 4.19 (for a personal android thing, and failed! Of course)
> 
> Can I have a bit of help if that's fine with you? The tree is based on GitHub a bit

Sure, I will be happy to help as much as I can without burning myself ;)

Seems [1] Alma Linux has backported DAMON on their 4.18 kernel.  Maybe you can
try their port first?

Also, what is the oldest kernel that you have to use?  As newer it is, the
backporting will be easier.  When I was in AWS, I backported DAMON of v6.7 on
the v5.10 based Amazon Linux kernel, and the source is available on GitHub.  So
if you can use 5.10 based kernel, using that could also be a good option.

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON


Thanks,
SJ

[...]

