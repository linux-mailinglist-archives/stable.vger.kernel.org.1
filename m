Return-Path: <stable+bounces-263024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tgcqGUjVLWrrkwQAu9opvQ
	(envelope-from <stable+bounces-263024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 00:10:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55167FE11
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 00:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=osZ8SvrQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263024-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA28F300362E
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136B3859DE;
	Sat, 13 Jun 2026 22:10:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3242E8B6B;
	Sat, 13 Jun 2026 22:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388611; cv=none; b=qiF4LoIznQKqXHdW3TyYSL3xC8Z5OUQvtOt7JcwAVUza6oiPOc7gMGLdVqwVbWv1O8Hz3ZqM0Ddm9Kuj89QzGmiZQYEV0pLksx3yKS8enG3lf1lgDC0ErEMLnwvYmAgXBpW2uGNS1UXcv6A2MoDTQDFtn8+zfWuOE/WDNYmI2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388611; c=relaxed/simple;
	bh=Ty23d+ua1dqkGA4hPjCbufVnZC9y/OdJE12hi2dRnP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCMxfOqICcqVwx7a1lVFeBLbADHRqeSH4BoaL768DGLdf/Z7uKW6KHsbeKZBoo4xIlFVoA6VBC8flgbp1oF0JEQlSR+XGgueMmSoBvZaBfcLT2+oy+zGrQ5PlSxm7yfoCe4eaWVHcrp9VDfJIsyV1mak7i9ysBAWcOIjeNggsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osZ8SvrQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFB81F000E9;
	Sat, 13 Jun 2026 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388610;
	bh=4PTIGDi9ER6F/Yu8r3U5jD2WB/pK85HSolNv8DfWnrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=osZ8SvrQ1ktcypllHLzzxml6/ZuuL3fadszmGsWMeoZtcrdlVpmmdTTYVSHbtX3dl
	 wU7xCH2dhkBkAZq//nHME9Va/P3RCTEv42m2EPq7tf7TBFQOK1mSqtn4z74KGYc6m4
	 AbBRX3rByLIwTJ601PMLVcjrSzCU7VrNsovmOjAjBOfF0oE2h93DlKETPMTw6htabk
	 E+/zMLg1JZ4oaYxhfT2RFnGkwQN80TqMLZ19uqlbuaNd5kIvVCBjA3hdWwbvXelbMC
	 S+i/7a3DJHN1e7zMX3t7EK9QtUtVqMeuopgWXO3mT2KWmfXQIe4Vu/T5kPWmZtIQoi
	 ZMEScEke/SYCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A073A54A32;
	Sat, 13 Jun 2026 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138860672.1607522.16960084358181288406.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:06 +0000
References: <20260611135647.3666727-1-lixiasong1@huawei.com>
In-Reply-To: <20260611135647.3666727-1-lixiasong1@huawei.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: jmaloy@redhat.com, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263024-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:lixiasong1@huawei.com,m:jmaloy@redhat.com,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:tuong.t.lien@dektech.com.au,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:yuehaibing@huawei.com,m:zhangchangzhong@huawei.com,m:weiyongjun1@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B55167FE11

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 21:56:47 +0800 you wrote:
> tipc_sk_enqueue() runs with sk->sk_lock.slock held while the socket is
> owned by user context. The spinlock protects the backlog queue in this
> path, but it does not serialize against the socket owner consuming or
> purging sk_receive_queue.
> 
> KASAN reported:
> 
> [...]

Here is the summary with links:
  - [net] tipc: restrict socket queue dumps in enqueue tracepoints
    https://git.kernel.org/netdev/net/c/acd7df8d9554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



