Return-Path: <stable+bounces-235382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I13IPuU12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B503C9FDB
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288B330166D0
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374837DE84;
	Thu,  9 Apr 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyIl9zWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E02836AF;
	Thu,  9 Apr 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736030; cv=none; b=Q+svbVONY4tuqiUqpGHRmJiZpHcE2CnWO6rZELVIf9h7XBIN1e1gvk2+0C511EFXrOLA6HJJ1StFPvZLBLCFtffF6BEd5LmnBlRc7L0EtxTV0KklsllU4VrvjwkFTldlx2HqOcTPz5JkKXgTiugBu3r+n/FpVdn6G/+fzjQl13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736030; c=relaxed/simple;
	bh=lbvScNZYIPTOR4yxwCLacsEW55HNZi7uSutPLOlvh5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaMKkX0n29a8UTP0ClGfbFcSGSK0vhqq6fJJ7T83ChNQOK04ioVH/Pt3o0LWOBcat1DkBtdcS0SrNz5cLgozUPl+M4Ue285LUoutWdnbIPI+UbQXE5uZaj3EI1xjZDuf78YmA00yu6m6tLcvgaJVOI/l7Io6xvrta28XxPv/YpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyIl9zWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A6AC4CEF7;
	Thu,  9 Apr 2026 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736029;
	bh=lbvScNZYIPTOR4yxwCLacsEW55HNZi7uSutPLOlvh5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NyIl9zWTdpRhccshvYmajwrsFttSdsGLO+PfdtfI1aViGsmXqGsdqIDJ0S6Hlh+/Q
	 9kPw/XmgWnI2Xo10GZQdEW0urBWZLJRBVxzOUCTjY7Z5/QovU/p339lvUQDvirxom9
	 3oB/OlZTxtiF6zYsRm5A1wcnwJ7dvu4hOicXts5UshbxjkhztjYqka0JB4NT85j/1M
	 iLBEkYzQ4+qFvxdPqtelxdlDSmf7MTw9hguj0YlGOl6G+2gVdtq6fuFL6HYWJNfJ/4
	 Yb+q6LDKzU9NybnvqoRpkzHnMgsfahiMTFeg3TbfPKQQQ/tdfbzo3Q//F3sRNAQkc0
	 6gTCQiJdbmPNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFB393088E;
	Thu,  9 Apr 2026 12:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] nfc: pn533: allocate rx skb before consuming bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177573600554.1141667.13480977622065542296.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 12:00:05 +0000
References: <20260405094003.3-pn533-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260405094003.3-pn533-v2-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, poeschel@lemonage.de, duoming@zju.edu.cn,
 rikard.falkeborn@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lemonage.de,zju.edu.cn,gmail.com];
	TAGGED_FROM(0.00)[bounces-235382-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B503C9FDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 5 Apr 2026 08:40:00 +0800 you wrote:
> pn532_receive_buf() reports the number of accepted bytes to the serdev
> core. The current code consumes bytes into recv_skb and may already hand
> a complete frame to pn533_recv_frame() before allocating a fresh receive
> buffer.
> 
> If that alloc_skb() fails, the callback returns 0 even though it has
> already consumed bytes, and it leaves recv_skb as NULL for the next
> receive callback. That breaks the receive_buf() accounting contract and
> can also lead to a NULL dereference on the next skb_put_u8().
> 
> [...]

Here is the summary with links:
  - [net,v2] nfc: pn533: allocate rx skb before consuming bytes
    https://git.kernel.org/netdev/net/c/c71ba669b570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



