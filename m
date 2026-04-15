Return-Path: <stable+bounces-238162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB9qJgnD32m9YgAAu9opvQ
	(envelope-from <stable+bounces-238162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B1406888
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E9903048948
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608E3E51E3;
	Wed, 15 Apr 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg04ZZiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A23ECBE2
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271866; cv=none; b=jUdc1juXGWoW1vlvsPRoI3PJOvcZCrGyvuOnUwCZBdxLnrMkWccuOYSyame+fbMfCh6MXg303CYxNRzACV78Hek47qSRbHm5HiT/aAlM82BjZ5FEc+btccMRV+04oJrqxAcu1Ubw0Y4x+Uo1KaGdIQsz6Feh21fwaO2ds9R1dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271866; c=relaxed/simple;
	bh=35miVx0G08ePpBXqcA0ayzPFY+95aTgCfrayDKUEhOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KyfRTfv6eAqFqBpfW5ORzsav6xr2w0Xy6720H43P45q3zofY8A7IccdcHd13jFTN42VGU20Dn/l2bWsYfQ1aG98MUHdJOj3ZB1q0qzgl8wrepwSYZseAiDZFvoRP11oLxgXr5Du9nUbiHPyMz+YbXz0pUuvhsRVSZ5dZjk5v7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg04ZZiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB5C2BCB4;
	Wed, 15 Apr 2026 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776271866;
	bh=35miVx0G08ePpBXqcA0ayzPFY+95aTgCfrayDKUEhOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dg04ZZiE+IcRk7+Q0cNZdKuJqq+CykO9VLGKxQBxvIOrwKuomWoiWDvLN5ai/Vzvb
	 MRxAvo3AL2vqJ8vpL7hw/t/wFe0FFeNbmoFD4ysMQMKSXMwHO5cA3sBUMjC7fRu+H9
	 ztOTINdok80i3hAjmnPuNSwJtMW4yy5S0sN192+sz+FoYmSIXiYR+QRwrO/0BSgwIk
	 9eRWuwvgF+/3rm0D28JwJSxN9nXHw2NNm+Csz5IFGjL93pLgK+VfzaZQMZoJ4beb/q
	 ESyx+pPhl2V0e8CJz0ae10Zofd6Ce7G07xz1gslw3pjNKbs/ba0y7iS/f4q2B8K6CP
	 wIbi5xER7+9sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AF8380A964;
	Wed, 15 Apr 2026 16:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix node_cnt race between extent node
 destroy and writeback
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177627183604.2303073.17250011751833572964.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 16:50:36 +0000
References: <20260403144015.221811-3-monty_pavel@sina.com>
In-Reply-To: <20260403144015.221811-3-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, yangyongpeng@xiaomi.com,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238162-lists,stable=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: AB4B1406888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  3 Apr 2026 22:40:17 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
> concurrent kworker writeback can insert new extent nodes into the same
> extent tree, racing with the destroy and triggering f2fs_bug_on() in
> __destroy_extent_node(). The scenario is as follows:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix node_cnt race between extent node destroy and writeback
    https://git.kernel.org/jaegeuk/f2fs/c/ed78aeebef05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



