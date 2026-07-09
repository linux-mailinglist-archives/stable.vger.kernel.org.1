Return-Path: <stable+bounces-272993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95+7JhXVT2q3owIAu9opvQ
	(envelope-from <stable+bounces-272993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B4733B08
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jRLx1Lf1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272993-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272993-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E996305C3E4
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5843B6EB;
	Thu,  9 Jul 2026 17:00:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8543803E;
	Thu,  9 Jul 2026 17:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616429; cv=none; b=FDt6jeTbqXecDIIcZwBXRnnWRID/4LFRX/+DGVRujE8g11xTfi1Hx9JjtFgKUunb2EbeisHakVJ9xb7wWoLTarEZ9wHC/7/Ef38J+JeJJH2+aGBPW+FnIdzGcQQTj4bgXBzlMvcJW5pB6QYPtUGKrUCWa/v1R+nBKXmGWcj/pSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616429; c=relaxed/simple;
	bh=TE6TkSRxEPXrOws8eM+EkyEB3zf4y5nj8R7Jc/0QgU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ca26nOs4s/KG9bodZtgGAGSgDdHA6dzXBOdJSAcZ2JMAV8dNnEfg7msuCUv8abPxA5m9yuwX+V8h00SSA5uRYlLF3q+pTYSGVBmKGze8qR/myGeKl8Uc+uSsJw1OzuyRrNVGtOjDEclg0IeLoTEPc0otCOCsUwsTQ5thJDB4xTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRLx1Lf1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0671F00A3E;
	Thu,  9 Jul 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616427;
	bh=3Kfy72ehgyZBshTSOMM1niwkdrsNSED9pTDMvKT6/UI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jRLx1Lf1bH7VTcHD4HPkYz/7o494waP48d/i25rQtBBJ5L1vWa917pma5eh6KMrk+
	 aN0YbqrSeAR5hvrYMtiQDoivnTIuzACEtAMCefJa31AAIVUNjOxonPdfAe4DXxmIvh
	 UTEJQzQDLBjOyNI7PaK9YctMSix9rnNH6k0qF5UKxN67g+4lIbiCzz7HWAICZZKCpI
	 1KcUhYIpmLGoD5vEm5PnverDDNUuP2yVXIgQZr91b5YrgLldrqXJYabK45AMUBD8dj
	 zF5rHgnyBfB5SBa1UlIRoDM4aAYMDG0rcqgGeUcU80OhrXdifwbpWA12RtyBTsWMVn
	 mkD5nbuWYt0ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C5139250ED;
	Thu,  9 Jul 2026 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178361640615.4028285.12738139082638292350.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 17:00:06 +0000
References: <20260709025316.999913-1-mattbobrowski@google.com>
In-Reply-To: <20260709025316.999913-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, jannh@google.com,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272993-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:mattbobrowski@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:jannh@google.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F2B4733B08

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Jul 2026 02:53:16 +0000 you wrote:
> Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
> before bailouts that access it"), sk_clone() performs an initial
> shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
> the cloned socket newsk.
> 
> If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
> to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
> to the parent socket's BPF local storage. When newsk is subsequently
> freed via sk_free(), the deallocation path (__sk_destruct() ->
> bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
> leading to a use-after-free (UAF) on the parent socket.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix UAF in sock clone early bailouts
    https://git.kernel.org/bpf/bpf/c/7cbd0c4cebe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



