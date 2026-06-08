Return-Path: <stable+bounces-262027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GbanFYawJmrlbAIAu9opvQ
	(envelope-from <stable+bounces-262027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 14:07:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D4655F8E
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 14:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NdsopHfq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262027-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262027-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2848A3057E31
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8E3750AD;
	Mon,  8 Jun 2026 12:00:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574D372EDB;
	Mon,  8 Jun 2026 12:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920015; cv=none; b=amHH1pZEsxZmi2vhELFGcvrpTr2SKYGinlJy2g7RQnv0jvJ3DSDGW33UVdRzIPCKrYAGj9P2wl5ruXwJ6JdLRxyciYwWL10oTFptsxC05jEWaggZbzepSe4PJGeIHgwVZMCGgMot7hsq+R2ZWj2zxcE7LlzLWybEmPoMS/xm4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920015; c=relaxed/simple;
	bh=iSUmoylf8/1ygBkTEmCjhBqfVrg1PFhIznDLN/bx3kw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gyQIw9bmBH8NcjTMRM1YbHqS4/eRcBsQ+CfdwmaH3d18rKDGV9eKRT5uFg3NQvLpvLq/UG6DLamay258n0DR/xhCO/99FpvViX1NKtGCkgUXOXqqARJdKprrP9JlrB8Bt0lgkNJ7neOXYpe81VQarem3Ou+tWqecb6a+CKIsB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdsopHfq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6AE1F00893;
	Mon,  8 Jun 2026 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920014;
	bh=i4t1rDwmbFC0mDMHdQRS20cjdrug12x5V1MErA96jds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NdsopHfq00KU3uY9+9/LkeiqsLWts9dWYorUAsx/9hYIjfnKC+Ar2RgAvslhzQA7O
	 YPdMxDUwm2yLpX2nVkEj5TXiqi8M7s3bdjwzyud61fK0L+Az/zpiBAfdsuzEkvTNwP
	 gejSPEfz7lXrzesvO7YHhshDudn0rRboruaT0czBTV98/L3p1rZCpNS/dZrlgmiLr6
	 0aCD4Y+8FGAL5OaO3w4bPvP3ILKUFqa5wEfhwkPWCLp7B5rJ3eY2RNqgGHSnCeebju
	 K8BbhW3dyaXO92MpFwYK/kzV52Z2z41ShAU+Mk/8/iS8LEk2dbrazMakIVWXgi+GA8
	 dBzuXYv9Cky7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198563930D69;
	Mon,  8 Jun 2026 12:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Keep dynamic inner array lookups nullable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178092001263.1007295.5762213253620384461.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 12:00:12 +0000
References: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
In-Reply-To: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, dxu@dxuuu.xyz,
 eddyz87@gmail.com, john.fastabend@gmail.com, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 shuah@kernel.org, isolodrai@meta.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262027-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,dxuuu.xyz,gmail.com,linux.dev,meta.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gnq25@mails.tsinghua.edu.cn,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:dxu@dxuuu.xyz,m:eddyz87@gmail.com,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:isolodrai@meta.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A24D4655F8E

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 07 Jun 2026 21:24:12 +0800 you wrote:
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. The flag allows a concrete inner array with a
> different max_entries value to replace the template.
> 
> The verifier currently uses the template's max_entries to elide
> nullness for a constant-key lookup through the inner map pointer. At
> runtime, the lookup uses the concrete inner array's max_entries instead.
> The verifier can therefore accept an unchecked dereference even though
> the runtime helper returns NULL.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Keep dynamic inner array lookups nullable
    (no matching commit)
  - [bpf,v2,2/2] selftests/bpf: Cover dynamic inner array lookup nullability
    https://git.kernel.org/bpf/bpf-next/c/a3847994b4d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



