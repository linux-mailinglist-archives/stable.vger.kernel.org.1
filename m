Return-Path: <stable+bounces-54987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAFD91462E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B7B209D9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA59132804;
	Mon, 24 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzZT7GL6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9F2C95;
	Mon, 24 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220829; cv=none; b=sMzGtakIUhS2AYSK7RegwzIQSMnKF6pcMhVynNpJDaPV+8FjFRSSUbbz4hrAIYSlhTnmYDT7o7r+OiFuiW64xgXeCpp4ToS/Rn5inYqA32eLm/UfvCTRg2kLUPwWy1TzshlD8SY4KdIvq7U9WArpnzj/6JmERGI+vEQMSIwaWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220829; c=relaxed/simple;
	bh=n9iWWQjvhofdB03JXdfwNE494Vwlu5aXJD+pBXY4f4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ak6j7Fw0liNaT5QJ6Veolkkr4x++2riPCK5Yg+HWlSs/gjaT2XFGhqSts3Wx5F1nHGLjmc87/cnoCmMW8YwR54ekV86mjYsFP3/9IQ4l0nRE+F8ZRObMfIpwGFtz57+7n1AFlVlIAIMUqXCRM3okka+6g6gudfbnqfjTyniZMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzZT7GL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EAD4C32782;
	Mon, 24 Jun 2024 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220829;
	bh=n9iWWQjvhofdB03JXdfwNE494Vwlu5aXJD+pBXY4f4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bzZT7GL6OkRUcUGMmBtnzkYY9CCHtECVxjI25gbFuCoh2fjUPMSNjYw1Dt8zpY+gk
	 mP8BEsb2ilmttAORBT1U8wHGsSWsQbY4WNB+FZQO33jYi+dBQ1NnTUJvq7Aw35Ljie
	 eG8zNUEqK/I1BB6JsTZDlGxoRWwcOFGBJ24fKWmcv7od2trIPH8SAINm0uDxrh0Vog
	 Cmb7/muXddP8nLJP+9rpIvHJYq7101t0HImzthzOHJsaZVpinhwkhMdMzlLPMQBGn7
	 g83e1miDJLVw/rsbEJXNab8R7yZwr88YyvBS9zC/kPQV+KGA7JOpnflq/eUU9awZdT
	 4Mug4cr+N87Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21608C43612;
	Mon, 24 Jun 2024 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: usb: ax88179_178a: improve link status logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171922082912.4994.8326638213926609982.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 09:20:29 +0000
References: <20240620133439.102296-1-jtornosm@redhat.com>
In-Reply-To: <20240620133439.102296-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 15:34:31 +0200 you wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and after this the link is set to up, the last new log that is
> appearing is incorrectly telling that the link is up.
> 
> In order to avoid errors, show link status logs after link_reset
> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: ax88179_178a: improve link status logs
    https://git.kernel.org/netdev/net/c/058722ee350c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



