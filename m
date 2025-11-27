Return-Path: <stable+bounces-197067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFFC8CC81
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 05:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028343B00F0
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8A2D5C83;
	Thu, 27 Nov 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAqMcKeQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B12D5955;
	Thu, 27 Nov 2025 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216062; cv=none; b=db9AVErRAwj/Bs07ZYOiMOdsC465QgzUwG8PDFPIODTNIXf5mlyXSxu/0faxbatWKPi0ITrcQxA8ZBu1uptmioitnSDbUPO71AVtwoOvdKemo1PJu0/KCE6B2f07bEBzGYNZevTDjJ86y0N7l71HZqhTXUDOgrtvUR/1mIWl7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216062; c=relaxed/simple;
	bh=6TjAYhNl2ivYozSDWXor83yNokEIZfpXImXT0hc8Qks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LWcI9lLiA0uZLN4p5a+3+tOZbSKfFeGH2lPXRvLpbTV88iARtD3GXdW+Tugaa9FmTtKnZHfgTfdKqupZ1iyJce/moU2OtC/o7f1kZYmblWgpn5HF3SMkJVwFJDSvh6tVotEr6QD8Y4khEmrBhL7xIDA6k0ozT1I60IjMn3ObMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAqMcKeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD0DC4CEFB;
	Thu, 27 Nov 2025 04:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216061;
	bh=6TjAYhNl2ivYozSDWXor83yNokEIZfpXImXT0hc8Qks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RAqMcKeQGoyiPc3CiTY+8hV49mSLDFgQwJ99ZxNBxltI4xR4+hLXQyVlne4UL03U9
	 ki0l89Z5RYaRfXqv98TykpFYJ8XVYF2F1u16d2cWmQteA1BEF8U2s2eMuLhmmex4VD
	 lUgcKF1c+HX2Rv5ENKct+R4S7Fxa13nCIAFy7raJZPQNf4KXlBDwtTmF6F3J0CxkCQ
	 lZ7RpiLa5pWMw0aM1w0SgHQAGz0DPRmB2tAC8vHooLSdUEMWiwpSCVZHG0+QTwcVtl
	 6/NNSKHaheHG14agQJr0uRg+SDx8IxZQMOLcnWYnVDFQ4dR7huoG37OzEYeCGTVcxr
	 +rFA3rG021n0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD0380CEF8;
	Thu, 27 Nov 2025 04:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] virtio-net: avoid unnecessary checksum calculation
 on
 guest RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421602299.2412149.3177062304225180121.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 04:00:22 +0000
References: <20251127033837.3002462-1-jon@nutanix.com>
In-Reply-To: <20251127033837.3002462-1-jon@nutanix.com>
To: Jon Kohler <jon@nutanix.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 20:38:36 -0700 you wrote:
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
> 
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid = true to virtio_net_hdr_from_skb.
> 
> [...]

Here is the summary with links:
  - [net,v4] virtio-net: avoid unnecessary checksum calculation on guest RX
    https://git.kernel.org/netdev/net/c/1cd1c472343b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



