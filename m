Return-Path: <stable+bounces-125664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22AA6A8CC
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12AB3B4756
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2421E25F9;
	Thu, 20 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzZQOp73"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B51E1DF1;
	Thu, 20 Mar 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481597; cv=none; b=LixSm4+AdYDAmXpjHRMyAZe1yp7uwxfgc6lt+dZ8WqAJer5fkzZdu5mEutYmlqFi/6Hneb4aLjmECggzkG9KNgun3vPkAQeYh52FoTKUH2scmjEIq3/ci9s/+Mk2lEa2krEco6xQ01Njn6R+4piZkv+efwwMiVi8PpQko/l9268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481597; c=relaxed/simple;
	bh=oVQojLeLWiozl0E/5VrnXjJuDZpnqy9tjthf9fqPAEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XtV8xoxJU9gBdiXkIJ3tTtAg+ka5StZ8qVWeNxK/dZggW52lqL8Nfd8lhlqDF6KeBPzPjP39k511Q2F2YHh9QfT6hHPa5V0dOI96rCH2PxKYWYIzFH7rilV4InJ85/rsqWehEMgIgKdS0E/I09kVdHlLjDQrK3Zd0I0pMEW4g2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzZQOp73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDAC4CEED;
	Thu, 20 Mar 2025 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481596;
	bh=oVQojLeLWiozl0E/5VrnXjJuDZpnqy9tjthf9fqPAEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OzZQOp73hasAgu0NBkmj6knatSW70kMR70mPUGqkd+WBRrDnvFjCuPRpl6+0Ezrrs
	 arZo2gIUtNhuOFjCANOfg8VuKUGaWgCXfiQ2bSksz62DpZH7/aHGGwzJz30zoLzCgW
	 xldy8+lHwwEV8hue0zAppb0PO6o0MA3G4FQ8iDg86zJhb1hQLo3+M7Ts7YPQX8DT2k
	 lWXClKH10lcFP+bBiMhpSCbGXTejOFl/C9Y48BpLLctZaKWyIerVtwOWjK38keAwd1
	 +WcUYlkMWMHuj8qrRtvNPrGZd8oAakV8V4wDeOs9sjR7C1T0VhbOCM1DdVK+ksiUvd
	 8XV+ZvEoNjJnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD33806654;
	Thu, 20 Mar 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Ignore own maximum aggregation size
 during RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248163252.1791127.9515297719544787878.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:40:32 +0000
References: <20250318150035.35356-2-sw@simonwunderlich.de>
In-Reply-To: <20250318150035.35356-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 18 Mar 2025 16:00:35 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> An OGMv1 and OGMv2 packet receive processing were not only limited by the
> number of bytes in the received packet but also by the nodes maximum
> aggregation packet size limit. But this limit is relevant for TX and not
> for RX. It must not be enforced by batadv_(i)v_ogm_aggr_packet to avoid
> loss of information in case of a different limit for sender and receiver.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Ignore own maximum aggregation size during RX
    https://git.kernel.org/netdev/net/c/548b0c5de761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



