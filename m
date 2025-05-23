Return-Path: <stable+bounces-146205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCEEAC26E1
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906033B80F9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544272951B5;
	Fri, 23 May 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH6hmQty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC002949F5;
	Fri, 23 May 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015735; cv=none; b=OQqosJDEAge3pCRI1i9+9tt9XY3ICDzwzWWOemWGw371oVufjoZJIFmdwgHLN72XnSb3RVQYw7vKo0WBnyNylViwzgxR4/o6Nn7FzEaAsaixEG+dv40aIHY0g5oVXdm3GGS1ImcCNNpdvOIRwRMm06LQBqNhYZrlXJRWK4j3lC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015735; c=relaxed/simple;
	bh=m44xrI/fBfus+oozAWiYMQ4E27YHXjWGCINvvnQVNbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cooK5RglmzY7cZg5nfvMpdUgYGax4s1e9H8eKghz/y3U5e45mGn9RWOaHOppD9rTvGBz0lJmEtPyxZDcA1ys9o0FFny20LCgNtfBTQIKKuP9LUsenoolK5BvsLoQ1QAYvC/2OlpORa8+QZT7MSonAA9D9MCIPtfA3Hlu3Tm8Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH6hmQty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D5AC4CEEB;
	Fri, 23 May 2025 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748015734;
	bh=m44xrI/fBfus+oozAWiYMQ4E27YHXjWGCINvvnQVNbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aH6hmQtyRLTz/lq1L1g3paFz7gGszV+fWSt0zSdZLd9qNzAgjyp1ARiho3k8iUOWf
	 0NdTrO87CpnL148dNgYZvB9Rxqg/NVZnvxUpaUgmyIywa3GDtVPQd1k2EchiiPpq9g
	 ZLAGpUbVG3BLk13/dYV1nIi6W3Uy/RfC6wfFTwaWtt//HL7Hg1QtE52YXapdSm2UGP
	 4Y7skYn/f6fSJYYg9Qe9cLYBXcz732OF8FOE0VzUDK33UPaWPedaJKRgM3MlpjvQS4
	 B5cVtDqxfTbLzoxC1dI8R0PqhPAZxBEQ18B1vW0lq2osJiG0VgZI717X2QLxObt+S8
	 qL4socMMUIS4Q==
From: Mark Brown <broonie@kernel.org>
To: Linux Sound ML <linux-sound@vger.kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, stable@vger.kernel.org
In-Reply-To: <20250523102102.1177151-1-perex@perex.cz>
References: <20250523102102.1177151-1-perex@perex.cz>
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test
Message-Id: <174801573267.565532.5484663158819379995.b4-ty@kernel.org>
Date: Fri, 23 May 2025 16:55:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 23 May 2025 12:21:02 +0200, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_mock_bin_add_name_or_info(),
> because the source string length was rounded up to the allocation size.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix OOB memory read access in KUnit test
      commit: fe6446215bfad11cf3b446f38b28dc7708973c25

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


