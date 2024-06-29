Return-Path: <stable+bounces-56109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254991CA09
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F081F21F23
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D81859;
	Sat, 29 Jun 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3Q5AzE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BDA2A;
	Sat, 29 Jun 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624629; cv=none; b=tf6IW5wyul7+MH6zpsqhXCC9UbTU6gv2PO6sQH9vy4W4w9OlGCCKG+4BhptwauRXmf4uwWJ19CUstO2m4BA7aO6jh90UmLZFhyhFn7xpiAeM7mLSd0NQhuA1UpHBqvN0YTNs+J/rYtiICCBOMOWFFSsyRYR/y+3Yiek+UXYpVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624629; c=relaxed/simple;
	bh=DuI1y+QYSLwyknaKdlKPTUA7NjfbBMDJsMGJmhHMSNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCEbSxytzNuPkEBfig6CC/otFd575/MX4VGtGqkEz4229088T9QtxUGpHeHweEmC3nmjhDX0RltVAaKQYIoH6AwEHJ3xenf7DBotwQO+F8ctwWrYeeaWk/pC0EcQX2gncvA4H7Sd78c6PjQ97GAQzeW7TX2sj+AS+raUS1OPXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3Q5AzE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E814C116B1;
	Sat, 29 Jun 2024 01:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624628;
	bh=DuI1y+QYSLwyknaKdlKPTUA7NjfbBMDJsMGJmhHMSNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O3Q5AzE0/K3naZYaJonykY/RxvhWJldSVyR2Z93TwdUwLqgE7zUJAjYDlC2PZYcdq
	 5YPHzRLSuTTY4hDxDZEt3aOHE+aT3PgZFKJCHntjWF+CSky0Ghz7UIbSyus3g3Hqqb
	 TFdda6jEuaXMnyWv3E8TGIu0USMCfqeU4y9aY9ZEyOT8/7vEOhBtlkpL4fBavOZmKv
	 GPPfFuRX/3Z18hAs8qYzx4mDMBkkyht+bAR2F38oNrJvCja1ot4M6e+tjq2h+n0IWB
	 Uv5kGYZmrBwRh9kWjMTAWNzETtA4aDTVn1wQYS4vQQjuymtjDCV+9IIXJ01DgaWPeb
	 gWsOWmbzV0L6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AF31C433E9;
	Sat, 29 Jun 2024 01:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171962462836.4840.5947953346740333097.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jun 2024 01:30:28 +0000
References: <20240627111405.1037812-1-ghadi.rahme@canonical.com>
In-Reply-To: <20240627111405.1037812-1-ghadi.rahme@canonical.com>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: netdev@vger.kernel.org, jay.vosburgh@canonical.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 14:14:05 +0300 you wrote:
> Fix UBSAN warnings that occur when using a system with 32 physical
> cpu cores or more, or when the user defines a number of Ethernet
> queues greater than or equal to FP_SB_MAX_E1x using the num_queues
> module parameter.
> 
> Currently there is a read/write out of bounds that occurs on the array
> "struct stats_query_entry query" present inside the "bnx2x_fw_stats_req"
> struct in "drivers/net/ethernet/broadcom/bnx2x/bnx2x.h".
> Looking at the definition of the "struct stats_query_entry query" array:
> 
> [...]

Here is the summary with links:
  - [v3,net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
    https://git.kernel.org/netdev/net/c/134061163ee5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



