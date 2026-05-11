Return-Path: <stable+bounces-245091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGAQNu4zAWq9RwEAu9opvQ
	(envelope-from <stable+bounces-245091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 03:42:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB0506FF2
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 03:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A951A300766B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA820125F;
	Mon, 11 May 2026 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPgqVjhW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EC7081A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778463721; cv=none; b=tMuSRRUdFF3Lb6Pbct4bKDlGf9qN3aNUUPjb/T8ezfSo6T/Ykv+urcv77dbzITRXGEKSzeGrJ43qtSHqkMI89kOkY0Mj+qfK+R9RdoGR8g0OFqJXyDU/PfXW0Q0UedYnOOBklboTbLkhCso4XjT74dt7ZAANtEDDt6o8Q8YtsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778463721; c=relaxed/simple;
	bh=NhWA/tMq4xGZNefuWO6VqTj5/0PmjBtaHZj7SA7H4DU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B9mgHf+pBowJm/P6VOuIc6EVt3XLPQv4WVdIQsm4EmcFgOuWDEvIYZeBZ+8im9yDy8/TxPBxzdn0JBK2ja8Hzpo/itS9+lLhylPPu0OH3SXBzpTFFsvg1A46rOtdWCAGsKG4LDXjzPXAdg9sLnlh+UGGZ1oz3KNmXFlQYbpJHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPgqVjhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0366DC2BCB8;
	Mon, 11 May 2026 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778463721;
	bh=NhWA/tMq4xGZNefuWO6VqTj5/0PmjBtaHZj7SA7H4DU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JPgqVjhWEpTDzZENppPJjtZ1YPtOnuP83KywlJ3ezAFrxNIQlhJJfvcw00a/m+qTr
	 4h8JMBUVDuB3t0en1LK7R8s2yyb+j2/gMak5cHLa8eA8nGG4FpnC8gGaNqXy8RWwN6
	 AAlPsQ7PqW9lWBciEV6L1CvmPksyrxYj9vOswAEVCfwLGpkr+odnA5Cd+nSjOz0t9a
	 /I0dZV+76drglHeHgALvoy4dCAc91IOybTfEkDgCbW641Qf655bXY9Kb64xmyL7gAU
	 GLAvNfv5lQX+IyHm1/laAJtkObvATz51nI/ErZLlcmpaqnXxvcOEn+yTKcE4gIc0om
	 lJcUC9y8NqYBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8D3930039;
	Mon, 11 May 2026 01:41:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix incorrect FI_NO_EXTENT handling
 in
 __destroy_extent_node()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177846366788.1975880.13051192544864333031.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:07 +0000
References: <20260427131050.1526593-2-monty_pavel@sina.com>
In-Reply-To: <20260427131050.1526593-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, yangyongpeng@xiaomi.com,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
X-Rspamd-Queue-Id: 52CB0506FF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245091-lists,stable=lfdr.de,f2fs];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Apr 2026 21:10:51 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
> not reset the length of the largest extent to 0 and update the inode
> folio. Since modifications to the extent tree are disallowed afterward,
> the cached largest extent may become stale. This can trigger the
> following error in xfstests generic/388:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()
    https://git.kernel.org/jaegeuk/f2fs/c/5f8f16b73b46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



