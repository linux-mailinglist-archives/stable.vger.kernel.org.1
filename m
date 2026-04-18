Return-Path: <stable+bounces-238606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG0VEYLX42krLQEAu9opvQ
	(envelope-from <stable+bounces-238606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C859C422079
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820D3302F984
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2122334C00;
	Sat, 18 Apr 2026 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOdHL59l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482113C918;
	Sat, 18 Apr 2026 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539453; cv=none; b=l24OD5krh1unx3Hn7TwM9wYsof2eLATV/Mz7F10Xv9UGGx9NYzFNYWXDP8nOCZAcDCvrgR6iJSXww4w/Kh6CQGTvbqyw1way3QnDzN6jIay2MEfsyhPl19eqn04q7ITuxC1ET4qlKM9bVaEN83Wh2GGPE02uG3le5Sx5ZADWWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539453; c=relaxed/simple;
	bh=Sj5+wnQtM7E3xt0RnneBSPmJDWwVxa0EjawWxitKEM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1l/rFjy/A7gpzEWsIOF25Vy6hCPQWcDDzBYjNOxf87/DcKA/Fy3fTHpiLUyhMMKJEckvSqmvhGBLLRjFHfGswr8N5oW20zu2LTmK1/hCN3QaLzXdk4jRJbMmXZbaWhRqOyX/3pUa9t9y2lHTiWEOWR7B+VXz2P13Ne6AkKQFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOdHL59l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DDCC19424;
	Sat, 18 Apr 2026 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776539453;
	bh=Sj5+wnQtM7E3xt0RnneBSPmJDWwVxa0EjawWxitKEM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IOdHL59lxtRAHMWVAPQCap8c8LhP0xmgFDTC1UlfDakZmeRVdzsPN7UbqxqNOzxnK
	 3O8qjr3UDqFIhmu6CqjB9wxmXzptRv8TwzIjSSAKhlNwXXaoYU9QyIeNqsr1xqhCQn
	 Tn1PI+D6/7GQtsNHqSOxcbZeQ9uB4c460EIT/iW+5VFpH/gJOtrdfxBEGeYf6SxhfH
	 bMk130GiIoNzuhSuBXmC8K24etXPJDmuFetEY8eskDmbJYNZ4W8YmdpozlW7a7V/vy
	 gGpFvM5lnZkWhaKPwt1jktFL3Rzeu3SL3S5IpSf139bdxpXIJcH8NRz7DXd3lDM8Lu
	 TiYQQ+P+CReYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0FF380CEDD;
	Sat, 18 Apr 2026 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/12] Intel Wired LAN Driver Updates 2026-04-14
 (ice, i40e, iavf, idpf, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177653941955.506354.7945438888789009201.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:10:19 +0000
References: 
 <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: 
 <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, aleksandr.loktionov@intel.com, horms@kernel.org,
 sx.rinitha@intel.com, zoltan.fodor@intel.com, sunithax.d.mekala@intel.com,
 lgs201920130244@gmail.com, stable@vger.kernel.org, mschmidt@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com, kmta1236@gmail.com,
 kohei@enjuk.jp, poros@redhat.com, pmenzel@molgen.mpg.de,
 rafal.romanowski@intel.com, emil.s.tantilov@intel.com,
 patryk.holda@intel.com, tactii@gmail.com, avigailx.dahan@intel.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238606-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,intel.com,gmail.com,enjuk.jp,molgen.mpg.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C859C422079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 17:53:24 -0700 you wrote:
> Grzegorz updates the logic for adjusting the PTP hardware clock on E830,
> fixing a bug that prevented adjustments below S32_MAX/MIN nanoseconds.
> 
> Grzegorz and Zoli update the PCS latency settings for E825 devices at 10GbE
> and 25GbE, improving the accuracy of timestamps based on data from
> production hardware.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/12] ice: fix 'adjust' timer programming for E830 devices
    https://git.kernel.org/netdev/net/c/885c5e57924d
  - [net,v2,02/12] ice: update PCS latency settings for E825 10G/25Gb modes
    https://git.kernel.org/netdev/net/c/05567e405273
  - [net,v2,03/12] ice: fix double free in ice_sf_eth_activate() error path
    https://git.kernel.org/netdev/net/c/9aab1c3d7299
  - [net,v2,04/12] ice: fix double-free of tx_buf skb
    https://git.kernel.org/netdev/net/c/1a303baa715e
  - [net,v2,05/12] ice: fix PHY config on media change with link-down-on-close
    https://git.kernel.org/netdev/net/c/55e74f9ea7fe
  - [net,v2,06/12] ice: fix ICE_AQ_LINK_SPEED_M for 200G
    https://git.kernel.org/netdev/net/c/4a3a940059e9
  - [net,v2,07/12] ice: fix race condition in TX timestamp ring cleanup
    https://git.kernel.org/netdev/net/c/7c72ec18c2a4
  - [net,v2,08/12] ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
    https://git.kernel.org/netdev/net/c/fa28351f970f
  - [net,v2,09/12] i40e: don't advertise IFF_SUPP_NOFCS
    https://git.kernel.org/netdev/net/c/a24162f18825
  - [net,v2,10/12] iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2
    https://git.kernel.org/netdev/net/c/496d9f91062f
  - [net,v2,11/12] idpf: fix xdp crash in soft reset error path
    (no matching commit)
  - [net,v2,12/12] e1000e: Unroll PTP in probe error handling
    https://git.kernel.org/netdev/net/c/aa3f7fe40935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



