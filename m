Return-Path: <stable+bounces-273390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cyO9KXEiUmqoMQMAu9opvQ
	(envelope-from <stable+bounces-273390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 13:01:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786874156D
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 13:01:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FYxPvA06;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273390-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273390-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F1A301E5BC
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB33C141F;
	Sat, 11 Jul 2026 11:00:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE352EEE77;
	Sat, 11 Jul 2026 11:00:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767648; cv=none; b=XT5ERToIXYDGpskD0tucrWBg+Nrgptf7LkfvT/sbj96TuguD9NqpsFc/bSr/hVXEpq+42xn1PbDGCHrLrLDyxhwYwqcbEammGLC1DEZRGYGUd26Up1X0ZY6mtMWQsIhzHCnJkWDEblKSk2c27JHsoYzLogBDxtuNf0mAracKRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767648; c=relaxed/simple;
	bh=/Hdlq07QT6cec9QK0gjFqWA0md0uFPXBnWdFvSu/0Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUexbN0cKwoToNnHUBhp+X031jqKBEyOTDMRtRODSIAOYFqwk6ORlM0LJ999s08M1frKZsJIM1VYFrj0TsfoB+5V1vq9EMikj74kuN1ogVMJgK0gAam5AA3LQR0wfXoH2BHqf7oqXs/7LttFiWAmkE9qNdmlEVsH+/lJ0hPNMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYxPvA06; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B11F00A3A;
	Sat, 11 Jul 2026 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783767645;
	bh=RMERE8igQkTzeoIxLSMUT+IGfvTmPfefBtS6+cyZ/zQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FYxPvA067/yiHekLwDijewrrNP91l+omzrrkWrJu19x63lDZ9o03EQb/HxM3mI7cD
	 dMv64465VSvR4xyO7/kDECufj9rYhNJg67PTmSC+wW/4PrHTP73Y+54GwdDDzsIRZ0
	 hFM58dRqj+k0DlLwLguhgUzPbDNMuaiqEijVc3r00HbAfUwUiVKdpFqJtAap/51I7D
	 xVrG8aMn6EmG1z39T9Y/O/5rc4C4TJcJupZOtaJDvsg2F9R2pZem+X0Z/1x2Q/dUTN
	 T3hDjRDPkDfxdfbv9tSkmQ/GoSzXCKmi/dgRjeVu518FwWuwgZYcd0zTjgUJezUETp
	 +P5AcsV2y71uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CF339244F2;
	Sat, 11 Jul 2026 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: fix promiscuity refcount leak in
 macsec_dev_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376762213.1079343.12809475600428290154.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:00:22 +0000
References: <20260705113629.187490-1-jamestiotio@gmail.com>
In-Reply-To: <20260705113629.187490-1-jamestiotio@gmail.com>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: sd@queasysnail.net, netdev@vger.kernel.org, stable@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, atenart@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273390-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jamestiotio@gmail.com,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:atenart@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1786874156D

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Jul 2026 19:36:29 +0800 you wrote:
> When a MACsec interface with IFF_PROMISC set is brought up on top of a
> device that has hardware offload enabled, macsec_dev_open() first calls
> dev_set_promiscuity(real_dev, 1) and then propagates the open to the
> offload device. If that propagation fails, the error path jumps to the
> clear_allmulti label, which only reverts allmulti and the unicast
> address. The promiscuity taken on the lower device is never dropped, so
> real_dev is left permanently stuck in promiscuous mode. Its promiscuity
> count can no longer be balanced from software.
> 
> [...]

Here is the summary with links:
  - [net] macsec: fix promiscuity refcount leak in macsec_dev_open()
    https://git.kernel.org/netdev/net/c/7410d11460eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



