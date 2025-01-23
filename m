Return-Path: <stable+bounces-110244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE11A19D84
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 05:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2624B16C14B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5F15575E;
	Thu, 23 Jan 2025 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS807DZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE83F9C5;
	Thu, 23 Jan 2025 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605411; cv=none; b=u2H72vezh1jpBWL7QKjmxo5bl8fysx2QeVLrwpNrURiZpgMEmZRDlXfDFfBQfX2+i8HfzxbtPelTiNIWkq3MaN4XRMI5K6nuFTNBnrHfqql+iTWAWqynNHOeN6aT33kcHAzk7LglRxURQ6vDrZil6HAXQi4H473HnypU2O++BDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605411; c=relaxed/simple;
	bh=pxRLwulr+o4G1w5QMFLlft/rLgF2P9dNP1ofylPDWgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qVU3UTh3SwE6EMIEEBdPwBXWO4AXgmXakbyyTSaH/kz+2DVP5zB9IG4JTajct2Wzqr2/x6lVzJoN9hQBENXRaGUMWbI2HHyLatxRy+WY7+Oy7Yg2j2SRAAdtm1eFYpUoIoYNEJNgcSoinUbYECxHxzcI3Oi83WxspA99MgmoVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS807DZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2884EC4CEDD;
	Thu, 23 Jan 2025 04:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737605411;
	bh=pxRLwulr+o4G1w5QMFLlft/rLgF2P9dNP1ofylPDWgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gS807DZGpAdKeUDEcI7PKv76ETH0tVTHOPFwZco9uWZ6X3VuPy/9qpL7pCWRaQCWG
	 JjMMg75JuCHUvvpghuuzpY+gJpFal1E4YdozvsjHWM+SX/xt1w5v1ZO+UMvCA2dmMH
	 lAWdEIFAuaISY6MuAmD3uC5QdlW+jbnWxzL1ewZkpoZzz6GRg0qD8ZWdEEibtz6xbQ
	 8CQZq2PQ8b0RI0593ULBoFXunTuYd5ffE7tKwomoSSjX6YZaMjrxwI/gDIt5Nsh+Ol
	 Gy6Z8XtQpJIFZy4ZyuRFkWo86fnF3mCG92kag38GjyoGnY/aaTxtKxszMnFXHWrmZL
	 OCfYlDCIVEalA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB090380AA70;
	Thu, 23 Jan 2025 04:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ncsi: wait for the last response to Deselect Package
 before configuring channel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173760543574.917319.5168244429411410501.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 04:10:35 +0000
References: <20250116152900.8656-1-fercerpav@gmail.com>
In-Reply-To: <20250116152900.8656-1-fercerpav@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: potin.lai.pt@gmail.com, chou.cosmo@gmail.com, eajames@linux.ibm.com,
 sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, fr0st61te@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 18:29:00 +0300 you wrote:
> The NCSI state machine as it's currently implemented assumes that
> transition to the next logical state is performed either explicitly by
> calling `schedule_work(&ndp->work)` to re-queue itself or implicitly
> after processing the predefined (ndp->pending_req_num) number of
> replies. Thus to avoid the configuration FSM from advancing prematurely
> and getting out of sync with the process it's essential to not skip
> waiting for a reply.
> 
> [...]

Here is the summary with links:
  - net/ncsi: wait for the last response to Deselect Package before configuring channel
    https://git.kernel.org/netdev/net/c/6bb194d036c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



