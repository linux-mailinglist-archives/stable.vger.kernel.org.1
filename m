Return-Path: <stable+bounces-240529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLTgLdhv6mmizQIAu9opvQ
	(envelope-from <stable+bounces-240529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:15:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C90456951
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3F530CCA0C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9228F3921C3;
	Thu, 23 Apr 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYIA9S+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F52391849;
	Thu, 23 Apr 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971458; cv=none; b=S9RoxxZLhZCdp39/a8aFnCHctpDCzgwggj7Km+gFDZ182lBwpiM71xkOhtcojqnhH+UfXv7HX/Q0sojJWy9oHod4cTCWHFbRuGCm5X1Ct0/dYKeg9bJH2kr8GDouLVwKzQbrAtWXgDfw0EiGqRw5wuP4jKkAQVs6+GsvsmQrMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971458; c=relaxed/simple;
	bh=9e5VmGda+qwzIXQa0CxGLtz5GcJXNLvIIrfVCTCBjO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjnAfEQj7NXocfUb42RZrmyzTvVpmZKvb+Ijhx5XWpsw8t/f4h01vN1qC4BEK8RJSJyiUJjofDSBOzfyoZhfQ/QUmcJLRTZIiwefPdnsvstezOcG9xoJTOXhmxB42kgO3XOTH06t+8eHFYYncl4/QYvHpPjLl2wU6SBtq/FUYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYIA9S+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD8C2BCB2;
	Thu, 23 Apr 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971458;
	bh=9e5VmGda+qwzIXQa0CxGLtz5GcJXNLvIIrfVCTCBjO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AYIA9S+GLMVfGejcdOheLhax3i3sonxphi4pQnDk5eoZhC49JFJx7DdOsiAslwzst
	 SmkuUs9Tq8nyWmdabL9Fv1K1QOzYi4qcoSYaGELWOxfxnuLVaMkUf5J9JGDCqOmMSJ
	 EVqbjA6YzR406L5pzvNK4ppKlBt6vjnDyNF8HymEyr+GmTnnVF8qJFE89BeUd96v5e
	 IA3inSOaUY7KRFu9UDPMT+nTRbNzG3hnQmdmxWlg0JRtMZSesz1f4gqTQnIk4S6nFC
	 r6qIS5/fNwotcObxhcyAOIfIH2bNf3V9s4U1jPaPOpqBcSILPMu4BjbatY5fyukhjY
	 n9uS16TH94XyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDC73809A90;
	Thu, 23 Apr 2026 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix firmware version check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697141900.724716.10482126880651767158.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:19 +0000
References: <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
In-Reply-To: 
 <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240529-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07C90456951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 15:18:37 +0800 you wrote:
> For the device SP, the firmware version is a 32-bit value where the
> lower 20 bits represent the base version number. And the customized
> firmware version populates the upper 12 bits with a specific
> identification number.
> 
> For other devices AML 25G and 40G, the upper 12 bits of the firmware
> version is always non-zero, and they have other naming conventions.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix firmware version check
    https://git.kernel.org/netdev/net/c/c263f644add3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



