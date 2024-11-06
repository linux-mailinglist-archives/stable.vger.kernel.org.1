Return-Path: <stable+bounces-90105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D69BE4D8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F1DB2198B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD791DE88E;
	Wed,  6 Nov 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="pWTGuSqQ"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C01DE3CD;
	Wed,  6 Nov 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890283; cv=none; b=fDEvEXqKjO9XaoYt5CQJxgjQ3yGOzqPRKlTGLqYl/TsL1tmE7JaDp5NuZmT1/e9n5IeufzoX99SKIjWr0mhgBejzXQLx3QAuY5EHnBsrTXUiBVMczlFvqT4FivpA7e5uE9WMbolFRS/2OBct/YXfALp1E17BEG1GOF53nd2Mozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890283; c=relaxed/simple;
	bh=91xyZJvrOWAyzLR65JD4tI5hHPkKw1Ximo0E5o5L5LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GieJPqfCgP6ZDsIfvTl/qZ8sdjh9jZqr9aZTzI+AonaPCMY0pgzY+z4Qy7VV2aAyDuqx/iDE8qL4m8RL6g6nvwlaur9DreB9ECLZsnoZ8qAo/rIVYr+5irpBM6gvxXPRJxrZU0HShUehOe3UTyhQTPePYpD7hL1vKmZ1HCO6Jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=pWTGuSqQ; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 0217A2FC004A;
	Wed,  6 Nov 2024 11:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1730890277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUxM+TDhBc4tT25gDHBZmTz+F++cFnGwVx5y8aqIjCc=;
	b=pWTGuSqQQLWNggA8vgbxSAtEiLPvgwCqK5toesG0Ekg7Xr9b2qPT1+S/rKHjWFpZdtv354
	PRouOLBLvU5wxdS5HwcSGEDYDEDWR3z7GGxFJWxtIOsnveHO1NldvMwK1U+nKLw19L64W4
	1ProqEjkrHT71+KGPdMocqneSH8Jr2o=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <b768433e-c146-46af-a077-3e2631a4c292@tuxedocomputers.com>
Date: Wed, 6 Nov 2024 11:51:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini
 17 Gen3
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Christoffer Sandberg <cs@tuxedo.de>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20241106021124.182205-1-sashal>
 <20241106094920.239972-1-wse@tuxedocomputers.com>
 <2024110606-expansion-probing-862b@gregkh>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <2024110606-expansion-probing-862b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Am 06.11.24 um 11:42 schrieb Greg KH:
> On Wed, Nov 06, 2024 at 10:49:04AM +0100, Werner Sembach wrote:
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> Quirk is needed to enable headset microphone on missing pin 0x19.
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
>> Link: https://patch.msgid.link/20241029151653.80726-1-wse@tuxedocomputers.com
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>   sound/pci/hda/patch_realtek.c | 1 +
>>   1 file changed, 1 insertion(+)
> What is the git commit id of this in Linus's tree?

0b04fbe886b4274c8e5855011233aaa69fec6e75

Is there a specific format/tag to add it to the commit? something like 
"Mainline-commit: <hash>". Didn't find anything in the documentation.

>
> thanks,
>
> greg k-h

Kind regards,

Werner Sembach


