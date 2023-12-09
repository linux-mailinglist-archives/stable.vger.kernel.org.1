Return-Path: <stable+bounces-5088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE680B25C
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AF5281102
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0D1867;
	Sat,  9 Dec 2023 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JByOoW2V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2371C03;
	Sat,  9 Dec 2023 06:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9CAC433C7;
	Sat,  9 Dec 2023 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702103700;
	bh=evyiymai8Mj6HXAskfzzPohovQRL2Ek0ONBj8sXQysg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JByOoW2VhX9rJ9CmscBJKczww0eOD5ao6VlGejTp72vlxmO0BFIrFJ1Du1gN9RjBt
	 IrpmDIHeAZvgoEhDazpnRLc8cE2OXxa3rEBpUbBEYocu34vMIB/jqzM82chs3vGyvA
	 ejFZ4IQ7HSSW0CWTwC6zsPJiQTELDAqOuZYFyK2nJc0DM9NjoMsbmWqvlR4l/l1p8J
	 +Sbasjzf80d2RtPdgX8AmjUgce6eLWXVVcR1E56/k+aMZPiDoaBqxFhX7Whl3wiMui
	 lagXnLgUpsuyqXNBjSPFub8cmsqydjE6k3mmNjeHJKMOmCLoJv9pqiWuiy+K+WmXeW
	 /okmyDRwc1x+w==
Date: Sat, 9 Dec 2023 01:34:51 -0500
From: Sasha Levin <sashal@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable-commits@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: Re: Patch "spi: imx: add a device specific prepare_message callback"
 has been added to the 4.19-stable tree
Message-ID: <ZXQKi4QvI7KOJsyb@sashalap>
References: <20231208100833.2847199-1-sashal@kernel.org>
 <20231208104838.xqtiuezd72nzufd4@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208104838.xqtiuezd72nzufd4@pengutronix.de>

On Fri, Dec 08, 2023 at 11:48:38AM +0100, Uwe Kleine-König wrote:
>Hello,
>
>On Fri, Dec 08, 2023 at 05:08:32AM -0500, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     spi: imx: add a device specific prepare_message callback
>>
>> to the 4.19-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      spi-imx-add-a-device-specific-prepare_message-callba.patch
>> and it can be found in the queue-4.19 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit b19a3770ce84da3c16acc7142e754cd8ff80ad3d
>> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Date:   Fri Nov 30 07:47:05 2018 +0100
>>
>>     spi: imx: add a device specific prepare_message callback
>>
>>     [ Upstream commit e697271c4e2987b333148e16a2eb8b5b924fd40a ]
>>
>>     This is just preparatory work which allows to move some initialisation
>>     that currently is done in the per transfer hook .config to an earlier
>>     point in time in the next few patches. There is no change in behaviour
>>     introduced by this patch.
>>
>>     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>     Signed-off-by: Mark Brown <broonie@kernel.org>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>The patch alone shouldn't be needed for stable and there is no
>indication that it's a dependency for another patch. Is this an
>oversight?

It is, appologies. I've been traveling and my patch-shuffling-fu isn't
doing well with conference/jetlag.

This is a dependency for 00b80ac93553 ("spi: imx: mx51-ecspi: Move some
initialisation to prepare_message hook.").

>Other than that: IMHO the subject for this type of report could be improved. Currently it's:
>
>	Subject: Patch "spi: imx: add a device specific prepare_message callback" has been added to the 4.19-stable tree
>
>The most important part of it is "4.19-stable", but that only appears
>after character column 90 and so my MUA doesn't show it unless the
>window is wider than my default setting. Maybe make this:
>
>	Subject: for-stable-4.19: "spi: imx: add a device specific prepare_message callback"
>
>?

I borrowed the format from Greg, and I'd say that if we make changes
then we should be consistent with eachother.

No objections on my end; maybe I'd even go further and try and send one
email per patch rather than one mail per patch/tree.

Or... finally drop the stable-commits mailing list altogether? Does
anyone still need this (vs. just looking at -rcs)?

Greg?

>Another thing I wonder about is: The mail contains
>
>	If you, or anyone else, feels it should not be added to the
>	stable tree, please let <stable@vger.kernel.org> know about it.
>
>but it wasn't sent to stable@vger.kernel.org.

Good point. I figured we want to reduce the spam on stable@ since you'd
see a mail about this patch in the -rc mails, and so stable@ isn't
cc'ed, but I can definitely add a reply-to header.

Thanks!

-- 
Thanks,
Sasha

