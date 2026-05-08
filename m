Return-Path: <stable+bounces-244845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAKHLu5v/mnNqgAAu9opvQ
	(envelope-from <stable+bounces-244845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:21:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC434FCB51
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7ADA300D567
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FB32E121;
	Fri,  8 May 2026 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGEMfB7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834512CD8B;
	Fri,  8 May 2026 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282470; cv=none; b=LtEsMY+FH9fuXgPy2PgjExn9HPnf6bxJekrHeqBST0k44ws7s75Za3rGnMGRSwxwNOu+VBhzQm4UxFuM1O0nWRprA/iVckoJFeNpjWGisVcEyCJiM5KPhPmmRhszQ6ilumR7wPv4yt1YJBxr6V33NJ1DjuqYf0FskDBdnZZbpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282470; c=relaxed/simple;
	bh=jiBBAh+tYPq01D1+yZYu764BQl5VgaiQlj5egEd6T0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpQdJ7398MadzJPXmwlkLHsCyD7oqOkk31nO9owhi5sWh9HFMOBfGjT2ZenD97ECdmxUgADPWPE8NqubcmndS7mJjNmyCdDg6do8gp96wetcUBdYEihjAcFef/+ygVFnvFsj2M20QfKyTNuQjTT8ZvnLD8IiG5SusiI/c9awDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGEMfB7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269A3C2BCB0;
	Fri,  8 May 2026 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282470;
	bh=jiBBAh+tYPq01D1+yZYu764BQl5VgaiQlj5egEd6T0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGEMfB7a+7c7g+M7fl40Y1/cUSASCmqYG57gbOiuRivqSYO7Ftt6/G3ctm/cwL7xa
	 FA8/EBMRBzleoY7ayfyoTccvw2H58W4jrqx1BvFnfCjCQ6u3gZ1d8c7k0DvPTMQ7aU
	 W3WgwTAw8//YvOWCENb63O0dSJj94Hn/SuCdO4CNh66drMI2wGB817NTQDqZ8Wsgwo
	 9s5xFDpWhgpq8R76n8Kq4qJ/JdWxfBc0bXTErFafgRWaBqcNe5JUHdMRVw7ChxupyL
	 azNUEuSmrh95xB7tdLNMtyUxIh0UC+dn/9Rpg+LEEO+rXh+SoePCDA0P/3gVHPOjcW
	 D0ZWnmksKyPJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA838119DB;
	Fri,  8 May 2026 23:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/8] Intel Wired LAN Driver Updates 2026-05-04
 (i40e, ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828241855.890779.16522525518979245121.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:20:18 +0000
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com, maciej.fijalkowski@intel.com,
 joshua.a.hay@intel.com, madhu.chittim@intel.com, willemb@google.com,
 david.m.ertman@intel.com, ivecera@redhat.com, grzegorz.nitka@intel.com,
 netdev@vger.kernel.org, stable@vger.kernel.org, tactii@gmail.com,
 sunithax.d.mekala@intel.com, kohei@enjuk.jp, pmenzel@molgen.mpg.de,
 emil.s.tantilov@intel.com, horms@kernel.org, Samuel.salin@intel.com,
 gregkh@linuxfoundation.org, anthony.l.nguyen@intel.com, stable@kernel.org,
 marcin.szycik@linux.intel.com, bvanassche@acm.org,
 intel-wired-lan@lists.osuosl.org, arpanax.arland@intel.com
X-Rspamd-Queue-Id: BEC434FCB51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,enjuk.jp,molgen.mpg.de,linuxfoundation.org,linux.intel.com,acm.org,lists.osuosl.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-244845-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 May 2026 14:48:09 -0700 you wrote:
> Matt Volrath fixes two issues with the i40e driver probe routine, ensuring
> that PTP is properly cleaned up if the probe fails.
> 
> Emil corrects the initialization of the read_dev_clk_lock spinlock in
> idpf_ptp_init, ensuring it is initialized prior to when the
> ptp_schedule_worker() is called.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] i40e: Cleanup PTP registration on probe failure
    https://git.kernel.org/netdev/net/c/1619553b0a6b
  - [net,v2,2/8] i40e: Cleanup PTP pins on probe failure
    https://git.kernel.org/netdev/net/c/678b713ece1e
  - [net,v2,3/8] idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
    https://git.kernel.org/netdev/net/c/da4f76b6a84e
  - [net,v2,4/8] idpf: fix double free and use-after-free in aux device error paths
    https://git.kernel.org/netdev/net/c/6c77b9510829
  - [net,v2,5/8] ice: fix setting RSS VSI hash for E830
    https://git.kernel.org/netdev/net/c/b3cda96feb60
  - [net,v2,6/8] ice: fix locking in ice_dcb_rebuild()
    https://git.kernel.org/netdev/net/c/0ded1f36ba40
  - [net,v2,7/8] ice: dpll: fix rclk pin state get for E810
    https://git.kernel.org/netdev/net/c/cce709d8df6b
  - [net,v2,8/8] ice: dpll: fix misplaced header macros
    https://git.kernel.org/netdev/net/c/30f1658fc538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



