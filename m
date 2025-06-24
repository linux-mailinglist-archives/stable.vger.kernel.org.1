Return-Path: <stable+bounces-158210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C6AE58D0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E012480FD7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EF1E260D;
	Tue, 24 Jun 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+iQYPtW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B91DE8B3;
	Tue, 24 Jun 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726183; cv=none; b=ICVxz/ZxWN62CGToLtHN3TgaiFBsfUWURl1bKs3nO+0kymRiNKNPNLr6w3/h5nd2T3IBcttsB3bMzwJM0dAwYtADSN5Nh6TurzG3r4Q2RQ2MTye11Bxx8MHh1GU89Nj2zttDxM+Va7d1Z8ZIAjxRR4ylaMOPKYIXHp9x/CpTHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726183; c=relaxed/simple;
	bh=RKieSCMnnxr7Bp9MnznRAfCwf58nBx31lL4xjTswCxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F8nE2Kev/UeOsjqcxGS98AtEOMCSaj+TCJQ0omHoQscbRDSDNEYoui37cJypQFGPDUjyXITyyO9AElgSEMk9QdDlrPdCzOiBMkaWFOvCjvlzHY6fqJY3gt2NWdfHlfNYSgOkw9+RGLYgvzCVSz/7/GQ2tZ0SpxVRw9H+L65+xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+iQYPtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDE5C4CEF2;
	Tue, 24 Jun 2025 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750726183;
	bh=RKieSCMnnxr7Bp9MnznRAfCwf58nBx31lL4xjTswCxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+iQYPtWM51notqk7uZ/u1i1LoXV32gP27oIzHnOpl6/R2ljV/Kb17OiJGmWPb0Fq
	 u0I2pr257XTSdklQwM7BI8tJ1I/VHmP1TVXXw1y9i/TWMS0ZkHJPW/DqHzWL1t7IU7
	 1P8Hd4twovsBP0NIpmy7iEkxVEZFh7u71FySHTaVUmWUx7nNjZHpEVZxij5pINAEFI
	 IeuodNdzIKTX2+wCl4zj8jfvCtV6XOWqIHFTqSVuIASPyyS4xiyES9YuEGm4oGg2np
	 qPtLH9N2PCFfSirpL97OxYssI3n2XKPa0eTSoIpHdUrzaj22Np4sR30LfcjbgUbuOV
	 fm1B3xuDOCPdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0839FEB7D;
	Tue, 24 Jun 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175072621024.3349808.1646542677101843866.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:50:10 +0000
References: <20250619155858.1249789-1-namcao@linutronix.de>
In-Reply-To: <20250619155858.1249789-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org, rtm@csail.mit.edu, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Thu, 19 Jun 2025 17:58:58 +0200 you wrote:
> This reverts commit ad5643cf2f69 ("riscv: Define TASK_SIZE_MAX for
> __access_ok()").
> 
> This commit changes TASK_SIZE_MAX to be LONG_MAX to optimize access_ok(),
> because the previous TASK_SIZE_MAX (default to TASK_SIZE) requires some
> computation.
> 
> [...]

Here is the summary with links:
  - Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
    https://git.kernel.org/riscv/c/890ba5be6335

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



