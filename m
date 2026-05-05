Return-Path: <stable+bounces-243946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOCNDsBY+Wk68AIAu9opvQ
	(envelope-from <stable+bounces-243946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:41:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F74C60A4
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B0D3022049
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD86397E89;
	Tue,  5 May 2026 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcH6LH1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E248CFC;
	Tue,  5 May 2026 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948860; cv=none; b=b5L9bkI7HH4qT/bPVFoWWfzKJaqGkZUAYKU4UzoHfOytA4qgbpgaGDTwJe9Hd65DS5S71AY3eu/X1pElT20L7gy8A0ckdWE2VGRPuL/sxgl3gzGu7QL6sjD4tNA66x+fkOn1mnewd+2oL0Z+bdyperXKnpewxKgYh7j0/ZuSCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948860; c=relaxed/simple;
	bh=kewYXfUzdIkeNWsN6MjHUy9OQ1CKVy2bRDBrUaweY6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H3UQt0ipkw2QB4+ZgZHbuXQZXtWJq0Z/OL0GAMmyF1rfCCBt0gi2NpJTPS4FJ0AMHcZmJjaKrTh/TR3amEvEOzNZC/sv1xF3jQRYtrsqWSOCBqXZVI7YkDklfmMV33xPLNGD8uJsiuSAZL6OdLvFdXJXAfSu8MnLYLZVYRnZjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcH6LH1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE63C2BCB8;
	Tue,  5 May 2026 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948859;
	bh=kewYXfUzdIkeNWsN6MjHUy9OQ1CKVy2bRDBrUaweY6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KcH6LH1vxypoAbWZ4XTBQfo4AOouGKAaOxNJ5uH7KDDGU9bhFhxIiPN3WXQYS/CNi
	 eyIMIfreSjKmFfhvmdC/FkKpEzUKnuXQYqmNmDxX28W/GQyfiXOdWatV7+p6n3Qw8A
	 m6L5T0OPmpRzxIdWghf7DkNeXpLa2omm3rLkbj9iUY8ht3M2BxtUTb1ns0HDIZprtO
	 gyJLDuqHr1ygfo/NmhMiXn8+hljieXSmcJ0EE7l7pBXsqGLd9KCJLLB6MG5iBzmUxg
	 w1Pa8bvUhV/Tb5xN0Jb2MkGjof2MrV8GO5BB2g+0okh3l8KckpMhmpJ5h8AjatVRWP
	 XkgCztRK8FjUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE8A39301A2;
	Tue,  5 May 2026 02:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] psp: strip variable-length PSP header in
 psp_dev_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794881030.1397274.16980111626733324367.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:10 +0000
References: <20260502141945.14484-1-devnexen@gmail.com>
In-Reply-To: <20260502141945.14484-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: daniel.zahka@gmail.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, raeds@nvidia.com, kees@kernel.org, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, willemb@google.com,
 stable@vger.kernel.org
X-Rspamd-Queue-Id: D03F74C60A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243946-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 15:19:45 +0100 you wrote:
> psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
> when psph->hdrlen indicates that the PSP header carries optional
> fields. A frame whose PSP header advertises a non-zero VC or any
> extension would therefore be silently mis-decapsulated: option bytes
> would spill into the inner packet head and downstream parsing would
> fail on a corrupted skb.
> 
> [...]

Here is the summary with links:
  - [net,v3] psp: strip variable-length PSP header in psp_dev_rcv()
    https://git.kernel.org/netdev/net/c/30cb24f97d44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



