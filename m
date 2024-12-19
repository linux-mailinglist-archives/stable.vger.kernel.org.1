Return-Path: <stable+bounces-105285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C19F7875
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5462E163F05
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9588115688C;
	Thu, 19 Dec 2024 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJPi4CH9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4E221459
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600438; cv=none; b=UpK0AnjkebL8+239Deh2OyNm0xchPHCTNUpevD+gRnKufxAkUP9LJiVtm8dUcSJ9HrVLouP3dp+3UGbRWgbSfiFDwbV3r7PlHsgZLOidB5CsT3WVMjasgg6JV0Y7XRO/dyMWolutj9B9vGgRYW2KpaL78WcWufLsiBXPcJgf2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600438; c=relaxed/simple;
	bh=Dhmh/fHKoO/5nFfxm0OoelmdAlM5m92OiFgk6tgg+Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6xWKkbjSqY3MXMxvYYa3nyMxSaH9VuXuG4nE8/kAaJJwFHWWUZizJGRulmoUcxIAWtm5dnD8QnoKvS8bhdvOAijaVYkXio7bpWCiXPnjy96eNvrWNRopGOIH03qOZhjlCYz0kNwtsvuSsMNszvNfN6gv8PtPrPbXF7sDlXpTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJPi4CH9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734600435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtOqNn5Ah7f9AT/ohPVGIekCuIswjUxtBeWBQzFVNlU=;
	b=EJPi4CH9MS5ws8P92igfeTMoSp9ftHwh3I5tizvmlcIMRhQENuBNue4ajKQcreftqssd2j
	KdfCD9TRTvbmE8qcmQS1eXCrVfBkwLriN+snG0HzwkKzFZ10tGTKPTCmfIZE7N3+jzAclP
	p9mQMjrcJfbu0/zs9zpeW+gQv6LhtwU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-cI3T8-4yOZyq4EaVGxy5tg-1; Thu, 19 Dec 2024 04:27:14 -0500
X-MC-Unique: cI3T8-4yOZyq4EaVGxy5tg-1
X-Mimecast-MFC-AGG-ID: cI3T8-4yOZyq4EaVGxy5tg
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d124077928so513024a12.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 01:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734600433; x=1735205233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtOqNn5Ah7f9AT/ohPVGIekCuIswjUxtBeWBQzFVNlU=;
        b=bQ78PNzVsqYiXZLGfk+eJu4HjOi+2bUcnl+vHRBNaS45nnn3dcChr03pYaLp0yNZid
         gojMGaIOulKzk2NkcWXMcjsUssnpeqq/WRBsx4Xh7n1OJK1RnmNxhkIgjZ6rpdPFLfqB
         3lx1sMwEL/aW5OBbfagu1TF+cQiF8bffeMFZ/Z463GqeAQ7jtvBKfAc/P2cTPlW/88UU
         BrIGslfNC50a+ab+nRonJhEfowWdiJRLOYHn9Y8LVgq77VeTc2dAkwO9eivb77Q6wWlT
         7Zf3ECwMym0K9dX9OeRk01IuA4mGmuj8Tqtp96+iNzPdLkm1wDnyt7yfTW0VAP5r9un6
         ycBA==
X-Forwarded-Encrypted: i=1; AJvYcCVt9a+pFfd2VwmoGTMfMRC1VmItFsy9FSbB6a/VI2mrtFeuRlWLIOnpWHOBEALkCJDI36Uo2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi41DNmLZnE+sSIodTnvZZ7tZsFCEeMxphqeSmILTDDU6eg0Xn
	54lG+oJrn8KObVTilpdw9+c6Xg2CQh+uGdC40JN1cURBY30DyMtIILVzNMNMmvHfogsRybatF4C
	KhGAfpe0fV5yMfMtwN8J3Ww79TrlLSz0YnjFNfIjf1VRCku2YMpszpA==
