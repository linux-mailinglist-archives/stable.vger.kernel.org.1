Return-Path: <stable+bounces-227191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILLnMQNHu2kliQIAu9opvQ
	(envelope-from <stable+bounces-227191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:44:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAB2C425D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92739302F7D1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072826B098;
	Thu, 19 Mar 2026 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXYP8pO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98B262FFC;
	Thu, 19 Mar 2026 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881070; cv=none; b=OczTlThlDAMCTt9/pOCWMToEUke3Hy7Lujs8M53ldNUvCVgLHxmvT1dN24bk8ZJDPktrXcYpk3U3aA2GHWHq/KPCn1060GKNDsgcIKiLVsfUESHsLkMTHjx0znGNn/DlSxjcd69kBY0IADBkyBy38FQwmALyxbviRNXVcWituO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881070; c=relaxed/simple;
	bh=7u41qZGQim4zB30AtNqB+cKkni7rNTi2DSiUbqCR8wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HTxlhXhAZv5zRzP/GuFBvyC066rQlCKLo0Ri77+/gHwIRdaqaJ2BppWQeIP4FFif8W/a/S5+iu7SmIZTyPbldeJC0Sl2ooTMfnEPyVhLVgBLnqBPoY28gpCHDvpc8bJcNr0JJdLFEYxWlCE8bejAIPxZMQfmCg+DSw68b175Tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXYP8pO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21786C19421;
	Thu, 19 Mar 2026 00:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881070;
	bh=7u41qZGQim4zB30AtNqB+cKkni7rNTi2DSiUbqCR8wU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXYP8pO1JEZF4gStpYhdJfGYXkIIo48lfr6jt0TcMsi3xoLixAEHqlOz+C77If9vm
	 hCKPTYQP4D+4lDP9G/d3WOZOZfjxf3HgfHaGfGtDOn9q3T7osKOrowm5+VjgdRADE8
	 Rnet/kiKk71a2zaJ9nAgzxFMVy83KjeUHgpDkELQl9Ds8IxBzh6lZntFqcQmC5IIHZ
	 47m+A+g42h84zaK/gadHOwubjCNW5F2GUt0N4joSOXZd7zkM75/mi2RSMjrca9VoYu
	 9TBmI4/pw/WaNJttuoeBKN5SFDP/gHhaMQjKINN46GVOiXTJB9dHSsCBGYmYU88UIC
	 GEfOpYJ6PQmTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F873808200;
	Thu, 19 Mar 2026 00:44:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3] NFC: nxp-nci: allow GPIOs to sleep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388106128.935482.9205617518937957492.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:21 +0000
References: <20260317085337.146545-1-ian.ray@gehealthcare.com>
In-Reply-To: <20260317085337.146545-1-ian.ray@gehealthcare.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: davem@davemloft.net, andriy.shevchenko@linux.intel.com,
 stable@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227191-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BDAB2C425D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 10:53:36 +0200 you wrote:
> Allow the firmware and enable GPIOs to sleep.
> 
> This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> connected to I2C GPIO expanders.
> 
> -- >8 --
> kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> -- >8 --
> 
> [...]

Here is the summary with links:
  - [V3] NFC: nxp-nci: allow GPIOs to sleep
    https://git.kernel.org/netdev/net/c/55dc632ab2ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



