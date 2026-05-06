Return-Path: <stable+bounces-244297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +McENr6l+mm7QwMAu9opvQ
	(envelope-from <stable+bounces-244297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:21:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE144D59FE
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0414A303F050
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B52C326F;
	Wed,  6 May 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtUyASib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9F2C11E7;
	Wed,  6 May 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034064; cv=none; b=XoBlsXm8pHAowoq4YsCq1hfce3t7wIeWotKF5aVFV/0DymA5jllRXoKOGG6FDaDM1SQ4ShWBZI7U0/LsFQlYwoAOXSGDeNlYn4tihfTyRilX3Gw5AyX3d0qMay4NhAlixo0rkxIJ2S2QTBzks3qCLRpvVNzgfFk0cieYExnf3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034064; c=relaxed/simple;
	bh=uak8MiPsNhbw8749asyyjd79ZMTu9zFU8nIh0UuRbXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G5dk2Ocv48KV9OsqoG02pSrU8Mp1lsqhaeu816xpR3RCV9kHgvTWXhDbIpAZPp1k7j3AxXAGu1X+8LsQGS5F0nfV+jHmdIolC6kL0yeGBojeHoihlTUfvfEhAuO85eoO8rL4zZXBEe8IJQvh0nbS+2N3kXw3RH/99M2tx9QC+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtUyASib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B758C2BCB4;
	Wed,  6 May 2026 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034064;
	bh=uak8MiPsNhbw8749asyyjd79ZMTu9zFU8nIh0UuRbXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MtUyASibegxpQ2Zxb9Mv4RYEdyofyLW47pS9EuqSSRJct5qV1+WSbEUSpzDeq/Vuk
	 BbIDGMX5xgzrjt5d/8SIO3KNDXwTPdHiW5kClU1F7GzfV97xMe6sfQpShx+c+W/iyf
	 5HEd90MDvyqkisyTEBysWwFusoAaGVpZy6DxB/PIwfmJPY0dsK4+opFzN8yWq3Egzb
	 Zsj9KVvmEgB9oWv3JKNgsQj5dinXBteacWVMTuB+z6Q0Jyt9a32jseckfaVVvl2sI6
	 dmENIs2tKHHA7E3ZKn1gBS8to2tj3IONDUI4+Dza5Onx7D+5/GNg+J2jKnmB5AGV+T
	 jX/oLGXw/RNKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF23930780;
	Wed,  6 May 2026 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803401454.2352352.1722198141421516263.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 02:20:14 +0000
References: <20260501110713.145563-1-jhapavitra98@gmail.com>
In-Reply-To: <20260501110713.145563-1-jhapavitra98@gmail.com>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: w@1wt.eu, pabeni@redhat.com, horms@kernel.org,
 chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 7DE144D59FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-244297-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 07:07:12 -0400 you wrote:
> t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> a loop bound over port_msg->data[] without checking that the message buffer
> contains sufficient data. A modem sending port_count=65535 in a 12-byte
> buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> 
> Add a sizeof(*port_msg) check before accessing the port message header
> fields to guard against undersized messages.
> 
> [...]

Here is the summary with links:
  - [v6] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
    https://git.kernel.org/netdev/net/c/0e7c074cfcd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