X-Gm-Gg: ASbGncvOobgSO7wknRtjw2g7rg7smbBwQMignl4kBhRIinMqRdJ1r3AYBifMg47+Hxj
	VcpqHVh1bG73QAXjlBZuRfFYzfF+rAPKujtJMzmYWBJETJnukcdarbkZXhE3uF2Zjfi3fs8DxJN
	iQQIfyCjNQnxqrgzi6+lD1NZKUz9Pf57CUvLwOvVKFbWJB3zG7eUXV5m6NmTjJvH8ELhwUo8Jzh
	5kgmfLpbtIy5xu+xo1pt/Q8EqkZOyQxX5NZc83hDEH6Wnvz5nJ0MmapCQflt0NmwE/fgEZZUDaY
	mErZ4SLEnjzeBL5av07HYrQibRG01vyG4LIFnpbUWHYA33cqKP9tnRikDhME4uagzwsS2lHLPk7
	yCyyFhSyZ/wfmjYMvDZ8j24kRb1ObwgA=
X-Received: by 2002:a05:6402:524d:b0:5d6:37ec:60cf with SMTP id 4fb4d7f45d1cf-5d7ee3ff066mr7036918a12.27.1734600432875;
        Thu, 19 Dec 2024 01:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpY0yeTZkltgJqBoBxtx25H14dP/HivVpG6PUcBbKwyOlAVppb9zvsYEwHN/VFedwFnj7rFA==
X-Received: by 2002:a05:6402:524d:b0:5d6:37ec:60cf with SMTP id 4fb4d7f45d1cf-5d7ee3ff066mr7036896a12.27.1734600432438;
        Thu, 19 Dec 2024 01:27:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fede4csm468671a12.63.2024.12.19.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 01:27:11 -0800 (PST)
Message-ID: <f0e267be-70ab-4323-8c67-8f28201a1696@redhat.com>
Date: Thu, 19 Dec 2024 10:27:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] media: uvcvideo: Two +1 fixes for async controls
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
 <e3316372-d109-4d2e-ad2b-8989babdf546@redhat.com>
 <20241219003708.GK5518@pendragon.ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241219003708.GK5518@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19-Dec-24 1:37 AM, Laurent Pinchart wrote:
> On Mon, Dec 09, 2024 at 12:01:16PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
>>> This patchset fixes two +1 bugs with the async controls for the uvc driver.
>>>
>>> They were found while implementing the granular PM, but I am sending
>>> them as a separate patches, so they can be reviewed sooner. They fix
>>> real issues in the driver that need to be taken care.
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>
>> Ricardo, Thank you for your patches.
>>
>> I have merged patches 1-4 into:
>>
>> https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/
> 
> At least patch 5/5 was applied incorrectly. Does that result from a
> merge conflict ? Or did you apply v5 by mistake ? There doesn't seem to
> be any other issue.

I think I applied v5 by mistake, sorry about that.

> I've rebased the uvc/next branch to fix this. Once CI passes, I'll send
> a pull request.

Great, thank you.

Regards,

Hans



>>> ---
>>> Changes in v6:
>>> - Swap order of patches
>>> - Use uvc_ctrl_set_handle again
>>> - Move loaded=0 to uvc_ctrl_status_event()
>>> - Link to v5: https://lore.kernel.org/r/20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org
>>>
>>> Changes in v5:
>>> - Move set handle to the entity_commit
>>> - Replace uvc_ctrl_set_handle with get/put_handle.
>>> - Add a patch to flush the cache of async controls.
>>> - Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org
>>>
>>> Changes in v4:
>>> - Fix implementation of uvc_ctrl_set_handle.
>>> - Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org
>>>
>>> Changes in v3:
>>> - change again! order of patches.
>>> - Introduce uvc_ctrl_set_handle.
>>> - Do not change ctrl->handle if it is not NULL.
>>>
>>> Changes in v2:
>>> - Annotate lockdep
>>> - ctrl->handle != handle
>>> - Change order of patches
>>> - Move documentation of mutex
>>> - Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org
>>>
>>> ---
>>> Ricardo Ribalda (5):
>>>       media: uvcvideo: Only save async fh if success
>>>       media: uvcvideo: Remove redundant NULL assignment
>>>       media: uvcvideo: Remove dangling pointers
>>>       media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
>>>       media: uvcvideo: Flush the control cache when we get an event
>>>
>>>  drivers/media/usb/uvc/uvc_ctrl.c | 83 ++++++++++++++++++++++++++++++++++------
>>>  drivers/media/usb/uvc/uvc_v4l2.c |  2 +
>>>  drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
>>>  3 files changed, 82 insertions(+), 12 deletions(-)
>>> ---
>>> base-commit: 291a8d98186f0a704cb954855d2ae3233971f07d
>>> change-id: 20241127-uvc-fix-async-2c9d40413ad8
> 


