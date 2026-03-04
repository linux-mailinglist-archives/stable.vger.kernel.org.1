Return-Path: <stable+bounces-222967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB+FDNaPp2lKiQAAu9opvQ
	(envelope-from <stable+bounces-222967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:50:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880851F9AD7
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C80C2303F7F8
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC475315785;
	Wed,  4 Mar 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oioS2hzO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F812336882;
	Wed,  4 Mar 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589006; cv=none; b=sPyI22Gah+LiruXngBqsztCmOG6l9rBXFihPDusDwqjU1bTY91tNkhMIeFZeyvT1s7Vna8jBThrkb4V60UAz2W60rG40Tp5nutS/vtG7A7z/E4TFyBagzR8PfeA03Nmkk+cLl9vRHs95DjlxoIOcTCRF9vQQbHutyyAD7KzmeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589006; c=relaxed/simple;
	bh=LX/70GT9Trt2zlliZIToeuLyvUbthChKseeWWPrJZDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W31VmvMdJB+sp2EG8xz7QXiDLz43rjMT6W6awBoh3LiU8QUh8ItFydOt0i2VCunvWPEO/LytXKqoMYgWfN+jAAIC5NQa4XunhAWZrkvH3m6q5ENiyTKsUYloPdNCYasqPyeYOa87+F3Jzv5Qtx/HokY7P61pD+QrpTdjlV/GmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oioS2hzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA66C116C6;
	Wed,  4 Mar 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772589006;
	bh=LX/70GT9Trt2zlliZIToeuLyvUbthChKseeWWPrJZDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oioS2hzONSVBfnV7kdVxTTdNl6u1MLLuvgYgvcB+NLmkp6N3v7n8mbqHm7ns8RRIx
	 aRvshgljBE9n1p7sZ+GSC3YWJAhdVkruSSoRB7T7xtTmXTFyx7NGUOsv8Pt20EtpX7
	 0oUGutIpJK9JL9OyDcEziLdEIu++0avOIYBiigma6gqkMR93PD6X1Udi60rxjvvypI
	 A14xBt1F3qA1hhO73VwwLER7+AFPZMpN56Vq9TA0dbjHhVPfamMvP3aefRE6VU5PI9
	 npm2wpgOCOQnUk5AL/Oy1Xb3W9Oq9Lhju5uLx+CPURd2DVZvu9pYIzdbyfI/aN3X+E
	 2BIjFYQv9+lyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401A73808200;
	Wed,  4 Mar 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: fix sysdata_release_enabled_show checking
 wrong flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258900705.1554347.8845916164165638231.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:50:07 +0000
References: <20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org>
In-Reply-To: <20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-Rspamd-Queue-Id: 880851F9AD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-222967-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Mar 2026 03:40:46 -0800 you wrote:
> sysdata_release_enabled_show() checks SYSDATA_TASKNAME instead of
> SYSDATA_RELEASE, causing the configfs release_enabled attribute to
> reflect the taskname feature state rather than the release feature
> state. This is a copy-paste error from the adjacent
> sysdata_taskname_enabled_show() function.
> 
> The corresponding _store function already uses the correct
> SYSDATA_RELEASE flag.
> 
> [...]

Here is the summary with links:
  - [net] netconsole: fix sysdata_release_enabled_show checking wrong flag
    https://git.kernel.org/netdev/net/c/5af6e8b54927

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



