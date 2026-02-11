Return-Path: <stable+bounces-215865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDJfBe/FjGnDswAAu9opvQ
	(envelope-from <stable+bounces-215865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:09:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53810126CB8
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AFD3011849
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FF346AC0;
	Wed, 11 Feb 2026 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="P2xzQ7aV"
X-Original-To: stable@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC512F362A
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833386; cv=none; b=tK7jNEZITWwtKCcCKMYrIK78U2jH8DDa3N5uVNiGRWsd6Ok/q1G/1s50doMZ9F5Ryr6dHzROASKkqinlei1z262RLZ4T6QWlbrq6RfwQmzdlobDd5UREXa0PZnk24LUQXNzChQK+aF2LpSNNsDAkx+fdXQZAIknqb1kBBjgIFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833386; c=relaxed/simple;
	bh=/Kk3AvTx8yA/Ghk4+rCWgyUgbz7Z4BuzC79m130Cn8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tda25P8T425iSDziG4KNaFYMUuQIpXQ8SyNrZoDn9krJbL2PaHvPY4bb/LuB6GndoxXq/qDpPfFKLLvghFgVjko9sr/3KcYwq0QzkCE3MMa1BR6rZuOPe8bcdUpS8O5daTev8d3pnuEM4JaE6amPUJTv63F6i2USxgEIOeshYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=P2xzQ7aV; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1770833376; x=1771092576;
	bh=/Kk3AvTx8yA/Ghk4+rCWgyUgbz7Z4BuzC79m130Cn8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P2xzQ7aVbWLoE3zcOmFx369J4P2zJ7kIbDXuJ8M7Sja+x2HC0yLrAmIxHNKXhCoM2
	 mEaZkQsFF9s3mMAkOabpgKB5DAQazsFDxXtXbLZ1GUN3swIfF/+cW/hBkjSu0RFvYR
	 MBVk9KeHQJYrXYVWz6OrOvKSjq3g2HEWREHI2+jR+F286SsYRRW1WtGO5UfyP9d6Qt
	 yL5JVCwM3Zb5zh3ZpITmOHmNPylPmzelOCrNP5CzzocOECYmXDR4c96ctaSZuxI7kn
	 a+k3E6jddtIqmbtutuO0rnCBR/FuiSdX4VNGFPgUxpKX5I5IZHcCdeyqFMNv+SEXrg
	 8McQfH/Bk8G0w==
Date: Wed, 11 Feb 2026 18:09:29 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Tj <tj.iam.tj@proton.me>
Cc: 1127597@bugs.debian.org, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, Bastien Durel <bastien@durel.org>
Subject: Re: Regression: v6.12.67 ip6_tunnel: ip6gre decapsulation fails
Message-ID: <4eef43d4-1c2b-4b9b-a193-c79a9f3445f0@proton.me>
In-Reply-To: <2026021138-gleaming-overarch-7e6f@gregkh>
References: <177076023892.578113.8206759777477389796.reportbug@sunny> <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org> <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me> <2026021138-gleaming-overarch-7e6f@gregkh>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 0a292bb54373d51d3c1f8e082180300c3a147f19
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215865-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj.iam.tj@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 53810126CB8
X-Rspamd-Action: no action

On 11/02/2026 05:29, Greg KH wrote:
> Please see this thread:
> =09https://lore.kernel.org/r/CANn89iL5ksZZCJr7SK9=3D4Sw6EejdOzr5_m6pBMM8R=
VtbLy_ACA@mail.gmail.com
>
> I think that should fix this, right?

Confirmed. Adding this patch on .67, and .70, resolves the issue.

Thank-you.



