Return-Path: <stable+bounces-6837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37422814D94
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696D91C23D2C
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B03EA71;
	Fri, 15 Dec 2023 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV6FdQbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB83FB0F;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E85CC433C8;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659190;
	bh=H/n0IAG/cynjDEVrZj84z7sndMgNHo04Ohh/G1RtAtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TV6FdQbJdiC6wFLg0cT8RPHZ/MTWZJMrBpnS3aeU5NZ5fZ7RZa1a1kiuH6qyosV0a
	 bAn/wUMkWCdUMKgQllZNfVHHCYBq2TxM/M4QMvT2y9uirhknWFAsB9qRCMHA/b8MHT
	 J7D1E5GlnPylXCeyF2uq3UEkpIqWiZ7I0CV3GQ1R5wtCYal9Q0uzkCFal43zXEP1ex
	 Ekw2pwD9MhrXnSKJm6OR1lEf7DnNmruw+gfVSkFcuhqHE/v2nlfBvQoi1teoX6sBXK
	 xxjaezGzTOU6vm+NGdDEvDqNEEcW2nBYJ+39Q3MWVjJXZIs1QtVpP9KveVARf9edMa
	 SZ7swzfK1NaxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8232ADD4EF1;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170265919052.3838.9262588716198159739.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 16:53:10 +0000
References: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
In-Reply-To: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, mario.limonciello@amd.com,
 regressions@lists.linux.dev, regressions@leemhuis.info,
 Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de, bugs-a21@moonlit-rail.com,
 stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Mon,  4 Dec 2023 12:08:58 +0200 you wrote:
> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
> 
> This patch was an attempt to solve issues seen when enabling runtime PM
> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
> 
> This was not enough, regressions are still seen, so start from a clean
> slate and revert both of them.
> 
> [...]

Here is the summary with links:
  - [1/2] Revert "xhci: Enable RPM on controllers that support low-power states"
    (no matching commit)
  - [2/2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
    https://git.kernel.org/bluetooth/bluetooth-next/c/24be0b3c4059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



