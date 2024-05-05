Return-Path: <stable+bounces-43067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8D8BBF43
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C14281F6E
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 05:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46281869;
	Sun,  5 May 2024 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wacr2QJ5"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE932A35;
	Sun,  5 May 2024 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714885202; cv=none; b=lbBSgutRsNNVXr9M18aYe1/TFKqyzm0ZXNTTHiV+DZ70wYJamdsOiho6G0H7kdd7gXBAlpr3u1UMNA1BB0lsZyx73v3QnhgTPZrviVYfLPo6AN+yTWZw82wyEO2EsyeQ0IEK9N2yPVWc+GXh6/NGjRoK+zH1dJDscxbo/iGximo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714885202; c=relaxed/simple;
	bh=gZWYN8TIJRhzisv1ghmJGD7uF7Ek/ub2Pify1gP8OTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQPj+0zJoBhl4ET/0iJK86FD5W4wT0fYspvWcZvUGTff8QSt4Tf+04OUjgBX4A8B+34Pci5kAPrPFVSkQso+6qlf8RTtLzENsT4Xu3cpiXaF/RZfbK1pJUF3GB0T5IDE9t1Pa+OYL+XMAKVlbY5+p0kGhwbyeKCeLBGd9zUKvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wacr2QJ5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=FqdPLKiJZZINToP0SO0egCn3nMeBdaZBsgYm9Al6woM=;
	t=1714885200; x=1715317200; b=wacr2QJ5e7ejSawzg3W4/7SoEO9vMizQP5Beqtghws31X5g
	Q5h0jFhzg+iomDmxjA/b6lBqep2cOUpUs3YMQZizen89BoC7LTzqkAX7biavtx34io/0JiR6i1ZTK
	cKgKmdkZ73dUg5XhTHHLlvazPipA8UZ1IbReQcN2lrTUYokTHzl9VcLx0GVxYULYrkxSqAF6celIV
	Y6d6OyjFLZ1/4kYmNUJCMzSlWVjtbEKQHTbUWkGnJxZBV6A7dwLaDi/pg8LamBIbdPcgEIn2QRigC
	/f6UpBzVKomrPQynBCo2f59tFbKu3eP0AO0GH2HXmlFteuqKtg9Pvx1hCvNz2zIA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s3Tyf-00055A-Fc; Sun, 05 May 2024 06:59:57 +0200
Message-ID: <3f1f55cb-d8df-4834-b22f-c195d161cab5@leemhuis.info>
Date: Sun, 5 May 2024 06:59:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Micha Albert <kernel@micha.zone>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <wL3vtEh_zTQSCqS6d5YCJReErDDy_dw-dW5L9TSpp9VFDVHfkSN8lNo8i1ZVUD9NU-eIvF2M84nhfdt2O7spGu2Nv5-oz9FLohYO7SuJzWQ=@micha.zone>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <wL3vtEh_zTQSCqS6d5YCJReErDDy_dw-dW5L9TSpp9VFDVHfkSN8lNo8i1ZVUD9NU-eIvF2M84nhfdt2O7spGu2Nv5-oz9FLohYO7SuJzWQ=@micha.zone>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714885200;7b11026f;
X-HE-SMSGID: 1s3Tyf-00055A-Fc

[CCing Mario, who asked for the two suspected commits to be backported]

On 05.05.24 03:12, Micha Albert wrote:
> 
>     I have an AMD Radeon 6600 XT GPU in a cheap Thunderbolt eGPU board.
> In 6.8.7, this works as expected, and my Plymouth screen (including the
> LUKS password prompt) shows on my 2 monitors connected to the GPU as
> well as my main laptop screen. Upon entering the password, I'm put into
> userspace as expected. However, upon upgrading to 6.8.8, I will be
> greeted with the regular password prompt, but after entering my password
> and waiting for it to be accepted, my eGPU will reset and not function.
> I can tell that it resets since I can hear the click of my ATX power
> supply turning off and on again, and the status LED of the eGPU board
> goes from green to blue and back to green, all in less than a second.
> 
>    I talked to a friend, and we found out that the kernel parameter
> thunderbolt.host_reset=false fixes the issue. He also thinks that
> commits cc4c94 (59a54c upstream) and 11371c (ec8162 upstream) look
> suspicious. I've attached the output of dmesg when the error was
> occurring, since I'm still able to use my laptop normally when this
> happens, just not with my eGPU and its connected displays.

Thx for the report. Could you please test if 6.9-rc6 (or a later
snapshot; or -rc7, which should be out in about ~18 hours) is affected
as well? That would be really important to know.

It would also be great if you could try reverting the two patches you
mentioned and see if they are really what's causing this. There iirc are
two more; maybe you might need to revert some or all of them in the
order they were applied.

Ciao, Thorsten

P.s.: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced v6.8.7..v6.8.8
#regzbot title thunderbolt: eGPU disconnected during boot

