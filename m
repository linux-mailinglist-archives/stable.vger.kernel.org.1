Return-Path: <stable+bounces-11355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4F82F42B
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796201C23946
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADA1CD31;
	Tue, 16 Jan 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFH8wYuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224261CD29;
	Tue, 16 Jan 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429443; cv=none; b=PQvEwKtSUuxz76r/Y+kXsBxeJAhJpYtUN8qwj+zt4TUSuHkDuW4dEaW4NuDDt7un3RqlOs+khh59jONre2E6E2kHzXvX3xDLeVj1CklQr1Z9HaOs5MFxk4GBiZYpg3jBKHCk9pg40kyTPjZJNqbjAW+HWEThxHwBU4yw7gpC+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429443; c=relaxed/simple;
	bh=Ny7yUTWUQmymtTX7P4DBusGcRxTBntr9KtUV8w6jbQg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ZO6v7FVWdPA6mwfi9SKx38ALUv8s+9coX86XKEb5qTkeb68PFo6x4YCLgDRXonbBdCSwmjrmQb/r74mq1IxcpjfaFLWfdYR4I0AGiiOXm1TT3aRH+8ojtMf1+Z/UL+NHHs09k5f12an59IQimyDV9pIgGRg5WLAuxymnw089pC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFH8wYuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64177C433F1;
	Tue, 16 Jan 2024 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429442;
	bh=Ny7yUTWUQmymtTX7P4DBusGcRxTBntr9KtUV8w6jbQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFH8wYuIlYf2tCV++H4TxMsYm8W3QXQq7OBPAgOImKlhiUN3qkV47KbVlgsxoJ+h0
	 Pj+NqnOJ9AJ9IHUElT4Tc+De1Disw9P/nFvB3I5BJDE7L0jh2JYoqLjv978rsdYbPT
	 QMKMCTvdp2AnkgkrtDlpies2vmrheHFd+qFp0ysrGipua4HJywo5yAdvEukoom4Ep/
	 hq6xqBpUEznsELr7Ubpg5lR6R0I7HChmIIUaL1zcJEjF2b/9iTF7n0Zszsx8zPjoUX
	 IJqiB8XJyRcoRpovhPZAlquCnlRFTxnKea1UHYfhj/zCMLsVxQpiwK0rOlkBkWndJw
	 4bErFPZwkudzQ==
Date: Tue, 16 Jan 2024 13:24:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: Patch "ASoC: SOF: mediatek: mt8186: Add Google Steelix topology
 compatible" has been added to the 6.1-stable tree
Message-ID: <ZabJwJax7gY-uTzC@sashalap>
References: <20240116105221.235358-1-sashal@kernel.org>
 <71af3837-d1a9-478d-82fa-1b52fddd5aa2@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <71af3837-d1a9-478d-82fa-1b52fddd5aa2@collabora.com>

On Tue, Jan 16, 2024 at 12:40:55PM +0100, AngeloGioacchino Del Regno wrote:
>Il 16/01/24 11:52, Sasha Levin ha scritto:
>>This is a note to let you know that I've just added the patch titled
>>
>>     ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
>>
>>to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      asoc-sof-mediatek-mt8186-add-google-steelix-topology.patch
>>and it can be found in the queue-6.1 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>>
>
>This commit got reverted afterwards, please don't backport.
>
>Ref.: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=d20d36755a605a21e737b6b16c566658589b1811

I'll drop it, thanks!

-- 
Thanks,
Sasha

