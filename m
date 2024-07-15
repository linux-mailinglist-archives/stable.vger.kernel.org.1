Return-Path: <stable+bounces-59270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB96930D4F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 06:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6041F21352
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63513A3E0;
	Mon, 15 Jul 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA5KIRzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC1A2D;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018431; cv=none; b=Uto/XXaJjxDQPm/1aGkOZwBHN5jtje4J+k9/LaurlzBaDHGVBcfru7BVV2aytHnaxfHl9fuL1s8VR2TMhS3iCn38wN4dRjEdnxQeE6LtF/O1AKlBOKC5nYz/JWJcnfGFJAJdAq8A5dxip4N8e4jqZSQcs98OyVtSqLegJZN8Ez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018431; c=relaxed/simple;
	bh=6zMSjDbtjmrHn7+EQHecK0I5Qyss7k/CP011FOFvUpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MhbInk3m6Qb8S4dBp6oeXi0iTkoFl6aHg9SW/x+ViTB0+3BmCQoFqpAvl/oZge10D6pM1KGAfKZBycSTyjZylH/oeke5v65ApfCvG/DNT8AxgqJ9y+eOISOJZNJ6v1fCAhXNbEhiJ1WKQir62u+jBtQVZgHvlsmVzcAL69KNJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA5KIRzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 790D0C4AF0A;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721018430;
	bh=6zMSjDbtjmrHn7+EQHecK0I5Qyss7k/CP011FOFvUpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nA5KIRzDCB09X9B/EL+vacyskyNFqJM+gen1xp0DOdZ9Zd/VSaJcEwwI99G9yh1yE
	 uM2R3CDzMf6ocLTXmMvAeLgPR1eQUBoLL5M2Kw+D7+IJB8fvRo1mSqUNVa8J0v1K2J
	 KWRZB+PCAwHBU136HmxJ2wyDWBUFofKIh7kpiHG7W/xqqWiVPGPrzUwMmRuYP1nT+8
	 fz9FinX+3Y0q2+5u25bU0WSpc3jxDQ1nfKoFfxISBHOS9Ds29nlE+SoXNFSxeI0fqK
	 LgsP+ozPkEJehvQCzhTfE/kgLkUVXgIyVyBkM41Ya5zTIpTHQyZEbPYwugTDH7qwyy
	 mJIG+tuB6gPHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64671C43614;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v10] af_packet: Handle outgoing VLAN packets without
 hardware offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101843040.2749.1887961636233742988.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 04:40:30 +0000
References: <20240713114735.62360-1-chengen.du@canonical.com>
In-Reply-To: <20240713114735.62360-1-chengen.du@canonical.com>
To: Chengen Du <chengen.du@canonical.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jul 2024 19:47:35 +0800 you wrote:
> The issue initially stems from libpcap. The ethertype will be overwritten
> as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the sk_buff
> struct. Consequently, this can lead to a false negative when checking for
> the presence of a VLAN tag, causing the packet sniffing outcome to lack
> VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> tool may be unable to parse packets as expected.
> 
> [...]

Here is the summary with links:
  - [net,v10] af_packet: Handle outgoing VLAN packets without hardware offloading
    https://git.kernel.org/netdev/net/c/79eecf631c14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



