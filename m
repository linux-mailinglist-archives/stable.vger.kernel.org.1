Return-Path: <stable+bounces-267485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hM56Jsh/NmoyAgcAu9opvQ
	(envelope-from <stable+bounces-267485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B06A8D4F
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ytnlx9zi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267485-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267485-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E1CD3010231
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB95393DD3;
	Sat, 20 Jun 2026 11:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D13932E5
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956510; cv=none; b=r2u1rMSlV5vfQWporSN5wQzl9xigWLJwYB+zC3tpMFPKFV95MZpfzHzdB28RcsE2Pm4WQOY/mEWWio8sRVhy5aHouEhJCW2Na8NK+2vNxEAtYb4j3ehgGJr8EHqLmoGZhPFqEOlZJZLnLHOSlpAU9y+Hv/cKIZq7XdEDeF1kdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956510; c=relaxed/simple;
	bh=QXZmyCAn3kJqZQrtlLb+duvGFbht5wpZTNILjZn2wR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA+CkdkoCduwqq5SBGyH4cIFdT+CZTaZ9NbrR0XNAfN8ev0lWDZNZpkpL13jV6DnIslKNROdS1Y5p828my9g3zu5qp9mjey2gOnkvCl88tUMmbSd/NY9/Jmwt0mtYOagvjEuLDyEgAoYkFy3as2XDyHbop+alIpTEr7NYUM1pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytnlx9zi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258981F00A3A;
	Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956508;
	bh=egcleAKw5AzHJbeXHUmgjj5sUkxMDV8ZP8FpY6GcMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ytnlx9zito/suBubqbFm82MEGvNlZKGxt9xma0zoKK4On+rgLOUkss3cr4Miph7kR
	 qgwvJPqo2CPz0aOyeuNZHiCw9lKGCJfworRt5NI8apXzhPFfE6yVDr7Yk8n6CETcE9
	 ESXul3I0u0rsRU8+eC9oDAU8lWHjGfFQDCUYXXK7Q1J80zWPvmhewS1QaLIUv+SZCu
	 RXr5B4AfhZLCpWsS4PVIm+ej8Dzay9ZO0TRqta4+EvjRpbyYYC7eVCOAoCXdAr2wjX
	 c1tslkZq+Pyxen2OoqOVgFvX22od5WQIjqrViKzbI+Xn5j2j2BtTwILJZ6ip+BFT4F
	 TzU5XWKL9Gfhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	mathias@mongodb.com,
	peterz@infradead.org
Subject: Re: [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness
Date: Sat, 20 Jun 2026 07:54:55 -0400
Message-ID: <20260619.0005.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618151426.308099-1-mark.rutland@arm.com>
References: <20260618151426.308099-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:catalin.marinas@arm.com,m:mark.rutland@arm.com,m:mathias@mongodb.com,m:peterz@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267485-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F10B06A8D4F

> [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness

Queued for 7.0, thanks.

-- 
Thanks,
Sasha

