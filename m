Return-Path: <stable+bounces-185561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24470BD6EC2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 03:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F36407CEC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8771236454;
	Tue, 14 Oct 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfNfPOua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61C22ACF3;
	Tue, 14 Oct 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404250; cv=none; b=S2k649fkpGcJIFAj/KLdEApLrPkxkTCvUxolh1M5x9p0cd3oiKnlTfdW1ADqZfZ7nzJXxr2FBsGlaCMwlzdw1xDVKezzYpFq1YHaJ56cyUhy8TXKD9QUoa+f0niGVRVnVzU3eDxVYNvHDnz2hNXe0Skc6j3nTlRNIEgrsc+VovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404250; c=relaxed/simple;
	bh=UlXz9SPqWN5GDVnFExB0oh6QNhIDQhd3TElVGi7zvhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUn5AgKUzynDOigKJ8cX9j9P1k+OgtbJ4gEq5RQoLdDiQ6JTDT/gsaYF3rhOMD5QLsTb3qZc1PBmaR02nZO4es0sOLDxJzeUQlIqwuZc9prJitkKs6XGmz4LXldjLUoS3S4rFpGxKYRURhOAPzon+jeqhfh9sT+H7fetkZNJcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfNfPOua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261FBC113D0;
	Tue, 14 Oct 2025 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404250;
	bh=UlXz9SPqWN5GDVnFExB0oh6QNhIDQhd3TElVGi7zvhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfNfPOuatkzswozxFgDSQQBdTWRLfqqarbr9q7X8shTPkkBtLpE6iJtdvh3HehQV/
	 Ji2oNodQ/uETWpBWECBAreFuzBeVIv4VpK+A5FKn10uMeEdnSnpPR+5GABvDv2y3LP
	 VNqgpRN/oYBnWi4vHQhOa89E5dbqUu4F8EWYeNu6SBD7xMX+aire+3o2MpQTifSu1x
	 nEc+uMldBAVF8A+Y7IwU+JTtDzCHbZhmwJhuzecQ8S3DBSDyszmEsiS/hNfFGZUaHb
	 fzS9PTZ1AVB0OrPxbftsSJkhkfVHz4qwt72wA/8Kug4K/xly6dEJY3yQMggCgwANRq
	 x2Zsvba7a12xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0F2380A962;
	Tue, 14 Oct 2025 01:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040423576.3390136.9978557000620458920.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:35 +0000
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
In-Reply-To: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 emil.s.tantilov@intel.com, aleksander.lobakin@intel.com, willemb@google.com,
 sridhar.samudrala@intel.com, phani.r.burra@intel.com,
 piotr.kwapulinski@intel.com, horms@kernel.org, radoslawx.tyl@intel.com,
 jedrzej.jagielski@intel.com, konstantin.ilichev@intel.com,
 milena.olech@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksandr.loktionov@intel.com, Samuel.salin@intel.com,
 stable@vger.kernel.org, rafal.romanowski@intel.com, den@valinux.co.jp,
 sx.rinitha@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Oct 2025 17:03:45 -0700 you wrote:
> For idpf:
> Milena fixes a memory leak in the idpf reset logic when the driver resets
> with an outstanding Tx timestamp.
> 
> For ixgbe and ixgbevf:
> Jedrzej fixes an issue with reporting link speed on E610 VFs.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/6] idpf: cleanup remaining SKBs in PTP flows
    https://git.kernel.org/netdev/net/c/a3f8c0a27312
  - [net,v3,2/6] ixgbevf: fix getting link speed data for E610 devices
    (no matching commit)
  - [net,v3,3/6] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
    https://git.kernel.org/netdev/net/c/f7f97cbc03a4
  - [net,v3,4/6] ixgbevf: fix mailbox API compatibility by negotiating supported features
    https://git.kernel.org/netdev/net/c/a7075f501bd3
  - [net,v3,5/6] ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd
    https://git.kernel.org/netdev/net/c/823be089f9c8
  - [net,v3,6/6] ixgbe: fix too early devlink_free() in ixgbe_remove()
    https://git.kernel.org/netdev/net/c/5feef67b646d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



