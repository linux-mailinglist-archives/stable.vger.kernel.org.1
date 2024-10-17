Return-Path: <stable+bounces-86645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E289A28D6
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EEA28BADC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0171DF995;
	Thu, 17 Oct 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVIJDfZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86831DF98E;
	Thu, 17 Oct 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182632; cv=none; b=nDa9Yhlemvcx9cOoPMBbTO8VtMEmS96zXSWKwmiBOcBeuRg1U+P+azkNc6DmH6kQfz8ZB++8/WXwzxPQzElftbwJjrBz8pgiVfFFfhFarFlwST/d/7vcUcIRF5QXFA+QWVxiG+fvGHvTDbvFObMztknhfUq2BQKlfyTMt/Kcu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182632; c=relaxed/simple;
	bh=MAHHxQS0eKTGEp4J515FyxJMcIxGuOSNzAHq4WtWGpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d85TCyhjoRbIiVuTxjdV+1KC5TUq0DoOWVqOuKCSTfyR5cc55F9/i/KXdzLwwcz8kgrOFf5CQSHI2QgRZk6RcuEq1HXkJgI0EG2aDURgWdEUYZklHSvqF+gBfVSBbuYnUlY3LdbjQyfTHo4H2UCv6428U2WKG8AKCEtuge7iQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVIJDfZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B773C4CECD;
	Thu, 17 Oct 2024 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182632;
	bh=MAHHxQS0eKTGEp4J515FyxJMcIxGuOSNzAHq4WtWGpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cVIJDfZswfdnadPqf0l/Gvj5Ex2Pc4431RNASOYjwrgbvbbKvCoQK121owGo4XrIC
	 adcHjXeMnSjASvCMEykvTPhhkBRYB0oDzEaO5z+lbhZc/diqCbs4cFrHfrCcrd6/pT
	 Cda4+GAxpf/CotLV1aiofGKl4N/tdUALp3pqDggmDxLAoZGvIN1FgauGtrJS0svWH1
	 wwPvf7+Yn4d3Oid1vc7pNo1XCbx8mVydqbUvsDlK+d7Kh7AEzYZa1fYK6deACzk9Fo
	 J/oj8o39PXeQS7qakIf4WucyAZZcjsY4+bPX8RTxZlMUGffmhv7bMdrmbAwtsP+7oj
	 9afBaMBwq0CzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB12B3809A8A;
	Thu, 17 Oct 2024 16:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172918263750.2528145.8683172772221919308.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:30:37 +0000
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
In-Reply-To: <20241009072749.45006-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org, jmontleo@redhat.com,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  9 Oct 2024 09:27:49 +0200 you wrote:
> Early code designates the code executed when the MMU is not yet enabled,
> and this comes with some limitations (see
> Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
> 
> FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
> as reported in [1].
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Do not use fortify in early code
    https://git.kernel.org/riscv/c/d49320974c4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



