Return-Path: <stable+bounces-240008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD8qASai5mkrzAEAu9opvQ
	(envelope-from <stable+bounces-240008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB254346B0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDEF301CCFC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF53CF69C;
	Mon, 20 Apr 2026 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oViRbKJS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DF3CEBB7;
	Mon, 20 Apr 2026 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722417; cv=none; b=E0f4rRVczWVMbUpifKkfMuoW4HmhSQOsE+8Z4L8ImLf5Ttl/d8Wes7z6FmHQ+2QvL32QXZt+XCdjcKASDXNHqkjt64czt1MonO37j68NCFmZQ3/5uYlcQ8wfab38JfQZxHO9mfKfHbYYlMVB352V3/ZZgKQDMxTnxKhynRTse+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722417; c=relaxed/simple;
	bh=8eaVsBhzwhofyfaYGOtGkW2AdaGQQ5UfOrg4++NeffM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TvGMdDHXZ0rB5AKne1dhByy2lGye1UD+ZVxODQzFCFonz1ilLs5eiJbIFVh6INKLRR8DGgr2kWwMfcEdIDolg+RYKCD/21aqYUDbhnXMAgWnSPBnFcYEyCeCrltl3FbRFEivxZdfBi50U0+harx50W2vUvr6xJj4nNuYGI4uraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oViRbKJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305D6C2BCB0;
	Mon, 20 Apr 2026 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722417;
	bh=8eaVsBhzwhofyfaYGOtGkW2AdaGQQ5UfOrg4++NeffM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oViRbKJSofnVf98ErcnqFYxsxShFJkd3Y7V3vt0pg3X7vkifhXbvtC/z3nNDMlZEP
	 a5Gyhkg1/iqJX7HIH9jkzcWcHok9kbPjQASfskFW2f1KJqt9f3EyWuvEElxXD/uLxb
	 AG+jSNAjKOrGK7uqC3/7S+WJVZb87Xz+uJ2vhmOGiQ75LhTFDWDa6eRzkFVcFTaY4M
	 70ksSvhJtAbZ2LbKVp+VdeQL3ejmZgRcdUVHPnjeUUYVAmCvMSWIAfQS2ZUdjxxKWN
	 lOVboquZA8NcxlxxOb+Vs2h+V0xPhoVY5X45obqx4TaI3TNE1bjWgBE4a/FbxGtMpo
	 04CPz2knp6Ojw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA13E3930022;
	Mon, 20 Apr 2026 21:59:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: fix don't require received header reserved
 bits to be zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238155.1802062.6794482710676496354.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:41 +0000
References: <20260417141340.5306-1-yuanzhaoming901030@126.com>
In-Reply-To: <20260417141340.5306-1-yuanzhaoming901030@126.com>
To: wit_yuan <yuanzhaoming901030@126.com>
Cc: jk@codeconstruct.com.au, yuanzm2@lenovo.com, matt@codeconstruct.com.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240008-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FB254346B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Apr 2026 22:13:40 +0800 you wrote:
> From: Yuan Zhaoming <yuanzm2@lenovo.com>
> 
> From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
> the MCTP header contains a 4 bit reserved field, and 4 bit version.
> 
> On our current receive path, we require those 4 reserved bits to be
> zero, but the 9500-8i card is non-conformant, and may set these
> reserved bits.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: fix don't require received header reserved bits to be zero
    https://git.kernel.org/netdev/net/c/a663bac71a2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



