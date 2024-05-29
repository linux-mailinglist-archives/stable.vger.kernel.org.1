Return-Path: <stable+bounces-47620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C773C8D328E
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675571F2252F
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF5169360;
	Wed, 29 May 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="o3ixHpwm"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049761E888;
	Wed, 29 May 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973623; cv=none; b=fJdIQK0y3fAwGCUey0OZ4t4Qnsz7NjBPNIuISTT0zSUMgZxHB2RP5lMqhh8rsLFVri1/faCewV7UljKOw7zsxSlejFHhF0hNsqgTitkk0fO2LEnJ4Ex0fekWbvPRYc/53EQl8rRdeAFSAMbt79p7vVfeexzzVdY9brQvNSKHAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973623; c=relaxed/simple;
	bh=8a+y4xebRj73GpHCVAWuMNXwnLAcUllC70MgJC5/I3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srVdmour4zM29w5KayZ8Xq7yJM4ZRA9DtZEVMdaYg1fdPZEXpk147wICCvGhsnyeY3DNIiGNPYu9qdpzvyN1Infkbefjn+orIU9CntmhFVdMXbGb0F/R1Oo2lVbujev7Y/NXEMfx6P5I8nuPt9vUn9BGqOxTf/K9IyytG0Xmr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=o3ixHpwm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8a+y4xebRj73GpHCVAWuMNXwnLAcUllC70MgJC5/I3U=; t=1716973621;
	x=1717405621; b=o3ixHpwmnNyZxqPYM3+EEPY1+/8VMyGKMzkha4/IbfKQUHqZH7Bwy96IpmsJ3
	RMTlJ93BuWn1FZX0PRMCropLHn/8AAHQ0l+mnQN36CtABtnstLd7OR2yN1BYCG4d5vV+Sp9i0O/Xa
	ykh1Xb2KkxUCG38DAtt1vDRdN/1ZLFeQWAMmZkKND7oTObKbm3Q1HYCVVZOfNTt06k9IAmAOvEtu2
	a8nmG+UKOzElKHMDFXU2rC3+qsvf71LCP/lKHMzwkcTLYBNoJXyG/hW0gbXcI1xp7Ms5gVLujZOh3
	TcumqFQq1Fwxsgz7TCvCvdE5kjn8n2LbRrxyNzcRmVSmO7tE1A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCFGm-0005Uo-Dr; Wed, 29 May 2024 11:06:52 +0200
Message-ID: <ecee3a54-1a09-40fa-afdb-057ca02cb574@leemhuis.info>
Date: Wed, 29 May 2024 11:06:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Mike <user.service2016@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <c947e600-e126-43ea-9530-0389206bef5e@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <c947e600-e126-43ea-9530-0389206bef5e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716973621;f632811f;
X-HE-SMSGID: 1sCFGm-0005Uo-Dr

On 28.05.24 22:54, Mike wrote:
> On 29.04.24 20:46, Linux regression tracking (Thorsten Leemhuis) wrote:>
>> Well, did you try what I suggested earlier (see above) and check if a
>> revert of 6083089ab00631617f9eac678df3ab050a9d837a ontop of latest 6.1.y
>> helps?
>
> I hope you don't mind if I jump into the conversation trying to help.

On the contrary, thx for providing the needed information!

> I tried reverting 6083089ab00631617f9eac678df3ab050a9d837a
> on top of6.1.91 and it looks much better: it's been 10 days, and the BT
> and the system are stable.
> Previously, I encountered the mentioned "kernel BUG" at each boot,

Might be a good idea to share it, the developers might want to confirm
it's really the same bug.

> and I was unable to stop/kill the bluetoothd process.
> Let me know if/how I can help further.

Jeremy Lainé already confirmed that 6.9-rc5[1] worked fine and that
another fix for the culprit did not help[2]. Therefore we just have
three options left:

1. test another fix for the culprit I found on lore -- but note, this is
just a shot in the dark
https://lore.kernel.org/all/20240411151929.403263-1-kovalev@altlinux.org/

2. revert 6083089ab00631617f9eac678df3ab050a9d837a in 6.1.y if that is
still possible, does not create a even bigger regression, or leads to
some security vulnerability

3. motivate the BT developers to look into this (some other patch the
culprit depends on might be missing), even if this strictly speaking is
a problem they are free to ignore.

Maybe give "1." a try; then we'll ask Greg for "2.", unless this
discussion or something else leads to "3."

Ciao, Thorsten

[1]
https://lore.kernel.org/all/CADRbXaA2yFjMo=_8_ZTubPbrrmWH9yx+aG5pUadnk395koonXg@mail.gmail.com/
[2]
https://lore.kernel.org/all/CADRbXaBkkGmqnibGvcAF2YH5CjLRJ2bnnix1xKozKdw_Hv3qNg@mail.gmail.com/

