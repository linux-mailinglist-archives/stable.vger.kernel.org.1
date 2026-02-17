Return-Path: <stable+bounces-216889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ7zD924lGlmHQIAu9opvQ
	(envelope-from <stable+bounces-216889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B626C14F5ED
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE04A305BFE2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B7374745;
	Tue, 17 Feb 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2278aTL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083237473B;
	Tue, 17 Feb 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354218; cv=none; b=GM9mPzDNpVkzitfP44txwjchCTvrZxphCr4mAWSYwuccLr5GYzjizx3vhkmqgzN1E3R96cYqIIi5ykxwj8RsailVqcCbVtfjoG9GMamGMxrL2+i8aNm6sp9bo8ROKe7nlf6Txf8j67ksEiwfNMqCOLQpZ/lrJBao0gCAJo5qZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354218; c=relaxed/simple;
	bh=aK4vF1gwg4WA49Ll3gY0b3EmhQ4Ty2kNCS8Xc1t9qU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kN0I7N7e0M9NZXaZZCK1Z5RqE64FeIRR34uG3w9DYGJIrox7UCgfBv5KZ/Y9jxAeOZV8XzHz4I5O9rkIcflvnwc2QNtR5DG963IBQ+ZEJJB+zZcfk7xwfDi6cAYGU8TGGGv6iTf/U0cc9gYnRu1AUgTat3XVs27H86ziGXvNlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2278aTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4393AC4CEF7;
	Tue, 17 Feb 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771354218;
	bh=aK4vF1gwg4WA49Ll3gY0b3EmhQ4Ty2kNCS8Xc1t9qU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2278aTLlxl1YXVGvDl/GR9gf/LDcYbHoMDa8GYOyh1fmpauK9/ZnmWfc6qJdNAv1
	 WuEJe209vdY7SMr4j02yicVw2Eh2zLpLcJdO9lD7ozQoMfTud+t1hJTvBxz+dngRdF
	 zAVTd6yBwcAycN5kvdnrzuC4a+jWLB55lZc5LiwyOwb5BdBSlG1mbscrq5Eolw0rdm
	 JjsboRo6Gc/3SZH+nmtcFmlRlQfojVzRIMzfmUESv3/4GLIcdw1VxojBiYDH4g3HRx
	 tvvyvmbKn6i2aezq0wfn81qke2R+MHIqmmidkxiBdRwxpei5sT/0lCRuCakFoQnp2v
	 ptnSoNCC/VVfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483A53806667;
	Tue, 17 Feb 2026 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Fix CIS host feature condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177135420982.600961.5386631441162259721.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 18:50:09 +0000
References: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
In-Reply-To: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
To: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 pmenzel@molgen.mpg.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216889-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B626C14F5ED
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Feb 2026 14:46:46 +0100 you wrote:
> This fixes the condition for sending the LE Set Host Feature command.
> The command is sent to indicate host support for Connected Isochronous
> Streams in this case. It has been observed that the system could not
> initialize BIS-only capable controllers because the controllers do not
> support the command.
> 
> As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
> supported if CIS Central or CIS Peripheral is supported; otherwise,
> the command is optional.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Fix CIS host feature condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/caa53589f0bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



