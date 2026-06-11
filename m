Return-Path: <stable+bounces-262819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YzNGIgA3K2qf4QMAu9opvQ
	(envelope-from <stable+bounces-262819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:30:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F4675A26
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:30:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DLwn2qea;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262819-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262819-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93DB4302F24C
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8193CF673;
	Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54472D1303;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217020; cv=none; b=NOir6LvFH/ilhqFhLnoKMRzA+/nCMBwByIAZAEvTPU/NCIlVBzAS5ew3YtJNSN3vaEYY023gwtF3D/mnXtW5g4sWKZdT1XaTed4xBJJ/M1lArUsaGr1L0xUa4K9vvF47Qf84ZyZZpp+1ePpCdobn3Ee1nY7B1pI5q7Ldb3WOoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217020; c=relaxed/simple;
	bh=eiT7h/e3FoeYoNZj6W0e0ctH5vKCvLL5rqIVcRkUu48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gnsacmLzHPnJb2H2HPS29i1WIrzH2qVN4CbMiwEsQzsAOm+HWo6PRFG6RQHg4uctBFNUDbPM/MUS589VbHoRrUW77UHAB2gk6YaYSRbb9crLd4jPntcbzezcOpsIqJYct+fFV7JqT1xyhvWGpsh4jvQeXJKMIHD8kqubNEQhABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLwn2qea; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A901F00A3A;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217018;
	bh=USld46YDXirMgWtuzZU2ioEbXHi6IBJv4M4nBp60DEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DLwn2qeaXXg7Z1JAyX+XncKWYMnsaPSFX6NgnJMygXUq8X0ZJhunG5aABOqSBCFw9
	 4IXenByviZQbHdNzUY3opiA/6+BZS1rRo7/2n0rhMPHvWjYTMQfrbKCm6312F6u7yU
	 g0fv+A2zH71O+elwBnT0BvbvYJ6Q3TfvVV+p6c0c56i+QyvajfxCnhMXJ7SjO8GW+o
	 PymucFWy+T1NbHrFIvRhz+KtHZfEx14uD2MXSShftY1Z/rclZsG/TRlvaKG5gBGhaq
	 gn68oXa/hYzyMiorWq6B6EvC3KAg9NKVXZ/ZstoM9eQDTFrIg+NXWGOM4pSrscp/EU
	 YnkEvOobYSSKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FB3930FAD;
	Thu, 11 Jun 2026 22:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701563.389578.2230008630812658511.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:15 +0000
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262819-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:linux-bluetooth@vger.kernel.org,m:alex.aring@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B5F4675A26

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 16:00:52 +0800 you wrote:
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
> 
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exported
> and can be reached from callers that are not necessarily covered by the net
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
> 
> [...]

Here is the summary with links:
  - 6lowpan: fix NHC entry use-after-free on error path
    https://git.kernel.org/netdev/net/c/1720db928e5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



