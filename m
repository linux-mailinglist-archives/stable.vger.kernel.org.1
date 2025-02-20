Return-Path: <stable+bounces-118524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB0A3E76C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7819C34E6
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE271F130A;
	Thu, 20 Feb 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt20uEmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9D1EC00B;
	Thu, 20 Feb 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090070; cv=none; b=sEXHV/B4MIgp7ayCqMNLTsjOaU5KtTNUVIhEwKzp69wNLgUd7jwDCzCLQ4oT7bVou4dTSdtsAdnO+JNhw99mGdcXXhagvS7NYKg4jpcKvlj1993/jq1BCsyE0c1r2J6I+ILSkLylXON+G3acl9Ye0EzNEBHAbnQ1IbPtNyCz7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090070; c=relaxed/simple;
	bh=8MHa/yFLLbTPkXZIOVdWL0TvmNMe6Z7YFHBdaBHbroE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lyy7aH88HjDErLMGMzU421ZNPVNlIXS0nWJEzH0lKFQ0hnAGHbovTcZKnrLU3se5TswQDdv5AzdktLhpY6dgxEWzmV7DQ5bUTMkEMr1Yz1InoKNw1OV+Mih9IrEBp8AvXw0mFMM2p3kqOyvSsrjDu9MIsS3Hax9zXYGaJ4bTFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt20uEmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B26C4CED1;
	Thu, 20 Feb 2025 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090069;
	bh=8MHa/yFLLbTPkXZIOVdWL0TvmNMe6Z7YFHBdaBHbroE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rt20uEmGHJYlKM4wlKHa9RX4kILZcde+BOdMDwnweW9FIKi5b/N9lY3UDj1c1I0W/
	 U3OKvossdspTmgnI/u7tqZHanB3Ih3XEcJNeHjVifXs8IW86gfbZ71vUGp3y0czNTR
	 deBBzUa6LSvKjzBThmAI7qziRGXVntx+HHqebaQSYePdAN5e5W6V5Ajqj/aVjr98sc
	 UblfQBnHhmPZIpFZh0fvk3Pgo8op+DNzKH+764FsXN+p9SZmzlbnSdRlYqw/PUKyLJ
	 Ok4y4Xb6Ud+gpT8GMTS3wfk2L9o639W5GlkreJrF1cMQC4D4ZdSoCUJF6bm0f/yoiB
	 RxInBQ/12Yjmw==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
References: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
Subject: Re: [PATCH] firmware: cs_dsp: test_control_parse: null-terminate
 test strings
Message-Id: <174009006793.2293478.17070090354458045036.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 22:21:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-42535

On Tue, 11 Feb 2025 16:00:02 +0100, Thomas Weißschuh wrote:
> The char pointers in 'struct cs_dsp_mock_coeff_def' are expected to
> point to C strings. They need to be terminated by a null byte.
> However the code does not allocate that trailing null byte and only
> works if by chance the allocation is followed by such a null byte.
> 
> Refactor the repeated string allocation logic into a new helper which
> makes sure the terminating null is always present.
> It also makes the code more readable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: test_control_parse: null-terminate test strings
      commit: 42ae6e2559e63c2d4096b698cd47aaeb974436df

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


