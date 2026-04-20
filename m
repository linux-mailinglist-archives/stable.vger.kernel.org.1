Return-Path: <stable+bounces-239233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP9UFYtV5mktvAEAu9opvQ
	(envelope-from <stable+bounces-239233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:34:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBF42FA41
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DC9E31AC650
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638C37474E;
	Mon, 20 Apr 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fozhAgKi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37709374726;
	Mon, 20 Apr 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694333; cv=none; b=MUtzx4XjUL2DsbB1Z9RH9lmlwtHvIrYanKL5XMpIaz44qykmjz93u+78tMfEoPCCeG7uQI2Gpwmekgm57XuTHM7gRVXD06zOElw6wfmPS/K7sBqXUNPhKIVRpWht8u2WbEC1wbOIVVoGBnppQxCoA/Vvj2pET8UzFAnkmL+bjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694333; c=relaxed/simple;
	bh=KUP+V4uqfCUMaSGxnbv21QPHCD50bcmDKtIbRcY1gAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rakqwsIb8G7fkPlTN48bg6Jq/c+LZCTuSYmsh3V0xcWulXhN8e75C9E9wmb3YY6BzS5XfvfDtTdl9kFeKUopZdGTIaZDn01IUUTUKRVwLFel40FPWrP0mSHxyPGahm3S1huSpxjlQJufRu83/O1QRwBVvs7la71MiTdFcnsrYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fozhAgKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345DDC19425;
	Mon, 20 Apr 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694332;
	bh=KUP+V4uqfCUMaSGxnbv21QPHCD50bcmDKtIbRcY1gAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fozhAgKiO0oARp9McnWrXz36z+yMgW+gnevRQ3c/2puRTFLWSzQpxWvpGmWlsdS9y
	 ajwWMVjBWTi920FtX2Cfjo4jkBRZrVsdTW3+nMPucOTiCJETgzbdRwdOWLmZMpQsPt
	 eDORtrDe79ADrBDQQwa92qvlN4maUO+qNhmHus7pE28afezXitr4v3LGLZBlGV3ncY
	 0CTgkUC9cXHlsU8hhMAtUAHQK1EfuLmmOCa7kgxMUB4R3S9r7TvrFALt+SNOC9Vi7V
	 PGgJl/uXryxG8Ie6cfK8X13HjR/xrtItozEEGAVAQBSorsFP9KxAGnPejmTCOsFTy3
	 e8FrUslvEEf4w==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>, Borislav Petkov <bp@alien8.de>, Sasha
 Levin <sashal@kernel.org>, fweisbec@gmail.com, mingo@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] clockevents: Prevent timer interrupt
 starvation
In-Reply-To: <20260420131539.986432-78-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
 <20260420131539.986432-78-sashal@kernel.org>
Date: Mon, 20 Apr 2026 16:12:09 +0200
Message-ID: <87pl3ten5y.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wbinvd.org,alien8.de,kernel.org,gmail.com,linux-foundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-239233-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ECBF42FA41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 09:09, Sasha Levin wrote:
> From: Thomas Gleixner <tglx@kernel.org>
>
> [ Upstream commit d6e152d905bdb1f32f9d99775e2f453350399a6a ]
>
> Calvin reported an odd NMI watchdog lockup which claims that the CPU locked
> up in user space. He provided a reproducer, which sets up a timerfd based
> timer and then rearms it in a loop with an absolute expiry time of 1ns.
>
> As the expiry time is in the past, the timer ends up as the first expiring
> timer in the per CPU hrtimer base and the clockevent device is programmed
> with the minimum delta value. If the machine is fast enough, this ends up
> in a endless loop of programming the delta value to the minimum value
> defined by the clock event device, before the timer interrupt can fire,
> which starves the interrupt and consequently triggers the lockup detector
> because the hrtimer callback of the lockup mechanism is never invoked.
>
> As a first step to prevent this, avoid reprogramming the clock event device
> when:
>      - a forced minimum delta event is pending
>      - the new expiry delta is less then or equal to the minimum delta
>
> Thanks to Calvin for providing the reproducer and to Borislav for testing
> and providing data from his Zen5 machine.
>
> The problem is not limited to Zen5, but depending on the underlying
> clock event device (e.g. TSC deadline timer on Intel) and the CPU speed
> not necessarily observable.
>
> This change serves only as the last resort and further changes will be made
> to prevent this scenario earlier in the call chain as far as possible.
>
> [ tglx: Updated to restore the old behaviour vs. !force and delta <= 0 and
>   	fixed up the tick-broadcast handlers as pointed out by Borislav ]
>
> Fixes: d316c57ff6bf ("[PATCH] clockevents: add core functionality")

Please hold that off until

   4096fd0e8eae ("clockevents: Add missing resets of the next_event_forced flag")

hits Linus tree. It fixes above commit and is marked for stable. So
ideally you apply them together.

4096fd0e8eae will not apply to 7.0 and older. I'll provide you a updated
version once Linus pulled it.

Thanks,

        tglx

