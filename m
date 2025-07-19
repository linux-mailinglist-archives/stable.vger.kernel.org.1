Return-Path: <stable+bounces-163409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE07B0ACC3
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 02:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E893BC984
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 00:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5979125B2;
	Sat, 19 Jul 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaW/S/Z1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AC10957;
	Sat, 19 Jul 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884393; cv=none; b=aUW7eF9QvcJLeflqfVlBB/XZONZ07K/EL5gnTCVLoFB7glj+OhB84tBneRlCtlM9uoXBK3Trchk7dIWeYY36JKqXPVUyajeFnIPkfqb5u8+DSVMPjk3Vv6kpwH/FtxLId4ubUp/zhBfBewebRhyqmWk3Z07wML6DUwwSn2XTRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884393; c=relaxed/simple;
	bh=E+17LaBUs6OjQnYqc0HJB1Ya5gyH9Km7O9Y5EqWdP40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2zGQ2EK4puVfECcgbJtct9ms7sTStp6+JKm4ffFOcYjKNjM8t1n9E7P5dk8z7Z7kvwfuxCpY+otbV0MSyqj9DqEFOKsTg5+lXv6NrvZv4E6YnPNi0mPQeE8JjE1G+vRzQsfPlkvsmhYO8Q8381oSWJT895wxxjM4tuJiG0BA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaW/S/Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E88EC4CEEB;
	Sat, 19 Jul 2025 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884393;
	bh=E+17LaBUs6OjQnYqc0HJB1Ya5gyH9Km7O9Y5EqWdP40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaW/S/Z1ReBuc0AAhjOyXSItcuij0h/+/kTM4vvgynYsPciI889oJpHyT7mJQusru
	 90HJmh6cMeXNl0Mjick7CNJAuucv96GO3u7u73ugo1L+SUhIATTZRStqb8ir5hjMYx
	 b0/Z7MSLf+UNmEAwwjFIsz37vx4DlYMmTf6M1ujvJ68SWWXMdtMdPAGOyzSu10i+pm
	 +FtzsCfQtOn5Kz15hEHFXqjMnPcnWJ340o1bWxwGzZZhAaEZWF83JRoCfbYhmlb2Wr
	 Cf8px6rJ3tgTymHb3yXd3YxgLgVyZ2Sed76jq11LrFbFTYHvyADrDaekGeSNaZjypC
	 D5owAcx4J3FQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAD383BA3C;
	Sat, 19 Jul 2025 00:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/3] bus: fsl-mc: Fix potential double device
 reference
 in fsl_mc_get_endpoint()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288441299.2833543.14707347919961717043.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:20:12 +0000
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
In-Reply-To: <20250717022309.3339976-1-make24@iscas.ac.cn>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 10:23:07 +0800 you wrote:
> The fsl_mc_get_endpoint() function may call fsl_mc_device_lookup()
> twice, which would increment the device's reference count twice if
> both lookups find a device. This could lead to a reference count leak.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1ac210d128ef ("bus: fsl-mc: add the fsl_mc_get_endpoint function")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
    https://git.kernel.org/netdev/net/c/bddbe13d36a0
  - [net,v2,2/3] dpaa2-eth: Fix device reference count leak in MAC endpoint handling
    https://git.kernel.org/netdev/net/c/ee9f3a81ab08
  - [net,v2,3/3] dpaa2-switch: Fix device reference count leak in MAC endpoint handling
    https://git.kernel.org/netdev/net/c/96e056ffba91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



