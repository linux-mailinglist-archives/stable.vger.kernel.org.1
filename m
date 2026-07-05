Return-Path: <stable+bounces-272014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yisoI20DSmo69gAAu9opvQ
	(envelope-from <stable+bounces-272014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 09:10:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AADDB709321
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 09:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SzW+ry2e;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272014-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272014-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3493300D45A
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 07:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D635676B;
	Sun,  5 Jul 2026 07:10:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FD18BBAE;
	Sun,  5 Jul 2026 07:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783235428; cv=none; b=tNG4TDkN2ax7nuR5j97e4YUV9pzeb7fi0/GJNKWIsqYIfgi0ATTvTswPm3KoCA3+YTC8k2Q70HQ5tSHdbeV0Rg8bs1ySaTIMbgpUB+8m6Lz6vaMMvu+Swiqc5+XU2w+oET1KJhiBsJvi5NvY0YAB0D9Ji5uMS+3pvS0vHeRndek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783235428; c=relaxed/simple;
	bh=lUzCzUI4dD1yXFU4jZ83WN0tPnOkGUz2pjoRIq8EFrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dHiFNOE+1IemZOthUvy/IU/tX9XeXZW8V4Ouj4lm/SyDBjTLhYFSUcHLxgDXb0IZ9RJvlE1JduxaB7F91efkpoZG4NfvsKfMHG72VPbRDYkC21K8BBjwYt3fsnxI2mjpWjeI/0ufmyza0gWojqf3Z2MnRI+l1T13Zxu6cKI02Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzW+ry2e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB01F000E9;
	Sun,  5 Jul 2026 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783235426;
	bh=yLqt6XvlOd9pDIhAXizheEtnZmuRGlHag0r5a930MTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SzW+ry2ePCYbOP2bavxU6ErlOYWH6qqf4Yr5oizEVjoE1xayupy4EU5rOQRh+vFa9
	 cVt+dHgzOn4H5nJi/4FM3NmlXqqzfD0cg5n/IPidvM9i2XH2szNGIdHExLNHFz8FtN
	 N4CzE2BEIVGZmrJFcDkPP92+2OiPXsDdQYiPCS1t3g+IWHZITMWAS1w478kaGxceKp
	 sNOWGF24AmOHER0HXLjQdaF04Si69zPfo+ebsDA5LHBLNBFK/uvU38DDZoNktuMiZj
	 e4pEQxC2pUhfgEY5HgMFGVc7b7dsPK4he8rr0pIl39X+VnOK4xacYVLvMGIW7e82ze
	 q6iiOWi54iQGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56894393A94F;
	Sun,  5 Jul 2026 07:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: fix SAP refcount leak in llc_ui_autobind()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178323540814.3748336.3025291993654697174.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jul 2026 07:10:08 +0000
References: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272014-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shuangpeng.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AADDB709321

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 15:48:56 -0400 you wrote:
> llc_ui_autobind() opens a SAP after choosing a dynamic LSAP.
> llc_sap_open() returns a reference owned by the caller, and
> llc_sap_add_socket() takes a second reference for the socket's
> membership in the SAP hash tables.
> 
> llc_ui_bind() drops the caller's reference after adding the socket,
> but llc_ui_autobind() keeps it. When the socket is closed,
> llc_sap_remove_socket() releases only the socket reference, leaving
> the SAP on llc_sap_list with sk_count == 0.
> 
> [...]

Here is the summary with links:
  - [net] llc: fix SAP refcount leak in llc_ui_autobind()
    https://git.kernel.org/netdev/net/c/660667cd4066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



