Return-Path: <stable+bounces-135211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06586A97B06
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAD21B6069A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8C1C84D9;
	Tue, 22 Apr 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CPRQCk8/"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A72701BD
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364661; cv=none; b=X4QB404diI6WD6V5T9gTbVc8NEI8wRyIuwsv1yZwTjoDRx0jiEI0Vu2W5hEJ8GBifdSNk4yPHrQcjIJKJzWF2G2dbzKvchEDouS5w+/PO+2WxDZb60JxdYc/9Hc+MjHVcsNoUf8w4Inw+SCjBJAP32JvevUYhGQyDCvJyXa042k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364661; c=relaxed/simple;
	bh=8BuCbiBTLUrGrb/pye6jju6aE1yPIdSfssJIu67Kh5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCK77WL9l4Elw5kdq3juWwAypXK37bR/BWv26rmnuoqp8NOZajgAkfkKf9je0ziD9EU3zEA/XyFaOzML6y78xUAoN3A9ctbPxMppmyBuUe1rkxizeU5Fn4DDhalAwSJOVTw6bCa9YhrxoK4muMIIxiAySp2Z57/MFJFw9bMCpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CPRQCk8/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745364656; x=1745969456; i=w_armin@gmx.de;
	bh=8BuCbiBTLUrGrb/pye6jju6aE1yPIdSfssJIu67Kh5A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CPRQCk8/PPXS+gMXYlYbQWuKz3RmhkQ5AJyUCQ3uHz8Ig9+mf/3lD69tqxQuhKjN
	 NWHKR4e+gKZbZHT8hkDqqEzF1Ut2bHPvJRLLHCwy+NrqP6mnAvYQRiPhLSweaflIz
	 kmyZ75PDrZzhvU72AL2vWcUmwJP5HDjqXkpg6PAv8xQHXIW4Ny9bTV4Y/wKuJow4t
	 y6c9JrKwGGe3uS7bpu6BY/mfQyxmAXIEKoc5mijRlBl5hnMsfqVVFnYMpOX0D3+In
	 vQ9GYfQcOm2e+6s15uJAI6ZUcn+SKO9mg4jN+egANwGSLZB/OMNWGy0c9H54t6KrG
	 402Fwz37rpL9YysjDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1utcFk3aLn-00kv3q; Wed, 23
 Apr 2025 01:30:56 +0200
Message-ID: <4d382bfd-45f9-4989-bf1d-1e6a1ed30295@gmx.de>
Date: Wed, 23 Apr 2025 01:30:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] platform/x86: msi-wmi-platform: Workaround
 a ACPI firmware" failed to apply to 6.12-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ilpo.jarvinen@linux.intel.com, lkml@antheas.dev, stable@vger.kernel.org
References: <2025042139-decimeter-dislike-3ca4@gregkh>
 <c479afca-a994-4a65-a7c5-7fb53b2d38e9@gmx.de>
 <2025042201-botanist-hassle-a21b@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2025042201-botanist-hassle-a21b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jiaohfxWrZtpVWG5hwLYbE/YM3bFh7C2QC/tGl8kaoZIAKOPZie
 uTzPSlZv8FiJSztie1LW3PFRMA455eJKv7DwIH5VLz2+sUi0V7SLserbN07gkwcRS3hWmDW
 Nvv+YjjNaUO0rwTX727wTOpsRnJFQjUCwVRgUBCDZNH4ZU27XrVjibwU84ZN6cR/SyXLK0L
 NJS5VZZVQcYNGGAhPKyJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mDs9K+MMT+k=;ZvaaZGYPxHgRnsN5Z3mjCJTKZCY
 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
 s5UnpPALfif5NMbQdzs/g1GorX0mn4ehzc

Am 22.04.25 um 09:39 schrieb Greg KH:

> On Tue, Apr 22, 2025 at 12:07:23AM +0200, Armin Wolf wrote:
>> Am 21.04.25 um 16:03 schrieb gregkh@linuxfoundation.org:
>>
>>> The patch below does not apply to the 6.12-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042139-decimeter-dislike-3ca4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>>>
>>> Possible dependencies:
>> Hi,
>>
>> this patch depends on 912d614ac99e ("platform/x86: msi-wmi-platform: Rename "data" variable"). I thought that i signaled that
>> by using the "Cc: stable@vger.kernel.org # 6.x.x:" tag.
>>
>> Where did i mess up?
> You didn't, I missed that, sorry.
>
> I've fixed this up for 6.12.y and 6.14.y, but both of these commits do
> not apply to 6.6.y at all (filenames are wrong.)
>
> Please send backports for 6.6.y if you want to see the commit there.

The affected driver was introduced with kernel 6.10, so both patches are unnecessary for kernel 6.6.y.

Thanks,
Armin Wolf

> thanks,
>
> greg k-h

