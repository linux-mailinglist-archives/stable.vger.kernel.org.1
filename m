Return-Path: <stable+bounces-81421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D0993489
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258001C22F97
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176721DD529;
	Mon,  7 Oct 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dJRyUuR1"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43B1DC18F;
	Mon,  7 Oct 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321194; cv=none; b=MhNqgzR9vt7zr7AI6DY/9e0lg7KsdiTV4nZwLeCrkG7oYN3ScNiJW0wkpUC4iV3aL5DSfjTffBDHVHwpQmuGlz4jCZwuy53l2m3EJPmbrP9SYJgvn730pjS3JlwMITXexzCo5SdoMVOX2TSQqAudse6pWZwL9R1zwWCyED5aDMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321194; c=relaxed/simple;
	bh=PKyxfWcnCoZT5Yrr+d9jxRdLbNw3SPWxHxpmmcr6SNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxrX/mCFSGkKxIb9+CfyRAtSBvEJ8mvVnS1qo2UW0nHwKx5gmnfLqrSkm6ovIa+hwO5IC0O9v+0Ug3HuN65eOr3xuCIfwxhwYVnpFvNSqy3bp2WRHopJ+hdIO6h1IlpIK+EsLWY1BZd26paC42R94kDLMLN+8XgWJ3Of4h2boPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dJRyUuR1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=RkBfKFjIJJ6FhVOD0VkjPQy6TvSJJ3XtVtwnyAzgvdw=;
	t=1728321192; x=1728753192; b=dJRyUuR1SDEVHzviUAztTAyHB5gF4mRzsOHKbWf/ZSP6HPB
	jfrXPLOhHgwIkywXUCPVVtgqyhwEVrH00O6reXNKlelchauzrBFrntv3DVZhwyeu8/6BMqz15C8qm
	GxE/izpeVs3Bd123dWCNxARrDA8L+4xrgqXIXoRCoyXqQiQb5NpxCaPwftjwLSvmUdUKIQa2PJB7h
	itTKtA5APRMM5wL4jU/6Jne4T+GH28yIo+FgGE4e8V6ILOMd0IZ6LzT29ER9pUAj/UqIZDQKOfACD
	cWF6CXt+qvNFS4KqzAFWdowFxFJct+ZMlxjTrETfgADTfdqFogTXVHUv8Ts5JCww==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sxrID-00077v-Qy; Mon, 07 Oct 2024 19:13:09 +0200
Message-ID: <3cd19fef-b15d-4006-abd2-77a2a68a8578@leemhuis.info>
Date: Mon, 7 Oct 2024 19:13:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: =?UTF-8?Q?Fabian_St=C3=A4ber?= <fabian@fstab.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-usb@vger.kernel.org, Sanath S <Sanath.S@amd.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh>
 <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
 <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1728321192;7a513ef7;
X-HE-SMSGID: 1sxrID-00077v-Qy

On 07.10.24 18:49, Fabian Stäber wrote:
> 
> sorry for the delay, I ran git bisect, here's the output. If you need
> any additional info please let me know.

Many thx, I CCed those that authored and handled the change. But there
is one thing that is not really clear to me.

Earlier you wrote: "The non-lts kernel is also broken." -- which version
exactly did you mean here? But whatever version it was: if you haven't
tried 6.12-rc1 or 6.12-rc2, it would be best if you could check and
report back if that's affected as well.

Ciao, Thorsten

> 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 is the first bad commit
> commit 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 (HEAD)
> Author: Sanath S <Sanath.S@amd.com>
> Date:   Sat Jan 13 10:52:48 2024
> 
>     thunderbolt: Reset topology created by the boot firmware
> 
>     commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.
> 
>     Boot firmware (typically BIOS) might have created tunnels of its own.
>     The tunnel configuration that it does might be sub-optimal. For instance
>     it may only support HBR2 monitors so the DisplayPort tunnels it created
>     may limit Linux graphics drivers. In addition there is an issue on some
>     AMD based systems where the BIOS does not allocate enough PCIe resources
>     for future topology extension. By resetting the USB4 topology the PCIe
>     links will be reset as well allowing Linux to re-allocate.
> 
>     This aligns the behavior with Windows Connection Manager.
> 
>     We already issued host router reset for USB4 v2 routers, now extend it
>     to USB4 v1 routers as well. For pre-USB4 (that's Apple systems) we leave
>     it as is and continue to discover the existing tunnels.
> 
>     Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sanath S <Sanath.S@amd.com>
>     Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  drivers/thunderbolt/domain.c |  5 +++--
>  drivers/thunderbolt/icm.c    |  2 +-
>  drivers/thunderbolt/nhi.c    | 19 +++++++++++++------
>  drivers/thunderbolt/tb.c     | 26 +++++++++++++++++++-------
>  drivers/thunderbolt/tb.h     |  4 ++--
>  5 files changed, 38 insertions(+), 18 deletions(-)
> 
> On Tue, Sep 24, 2024 at 8:58 AM Fabian Stäber <fabian@fstab.de> wrote:
>>
>> Hi Greg,
>>
>> I can reproduce the issue with the upstream Linux kernel: I compiled
>> 6.6.28 and 6.6.29 from source: 6.6.28 works, 6.6.29 doesn't.
>>
>> I'll learn how to do 'git bisect' to narrow it down to the offending commit.
>>
>> The non-lts kernel is also broken.
>>
>> Fabian
>>
>> On Mon, Sep 23, 2024 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian Stäber wrote:
>>>> Hi,
>>>
>>> Adding the linux-usb list.
>>>
>>>> I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
>>>> Linux for years without issues. However, updating to
>>>> linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using the
>>>> latest non-LTS kernel doesn't help, it also breaks the USB ports.
>>>>
>>>> Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
>>>> working version.
>>>>
>>>> I opened a thread on the Arch Linux forum
>>>> https://bbs.archlinux.org/viewtopic.php?id=299604 with some dmesg
>>>> output. However, it sounds like this is a regression in the Linux
>>>> kernel, so I'm posting this here as well.
>>>>
>>>> Let me know if you need any more info.
>>>
>>> Is there any way you can use 'git bisect' to test inbetween kernel
>>> versions/commits to find the offending change?
>>>
>>> Does the non-lts arch kernel work properly?
>>>
>>> thanks,
>>>
>>> greg k-h

#regzbot introduced: 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55

