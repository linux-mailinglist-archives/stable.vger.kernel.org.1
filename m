Return-Path: <stable+bounces-224756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA5DEErUsWk2FgAAu9opvQ
	(envelope-from <stable+bounces-224756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:44:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6426A1FA
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117953214668
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D77375AA1;
	Wed, 11 Mar 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmaOAUwM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328F355F43;
	Wed, 11 Mar 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261609; cv=none; b=iqduohFVvq/rp0lKNVeI0AuAAZHDsM/FmfyO6ehK8Dgy2AkmPRiezm5JBDZ6BNNJQAKwSQKvTIXiOnSf7JGNS0tnmV9Ewexu8h6TPB7WsDOq8DreYLtkaXaOalN1GOBFaSYzSzUxbIhM+PQAQEw3DsIjb8TzBcrqvSyHFpGBD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261609; c=relaxed/simple;
	bh=xjOXRjAw8P7R+jPLlL9/9ff6GKlKztkkP64eaUB2QH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VqCI8c2t3xPdH7ppc0bjbPfN5TyjWx86R86uErdLGOY44fYWzErkjbJaJpSYUelCmQ1elQbcYKnfs3t0S9QEhjf4GDJqEnGKWwp5pgonj8BydHUDOwZg0AYFqrPqYAYXWJgNmqpKjCHbuWthceQXUR28JxFBVA1Xeq6IAJ8ciaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmaOAUwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E94DC4CEF7;
	Wed, 11 Mar 2026 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773261609;
	bh=xjOXRjAw8P7R+jPLlL9/9ff6GKlKztkkP64eaUB2QH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cmaOAUwM23Fk+VBPzUZgQOvdmgjh8Ap3Oq3CpgmASX697KPuxcQwexXsbfaaqrFwJ
	 Xy0Yidp/txT9P8FY/jKZKY70so3Iu0mVcTiIcGBh8YgPpqByBzBLxj89o8/WTRbesB
	 acUOG0kxUupuOot66309IceeSZrWQajzHbs+7BdlXrSYoZJVmo7mb348C696M7G6z/
	 wkqnKwBe2W3U83DCSVNEVkgjXKpJSS35875S33lU4Y9uI3dWHhx7SAFt3kxccF7q91
	 i9um6ew2X6hFLPVtFuDT8Z7Vrkv5ppmgSa1ix5OaLv4c+JapzyzDVAqHito4f+psW2
	 ddtKAUVEbcsAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400543808200;
	Wed, 11 Mar 2026 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Fix type confusion in
 l2cap_ecred_reconf_rsp()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177326160505.3825078.5494696888868666095.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 20:40:05 +0000
References: <20260310215947.35756-1-research@johannes-moeller.dev>
In-Reply-To: <20260310215947.35756-1-research@johannes-moeller.dev>
To: =?utf-8?q?Lukas_Johannes_M=C3=B6ller_=3Cresearch=40johannes-moeller=2Edev=3E?=@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 stable@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-224756-lists,stable=lfdr.de,bluetooth];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.929];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B8A6426A1FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Mar 2026 21:59:46 +0000 you wrote:
> l2cap_ecred_reconf_rsp() casts the incoming data to struct
> l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
> result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
> with result at offset 0).
> 
> This causes two problems:
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
    (no matching commit)
  - [2/2] Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
    https://git.kernel.org/bluetooth/bluetooth-next/c/4b0c8bb9885a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



