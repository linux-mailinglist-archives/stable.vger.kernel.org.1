Return-Path: <stable+bounces-262818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0SmLLM0K2r84AMAu9opvQ
	(envelope-from <stable+bounces-262818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C867595B
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:20:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MsWiQCa0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262818-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262818-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886AC33202A5
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAF36A379;
	Thu, 11 Jun 2026 22:20:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10352F549F;
	Thu, 11 Jun 2026 22:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216413; cv=none; b=cctZ/+7Y/GDSM8UavzHExpSi9ma23ijrHUWWmlLLtsUN+Nqx2wdVZBMX2xZYGrCBCWR77V7ghaHEbuidsJ8T6MQ4vj6fTAxsj/h0nioA67VmHlUtmf/U+C/XqQH0TKvSaxdgzXKowipkUUbLb1JCR44jxUMsPF4SHWfcoalSFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216413; c=relaxed/simple;
	bh=wjYLPNMgwXIe942a/D6Rh7N+qvKWaLydMg/rZsocfsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKbsD/VvRXUaYOsJ8vUqrVpgHwAeDIq3Sm64nVXYjqWCtXoCh3mDjD4j4t6mNhFZ3xHwPWYl7EHcaHpi5yCfcjf5fJyivzTDSb36TC/volGki+DaLZIalTAK1IZVjuDL9WQZ3XZscSxZE8cEYKX6JAMuZDrdi+7boZdi//j/Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsWiQCa0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B3A1F000E9;
	Thu, 11 Jun 2026 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216412;
	bh=bwKO20aIj6Z1fgQW2J2GQV0+X9nndAyXDu+Xqu+HI4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MsWiQCa0Br76RkRigHK0t8ZR/79wXVymmTTo8lOAo+NHanGloK9uS09gxePMb5gZP
	 20FqsgpZ5hVybuGCJpzZVo994QcqmOdYtBoqM9ULrbyaN5oEvf6ZPy/XEqWPZb3Mqa
	 qOMUofP6E0DoQw/s6kRiM5v0rJFEj9IEqZogFGfABIp9Ji4Bc/c31gBdc8qSwF0JTH
	 Dc/z19bw0Tw5ekP+Uc0femzoxXh3MF1q9X52ZXhNrnynEW/MVHjjXbwfPz/64AMaUN
	 qrjCB4crw09UqbiXi3N2fn+6iR+/pSD9gMCG6hZakXXs1VcxbAoEP7H5oJgruy746g
	 AbaxOn5wHBezw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09653930FAD;
	Thu, 11 Jun 2026 22:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bnx2x: fix resource leaks in bnx2x_init_one() error
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121640938.386394.3435821664297211443.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:20:09 +0000
References: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ariele@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262818-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:lihaoxiang@isrc.iscas.ac.cn,m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ariele@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 038C867595B

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 15:46:10 +0800 you wrote:
> bnx2x_init_one() falls through to the common memory cleanup path for
> several failures after probe has already acquired additional resources.
> 
> If register_netdev() fails after bnx2x_set_int_mode(), MSI/MSI-X remains
> enabled. If later failures happen after bnx2x_iov_init_one(), PF SR-IOV
> state can be left allocated. Also, failures after bnx2x_vfpf_acquire()
> must release the PF resources before freeing the VF-PF mailbox allocated
> by bnx2x_vf_pci_alloc().
> 
> [...]

Here is the summary with links:
  - [v2] bnx2x: fix resource leaks in bnx2x_init_one() error paths
    https://git.kernel.org/netdev/net-next/c/034b95cf69e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



