Return-Path: <stable+bounces-87606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1B9A70AD
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670BA1C221EB
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0A1EBA19;
	Mon, 21 Oct 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvDAix3C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027131CBE89;
	Mon, 21 Oct 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530622; cv=none; b=ZeXAktwn9PHY/YGGfI5iIJ10Zi51ye0xX1Gc2ktCc/bs3yglPkBQ6Zgl3tuOW5z9a06pI6vGXGj6D8xhzlP0MafuESut7bS50VW3EJ5eVxo8nQ7n2MQbfs8OqSiQrGCeReN7jooCwiqFksIrwd7OywrR3SueXBRFLYt22OF/Fz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530622; c=relaxed/simple;
	bh=JSJuVsapbqSogIvWU6lCf/45vrjyZeff+ubHpUYzDJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=exr+PdZnwZ/mpofqW4zJQ9Fp6rOsjcjpqB19Uw9H+/MD2h29PajOJEkUvw2RppMJXpmWhk2r47kMIL/eUHkcI50qiYZmbRGj8Q6GP4zOS/ham318kh5IBly+6RAdTFj9uC4CeSk8UXUAkNQzOaBYEGJSYBbjqtUrv9/VF9xlFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvDAix3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6714C4CEC3;
	Mon, 21 Oct 2024 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729530621;
	bh=JSJuVsapbqSogIvWU6lCf/45vrjyZeff+ubHpUYzDJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvDAix3Cr/N+PglvCQyDgTCqFPl+YA33IWnlXBTrzFlBk2nh8LpYdFuqmeafSUS9D
	 yC8rNAuBnd/87NGFCrA9H8gCZzLt0qt3s2xGvxRV9g75KkcGw1VoARabXJWlUbuR5s
	 U31xzvzfFuZTSDZnZQDG56yV1IWP7q87apuSZE3tQegiNEX6U482RJBZSBDULQCXSQ
	 s3rmhKSJiwmjdIU3rDRIoKlUdyQoKXIBsWoL7FADEqpx5XPTDiq8ePylBCQyVfYH3B
	 jkbjJKRca/o+HVSTiaxzcQwMAGZIlqnD+y9367BJXeHAhT4KfXcz0+dsk4d1K9396C
	 8wUyE2PHkQ+kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB26D3809A8A;
	Mon, 21 Oct 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Fix type of len in
 rfcomm_sock_getsockopt{,_old}()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172953062776.352920.15255836650338390690.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 17:10:27 +0000
References: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
In-Reply-To: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
To: Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org, nathan@kernel.org,
 justinstitt@google.com, vvvvvv@google.com, llvm@lists.linux.dev,
 kernel@collabora.com, gbiv@chromium.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Oct 2024 14:14:24 +0200 you wrote:
> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
> optimisation change in LLVM main:
> 
> > len is defined as an 'int' because it is assigned from
> > '__user int *optlen'. However, it is clamped against the result of
> > sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> > platforms). This is done with min_t() because min() requires compatible
> > types, which results in both len and the result of sizeof() being casted
> > to 'unsigned int', meaning len changes signs and the result of sizeof()
> > is truncated. From there, len is passed to copy_to_user(), which has a
> > third parameter type of 'unsigned long', so it is widened and changes
> > signs again. This excessive casting in combination with the KCSAN
> > instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> > call, failing the build.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c440001ad70d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



