Return-Path: <stable+bounces-111232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3913A2250D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 21:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F1918884C4
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF821E22E6;
	Wed, 29 Jan 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m37eUesV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65A4C83;
	Wed, 29 Jan 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182006; cv=none; b=BxGQgxAFlyhDKC/AtW5F8jKrOfGv51RTVQ+P9jj40wBVAQjP47t6qaJJJkB2GkBo2mzUUSeBqkXUqtfovuik0R2uCN6O9lBhohYecGJsrz840FJB8NdQvHh/IiZH43cu+5VtJUak6o5BMltmY1J+L8MNx1mWahWn1X68hxxgBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182006; c=relaxed/simple;
	bh=dTf3ZN/6ZOV91ZbVgA3bR+A/8T9BZ5qZqbaZYN+jx8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xlid0kj22v/OG0cfJPraNVRDxHWC4lUU1XeHOsgjEu8D7bCXX425/bOvpJXRhlO7YRAepDcWhlP0MNYyNhM1umi2edDBCXy7+rQD1Nr10rvw0+ms/9qTulwXqvvsbLedphUVLp7eKpu5ObEKIM8nyy4M9dO1/je6DiryQLe3goY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m37eUesV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB407C4CED1;
	Wed, 29 Jan 2025 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182006;
	bh=dTf3ZN/6ZOV91ZbVgA3bR+A/8T9BZ5qZqbaZYN+jx8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m37eUesVKiES5U9yVfgMlqWbJLIiwtEF45a5I3K5FsMv38RqtCmM+PJs8PiRVvEEr
	 GJkjB14eIfkpW0uwswBWdYvdsx+1S/t3b8mTc1nQxC5ayF1iAlIX37KANTUQcqc3Fb
	 sq63w1M1ROGpjuknVsBJsRgNiHDpo4jHuMGqPhwA9qZNrkatsU+q6vREyNoe60qqGy
	 BZH5ga3YbNGJQCxu+B/TELm88vVC6yRB03+krpi2QhuAUZwMLFJEjVVq40cE9jAHIT
	 MNffZ9iEbm7SecqdK/maD5bWhZWlN8U/7ufloaI7AxncJIUN0EDSv5KpCrNn324P5Z
	 t24d4akumRM4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34261380AA66;
	Wed, 29 Jan 2025 20:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: accept zero as a special value for MTU
 auto-selection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173818203201.417583.10236619568637892434.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 20:20:32 +0000
References: <20250128210814.74476-1-pchelkin@ispras.ru>
In-Reply-To: <20250128210814.74476-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org, johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 00:08:14 +0300 you wrote:
> One of the possible ways to enable the input MTU auto-selection for L2CAP
> connections is supposed to be through passing a special "0" value for it
> as a socket option. Commit [1] added one of those into avdtp. However, it
> simply wouldn't work because the kernel still treats the specified value
> as invalid and denies the setting attempt. Recorded BlueZ logs include the
> following:
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection
    https://git.kernel.org/bluetooth/bluetooth-next/c/257a2b95631f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



