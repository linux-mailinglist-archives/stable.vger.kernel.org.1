Return-Path: <stable+bounces-86646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD49A28E1
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406C2B287DF
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B41DFD9B;
	Thu, 17 Oct 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmyEsbHG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828D1DFD8C;
	Thu, 17 Oct 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182634; cv=none; b=DCMqc9oKOJZcfhtNIs28SOtYvqQ29rXXVU0fPmc1UtvUuG0U8I0VGYTATqSQFLW+8p3rI48GJ5UrAq35rvXbsd2Gj87RBdlE7crFIRTNHDtbKhA75nqET35vNoEHpCyOB+6Db6ZwVMWcpfQeQINQywT4ykQ5De7ogMnST7Ap/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182634; c=relaxed/simple;
	bh=JgEDONuZMW0RXmaThVkqpbpBWNhaPxsT+5egJGMHYzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpkvzetjBly9Yi6a7GSHRMzJubsj9ux57MPLctb5FLSKNAtb3OWGfhXANWqOR7hiRBoMH0FRCOglq/GLc40sA0IlW3RYqrVc4lzXbBWFjxJ2Tm3UzvVaTYfVf4IFKhVg/yMhznHNMW5nrkQ4o0RWl1V8uwcZxdDXUztRCkkIp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmyEsbHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABE6C4CEC3;
	Thu, 17 Oct 2024 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182633;
	bh=JgEDONuZMW0RXmaThVkqpbpBWNhaPxsT+5egJGMHYzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RmyEsbHGJAFaHiUBDwYWaCxAkoe/fElZTdhpk551hhl+E9A0vMX0cin3kJAUY3lY1
	 vHjQCAL5mVFrNo9hUrhQvhPf8vMt4+WSRP6P85GDcsuAE2flniQ8OFZ0mXWS1+8hEG
	 5JMiqJXovkeJMvSpy5Yo2eHTfwuoOxhgzxfUjqaLlJWAWaUXYhfUbH1iydiuVWnW9F
	 vjlIfsdgxrqA4JMJNB/2djZwOZp3TUoAb2Ftui6ul6GMpAfKw7I7YF4KvWXquvGW6k
	 4VxTC5DZw+nvX//mjmG5JpT42NRuGa9s/0N5R33LIswep+fA9RLvpj1bUU9gzDa/fA
	 mUwcQxTw+HgjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713BE3809A8A;
	Thu, 17 Oct 2024 16:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172918263898.2528145.2599453059177986723.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:30:38 +0000
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 29 Sep 2024 16:02:33 +0200 you wrote:
> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
> EFI binary does not rely on pages that are both executable and
> writable.
> 
> The flag is used by some distro versions of GRUB to decide if the EFI
> binary may be executed.
> 
> [...]

Here is the summary with links:
  - [1/1] riscv: efi: Set NX compat flag in PE/COFF header
    https://git.kernel.org/riscv/c/22a159b2d2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



