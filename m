Return-Path: <stable+bounces-19780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A12A8536E6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7171F26BDF
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3045FEEB;
	Tue, 13 Feb 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7DUp+U4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A25F84B;
	Tue, 13 Feb 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844362; cv=none; b=cw5KQyZc5IV2Fhj9OqO9ZQRBTECj6dAaAxDx0JCfeTbG4XLX4jlg+qDRSuhB0WRFhbpz+RBTu/79gB3Jirhp952YboCmuEHCHK97V6+e7KBmHex9iL3KAIzr/1F/TlgKu6J/u3m1FqG/zaInHYWinM6qvDPx3+2TQGu+GmCVuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844362; c=relaxed/simple;
	bh=DODOhjUD2slZ/cgfwysouYBG0XDvcKxiIpc358gSyao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G5UWNceocbCCfAhD+sV/SzikIBcazZvUcwYeLEpIU/Lo2NASJEaxcn0lDeQvJuTiJzgZ7cx5cAwB8p7ervFVmdTayClBx1dePffsRIBkJ/A2JGeMa7A+QGXzpumvXqByt7aSvVmYFK3sa/WAqKWGQAWXumpJq2OcvhdnoICBVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7DUp+U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4590C433C7;
	Tue, 13 Feb 2024 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707844361;
	bh=DODOhjUD2slZ/cgfwysouYBG0XDvcKxiIpc358gSyao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M7DUp+U4yRiCZkSDg4dYkigqH4LdxlXWe1xFiEvofBwXWa3L8UySlRO//QOdQ5ZG5
	 /BOCvYYBTIiL9UFL6LxFGTsd5EvecRPyH8tZcOMMmBxWQrv4s4xLIh3Qb142KEDE3h
	 8dA+Feb4mBjlET/D/b+2Y0pmUAAMZM+l8KVmLkcRLsN/yyRzW2AAJSwatdi5eJR3vm
	 rpO02OHmfZ6WQP90h/bPidM3BpJv6ubkLGfldxH7LDJ7+A1t51KyWj1en+ufak1jJH
	 4JGuRxuf5iaki+lkRArZsHbWdmDNiMQ3b4mQ+rgUXN3ODQv/uw7JQRDPHrjKQBnsff
	 4XYEunu/HDLVg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com, 
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 timvp@google.com, cujomalainey@chromium.org, daniel.baluta@nxp.com, 
 stable@vger.kernel.org
In-Reply-To: <20240213123834.4827-1-peter.ujfalusi@linux.intel.com>
References: <20240213123834.4827-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: IPC3: fix message bounds on ipc ops
Message-Id: <170784435966.387832.16439838513913761669.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 17:12:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 14:38:34 +0200, Peter Ujfalusi wrote:
> commit 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
> introduced a new allocation before the upper bounds check in
> do_rx_work. As a result A DSP can cause bad allocations if spewing
> garbage.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: IPC3: fix message bounds on ipc ops
      commit: fcbe4873089c84da641df75cda9cac2e9addbb4b

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


