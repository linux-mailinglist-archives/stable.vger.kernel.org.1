Return-Path: <stable+bounces-132136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40FA848F3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AE99A784B
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964641EB1B9;
	Thu, 10 Apr 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlXWYwYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554661EA7F1
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300400; cv=none; b=TemTd6XkxyhhyKhiMpQgX4xjGIGZc00zb747j/R/j7CPGUwVA7kdypnICQt8kyy4WMlE4RYRabM8io5t6tvqpA+kooh7H6zJuvGXDDEs+P8cPtimuOQoIT6KFmuW8ICqP7H99wTwTXyKA/ydMS+y142WXOOr2VVvK2XteoZUxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300400; c=relaxed/simple;
	bh=1xxZwszbxYPFFtObGGoMllgUw972ylx6CjgqPeP52DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiPqXttTiLr4GUcq3pHTd6PicCy2hFWiKO/zkyGaQBVsw53/vhwk4P7VVkhKEc/nOML9reIxKM/Uj2jnZcWsmeU1POD4UQkPTwS5XT8pS+FeqczAGrgX2kuogauLBw4gRZ1eO7CumZax5hdi2EqWVcCA89SRf6DiPhymODC/I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlXWYwYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C931C4CEDD;
	Thu, 10 Apr 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300400;
	bh=1xxZwszbxYPFFtObGGoMllgUw972ylx6CjgqPeP52DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlXWYwYczghP1EaDi0Xt/mtTVKopWjWYYD7PI1+C15T8NEMYbXdgCbEpSos18S5nf
	 tHHvGFQ+5tAEDxEYEt6r2C3cDrBXjitakMWv2kGjYa4z0XO5uwRDH7FWRpuIbREAIu
	 6O+Q4GRFnF2qPRXr9njzJ61O1nyVuPOFr/p8L/SNZVqBLK+YKXLGI+4nbP1o+y4Pbx
	 myAQWNSs4vCt8SKNjiHaTeWUafmNVao+ziQGoP7JmYgkNX+COBf+kD+sLLyOAzhJWb
	 KplZKUTxLeziOf8z7SvfzESHAmqHvSXK0WeKtjy58LhCqfSYkZ1vHjV4cgmJDoYsdu
	 o0iMSZ82/mCfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY" failed to apply to 6.13-stable tree
Date: Thu, 10 Apr 2025 11:53:18 -0400
Message-Id: <20250409224452-9768aaa037ccf842@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408152300.GA3301081@ax162>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: e7607f7d6d81af71dcc5171278aadccc94d277cd

Status in newer kernel trees:
6.14.y | Present (different SHA1: 9309361bbaee)

Note: The patch differs from the upstream commit:
---
1:  e7607f7d6d81a ! 1:  c49dffd98b600 ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE
    @@ Metadata
     Author: Nathan Chancellor <nathan@kernel.org>
     
      ## Commit message ##
    -    ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE
    +    FAILED: patch "[PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY" failed to apply to 6.13-stable tree
    +
    +    On Tue, Apr 08, 2025 at 11:15:05AM +0200, gregkh@linuxfoundation.org wrote:
    +    ...
    +    > ------------------ original commit in Linus's tree ------------------
    +    >
    +    > From e7607f7d6d81af71dcc5171278aadccc94d277cd Mon Sep 17 00:00:00 2001
    +    > From: Nathan Chancellor <nathan@kernel.org>
    +    > Date: Thu, 20 Mar 2025 22:33:49 +0100
    +    > Subject: [PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY
    +    >  for DCE
    +
    +    Attached is a backport for 6.12 and 6.13. This change is necessary for
    +    "ARM: 9444/1: add KEEP() keyword to ARM_VECTORS", as pointed out at
    +    https://lore.kernel.org/71339b92-5292-48b7-8a45-addbac43ee32@sirena.org.uk/.
    +
    +    Cheers,
    +    Nathan
    +
    +    From 4800091d0ce47de62d584cda0c4c4eb2eedbe794 Mon Sep 17 00:00:00 2001
    +    From: Nathan Chancellor <nathan@kernel.org>
    +    Date: Thu, 20 Mar 2025 22:33:49 +0100
    +    Subject: [PATCH 6.12 and 6.13] ARM: 9443/1: Require linker to support KEEP
    +     within OVERLAY for DCE
    +
    +    commit e7607f7d6d81af71dcc5171278aadccc94d277cd upstream.
     
         ld.lld prior to 21.0.0 does not support using the KEEP keyword within an
         overlay description, which may be needed to avoid discarding necessary
    @@ Commit message
         Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
         Signed-off-by: Nathan Chancellor <nathan@kernel.org>
         Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    +    [nathan: Fix conflict in init/Kconfig due to lack of RUSTC symbols]
    +    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
     
      ## arch/arm/Kconfig ##
     @@ arch/arm/Kconfig: config ARM
    @@ init/Kconfig: config CC_HAS_COUNTED_BY
     +	# https://github.com/llvm/llvm-project/pull/130661
     +	def_bool LD_IS_BFD || LLD_VERSION >= 210000
     +
    - config RUSTC_HAS_COERCE_POINTEE
    - 	def_bool RUSTC_VERSION >= 108400
    - 
    + config PAHOLE_VERSION
    + 	int
    + 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

