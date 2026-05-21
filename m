Return-Path: <stable+bounces-253598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIAVBFgwD2pSHgYAu9opvQ
	(envelope-from <stable+bounces-253598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:18:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3065A9172
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435493239AB0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DB357D11;
	Thu, 21 May 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaCVjfya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8300349CFB;
	Thu, 21 May 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376805; cv=none; b=oEjtBJ7YgO000JkwVOE2MJPKGJJOFgmTxoNSTm/3RPUsNm7G8wlQAHi8nwYA9OQbOJbY30gCkoj54gOWrQLSTQvuoYQ7bJtzMWJVqAYADPhs5dIMnU09dGavizQURrac7zgkHWKK1fbfC647NDQnYwyb5QgWuGrKxQL7CZLFXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376805; c=relaxed/simple;
	bh=SnAbICt+sFNLmOpdQqMMqbTxXg08miDw6DF34MkSvCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfNwzZZ1cTiT3ETdfdh6NNHA/jCTjP0OPOrjMER30xQDPPDY9Dh8NRLuwO2INMBMjYfeF16wFgQNTypHSkYTNB4eoiAmri1bhNNp4FxivcZVcXOF79Pvek1bKFZxlNGZPIfzPz0ysKSpoLc0u5zvA0AcDa/EqjISWA1PRxjogTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaCVjfya; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCA91F00A3C;
	Thu, 21 May 2026 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376804;
	bh=XuGkmvh5hLugoY+Ffa+rGH+vw37ScgDVNuo5fB8zqU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HaCVjfya3nOEa97oGkCfmw4F6WExRTQh1rNExhRnXufBMrgWif7o5GdYOnKXfVLvy
	 ORiWt39+R/8AqUoraqk8NVWwcejFYVQg52NRISJx3pUSqiK0XJ2ZWpLiFjXo9eTK/w
	 Ywea0CqVUVYlYjI21pOOMy+2U0X4jua5Xk9m87jp3xLRsdf7WPlKkQ8FpHthAnYPQB
	 Oiwqjvpz2hIVSBCWfdoJszp0kmeoicjcSDrdK7vrT8fCe2pSfkUIAT8edDEMO116kT
	 G5cO7lAhdcBICCAggjJx9nZyNGbJGnl7awnKbrHreeI+VfX+NC+/iT6GW+QufP9FZY
	 cgNCu8GdEGREg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C93930E00;
	Thu, 21 May 2026 15:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] qed: fix double free in qed_cxt_tables_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681438.379332.10701744949542256391.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:14 +0000
References: <20260520070323.2762379-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260520070323.2762379-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kees@kernel.org,
 Ariel.Elior@qlogic.com, Yuval.Mintz@qlogic.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 zilin@seu.edu.cn
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253598-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B3065A9172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 15:03:23 +0800 you wrote:
> If one of the later PF or VF CID bitmap allocations fails,
> qed_cid_map_alloc() jumps to cid_map_fail and frees the previously
> allocated CID bitmaps before returning an error. qed_cxt_tables_alloc()
> then calls qed_cxt_mngr_free(), which invokes qed_cid_map_free()
> again.
> 
> Fix this by setting each CID bitmap pointer to NULL after bitmap_free()
> to avoid double free.
> 
> [...]

Here is the summary with links:
  - [net] qed: fix double free in qed_cxt_tables_alloc()
    https://git.kernel.org/netdev/net/c/2bccfb8476ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



