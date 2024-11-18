Return-Path: <stable+bounces-93815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1B9D16A2
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDDC281961
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB71BDABE;
	Mon, 18 Nov 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyUy6t42"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3C1A0706;
	Mon, 18 Nov 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949229; cv=none; b=CYBuQapbWpsi/1CsgKPv0G6g4wwzuFzZBMl4LoE2yr/bAnei75JBPI8Q+bRNwAIRedI2HMO5/o4ys8dqPeD0Q7Oa3EnfrLH9VbY7iFTR2YMzUCwcecKvMkWk9ILMNqHpUVc9of2Glp9s6WjgqSsfmBsIHC50KPwkAAHyzsiaXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949229; c=relaxed/simple;
	bh=aCMzkrnkmswBGkORH2PDGxYL9yDX2zO7PHnNpveln+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oU6W+eCDYdVv9+sYpIJXWUjD6nrkGId7B5IkuQSxKQ0ofevFKmlLDwfXh+saUmZnrv0KcgG6E5fX5JG6FrT5TBI5KtSAbMVIL+Z8KvU7sLHnKhWGa1+z92UPfZ+ufQY2R40dpeWGnoiGd0A5TvRS1BNvTcK1NvQ9JS+3Olc/8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyUy6t42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B49C4CECC;
	Mon, 18 Nov 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949229;
	bh=aCMzkrnkmswBGkORH2PDGxYL9yDX2zO7PHnNpveln+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DyUy6t421aI7preeDKTIOPxMqJNGTTbifTvLNLelkoISmTFeiZfv0rPEF9AFlLNCG
	 9qcKzF0Am+zaJfrR8byG5JBKQoXc6R6/WC9P9Rm4KwCaNS1A1+mT9D1bhTeWwFMyTd
	 +ZJ9M12n/UZar8/ZccZOs0DXwHf/9jxP3dGmkh5rNqaUqMh1tTc3tKaSxxjm+IGRYB
	 CQ1kdiXlZTxdJgUE5cAESiSkOSaHBfCxwxkcve0E//QKi0FaxGsFjIyfpjwksl+J9k
	 Gd7w7P2kBz+RxDbj/4E3SgUhmedwGLu4UY4JYqL2+gJg3Wj2DxJmroKoLNAnLZQHUt
	 aRnbUJZTFIsZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE263809A80;
	Mon, 18 Nov 2024 17:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime mount
 option parsing"
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173194924030.4109060.8641898406336440438.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 17:00:40 +0000
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
In-Reply-To: <20241112010820.2788822-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 drosen@google.com, stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 12 Nov 2024 01:08:20 +0000 you wrote:
> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> 
> The above commit broke the lazytime mount, given
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> CC: stable@vger.kernel.org # 6.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: remove unreachable lazytime mount option parsing"
    https://git.kernel.org/jaegeuk/f2fs/c/f8bed73c6c52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



