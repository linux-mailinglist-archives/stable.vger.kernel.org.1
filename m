Return-Path: <stable+bounces-60694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3103938F59
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309E01C212F6
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455A16D30E;
	Mon, 22 Jul 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIn44lyH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43016A399;
	Mon, 22 Jul 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652642; cv=none; b=Xd1n/hfmlAOo/F8BjlPtUE+jePA6h99akQZpYQIu86xOvZeiGjC2CkDcF67eKvleP2tAN+YBtt/Wh6feJr4DJL2oK3E7zWDqCrrNpcX9go4yuZND/ftSsa6BeM68Mn9NjGn/h0PEfEMzscs8FVgUF8tIOOo2MXSg6o5Vw+y6QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652642; c=relaxed/simple;
	bh=W982RbKM0FhaZsBOiVBU/Ls1Lu4p3QpOAVhhr7poQCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCcpviE2wkGL4u/kngiixcLNHFOPYP1FijmKByoA3y5oFOlCEPXMWv4SaCBFEaxYwqBQbZvXdwJSA1A45VbkL0BDjceiD143EEz3K2esDawea6vB8i/7tSkEBsR019tZAvq9LVbboVmj4GjdmdiFnyXAvCWv1tnVoTBpThJ4YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIn44lyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D846C116B1;
	Mon, 22 Jul 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652641;
	bh=W982RbKM0FhaZsBOiVBU/Ls1Lu4p3QpOAVhhr7poQCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIn44lyHzVYq4T2bA3n0wKBGo41TxkJMXDtOXKDU1gnZztUMQ12ikGRkmMb14aQJ5
	 KZ2nCgnEXNuprrAmzGvHINWs/9IVj0AFqjsbOluR2ij5vdYms6Yn+YBMZQXbDjZYTb
	 ef94QN+aVXPTKpuyV16or+h9Fd/KzBVva3W9NKfHleoWCblQ0VsOwAxGVL7iEORd/Z
	 1Wr2qsTZZ2T3l+BVgZ4QA3Wh1yupMuVZ2FK6L5bFLcu/zDmuoJ+9wnHhYMb1Iw8RrW
	 TOPoWUMTZE7pA8JKY1YHHlhhvbN2FpsuTm3M4y+P6sGHB57Er6vcyfhd1woxJYgkux
	 TdFPgDvpLRCHQ==
Date: Mon, 22 Jul 2024 08:50:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Simon Trimmer <simont@opensource.cirrus.com>, perex@perex.cz,
	tiwai@suse.com, rf@opensource.cirrus.com, broonie@kernel.org,
	shenghao-ding@ti.com, sbinding@opensource.cirrus.com,
	lukas.bulwahn@gmail.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 11/12] ALSA: hda: cs35l56: Select
 SERIAL_MULTI_INSTANTIATE
Message-ID: <Zp5VoMzMjH6gHExm@sashalap>
References: <20240701001342.2920907-1-sashal@kernel.org>
 <20240701001342.2920907-11-sashal@kernel.org>
 <87wmm5a8ka.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wmm5a8ka.wl-tiwai@suse.de>

On Mon, Jul 01, 2024 at 09:13:41AM +0200, Takashi Iwai wrote:
>On Mon, 01 Jul 2024 02:13:30 +0200,
>Sasha Levin wrote:
>>
>> From: Simon Trimmer <simont@opensource.cirrus.com>
>>
>> [ Upstream commit 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc ]
>>
>> The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
>> serial multi-instantiate driver which starts multiple Linux device
>> instances from a single ACPI Device() node.
>>
>> As serial multi-instantiate is not an optional part of the system add it
>> as a dependency in Kconfig so that it is not overlooked.
>>
>> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
>> Link: https://lore.kernel.org/20240619161602.117452-1-simont@opensource.cirrus.com
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This change breaks random builds, so please pick up a follow-up fix
>17563b4a19d1844bdbccc7a82d2f31c28ca9cfae
>    ALSA: hda: Use imply for suggesting CONFIG_SERIAL_MULTI_INSTANTIATE
>too.

Will do.

-- 
Thanks,
Sasha

