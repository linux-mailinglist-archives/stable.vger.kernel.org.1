Return-Path: <stable+bounces-266945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lpjaFQ46M2oR+gUAu9opvQ
	(envelope-from <stable+bounces-266945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:21:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E11EC69CDDA
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:21:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c8Xch6ww;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266945-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266945-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E71D30F2C08
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933923EA97;
	Thu, 18 Jun 2026 00:21:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8823BD05;
	Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742061; cv=none; b=Xmi6s7yBAYnk5wUahz9Q/h73pwYnZ5fF9TFQ5AVk8JUAy3ZVZXiffWh0ClGxZWsq4EA9/ZsAamsiASXPfgtJnbL2hzpXlPuFqZI1TLAbJZ6DJJSHr5ZM+e4kWBvNnq+8a73Bh7buXbH0N9ElYV4wJmp1zqRmQP+w9tvN/sZX+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742061; c=relaxed/simple;
	bh=lr8B23CUEuUVxrs018Ab4gVyzVvF5e+YytiPE25nT7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=THpcfQoqZOxiWGU442cLz5CrrSb/gq8XQi0jaVTM+Ni3kHdA88nWFPGGO/IsiKW0xWyorpx+Sjm0xbnPSSUz5T3qWz+MRElGFhp+KrOuAs1QtG/HoxV9AJLuB/Kwy+kivFy+QjOVVrX/uLqZSwpRowz45Hb0MUmSqrCHKBWpxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Xch6ww; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812D01F00A3A;
	Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742058;
	bh=txMSbLOB/VgDi7veIhU/GN1KySANA1CPKnIMDHt4Oz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c8Xch6wwdJpFFmMVVKziBBDAQvByuV4Oy7oVqymVt/blvGPHTOtgmFqLxz1i/I9af
	 OfYJ0lCtTVAXyQiiqaz/slhyrKB9ETzNIEXqU8bvVoQIRf3OrnAUdcuUaMucIGgPK0
	 0CFMcPvGY+spHbmXWmjjq3RAUD2Fv7MWYvRopD1xilUa5XEo2j4DstTQoeRj6AoFme
	 jDIx3YjsDnEsQLnVOXc97gvpHrBaPsGZ4gmkNyav/zP1Lgg7G0SMubNlorzvBAF9HE
	 s9JdG33aIoQOJUNwTYLrM6itXBI7BdKw7as4lEFb2hHVtpviwY+56C2kNA7oApmWPM
	 c1ZzRMqo2k8aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD2393102B;
	Thu, 18 Jun 2026 00:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev-genl: report NAPI thread PID in the caller's
 pid
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205225.1875263.7744214441467621571.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:52 +0000
References: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 razor@blackwall.org, dw@davidwei.uk, sdf@fomichev.me, dtatulea@nvidia.com,
 skhawaja@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266945-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:razor@blackwall.org,m:dw@davidwei.uk,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:skhawaja@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E11EC69CDDA

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 01:17:36 +0800 you wrote:
> netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
> using task_pid_nr(), which returns the PID in the initial pid namespace.
> 
> NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
> is netnsok, so a caller in a child pid namespace can issue it. That caller
> then sees the kthread's global PID, even though the kthread is not visible
> in its pid namespace, where the value should be 0.
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: report NAPI thread PID in the caller's pid namespace
    https://git.kernel.org/netdev/net/c/1f24c0d01db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



