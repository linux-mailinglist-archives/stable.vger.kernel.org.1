Return-Path: <stable+bounces-233241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEowIb1C0Gk45QYAu9opvQ
	(envelope-from <stable+bounces-233241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A7398D2B
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D003010D8A
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399212FF147;
	Fri,  3 Apr 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkRzQi+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B2285CA8;
	Fri,  3 Apr 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256025; cv=none; b=dPlWZ/oIjuxP943YAxAZqADvWHyVOTSJsnnxDelViM2UME67CoePTZ6Tc3fc3QLh6j4ZMYtWaegX6R6GdEstq8TvWhSm7lELJlEjtmJKc0rtFPjHQE5i+VxNM6nTnXXIPhy8yA72qjIzEnlbBQWtXonVVQgCFXla0AMHsdwFNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256025; c=relaxed/simple;
	bh=uUOoAM0NBXbgJWjawmh5JOp+e0LvFkSpy4qwPhquyJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUTBgopuu8vxgtwmb4u2uy6Qeq+xEyxtFpePnPSC2WCNxpWpGflITLPhMDLg/hKCmAZwenzfl+HxAeteuMaRougwx3Gt0kf5zFmuHywuXzmVR2kAaL2himY27SWmBitbycZauQGWYEsZmZEiLQG53iNWkrORoot8wBDo+HETSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkRzQi+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3BEC19423;
	Fri,  3 Apr 2026 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256024;
	bh=uUOoAM0NBXbgJWjawmh5JOp+e0LvFkSpy4qwPhquyJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZkRzQi+jx1ZpzHHIHeKe8m3H+sCGCbvTWX3I6PvdmXu5sllX2rXzaM96wRtF26npd
	 dqPkjSUCWU3iWjuCFV17zNQViOJ5/IPaQzVNrbY3QUK0lgVZ5NwiYt2fQV+AJg039C
	 lu4Zu4lW/lWAuRX/UEnErshGW2sNAryXStYpZWX2t611T/9oMe3ibIUxDOPVW9XAm+
	 Fv8QIsCI8wT8fA4VkudAhigQaiZ0ejVoqx5OGe46miWouFvxF9GIckQx+yXUduzYXo
	 kPujNvKT0FlDAPRiHCNbJX/3fJXtKBDY0kgwr3Gf8tb12uAnRiccNZmWpeehFz5y/v
	 LXJmhO0twpQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD253809A14;
	Fri,  3 Apr 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qualcomm: qca_uart: report the consumed byte on RX
 skb
 allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525600579.1477337.14609521436581786813.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:40:05 +0000
References: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260402071207.4036-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: wahrenst@gmx.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-233241-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC4A7398D2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 15:12:07 +0800 you wrote:
> qca_tty_receive() consumes each input byte before checking whether a
> completed frame needs a fresh receive skb. When the current byte completes
> a frame, the driver delivers that frame and then allocates a new skb for
> the next one.
> 
> If that allocation fails, the current code returns i even though data[i]
> has already been consumed and may already have completed the delivered
> frame. Since serdev interprets the return value as the number of accepted
> bytes, this under-reports progress by one byte and can replay the final
> byte of the completed frame into a fresh parser state on the next call.
> 
> [...]

Here is the summary with links:
  - net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure
    https://git.kernel.org/netdev/net/c/b76254c55dc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



