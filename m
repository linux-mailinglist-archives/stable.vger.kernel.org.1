Return-Path: <stable+bounces-217485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DqYAhBLl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:40:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D316151C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD1DD3010784
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B8342C8F;
	Thu, 19 Feb 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe/rAFv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29E34DB7B;
	Thu, 19 Feb 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522826; cv=none; b=Ys6M5L6UKduEItTsCl/xHCOOeFjT+I1KgfPN79apVlbzef5+Fbq3DRxe5ZGGWpa6VLmojd1VzAi03yFlxCJRjcRyq2sHUAEmGS7yOpsGZXsAr5fUPsWaz5q43YCVHT2S5jf3wvjqmily2tEZg2ZRCei1Ejf8uom0uCsL776B/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522826; c=relaxed/simple;
	bh=K52d2zJMFf3z16p2U8f9apBmP5al2DYkLQOxG/9VQtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3/q+lJYuh+pjuyR1a4KEANkqDzVro5B46WDGv5GOyUCezRVOTT32ynUDGho2d7OOn2qH0PTtuuPiL2WHJAQAZ3+eVdQ/LIDEvy+cc1gEC9VaLWhCI6ndeaKDPtRVNSWIJ306w2NQWZXc+nSWMl03VAUgBkB/+ublDirXOt2+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe/rAFv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEFAC4CEF7;
	Thu, 19 Feb 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522826;
	bh=K52d2zJMFf3z16p2U8f9apBmP5al2DYkLQOxG/9VQtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xe/rAFv0SJoQMrAaJzDyUvhaCGLHJkrOibK2vzUsuBhk2S8phvhGV+Fnuyfyzc293
	 vAnteCrDUGbVZxDHf8hSjaJBwVfIPo01NEpJjdueBTnJ1EdJ4crjr+kjhwSGh73EhD
	 pkJxnVz8U7+rAIe0uL+9KDbUbbXxwQgLnPqgDtB0nbyxamiJlroBnlospyI0Q0GhvR
	 C7o/RRdGDmxmL8u3bayHVRXJ5LQg6S3Pd+2TcrCjF8J0ln3i5udyYYvBfRcyh8xNvd
	 bxdFup6yk0AzjGDtTFw0lJ0aUAPwHa7/x1cZz5efXhz57D95+PvBwNMczO96NoWoeY
	 VDBjGFLdZeBRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2A5380CEF3;
	Thu, 19 Feb 2026 17:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: nfc: nci: Fix parameter validation for packet
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152281658.2317554.15811337395929240239.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:40:16 +0000
References: <20260218083000.301354-1-michael.thalmeier@hale.at>
In-Reply-To: <20260218083000.301354-1-michael.thalmeier@hale.at>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: deepak.sharma.472935@gmail.com, krzk@kernel.org,
 vadim.fedorenko@linux.dev, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel@0x83.eu, michael@thalmeier.at, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217485-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,redhat.com,vger.kernel.org,0x83.eu,thalmeier.at];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 904D316151C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 09:30:00 +0100 you wrote:
> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.
> 
> The mentioned commit tries to fix access of uninitialized data, but
> failed to understand that in some cases the data packet is of variable
> length and can therefore not be compared to the maximum packet length
> given by the sizeof(struct).
> 
> [...]

Here is the summary with links:
  - [net,v6] net: nfc: nci: Fix parameter validation for packet data
    https://git.kernel.org/netdev/net/c/571dcbeb8e63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



