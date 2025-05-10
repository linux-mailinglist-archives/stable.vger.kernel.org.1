Return-Path: <stable+bounces-143073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231BAB20DE
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 03:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF61B66850
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8920267736;
	Sat, 10 May 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0B+2Qo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508A1754B;
	Sat, 10 May 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841788; cv=none; b=Ngcyo/h0KilVydFiVPil8lviIeaIKFzvpYdMOISTnZTFbj/6gfIHCxzRdnzWCKRVwG06/xcgjzbAPujcN9bIQwp6iwAqgN/ztSuaX7Kbdb34FJDCNRy8q71hxHlDDy2nRIfUht6bnD17r8UKMiai+fV6eiqktMSOBCa8/ja9LqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841788; c=relaxed/simple;
	bh=SswOEwGwaUgJCPy1YDxa8sDEbRaAeIimcFnmOM34gdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fNuJjlO6gKfbtaJkweQMgSHvMbRNcUTSR15brY2CZVMEAS3W3mS293S8WAPQaNh4ajzvKHwsFekjcJt/LC50xqfYOxcRpWW6x19vMBKcaJrjAILBsL3jP83yF64Dbm8pMbKfdUz5exWMUiQafdvg95I0jNEJu2crqV5Amph+L70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0B+2Qo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B0C4CEED;
	Sat, 10 May 2025 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746841787;
	bh=SswOEwGwaUgJCPy1YDxa8sDEbRaAeIimcFnmOM34gdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R0B+2Qo0o5K3dQ3CWvLQnmvXdizVDvU+0E4ufDegSZUTDu3QjRstEfwTAolOZu3lt
	 tU0wYB3tbRep03tvAcE1Grs+OjmZABxcpneYTM5KRKFEGMM3eNgP9wVPI4nBFD5DSg
	 p8Nc0phYgQzNO9mdaJViZbRaCzeOdaowGc4iLqutfrsIWmcU2jSFdiezFp7sVn7H4p
	 Ztx9PsZBlcLMb3dCalMQYk/0az1ZmjZuyV7ARkPLrY7jRWm18foaTX51s3ta7W9jPD
	 6hIC9GzQdWhsdoEixS0O8QpxgcD2ncoumVb4xNh/aMDwI3fpBmoRJ8PM2hsTA7BEgZ
	 VBHh5xkCZ6pwQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, stable@vger.kernel.org, 
 seppo.ingalsuo@linux.intel.com, liam.r.girdwood@intel.com
In-Reply-To: <20250509085633.14930-1-peter.ujfalusi@linux.intel.com>
References: <20250509085633.14930-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-control: Use SOF_CTRL_CMD_BINARY as
 numid for bytes_ext
Message-Id: <174684178538.47320.10513460224175943548.b4-ty@kernel.org>
Date: Sat, 10 May 2025 10:49:45 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 09 May 2025 11:56:33 +0300, Peter Ujfalusi wrote:
> The header.numid is set to scontrol->comp_id in bytes_ext_get and it is
> ignored during bytes_ext_put.
> The use of comp_id is not quite great as it is kernel internal
> identification number.
> 
> Set the header.numid to SOF_CTRL_CMD_BINARY during get and validate the
> numid during put to provide consistent and compatible identification
> number as IPC3.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-control: Use SOF_CTRL_CMD_BINARY as numid for bytes_ext
      commit: 4d14b1069e9e672dbe1adab52594076da6f4a62d

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


