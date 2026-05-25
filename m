Return-Path: <stable+bounces-254196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGkxLWSqFGomPQcAu9opvQ
	(envelope-from <stable+bounces-254196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:00:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D665CE2EB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30A0F302A69D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E23947AE;
	Mon, 25 May 2026 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhOSa7wu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CA388396;
	Mon, 25 May 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739203; cv=none; b=FAnGCcryUAL2hAdVfY0+qq+YOFRAlMB9z/ZrBCBRr+u3mQhnGLjwjWtb49j2ucGaM2iAG9by3uv/MnwdDUT0P7i90Aun+WaAOPmhUcfpaJ3kzabLftVSQEPKobsU37CnSGTtvbyWDcTNt4Fsba1MKSQ90v7WHJx/Wh4nnJAsDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739203; c=relaxed/simple;
	bh=ZPFIPDzEcv9wCHFOa5+QxzXXniwaSfr0AReixAZV09E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usEL34abTgItwMMVJlO/P5tA3dD7BKlwo4WMtXpI40xIZEhu/Doa+y0J3Ue9ukqzYwv+a1gju1bVfJsb1wUiRRLXYRRo7kT3WpywGyY9nvbqmod+3YwNooMoKKugbrm5thch5DF6TJnPW8+xCP7mqbHFlPRek5WMAx0e6jrDkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhOSa7wu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDB1F00A3A;
	Mon, 25 May 2026 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779739202;
	bh=1/oC8rZvSb0/58rjVfNg3qIosXAwNMulf1db0rnZnrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RhOSa7wu3zzCdSmYcgXeQfgPLGu2Ssydk1HMfETUvCErawiZ7DYS0OB+CaxCVTO5m
	 Va9zv+NYuwSwDbciB81ThJ/CbBlhPFwvLPtvKQtb+JNFGVuer1Yvx4U+foT0ZhraC8
	 CqXh9RbH/idDKBgRDI7WsDfc1b/WfJ9a8VfAy4FVPOxSFR2dCusSL9+ZGo5ZSIobre
	 o+Cwif+5lTFmQdK2vB4FhxwFuTqPEGFeO77HNPi/tszqnMtKFJXzioZb1/6g1wyu2S
	 AZ+mRwO9fBifYTntKFQn4layBHvaYNCN/+UNQbMTsitL1/zdEWbASa+8+87RakFxyk
	 1Zee27BimZKJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BD4380AA76;
	Mon, 25 May 2026 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: fix replay protection at XPN lower-PN wrap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973920864.3098866.2633413254433514434.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 20:00:08 +0000
References: 
 <SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mayflowerera@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 danisjiang@gmail.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254196-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58D665CE2EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 11:47:55 +0800 you wrote:
> In macsec_post_decrypt(), when pn is U32_MAX, pn + 1 overflows u32 to 0
> and the first branch never fires. If next_pn_halves.lower is also in the
> upper half, pn_same_half(pn, lower) is true and the XPN else-if does not
> fire either, leaving next_pn_halves unchanged. An attacker that captures
> the legitimate frame carrying pn == 0xFFFFFFFF on an XPN association
> can then replay it indefinitely, since lowest_pn never rises above
> the captured pn and macsec_decrypt() reconstructs the same IV.
> 
> [...]

Here is the summary with links:
  - [net] macsec: fix replay protection at XPN lower-PN wrap
    https://git.kernel.org/netdev/net/c/e68842b33564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



