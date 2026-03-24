Return-Path: <stable+bounces-230204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB3OOC3MwmkBmQQAu9opvQ
	(envelope-from <stable+bounces-230204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:38:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344931A29B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570E33179690
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211C40F8C4;
	Tue, 24 Mar 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhpT2JA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FB40F8C1;
	Tue, 24 Mar 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373558; cv=none; b=Cgiu9YdzLodfXx/2RXlMtZr+QBhm89qjwHiiH7S1M1DxaN0W0uqG+v1/73o/vByDLTpyl2jy/gFWGthOZePhODoeioVNv4Def5pmjPilblOmZ9/7P/rDPpLVz9OhUdGhBxS6+m22IJ9pVfs+YHY1OdGVe5cK2PpSHmLvA/s6Z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373558; c=relaxed/simple;
	bh=XjDWPFaC3BEJKzMiAmgWBIj7cF6+CCRqYnco2WSFGnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATIzDVUndSu+VyhVFYq+AguoFrh/3EufGldtzPd43osyQhEUtGKAS1hFBghu9jhtKYehPxGy4vkYBrWsbNV76c271ZUcBfRq4nMcACRnLmxN54YMOenfMn24u2X3U4WaqSbIef/BKOFPocDBSHcctflpEFyUa8zPNObt0gV46YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhpT2JA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75903C2BC87;
	Tue, 24 Mar 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774373558;
	bh=XjDWPFaC3BEJKzMiAmgWBIj7cF6+CCRqYnco2WSFGnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PhpT2JA0ObNIkBuHNxAA79hk6JzykVfGhWBDVI5O2y9jkV9B/VbeFEkTOKv2OKm7Z
	 3ePkQpp+l/LWjDgZ+fZ9Qmvy2c2aPDhTvAgenGYJYq7tLXrSOkg5L1Z8hxG7JntcXY
	 eV7e5cKh2BUXjx9Z7sUkNexVUusnCYESj0UX2StSwDWLHb8dO3LLZ9mgXmvi6hgjo2
	 ONLc1g4xzIPiE0aGgUHuBDmDoW0Vveahkb5QwJs6iRG0L2yoe2oKkEHDhSwuQt1F+4
	 oGOEb+Hebax/ZMGCF8II4o8LJz/KIlh0c4n9y4kqGvU8k9F9F6/ZK+MLAwSSOBTBrq
	 L17w5m+k/jHYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D07A3808203;
	Tue, 24 Mar 2026 17:32:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add READ_ONCE() for i_blocks in
 f2fs_update_inode()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177437354603.1223048.5695507886774694517.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 17:32:26 +0000
References: <20260318073253.3108313-1-zzzccc427@gmail.com>
In-Reply-To: <20260318073253.3108313-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, baijiaju1990@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-230204-lists,stable=lfdr.de,f2fs];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8344931A29B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 18 Mar 2026 15:32:53 +0800 you wrote:
> f2fs_update_inode() reads inode->i_blocks without holding i_lock to
> serialize it to the on-disk inode, while concurrent truncate or
> allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
> u64, this risks torn reads on 32-bit architectures.
> 
> Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
> potential compiler-induced tearing.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/5471834a96fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



