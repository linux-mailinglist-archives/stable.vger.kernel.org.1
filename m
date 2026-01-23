Return-Path: <stable+bounces-211408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEx6L+S0c2liyAAAu9opvQ
	(envelope-from <stable+bounces-211408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:50:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 301267932F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E74AF3030D04
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E42749D9;
	Fri, 23 Jan 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSkobJ1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013423E350;
	Fri, 23 Jan 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190607; cv=none; b=T+YZTH2QyvzhLKJhaXCLQt1HqTE86qT+6xkJa0kSRqr/enCPvRvdMO6kORVOhfU6AbJw+oCfKSLXUPWB5prlvEMcsGkVmDzwhJ2ge4AFrqE1/r0ZUPhZr8egz4NoHa5jDm5vzjQg3g3z+d0LEcLagPUcfLB01UXXh0dNYM5E4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190607; c=relaxed/simple;
	bh=pNDw2hoRSoUTdVAMzmKFR2iLJdLsJKYyv1Q6f1ot0x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT4oZhd6GRWWtaDt/8XIhv0djslmqIFQiBs4YeRA6yGJpCz5cTuu63cWPBFAoC0SFRUWb8a+dDEN0ng5VINvfrXbYlSFtqNYL8OGdL2/brd2H88immw5TDvEKTBDv43392umHO81psEpyy7sBVfHMzYwYUEVJ3RxQhi3gnDqNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSkobJ1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40610C19424;
	Fri, 23 Jan 2026 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190607;
	bh=pNDw2hoRSoUTdVAMzmKFR2iLJdLsJKYyv1Q6f1ot0x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSkobJ1PuDzl3BZW/6RSLzYhStZSQ2v5BISMF3Dz08or/CD1gwUKeWQGFmIYzWCr5
	 Faqs+7shujGbSQbvR0V2ly0H5qUprgjZ4Doi5O2+dM9Ir8aM5dJzRMDtANzg+HF+O6
	 VqMFaxuOvdBPTHckF5me8lSkWHZpu9ReDkrKz3iZy0cdBoxw8CxoZ2LhaOmREtJt7w
	 LJRaOdqdda/ipGe1fOATg0t/GGPgn+pC0OtyEOQ279BS+HZaWvYcS8PTjD2Com46we
	 P2T8N0ak/SPu0vKV2nD90rxyxIdhGEQerzri00u02HaqhPD6U922FJZSVJuiprYCEB
	 H8EpDzztgVSmw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lucas Wei <lucaswei@google.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	sjadavani@google.com,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: errata: Workaround for SI L1 downstream coherency issue
Date: Fri, 23 Jan 2026 17:49:49 +0000
Message-ID: <176917501918.797415.179034767474498162.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114145243.3458315-1-lucaswei@google.com>
References: <20260114145243.3458315-1-lucaswei@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211408-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm64.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 301267932F
X-Rspamd-Action: no action

On Wed, 14 Jan 2026 14:52:41 +0000, Lucas Wei wrote:
> When software issues a Cache Maintenance Operation (CMO) targeting a
> dirty cache line, the CPU and DSU cluster may optimize the operation by
> combining the CopyBack Write and CMO into a single combined CopyBack
> Write plus CMO transaction presented to the interconnect (MCN).
> For these combined transactions, the MCN splits the operation into two
> separate transactions, one Write and one CMO, and then propagates the
> write and optionally the CMO to the downstream memory system or external
> Point of Serialization (PoS).
> However, the MCN may return an early CompCMO response to the DSU cluster
> before the corresponding Write and CMO transactions have completed at
> the external PoS or downstream memory. As a result, stale data may be
> observed by external observers that are directly connected to the
> external PoS or downstream memory.
> 
> [...]

Applied to arm64 (for-next/errata), thanks!

[1/1] arm64: errata: Workaround for SI L1 downstream coherency issue
      https://git.kernel.org/arm64/c/3fed7e0059f0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

