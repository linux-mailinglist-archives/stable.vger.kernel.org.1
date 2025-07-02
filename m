Return-Path: <stable+bounces-159268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DD8AF6462
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CC1893797
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51B24113C;
	Wed,  2 Jul 2025 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsRy0b2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFE2405FD;
	Wed,  2 Jul 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492989; cv=none; b=o8nDXgKZWaXz5CZj2Ucc5rlma3hZuxGo6oFBfkCehlcGr0DOMBVIgQysAqJQz0y5HE5iTeWLrLstCZcLsLPAVCUYW+wSVWR1DWFjcbg2Sr4qxQbF3En2j5pFwHeVz1sNPcmOL/w/SbnNkuXHx0FRT15QjigzcMdbyIBHQBs6IvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492989; c=relaxed/simple;
	bh=cQ4AeuAJQRdOm1S0Qcwv5gFojYvdFZYJNZXYXjyg2Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YPSAO1hjIgAyCLKUW9tPVR5xFuNtmrTSF1VSXLe78Yo+0lM3lv18xogMr0yDsyGRCf33gNr4ays6Gadxa8gBjayyj7p59WL6isj40ibqFB6TQHHt35R0ildI14H9VGyN17vtv0ut64ALA6+S+ujmh/xULOD7AHHzBoed5d97/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsRy0b2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49A9C4CEF0;
	Wed,  2 Jul 2025 21:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492988;
	bh=cQ4AeuAJQRdOm1S0Qcwv5gFojYvdFZYJNZXYXjyg2Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jsRy0b2u198xmEEOIbpMa5hZ4s7u6b87ItjEE2NEml4MCezh4g7bPNUHqKOk+knI0
	 BUMFxqwiiOvwcQIvRXobZhaL/wZinJnYVeaZKQ0/c2AM+QyWMKfDQKZmtAlP/JWHy8
	 UMpGJfE1l3e3NjV3z86x5kVxoZ9GJKGrOQmBGldv4ExDrks2/RMw0WJ3KQe2oJIp6G
	 zKZBFftN43ZUZNFOMNQNzdUbZOCN8nWEVJTfu7r7jaqWZ0TCEg+O+MFiWV5YISlOLi
	 7G5aTZCvjq1k8KAOY8L1p5rC439XP9uv5N1CfN3QxwpQLgec41cmMnWWx8N8NUcx+V
	 M71muETI6CiGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F29383B273;
	Wed,  2 Jul 2025 21:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: libwx: fix the incorrect display of the queue
 number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149301300.875317.11023203910034838166.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:50:13 +0000
References: <A5C8FE56D6C04608+20250701070625.73680-1-jiawenwu@trustnetic.com>
In-Reply-To: <A5C8FE56D6C04608+20250701070625.73680-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Jul 2025 15:06:25 +0800 you wrote:
> When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
> changed to be 1. RSS is disabled at this moment, and the indices of FDIR
> have not be changed in wx_set_rss_queues(). So the combined count still
> shows the previous value. This issue was introduced when supporting
> FDIR. Fix it for those devices that support FDIR.
> 
> Fixes: 34744a7749b3 ("net: txgbe: add FDIR info to ethtool ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: libwx: fix the incorrect display of the queue number
    https://git.kernel.org/netdev/net/c/5186ff7e1d0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



