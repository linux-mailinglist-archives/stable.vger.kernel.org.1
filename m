Return-Path: <stable+bounces-146387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828ACAC4314
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C3F1890296
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253F20D51F;
	Mon, 26 May 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiF0jrnO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEEB171C9;
	Mon, 26 May 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277179; cv=none; b=joWBPO1CaP7CaW+flAXmF3LdGhtKnrsoszUXwx05BkzR8v7L+TZPA7WiObSxvtE3lrivPVIkj+GvSNNSwkavg5H4ix+FEc8+MMkL0fHvFEIW/aTcBLsofkxCqrXlIOlNkj157FsLHXqiS7XZukif9pZdhGwipJgmNVixDuXtG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277179; c=relaxed/simple;
	bh=c32tG7DvGoUbKdoz3SeKC+DeGUkkAO0kbYZEA+WJbpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P5iY/NZjA1c/maeBQxXuORfJ1Z2W3a6iEtVxcQX4iL8/vbIkz/r9UfcAOhOFDvmLk/aggo/jlijqi2aBJGV1+z5Qs46Vvoyq+bDj2z7P75aErAjoLDsNp8fEMHaGo2/JguxPYDjC4mFtnOi9zaS/ErtXGlYZsTI38C0FbCEtAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiF0jrnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446BBC4CEE7;
	Mon, 26 May 2025 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748277178;
	bh=c32tG7DvGoUbKdoz3SeKC+DeGUkkAO0kbYZEA+WJbpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aiF0jrnOIkvPCZghN5Jcs09lWNqwfUIn7GMkK+JDZCH3i5CjrDLdSu/Xb6GcQ5F6J
	 nWhetWvZCQmWeudNmyRio96VpuKn1pzXVQZzBlI6zPc6xDycZqPnTHu91ZRvExotJ2
	 CdBYsEDM3BOPwys3/t7BPr1uHCcsJbJUZZJvJSLBbi0B+5qVoG7epZCSe0YSFGBxKW
	 kdjgh2jxdcoxcM+U1skEOFZ9ZFmCPLcx9zWWIA8VfI8ODUVCMSalMq4gCQ67wm7kaU
	 5w65APL3x2ZHHwAILPoqfiTQ9Sx1QLk5Fhzo2HfCk4Au5UHPKZOLFyv07tZ0YuEzMi
	 d3kSttQfMP/lQ==
From: Mark Brown <broonie@kernel.org>
To: cw00.choi@samsung.com, krzk@kernel.org, lgirdwood@gmail.com, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250526025627.407-1-vulab@iscas.ac.cn>
References: <20250526025627.407-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: max14577: Add error check for
 max14577_read_reg()
Message-Id: <174827717705.619417.16011537123487299524.b4-ty@kernel.org>
Date: Mon, 26 May 2025 17:32:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 26 May 2025 10:56:27 +0800, Wentao Liang wrote:
> The function max14577_reg_get_current_limit() calls the function
> max14577_read_reg(), but does not check its return value. A proper
> implementation can be found in max14577_get_online().
> 
> Add a error check for the max14577_read_reg() and return error code
> if the function fails.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max14577: Add error check for max14577_read_reg()
      commit: 65271f868cb1dca709ff69e45939bbef8d6d0b70

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


