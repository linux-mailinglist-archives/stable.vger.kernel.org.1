Return-Path: <stable+bounces-114875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4665A307A3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD5B3A7305
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C621F1521;
	Tue, 11 Feb 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs9D4/+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E241D90CD;
	Tue, 11 Feb 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267404; cv=none; b=X0XXtJ99MtIoOohgZAfv4b2IYqSfTvZ25SIrfs7edikdFwX3E5izWUo6q8xlRYexrFU7jGJdl9sqWYYQrihaenYejsXDx8AeNpFCG+Q+jqrqQv5JlfIZJCFeVoNbm7mCs8Hd0g1McJPRNtIEeEw2eVC+zxJGvhHGwW9gdFXyKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267404; c=relaxed/simple;
	bh=VgBAiX3yNRVQj4Ge3DZC3LmymGMdpfvflsm+T+703Ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kLOCuui75bnCdRJoRJ+sVS4nH+zsajJo76WBMzqYZf8ho0i6H8hYjhE0F3+YWi03wcYQgnbjmg+a2e8kesJkJNqnjaCdTlG2m7/n+Wcnadaa9L9g+0ST87WcRNa6IeH0EK5jyNPGH81ICwKStAmCVtwQpxUo1J2fhJUjFV745K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs9D4/+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D666C4CEDD;
	Tue, 11 Feb 2025 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739267403;
	bh=VgBAiX3yNRVQj4Ge3DZC3LmymGMdpfvflsm+T+703Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qs9D4/+PrEau59CsLC5BcwrH3Lq3LmW7Oa/lcXEbNN5eDlecIvaoMIEPT/fMhgggQ
	 YA5yA2ktcOLuBzeyBob1vQbCmJ3SP8gTswW7IY51qXLYf7JpAk19j+kkjh1i81uGx0
	 Ufvk0zv0lkYxhIZIfYWf5g74XlwOfINH8QzjHgcrs/RvCeLojvAHDofV3HW0fjYxei
	 0dhn3ZqoZkt3haqrRDMqjZ4EOsYwprMVdc3/hvUVa88mV0XjSETcJliIfrBfq6awnl
	 Q18oUHW9iZWifZ4YoKjxKnoKWaN8nqfchj3RlgFDCP6rr6i5z67onZNl1XIGx0bChT
	 dd98573PFZ2Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E49380AA7A;
	Tue, 11 Feb 2025 09:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: fix panic during interface removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173926743228.4012981.3770708336571072464.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 09:50:32 +0000
References: <20250207095823.26043-2-sw@simonwunderlich.de>
In-Reply-To: <20250207095823.26043-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, andrew@andrewstrohman.com,
 stable@vger.kernel.org, sven@narfation.org

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri,  7 Feb 2025 10:58:20 +0100 you wrote:
> From: Andy Strohman <andrew@andrewstrohman.com>
> 
> Reference counting is used to ensure that
> batadv_hardif_neigh_node and batadv_hard_iface
> are not freed before/during
> batadv_v_elp_throughput_metric_update work is
> finished.
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: fix panic during interface removal
    https://git.kernel.org/netdev/net/c/ccb7276a6d26
  - [2/4] batman-adv: Ignore neighbor throughput metrics in error case
    https://git.kernel.org/netdev/net/c/e7e34ffc976a
  - [3/4] batman-adv: Drop unmanaged ELP metric worker
    https://git.kernel.org/netdev/net/c/8c8ecc98f5c6
  - [4/4] batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()
    https://git.kernel.org/netdev/net/c/f4c9c2cc827d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



