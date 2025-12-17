Return-Path: <stable+bounces-202777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD1CC6AC9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9F430CBF7C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542F33D50C;
	Wed, 17 Dec 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUf2vRjC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3972338592;
	Wed, 17 Dec 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961208; cv=none; b=GghNlAHxeJ5FcHkK817AsXu0Pm4M49blLBI00zziqRJmhkxmlahJIpNEfJ9N6XxlzINzkjQri7Fx+UI5awwMcZmfiKsTFCfJv3gf/22LsE58YPK8/3iegodXnlkJptOIGqilhGxSKGRQpSgVAMftTNYNSEhwqrCC8qg1/ZtSwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961208; c=relaxed/simple;
	bh=6EPA9C7oI1yVrLSkp2OF0U+gSoEDxDwuiYwet2UyBYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kc17jsSt5PT1emKW5yHx7nNoWK4356C8+HqzC74XN/R1HXi2VatYgt7kBjoBIDiXJ6T6zM8yzwIvJ3QzaNCaM+9GmcE8pfIJoHBeWRdOExfBV9ViYsgSAaMERNBRuStNCQKMf4feu+7EQA2uKBgfPIrRbKo71iSsAtDWYKYKLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUf2vRjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D0DC4CEF5;
	Wed, 17 Dec 2025 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765961207;
	bh=6EPA9C7oI1yVrLSkp2OF0U+gSoEDxDwuiYwet2UyBYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dUf2vRjCQh4YxP6uX1pqOBqvF3h5CLe66wbOZyLIffyyVla1ZrsmJrwtc4+2/NJnR
	 NBgSuvXt251la+CkuQ5nvEE+TnSsQN5DfFAn62XdPxfKxw0ZIJLwHswlLJhBog62b/
	 ADfqtiry4pue1v6xM2QMyCwcRLKgSx4Wh0S7bI5NtZrD5iXvOcVuxBpbSv1CA0N7Td
	 bkiJu3CkzbizFlQ7IiKu4aYGTsM0dGrq9ERgoCG9bzWP2m7Vk7QfIzwDWnByMsPQ2q
	 l04NF1qBnZOrqeRuZWcFDv5+NQjwGaEhJCLISGzYs4rhpsySg9Kjf/l+vxNqq8KVFJ
	 WZkaVIVujgzuA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, seppo.ingalsuo@linux.intel.com, 
 stable@vger.kernel.org
In-Reply-To: <20251215120648.4827-1-peter.ujfalusi@linux.intel.com>
References: <20251215120648.4827-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: ipc4-topology: fixes for 'exotic'
 format handling
Message-Id: <176596120523.335337.10043009817383930639.b4-ty@kernel.org>
Date: Wed, 17 Dec 2025 08:46:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 15 Dec 2025 14:06:46 +0200, Peter Ujfalusi wrote:
> The introduction of 8bit and FLOAT formats missed to cover the
> new corner cases they cause when the NHLT blobs are looked up.
> 
> The two patch in this series fixes the 8bit and FLOAT format caused
> cases to be able to find the correct blob from NHLT.
> 
> Regards,
> Peter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc4-topology: Prefer 32-bit DMIC blobs for 8-bit formats as well
      commit: 26e455064983e00013c0a63ffe0eed9e9ec2fa89
[2/2] ASoC: SOF: ipc4-topology: Convert FLOAT to S32 during blob selection
      commit: 816f291fc23f325d31509d0e97873249ad75ae9a

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


