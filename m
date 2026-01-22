Return-Path: <stable+bounces-211190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJNoI1WKcmkPmAAAu9opvQ
	(envelope-from <stable+bounces-211190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 21:36:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F46D745
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 418864FDA81
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4B3D410A;
	Thu, 22 Jan 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc5lu1/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DE3B8D70;
	Thu, 22 Jan 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052612; cv=none; b=tiWZ7RLREtD0p9ejpeoYu7R3hSAXMjUhtLBuQ7HMfQxBBxq0Yw2RgzqQt2mgdygEAuV8JTIPEn8SczBCddI2NLAQBLkXw9vtR/aWas1FNDM8f/cYmQJmkjnz0lhoVKgzRVFxfIuS6gdTHHRqmunOcqSJerfTmMVVfOH+pUSb6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052612; c=relaxed/simple;
	bh=aJNwTCZb6sShIfW52PUO8eHOwbjSWHh0BTCf90rQXrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=isQwLbAOt5IWxqH3BZw6f0mzaXA7TOnS/So1/N/kMZo9HCmv9wSt8pbAAlMwxjn+7kAFvDALqn20Ix/MpJso0Yp6AlNm9sMA3CCwjxuP08C1edPS9LHEvnKXyHIPkf9qD9Hol77dp3i8TXSXhWLzni5wSifibbGhRsMfJx83OvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc5lu1/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F26FC116D0;
	Thu, 22 Jan 2026 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052610;
	bh=aJNwTCZb6sShIfW52PUO8eHOwbjSWHh0BTCf90rQXrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pc5lu1/rrM/RHWvVTMKHan3dpFgwrs4dWduPZyHC8LNpyQGy6WNzJvCzYOKaw8+/l
	 fw9Eg6PBBce87qvU3ea1t2gTyR/TYgjNpNYn1CmSwSeTDJ8qVhNV3Wy7/qP1kuKMWT
	 RMJxqCHA7Le93VgBW1EgAB3pAUst+7ual0TbEDjGjHv+2ZB+BbGDObjMqpQR7jF+Qt
	 2I6W7fS+EWWxdAmDok5VEAJ/GzmZQAc3jkq6udLfwA1RSAOf+WFB9f5YA7OkdJAiwI
	 Xw4Y0DoJ6REp+Lqf03x00ojNDHcNIj0sJ59JjL6ybUhzfFLnGJKJdhThQkUinx/4eI
	 AD382NCdkeaLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB1B3808200;
	Thu, 22 Jan 2026 03:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] be2net: Fix NULL pointer dereference in
 be_cmd_get_mac_from_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905260710.1542867.8147787917289306815.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:30:07 +0000
References: <20260120113734.20193-1-a.vatoropin@crpt.ru>
In-Reply-To: <20260120113734.20193-1-a.vatoropin@crpt.ru>
To: =?utf-8?b?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuSA8YS52YXRvcm9waW5AY3Jw?=@codeaurora.org,
	=?utf-8?b?dC5ydT4=?=@codeaurora.org
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sathya.perla@emulex.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.74 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[kernel.org : No valid SPF,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[kernel.org:s=k20201202];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211190-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable,0L/QuNC9INCQ0L3QtNGA0LXQuSA8YS52YXRvcm9waW5AY3Jw?=,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,crpt.ru:email]
X-Rspamd-Queue-Id: DC6F46D745
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 11:37:47 +0000 you wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> When the parameter pmac_id_valid argument of be_cmd_get_mac_from_list() is
> set to false, the driver may request the PMAC_ID from the firmware of the
> network card, and this function will store that PMAC_ID at the provided
> address pmac_id. This is the contract of this function.
> 
> [...]

Here is the summary with links:
  - [net,v2] be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list
    https://git.kernel.org/netdev/net/c/8215794403d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



