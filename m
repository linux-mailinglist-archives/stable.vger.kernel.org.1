Return-Path: <stable+bounces-17662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C18469FA
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 08:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A876E28E66A
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 07:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95217C64;
	Fri,  2 Feb 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4iVvijN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D618028
	for <stable@vger.kernel.org>; Fri,  2 Feb 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860749; cv=none; b=kHI7ovaWnmvwjYSD2MFS/QClRpXxOy1PFe8udwOgiNwK4pi1NBgml3TX889a6l2il/otu/p02Xy3c4MyNdOSShGbSEJ4IsRVuov7MAxlqzhGKRG20ito2xDlFo1Nmfn7JN1lrpqW3w5LtHQOweSZtA0eKDPIWPdyAA8h5SotyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860749; c=relaxed/simple;
	bh=w8tCpbQ0A1YgNYhQKFY3Za+PAmrvcXk8Bry4ghhpDI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9nrBsilnBNauhjiSXMJxCNziRfBlpWESQQ5GQVESk92JeraC2YTW2q4vZ0QsuULP5+YW/MWs4bkUVr0hZgFDnEWVSVR1t4vzXDRcaM+xhXsfm3l+sF8qz/HnPS/ZtiYmiDlqv+5YABimm8IB+89pHSdHgIjGfS7q72og4XiwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4iVvijN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706860744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptzZ7yZPPFvC3T/6Mypo9JQzCvFLU0tUQ8aX8kCb+bg=;
	b=h4iVvijNGApl+XRCX9MZQXZXog9RhE00oQ2DnBvD1gvoa4Gj3I5+lraNOaxwypmVb5RLdA
	fG214sXQwpHNpb1TOGEpa2WBQ+XwxF4KX/JnmJZoR0m1qiALw9iGnRbM0hxxIwMRUvv0qp
	lVZTFjd1rSAGK9LXJ0KKcTYb26BvoHE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-ShPaqMMFNXi4K7c9fdZfjg-1; Fri, 02 Feb 2024 02:59:01 -0500
X-MC-Unique: ShPaqMMFNXi4K7c9fdZfjg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3639d04fd20so14822615ab.2
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 23:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860741; x=1707465541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptzZ7yZPPFvC3T/6Mypo9JQzCvFLU0tUQ8aX8kCb+bg=;
        b=iss/NwmmJY268q9Twr0Nq/M5aoZzSRnG7tNP0QaAyJvVPPnM2gpx6f+1eHY3xSSSV2
         hIzaCpgUbkas7OWl6mD9hYYZTqlM4HxtZyKoMIgcztFdWSJLwdOo29PlTaaxBx7pFGMm
         waFYNWyNRiuft8I+Sb4B9fGmnrTbKY+AASUQOHtVzNTgpofQsjvxa4MVCIeTbFWjDCD7
         v3GJBlKTFYw5MK6DQnfIOhnXtmYvt6RaDCfLEDmyeTIbIvZlR2IZyfMUXu/fhKeEjpRP
         0gMT4byr7HhZ212AR1rHZM1sko7rJ0TdpATvLc2k2vn4R6DrQMTclrfofQAVOKT6CcgD
         SVFg==
X-Gm-Message-State: AOJu0YxeSQqbNea7h/HeExuAtE0HtqkdK3EWKyusE5W1qSAZAn1rAbsm
	j3u/PzyQ/ugQ+HA7blS2U9ZxQejht6lxOX4hgn3J1RneNGS8XgYN7Rukfjud+ioNBByt+u5RdJl
	KEBJfdWcmE1rn1AAr+MaqjvgUvO5SJyel05kFsBU+awc3+fQykaa2QA==
X-Received: by 2002:a92:d981:0:b0:363:7bc5:727b with SMTP id r1-20020a92d981000000b003637bc5727bmr8120779iln.26.1706860740845;
        Thu, 01 Feb 2024 23:59:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmI/5H4LFMJxHc+cmVKY/ZzxbWqy6c1sOkkghhT3cKQ2oxAsfpKcBtUe/6o18bUqG6ORurQ==
