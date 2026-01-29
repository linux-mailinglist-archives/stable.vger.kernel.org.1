Return-Path: <stable+bounces-212771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBdEOpZZe2m5EAIAu9opvQ
	(envelope-from <stable+bounces-212771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:59:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E023B033C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D280830131E5
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646438885D;
	Thu, 29 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxAXmH6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0019F135
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691539; cv=none; b=EiiF6ygfcAeE9qXNkr1jNDWiF/6cUY+guUXNJB2CxcYvS3apYe6sKQTz59ICAbBljjKjb/h32JNGvyS3yS9how+B1F/D4DlwS+xQ+O2FHnJH3vzf0ae1Xqjabd6TcC/IRcm0pVxO5aHaOaBCCbv6XE2l0CDy32YcMzzym+NOE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691539; c=relaxed/simple;
	bh=1Fj+r2uLORJAG+zkGC7tWDcZ0ldnTD7zhdJQF3oY6Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZHRvbKfVvCY7m4bcZu6w1QPhzQdprDR6F4DvVaEid5zP2K+d/uPi/9kg0zZsIa7CNT8Qsy1RgO10lNw0zPS85Iy8G6pYNOKxfaYu2C3/4UnXekPqEqyKa6JghzJ9kDeBOiqmy4M7WSpaOQ31L+TmBRAEkYj/j6w+wmt4BwTRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxAXmH6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2AFC116D0;
	Thu, 29 Jan 2026 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769691539;
	bh=1Fj+r2uLORJAG+zkGC7tWDcZ0ldnTD7zhdJQF3oY6Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxAXmH6Qvbo3zRUvnJ+U9dGn5nYLCWC5pdy6422pyarQsDG4fRggiQKjpeTGHrkSU
	 NCeT9Hzc2j2GU0huuHzHiQpV3zFTy0cbvSRkbe4kyz7KLrm/opkyogJ6W3bbmljQB+
	 ynBRzGOm8unqEMXHOuFXzxP79EAqfnXbNa8omxsvKPCyeY7109hzyeHjvE01hjQeBS
	 c/Tx1hE1KWL+6JEweAp1gK7mVl/gFYfDVr7IEXkBfdJlyd/5SP0YkRRb2mK/Sal9Pt
	 lgrEfouv7x740CtmXTrsHysTfo/To1i9+0MGzAAbMtDwMyhbwLSiAjQNHytDYJsw5R
	 DsauZy485BHHw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	david.spickett@arm.com,
	kevin.brodsky@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: poe: fix stale POR_EL0 values for ptrace
Date: Thu, 29 Jan 2026 12:58:51 +0000
Message-ID: <176961836556.4090706.13306795344334749447.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127133926.2677180-1-joey.gouly@arm.com>
References: <20260127133926.2677180-1-joey.gouly@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E023B033C
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 13:39:26 +0000, Joey Gouly wrote:
> If a process wrote to POR_EL0 and then crashed before a context switch
> happened, the coredump would contain an incorrect value for POR_EL0.
> 
> The value read in poe_get() would be a stale value left in thread.por_el0.  Fix
> this by reading the value from the system register, if the target thread is the
> current thread.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64: poe: fix stale POR_EL0 values for ptrace
      https://git.kernel.org/arm64/c/1f3b950492db

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

