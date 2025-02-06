Return-Path: <stable+bounces-114149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8FA2AED9
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE51674D4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1B166F06;
	Thu,  6 Feb 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Y8m9yh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CA15B54A;
	Thu,  6 Feb 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863007; cv=none; b=aq3Ydwggb+ZqhCL8RAzmQklAeXFtcX0OlJ2cQquDv9EsryJlulv3YQVd0sDQ21UT6XPwCM9czaLQWfQ/x3W7Bx3v9j3NsJJmSYEKlVbAtP/Y4dT7+U4TlCDcGxgfnnbCkYlJ3q6xAOfv3DoXKL7fZFKCmifPToc+dhNd02G0LEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863007; c=relaxed/simple;
	bh=GP0hG9OyqRfjlpVFR9+eNneV4N0o2W4356JI0mawZ88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EffX3S1PVeKkLI6qsuMuTsn8Z3hocFpWLbxzKWU+wMWgiBjH0WjykqAWl47YRQdhQm9qAX8v0x2x8aYXw+VZgX3am6pfVpUab+F/QViJrh3WVA9+YtXXkvhI3UXuQLuEx7KKsRQeHsxTFLthwfJGsab9BrmRLklWkZIZGEWWkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Y8m9yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FB7C4CEDF;
	Thu,  6 Feb 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863005;
	bh=GP0hG9OyqRfjlpVFR9+eNneV4N0o2W4356JI0mawZ88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O9Y8m9yhx9W3tvT5wBVXMBla08tViys39H45eEMHfFMpIfArco9slEjeagoxhwPq8
	 qjfRs0R8ugOBXVZZYxZxpWHKb/GzNFT0meQhXnOLZmfDYI5+8iXGJ+94Q6TbqtZX5O
	 kd2Tfna/F1irIh0bAkjnmAyaVLuIsLz5WFeF3ruYiCRKnLNkB4/wX9euZRRDxFFcaz
	 iXDhxOvAhL8tK1BRQJ0qnb2vM9hStHZt6By7CUL4Qdw5RliSBaoty6XgkPkfgftpPF
	 /jjQOfZL6xn04qR3dCwqkwtSH3dMd5RV/D5lTpkxEJznzgwDRkow1w1kDdaytyTw8F
	 uekiGlz/yBwog==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 cujomalainey@chromium.org, daniel.baluta@nxp.com
In-Reply-To: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
References: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: Correct sps->stream and cstream nullity
 management
Message-Id: <173886300281.325569.140818833253101445.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 17:30:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 13 Dec 2024 15:13:16 +0200, Peter Ujfalusi wrote:
> The Nullity of sps->cstream needs to be checked in sof_ipc_msg_data() and not
> assume that it is not NULL.
> The sps->stream must be cleared to NULL on close since this is used as a check
> to see if we have active PCM stream.
> 
> Regards,
> Peter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      commit: d8d99c3b5c485f339864aeaa29f76269cc0ea975
[2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      commit: 46c7b901e2a03536df5a3cb40b3b26e2be505df6

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


