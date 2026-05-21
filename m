Return-Path: <stable+bounces-253600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFrrDYI3D2qIHwYAu9opvQ
	(envelope-from <stable+bounces-253600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2475A9995
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07F3230B1465
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906F368D7D;
	Thu, 21 May 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj7Pbl9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20A348898;
	Thu, 21 May 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376810; cv=none; b=hMyG2fSPDWLpyEewaGsHXBv0+IO7yKsc8RDzERmB3HzBT5nDX/C/GmbSM0T2atMs2P0KwOC+zVhMpHNleUi2sLoCHQp4RThGjiMpkyvEyC/TJoTz/5KksCmBND00n9088eI6YNQD1184szYocAmZPOfhzmXzXuouvC4U5wvmHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376810; c=relaxed/simple;
	bh=N2ItQG/2NtaeFXN+M1Phqahc2F/97KhTFbThO6r3iUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUQo/pPnVUc4k8YvVaQJQiJ6XIaGo0JGn6n5KXJhOYWKTsOc5smezgGbXxcT7dqt/ZZEnmGVSAzIUMY/iRkF2uD4H1US1b/Lv/gEdB/W4iqe5912FaMgnNryM5yTdKVq2MUU8qnB0pgWWE4uVX8/8z2t8/ja3kbrHeVomo1J8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj7Pbl9l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0443A1F000E9;
	Thu, 21 May 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376809;
	bh=MufHoQuSW1bxEHe3nQRvkLIIVe1UoUfMLvYeXvQ1rUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bj7Pbl9lfjCd6TjmlKfI8oT7zbzYfMogorru4Q6m1qRbazxsN2mEh8uqHR/zGh+kL
	 /rW/P2NHxQISZGpyccy3HMdrUCZegvKFcbvt1IuFwQqWGtqeBPRTNQWhqZNhC4sBlb
	 5NkoLJHgTxp8j0Q7WONKGqm/AbflA4yEp5XpEPBlEBEpvL45cy0kbBWXAjwfd4Bkwm
	 TwvXu946m037HkMkLRx1e/v2dhbHiBKpiKT5vWGWUdVqxlxgA9fKNVkjpRl5Qxp3xy
	 5sPaqAWmZ2Q6qNjaXRXXazB9GfAjX4ZSCRJudAKS2e49SFFjv0A/akK4x/Np4kMevC
	 3a7kC/xLHMaag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B43930E00;
	Thu, 21 May 2026 15:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: wwan: iosm: fix potential memory leaks in
 ipc_imem_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681864.379332.246212692451630771.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:18 +0000
References: <20260519062815.55545-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260519062815.55545-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253600-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iitm.ac.in:email]
X-Rspamd-Queue-Id: 9D2475A9995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 11:57:39 +0530 you wrote:
> The memory allocated in ipc_protocol_init() is not freed on the error
> paths that follow in ipc_imem_init(). Fix that by calling the
> corresponding release function ipc_protocol_deinit() in the error path.
> 
> Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
    https://git.kernel.org/netdev/net/c/c5d93b2c4035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