X-Received: by 2002:a92:d981:0:b0:363:7bc5:727b with SMTP id r1-20020a92d981000000b003637bc5727bmr8120774iln.26.1706860740609;
        Thu, 01 Feb 2024 23:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXn7psG7leaijQtxb5Ad/407m+3IhWCYuJ/F0Pmrw5yhB+1NtIQ7FJF57VQC2eJBwpwcM8UymrQVTogscfpcPvN7Z+v+Kr5Z4Fi632OcvdnLDyh2Nlo90g7N6nB21W6FAQ9+Z+8GxhJMXnktz5NRuFMm9PKlRMb54KyOf++QxulJQ==
Received: from [192.168.43.127] ([109.36.129.188])
        by smtp.gmail.com with ESMTPSA id db5-20020a056e023d0500b0036299f401b6sm430941ilb.71.2024.02.01.23.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:59:00 -0800 (PST)
Message-ID: <3b18ecca-c6ed-4685-a45a-71c3ffac4f96@redhat.com>
Date: Fri, 2 Feb 2024 08:58:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH regression fix 2/2] Input: atkbd - Do not skip
 atkbd_deactivate() when skipping ATKBD_CMD_GETID
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-input@vger.kernel.org
References: <20240126160724.13278-1-hdegoede@redhat.com>
 <20240126160724.13278-3-hdegoede@redhat.com> <Zbx2Cuhfy-rpcvCE@google.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zbx2Cuhfy-rpcvCE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

Thank you for picking up these fixes and
sorry about the breakage.

On 2/2/24 05:56, Dmitry Torokhov wrote:
> On Fri, Jan 26, 2024 at 05:07:24PM +0100, Hans de Goede wrote:
>> After commit 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in
>> translated mode") not only the getid command is skipped, but also
>> the de-activating of the keyboard at the end of atkbd_probe(), potentially
>> re-introducing the problem fixed by commit be2d7e4233a4 ("Input: atkbd -
>> fix multi-byte scancode handling on reconnect").
>>
>> Make sure multi-byte scancode handling on reconnect is still handled
>> correctly by not skipping the atkbd_deactivate() call.
>>
>> Fixes: 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in translated mode")
>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/input/keyboard/atkbd.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
>> index c229bd6b3f7f..7f67f9f2946b 100644
>> --- a/drivers/input/keyboard/atkbd.c
>> +++ b/drivers/input/keyboard/atkbd.c
>> @@ -826,7 +826,7 @@ static int atkbd_probe(struct atkbd *atkbd)
>>  
>>  	if (atkbd_skip_getid(atkbd)) {
>>  		atkbd->id = 0xab83;
>> -		return 0;
>> +		goto deactivate_kbd;
>>  	}
>>  
>>  /*
>> @@ -863,6 +863,7 @@ static int atkbd_probe(struct atkbd *atkbd)
>>  		return -1;
>>  	}
>>  
>> +deactivate_kbd:
>>  /*
>>   * Make sure nothing is coming from the keyboard and disturbs our
>>   * internal state.
> 
> I wonder if we need to do the same for the case when we go into SET LEDS
> branch... This can be done in a separate patch though.

Right my goal with this series was to make the behavior change from
936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in translated mode")
as small as possible (just skip ATKBD_CMD_GETID and no other behavior
change like calling SET_LEDS).

I'm not sure about doing the same as this patch for the SET_LEDS
path. We only hit that path if GETID fails which means we are
already dealing with quirky hardware and we already have quirks
to skip the deactivate command for some keyboards which don't
like it...

Let me know if you still want to give making the SET_LEDS
path consistent with the others a go and have it call deactive
too. IMHO that would only be something for -next though,
so that it gets the maximum amount of testing time.

Regards,

Hans


