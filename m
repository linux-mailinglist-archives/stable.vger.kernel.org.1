Return-Path: <stable+bounces-240406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPWjMqac6Wm3ewIAu9opvQ
	(envelope-from <stable+bounces-240406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:14:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB144CD22
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47019304B815
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0335F61E;
	Thu, 23 Apr 2026 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/xBp8pz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208C3CD8BE;
	Thu, 23 Apr 2026 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917453; cv=none; b=Tz+9EuP2i8B3O5bWfbUyGtmRBPN/7BiCc0PBZbT9wRx7wq0lnXfAici7tNBzm9lYlMynY5y9uFVuDrnSYVPjnoLn+ftsXVOWBcqmTw2Q4Cc8tD/6Wkh+OPwDn9AvKqt3p+0xmULX7e54gn4U2VC0s5Px/HJrMENMqrvXndYw2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917453; c=relaxed/simple;
	bh=7PrAqKeeuYuMAPjtByCwNFHL4suwiiKJnZF01gaSZ3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uzay+HqZImoQ665S1cTG8PczgXLKqjRsbA6x1SwExBjRGrV+Xd3AK/j/fQv4RJvOtOEnnHKn60kioYi8al6mTJlyAPZkyHcBrhPzXXSXcO/L3N0OPiWg0NbioLH25Q35BqtC/kVp4hO4Yo0fTrCjEGl6X4nNQHDEjqoPVfe45Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/xBp8pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C98C2BCB2;
	Thu, 23 Apr 2026 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917453;
	bh=7PrAqKeeuYuMAPjtByCwNFHL4suwiiKJnZF01gaSZ3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H/xBp8pzVms05B9WXQruY3zZxnwI4cHd97+NUd/eBhBWwhTfvalw3+r8jhfsxX3sP
	 3q03xs/5WauSBKlSiXV7oWTxL7SdadChE8+tFzU7oof2J/6OPxg9l0nWlAmrvEvOPJ
	 /d/5uvoUrMtfhEWDDjY+KZAi4qYiI8BAIbfGjM5OH/op5PcfFnBivTc+FqvZdqpPkM
	 gknbApols7U4rUuQLP9yWBiR9QIsVUEcPVaJ1NYNN1fWUoOvxUxZjggwe4Acn+R7V+
	 tknI+gBWkO6CxTEhCSeyGRG7avlC8vVzZJSWO2hd9uVy1lrT5E9rIuKkRzsBdSCCmr
	 /M2/eNuPpApiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC653809A86;
	Thu, 23 Apr 2026 04:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] seg6: fix seg6 lwtunnel output redirect for L2
 reduced
 encap mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691741480.4152232.8683053471530230786.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:10:14 +0000
References: <20260418162838.31979-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260418162838.31979-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 anton.makarov11235@gmail.com, stefano.salsano@uniroma2.it,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240406-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,uniroma2.it,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85AB144CD22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Apr 2026 18:28:38 +0200 you wrote:
> When SEG6_IPTUN_MODE_L2ENCAP_RED (L2ENCAP_RED) was introduced, the
> condition in seg6_build_state() that excludes L2 encap modes from
> setting LWTUNNEL_STATE_OUTPUT_REDIRECT was not updated to account for
> the new mode.
> As a consequence, L2ENCAP_RED routes incorrectly trigger seg6_output()
> on the output path, where the packet is silently dropped because
> skb_mac_header_was_set() fails on L3 packets.
> 
> [...]

Here is the summary with links:
  - [net] seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
    https://git.kernel.org/netdev/net/c/ade67d5f5888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



