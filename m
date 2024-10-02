Return-Path: <stable+bounces-80580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44A98DFDB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D31C23814
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D047A1D014D;
	Wed,  2 Oct 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ok71O4mC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399E42AA2
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884468; cv=none; b=uB1RqeRVFtFck9RIGl6qLTBL5aQZbZP/Zwvg60rstKLR+0hhLamypCnmgwVDIRodwmokfHPfj9QR2s4t3hpOuZBKmhIBrHzUkcnHbpilqhjc1lHMTtH8ZtqT5t6qD16cjZ/1lXpFlnRPzgdjcTXGUxiOlMD0O3ZXts2zGiFO04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884468; c=relaxed/simple;
	bh=SEQjv2/dUzisfsFVUp2mEGNmcVis35nMY+0U+u/NXuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQ5g0iS/Z4Y1h4+FcEujiP9BEM11yBptUyC38uAACup6i6HuYMWsUHbnCIHJ3zCT11GTFtCv54KWGQj9b3AZRYQhLdn663v0AhTA1KvLt52gjs3gjuovSzHS7tSsqWfyVS7jlY53DzrIG3U2JDfqCMiHTGuyLNubh6+xZFHh8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ok71O4mC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso340026439f.2
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727884466; x=1728489266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbIRMgGqDz2m4+NHhiR957SsicRhL8iYv7vOiuZBMR8=;
        b=Ok71O4mCVWc3O5SmdikovNmtQT1so4sB7Mm1pYcXjyLWb7W3PQ7TBWIiLLvnBcCFYd
         2QYO12SvU8P2+R79m/z3iDVhQVK6RpH/IkrmrjdJyjJti7nwVorahPpfMJ5g6UIXXDZf
         jgleWPwOhPJeuLbWNOi8qx/c2LrP1pMvXF/aYA3cKeCoE+IQNRqBRw0na/x70lWdB4gB
         5hc8+Q+5DRcIoIE21+uZ0mmv0ql4RVLd8efPXLpzULd+HB/hr0ARVyNyqLBsQVDI5gOi
         Kzx+ahvhUMY0cfBniiEeh3ldqXtn+lSgwh7fyO59W0WAVdAs8BgdUnTQ//6gRrjEQ0pC
         wsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884466; x=1728489266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbIRMgGqDz2m4+NHhiR957SsicRhL8iYv7vOiuZBMR8=;
        b=HlQD2ktYQN3KnFyDb2hb6tXdENVlGF6jCPvzy43ticLLoUgM9t1bngC4w99E6sL+ps
         LyKNKdH5dnS5VFePxbxTvS6z0XDwW9PEnCzxC3SB/knpZbrmX36RwAqLYl37n7G4uxYz
         LwwbfqBBRi9TRTyx4w6/yCDaTkiKCEkTkfEouKpL/C4YNOwo6G+0tjS/8p35ZQUsr+ch
         vb/HK5l7akO+dJqMbwgyYtUeanu6urZax+BkSmOxyqZ8dXn9OBO0d/y+Okg90Wn3PEWC
         ca2IYdx8wo/+VJa3szCJq4NmSrXyJgCKC0LGUuN/3EdwH7MmxggGuJaKzKpYibqg3p1y
         QGLg==
X-Forwarded-Encrypted: i=1; AJvYcCXyWzdSjKzsWTqJ4FH8FbBQmwfdLcr250pUc5ISqsl/Ask1zSh9GVHtWTEsplvDV4Urjbe5Wgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6vGu4qsMI8HeFIMmtbBc0+n8GN+ct0ZYsnm4YchYJYN8SsX2
	08Maxfq+2f+cKcnWKho8PZOKne8ohGPTS03JPEg3SEvfN26AmxfElsx45i+UL6o=
X-Google-Smtp-Source: AGHT+IGCaAdfeOnc4rfALtVFdvv2rOuSk3tx12NVU/gSQ0sHZuT47mpRRiRl9W7jR4W4uWoyyCHvKw==
X-Received: by 2002:a05:6602:1691:b0:81f:75bf:6570 with SMTP id ca18e2360f4ac-834d83fa8f0mr382498939f.5.1727884465770;
        Wed, 02 Oct 2024 08:54:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835053sm3141560173.32.2024.10.02.08.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:54:25 -0700 (PDT)
Message-ID: <5af60c25-f917-437f-b918-fedaebbc8c68@kernel.dk>
Date: Wed, 2 Oct 2024 09:54:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 pavel@denx.de, cengiz.can@canonical.com, mheyne@amazon.de,
 mngyadam@amazon.com, kuntal.nayak@broadcom.com, ajay.kaher@broadcom.com,
 zsm@chromium.org, shivani.agarwal@broadcom.com, ahalaney@redhat.com,
 alsi@bang-olufsen.dk, ardb@kernel.org, benjamin.gaignard@collabora.com,
 bli@bang-olufsen.dk, chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
 ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
 florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
 hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
 ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
 kirill.shutemov@linux.intel.com, kuba@kernel.org, luiz.von.dentz@intel.com,
 md.iqbal.hossain@intel.com, mpearson-lenovo@squebb.ca, nicolinc@nvidia.com,
 pablo@netfilter.org, rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
 vladimir.oltean@nxp.com, xiaolei.wang@windriver.com, yanjun.zhu@linux.dev,
 yi.zhang@redhat.com, yu.c.chen@intel.com, yukuai3@huawei.com
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <0c664087-e9af-4744-ac81-1839ea6b4051@stanley.mountain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0c664087-e9af-4744-ac81-1839ea6b4051@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 9:50 AM, Dan Carpenter wrote:
> On Wed, Oct 02, 2024 at 09:26:46AM -0600, Jens Axboe wrote:
>> On 10/2/24 9:05 AM, Vegard Nossum wrote:
>>> Christophe JAILLET (1):
>>>   null_blk: Remove usage of the deprecated ida_simple_xx() API
> 
> It makes cherry-picking the next commit slightly easier.  There is still some
> conflict resolution necessary so it doesn't help very much.  Could we annotate
> these with a Stable-dep-of: tag otherwise we get a lot of questions like this.
> 
> Also when we backport patches from 6.6.y to 6.1.y then we can drop any
> unnecessary Stable-dep-of patches.
> 
>>>
>>> Yu Kuai (1):
>>>   null_blk: fix null-ptr-dereference while configuring 'power' and
>>>     'submit_queues'
>>
>> I don't see how either of these are CVEs? Obviously not a problem to
>> backport either of them to stable, but I wonder what the reasoning for
>> that is. IOW, feels like those CVEs are bogus, which I guess is hardly
>> surprising :-)
> 
> The definition of CVE includes NULL dereferences so that's automatic.

Sure, I'm not a total idiot, even if it may seem like it. But this one
requires root - both to load the driver, and to trigger it after it
being loaded. It's not a non-root user triggerable oops. And maybe
that's fine and that's still a CVE, at least we're not doing scores
here...

-- 
Jens Axboe

