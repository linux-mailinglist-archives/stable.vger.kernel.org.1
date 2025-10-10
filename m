Return-Path: <stable+bounces-184023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156CBCDECD
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B0654080E
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FEB2FBDF8;
	Fri, 10 Oct 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3s53mzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E9266595;
	Fri, 10 Oct 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112618; cv=none; b=lKVvEW5Jjbw0sIcS1gscE77VX3BaahMU3ac5uZsLtwcSBJEuyZ7nQJbVSflJzXZ39HdKbQGH5yPJDKMPC0O9gYsZeQz4smt8XapnvMwPZwrldRuyvtfiOLwW5oSuf2rAGWRkRSzk3ziELj2o/V3pFti5T+9Kkvgh1uaoYZ9Asbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112618; c=relaxed/simple;
	bh=BYrNZj2WgdfO2F/sOzJIX3fMIOh78MZdybtGGqt65CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eb3DGcVX8JLOJvRAhf5LPa2WUWIoOL4FwgbeAA8KQL/jWGUoMK7DesxCNaK1gPivHy5qtOyuNxH+twaqjfinBM+XtUudxLiIKsEyYPOtecuTmHRZCy1/Y6Z7ueCr79GbaXjtDfeOjYkcGLCKxlasS8ioWjklAwtlgxk0GgmwvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3s53mzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA74C4CEF1;
	Fri, 10 Oct 2025 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760112617;
	bh=BYrNZj2WgdfO2F/sOzJIX3fMIOh78MZdybtGGqt65CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T3s53mzEmtixItjKB55IAS1viBVIlSNF7jtmzmn8+VmpxGgfvr1TmyK9TSjmo4XEG
	 K8k1cBoYZB6D1J9w8zpVu2yrxonyiUzJ+bIgqKaF+gvqpzVTC7ofZSJwHL0Hu6lFhs
	 u9KieecYaXl2DjEUoCMMPeBAuMZd5dewlBuxbFFf26Y+YwMgXbN/0i5UJFeO5ybGXJ
	 gEH17QX/AdtiPNB3zb7UHCuu0MloPQfVEpm6Vc0OlYx99ykAYbn3Bjuvjvy2JozyAq
	 ScsAo9Dc/Tf5sW0u98E0kSLl+37qJxyjey8lrSUi6PaDA7owMrQTM2FI+dYLuQeg+n
	 ZAZpi7oNgXCxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD93809A00;
	Fri, 10 Oct 2025 16:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong block mapping for
 multi-devices
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176011260525.1033062.2407373127040917969.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 16:10:05 +0000
References: <20251007035343.806273-1-jaegeuk@kernel.org>
In-Reply-To: <20251007035343.806273-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 Oct 2025 03:53:43 +0000 you wrote:
> Assuming the disk layout as below,
> 
> disk0: 0            --- 0x00035abfff
> disk1: 0x00035ac000 --- 0x00037abfff
> disk2: 0x00037ac000 --- 0x00037ebfff
> 
> and we want to read data from offset=13568 having len=128 across the block
> devices, we can illustrate the block addresses like below.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix wrong block mapping for multi-devices
    https://git.kernel.org/jaegeuk/f2fs/c/7d9fdb3c9e5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



