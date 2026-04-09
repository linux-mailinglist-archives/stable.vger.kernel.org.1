Return-Path: <stable+bounces-235299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Gc5GyoV12k1KwgAu9opvQ
	(envelope-from <stable+bounces-235299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:55:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C93113C5C6E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5BA7305AD67
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7B371067;
	Thu,  9 Apr 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl7VHVcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108F36EA8F;
	Thu,  9 Apr 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703078; cv=none; b=hPrQAQy5n+CfvONg3FttUDvh3PX59mMefZ8wl+xBpbCHbox8lRhv70dDSuQ4Xvi21/KC/A2TOP2mvPLKVFGDM81Al4S4PMj2AL9HpoYHKOzHSFOsWGljDmaKK0eRpNmnlduFcicDaHhcm6yCBX9zyS8uBmTj7kvxT/Vi/iDQg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703078; c=relaxed/simple;
	bh=tcfDya9MYNNiDKrZlg8HsEmnKPVeUFjzwubY5+gbTFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oNt6Ru7Xiq7Nc3hAKwPDu9RaRteVr2GFfz1AQArYMYEauP4IpzFGjeatA9m94TZuuaHMT1ovzyQCpmT9Rdgke8HEq3XS8b2fRpH3Bihq+osbxw+0WP7h+SprqW/Z4aVdmbCsLsLDoTPFf5HiTDZ0HX7n5D5szKecLbwfox0OK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl7VHVcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181E2C2BC9E;
	Thu,  9 Apr 2026 02:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703078;
	bh=tcfDya9MYNNiDKrZlg8HsEmnKPVeUFjzwubY5+gbTFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kl7VHVcr1JyqWb1Z1fexDnvGjkAOnEmQsa5UPZx/a4e5EKArWPfrvGoDZA80sJ8FU
	 mhYJqTCSE8zpvvOBqXbb9pVSoJHORH8W6u1/WS11f67tEp/60uYFstknCMfMivpz7R
	 91DnTXgd0lCgL1ka4Nk45/dd2Cmls5i0JUfAlE6HGCrCykuWDV4V3F/Ii2mZliY0Y0
	 kQ7e5cnDhE8Iu8xLESsTqnT2XrjdVAbygp0Wyek01/PGA3w3L6RvPRliivHZE3k5/c
	 f2dBSd8ofN3OFuV++0TFV3x0x+m6gAceJcXj4QGNgS9xn+TnMbARMMleqPxuf45vOC
	 yjYNGa5TcVbaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE763930793;
	Thu,  9 Apr 2026 02:50:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] Revert "mptcp: add needs_id for netlink appending
 addr"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570305429.968772.9148300524372539778.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:50:54 +0000
References: 
 <20260407-net-mptcp-revert-pm-needs-id-v2-1-7a25cbc324f8@kernel.org>
In-Reply-To: 
 <20260407-net-mptcp-revert-pm-needs-id-v2-1-7a25cbc324f8@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235299-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C93113C5C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Apr 2026 10:41:41 +0200 you wrote:
> This commit was originally adding the ability to add MPTCP endpoints
> with ID 0 by accident. The in-kernel PM, handling MPTCP endpoints at the
> net namespace level, is not supposed to handle endpoints with such ID,
> because this ID 0 is reserved to the initial subflow, as mentioned in
> the MPTCPv1 protocol [1], a per-connection setting.
> 
> Note that 'ip mptcp endpoint add id 0' stops early with an error, but
> other tools might still request the in-kernel PM to create MPTCP
> endpoints with this restricted ID 0.
> 
> [...]

Here is the summary with links:
  - [net,v2] Revert "mptcp: add needs_id for netlink appending addr"
    https://git.kernel.org/netdev/net/c/8e2760eaab77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



