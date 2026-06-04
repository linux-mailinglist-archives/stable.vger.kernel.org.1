Return-Path: <stable+bounces-260245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t2bkLT3gIGoJ8wAAu9opvQ
	(envelope-from <stable+bounces-260245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 04:17:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2BC63C70A
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 04:17:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HfpdbyGw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260245-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260245-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8F5830C58D0
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032D2C3768;
	Thu,  4 Jun 2026 02:10:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F71B4224;
	Thu,  4 Jun 2026 02:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539026; cv=none; b=ICogqLVXXWLx2nIwCMHxZI01k33GIzOH27OS5swymTvq9dXIthiiJDYVz0QeA6iYyOYfN5NpLVz9JLtvfzEiTYDjxsshRsm4yqt2Fdr/OIidRowmWlrwE0Vq0udJuCcpmikZMPpRW89Ky6ICRrpmQrTL3lqzduMo8yvzX0cyvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539026; c=relaxed/simple;
	bh=4DLDconD/2DGw3LHooyZ8PUWvQ0OAuqVemZ6dg8/ag0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOtL8M5pZRY6v6VcwQeomJUJeyMCJ7b/Atxfmk2bZSW7y7YdzIeLMklMvw/Ck2W1hTCKyqRIIB1j6Rhh7O6q6SbjxA3hWmRjd416rVu/O1o8y3m3XmVZT1CtdU33W0ZMFD4AcTdDG0RxApq7slb1/Vy/9RaWNezoyYWQRsc+GQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfpdbyGw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FA21F00893;
	Thu,  4 Jun 2026 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539025;
	bh=pG79E8kqKE0hDvq0vf8BpvVSi3rFLjhO+VC4wu7V3go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HfpdbyGwKQokHbllafN4TwAung9wwtQg/MLIVNKYj1dsiFc635nQBUUEUpc3S6GdO
	 qZiIiaxq2ld2N9V2rEPeQTnnw+h8VKeiKzLhC8PfT43z6LtdwLMI/tqs9IJaEeclWb
	 N78Sy7RYvjRmtZO+NZiIMVugT4r8hXrC1q4UchdMdcakdBr5l3ixtvk5mSEHeXKngb
	 H/+isGn7crOt3eEew153jeehsS+OLZgq08RnP3r8YKVofAEyCbvRm2ZI+MsiipQ2JE
	 WIOyeFnINnfMdtjwBybvGmfovc9MTbds6DRMA8l50wbveSXBCozUdsxHHphqeVQQL5
	 us2Me+wcG0U4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC839308E0;
	Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/11] mptcp: misc fixes for v7.1-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053902614.2204548.2424372511848234047.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:10:26 +0000
References: 
 <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: 
 <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, cuitao@kylinos.cn, shuah@kernel.org,
 willemdebruijn.kernel@gmail.com, yangang@kylinos.cn,
 syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260245-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,strlen.de,vger.kernel.org,lists.linux.dev,kylinos.cn,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:cuitao@kylinos.cn,m:shuah@kernel.org,m:willemdebruijn.kernel@gmail.com,m:yangang@kylinos.cn,m:syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com,m:willemdebruijnkernel@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,ff020673c5e3d94d9478];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D2BC63C70A

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Jun 2026 22:14:07 +1000 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: fix missing wakeups when multiple threads are reading from
>   the same fd. A fix for v5.7.
> 
> - Patch 2: fix retransmission loop when MPTCP checksum is enabled. A fix
>   for v5.14.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/11] mptcp: fix missing wakeups in edge scenarios
    https://git.kernel.org/netdev/net/c/9d8d28738f24
  - [net,v2,02/11] mptcp: fix retransmission loop when csum is enabled
    https://git.kernel.org/netdev/net/c/d1918b36edca
  - [net,v2,03/11] mptcp: close TOCTOU race while computing rcv_wnd
    https://git.kernel.org/netdev/net/c/8ab24fdebc36
  - [net,v2,04/11] mptcp: allow subflow rcv wnd to shrink
    https://git.kernel.org/netdev/net/c/da23be77e129
  - [net,v2,05/11] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
    https://git.kernel.org/netdev/net/c/14e9fea30b68
  - [net,v2,06/11] selftests: mptcp: add test for extra_subflows underflow on userspace PM
    https://git.kernel.org/netdev/net/c/06fd2bec7aeb
  - [net,v2,07/11] mptcp: sockopt: check timestamping ret value
    https://git.kernel.org/netdev/net/c/57132affbc89
  - [net,v2,08/11] mptcp: sockopt: set sockopt on all subflows
    https://git.kernel.org/netdev/net/c/7690137e70ab
  - [net,v2,09/11] mptcp: check desc->count in read_sock
    https://git.kernel.org/netdev/net/c/c378b1a6f8dd
  - [net,v2,10/11] mptcp: fix uninit-value in mptcp_established_options
    https://git.kernel.org/netdev/net/c/5e939544f9d2
  - [net,v2,11/11] mptcp: add-addr: always drop other suboptions
    https://git.kernel.org/netdev/net/c/bd34fa025726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



