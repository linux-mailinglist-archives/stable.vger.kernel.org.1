Return-Path: <stable+bounces-45254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E58C7337
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C6E1C226BC
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D0143720;
	Thu, 16 May 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDw8YUFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1291369A6;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849430; cv=none; b=n9Vv1gAjM0zLIgZjcKfzSVOlHCG3558aLFMVbv0hy+gXGbcyiQLEoVAIkkWX+sHz5YoLgUTHsERPDd0igL5MqJBoJmetOvCCRJndYPNReENXEirifO7kpOVJORqgDCHwq1NUHGynSa8TvR958t6yPXfIJ1Pna8nD41jH4iPOP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849430; c=relaxed/simple;
	bh=jGZ1Q8ASZwPpFqiD9bNHm16JhmI8gL6wk9d+T6GjM9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sowb/PJwiLbnogYyI8foIRBhjE1BKuwuJWKDg2P5JBJniBIkJEVn99wz2uU1kWXmwr7ljkc5/z9zY5sJKI0pkuBVnBIi0Cd3cD0ycD9qZZOqS9zq0zbIX5gy0ftn0MIUvepcaGaugPcSGwFDUYtiGa3YA9Cre/oh09wYb3H1/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDw8YUFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97473C32782;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715849429;
	bh=jGZ1Q8ASZwPpFqiD9bNHm16JhmI8gL6wk9d+T6GjM9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GDw8YUFfEXRxPKJS78D7fgbPRNnYCsOOlSD1EJLjNmac2/3GvyZCX7DE8sBUnQhv5
	 UeNvNaPigSECyw3fmVmbFbmjpgbpRnLDU/BhvhPv65o0vgGGVfmXWzNERT6lB453U3
	 QI6UgTOTuIUd0WNKUF842jM8z4gy1nyZ2qfRUOLSLwCxZLpcfWgQK4313yZB4WAzHI
	 c16bYoYPo//vvak7cpF7cb0l2sZ0Y1nZr7AFO21jUsYGKFRZaiwvDiXzIpUq/I3pwf
	 mwZjd4XniQYsqvmMLR2Bu6Lod62XnvcpRGcLjtJx5PEIs1vaFQefi++rxJXwjDdkME
	 vCqlymYymcTyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A33EC54BB7;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: lan966x: remove debugfs directory in probe()
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171584942956.27746.704741396527709628.git-patchwork-notify@kernel.org>
Date: Thu, 16 May 2024 08:50:29 +0000
References: <20240513111853.58668-1-herve.codina@bootlin.com>
In-Reply-To: <20240513111853.58668-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 allan.nielsen@microchip.com, steen.hegelund@microchip.com,
 thomas.petazzoni@bootlin.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 May 2024 13:18:53 +0200 you wrote:
> A debugfs directory entry is create early during probe(). This entry is
> not removed on error path leading to some "already present" issues in
> case of EPROBE_DEFER.
> 
> Create this entry later in the probe() code to avoid the need to change
> many 'return' in 'goto' and add the removal in the already present error
> path.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: lan966x: remove debugfs directory in probe() error path
    https://git.kernel.org/netdev/net/c/99975ad644c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



