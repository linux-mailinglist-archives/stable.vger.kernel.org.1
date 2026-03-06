Return-Path: <stable+bounces-223334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHseMKzIqmlWXAEAu9opvQ
	(envelope-from <stable+bounces-223334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:29:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36373220A1B
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B24B308705B
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B99329C7F;
	Fri,  6 Mar 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqhzYvMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45A1B4257;
	Fri,  6 Mar 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800022; cv=none; b=Yl0kKKS2MCmRyq9q3pUVyOwzjUQ3ZZ1oQPbeRJzBNJhJ3L7wF8NpNzbCRUhNxv3uVAe3xrrwAYSWg6cUg1GKUR6H9PL6vQC5V2UABStBZCjWbNHWqweR/JDdJj5fQAHWG/QaOMLsCZlcUxe9TVIR/GTRRmrPRdynCpdqnanlZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800022; c=relaxed/simple;
	bh=7Hk7fAZvQF0ye88ruxvV6p3f98XYs2WUnmaeYiPvIvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDtpjA27zzceq59fvQnKCpGp8xgvAaYiybDa3zNXKqSUo/4zjG0jd2fLB/GzhYmquCcXfufO8RlROh/0RAI2X9hSVjC6AFiStO9Ne/oWPW99Y6YS16YlMCnYWfgViZ1r0+V9Xt0Lbi9au5hcHcdGL4PODJBvVqV2h4rnHUCoiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqhzYvMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF5EC4CEF7;
	Fri,  6 Mar 2026 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800022;
	bh=7Hk7fAZvQF0ye88ruxvV6p3f98XYs2WUnmaeYiPvIvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqhzYvMQwShy+yX4ebcbqbL3BTg7VeWu+fXcy9+1csqA9F/dXEuQrIdJpJZu+7/L0
	 5TgSSRj+V3KcV7JHs2tslveU3OM/HEYLlNmh+4YUzsoBAh4S6ubp5FHWLY5EUcu9EQ
	 OkVIHTdTid6voTnxnBvJKAlGOAF3Ripzjnz7eDX//RBm/16v4Hna2W4f4iFMguIVUB
	 +9hIYILu+nbENLitc+lrZibMpnr/KTamNWDgb9h8+w/LtfkCWWYWjCazcILWVhZQlq
	 BXBIEmeXIrmRql3AlTl5ui/O85GYlhV2RXy+Jqajab5bro4mwmJz5963mPzfM8Nggo
	 OZZrrPC3nNl1w==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	stable@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2] arm64: contpte: fix set_access_flags() no-op check for SMMU/ATS faults
Date: Fri,  6 Mar 2026 12:26:52 +0000
Message-ID: <177279636044.453548.11482786576662988237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305-contpte-fault-loop-v2-1-0216f0026d7f@nvidia.com>
References: <20260305-contpte-fault-loop-v2-1-0216f0026d7f@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36373220A1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223334-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm64.dev:url]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 15:26:29 -0800, Piotr Jaroszynski wrote:
> contpte_ptep_set_access_flags() compared the gathered ptep_get() value
> against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
> from all sub-PTEs in the CONT block, so a dirty sibling can make the
> target appear already-dirty. When the gathered value matches entry, the
> function returns 0 even though the target sub-PTE still has PTE_RDONLY
> set in hardware.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: contpte: fix set_access_flags() no-op check for SMMU/ATS faults
      https://git.kernel.org/arm64/c/97c5550b7631

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

