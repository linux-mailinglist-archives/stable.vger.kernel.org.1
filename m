Return-Path: <stable+bounces-80576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCC98DFBB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0460E1C25180
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191721D14E4;
	Wed,  2 Oct 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QjPJMPHh"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CD1D1307
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884049; cv=none; b=X6X7BQeo9Mti2GmfgznBUWiN/ufFFqvQ0G4PNeH1GR67LtrYBceJIu1NYLqrEPggyM8qcfxLRPf3NNLUhqrZ4wcqSrSR8LyhHLogOOSAf6oFvPFl/g3M5T6Alvux78jECssnRpOwHsAKUa0riaYcZqfcpP+66YhF5P/9icWgKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884049; c=relaxed/simple;
	bh=msO9K/aa17idWWs20Ne1nJcVk+Ug/2H6j0qqQZJzBd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtOSA/sv51wRb4DsCzI+VJvLi00jiDre4LDtS7jwgzma/wubz7eS908q2t26r8/Dw9dipa8ucjWG0sgAJ2vDXbxg7tBQEnTVQFa5AEoGpyJUAIwZMgBIEWJU0w7u9Gqcm4MLEm9CL/oI/tGLstcwuLj6xHeABnSWg+mdXK7VaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QjPJMPHh; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a33a5a3b5cso23964765ab.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727884045; x=1728488845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgQJYMAV1Cy6gzGL/u7HivKjPLbAqbqlxtOEix/JCBs=;
        b=QjPJMPHhwoiPzrznqBliX3PRzXgWAfX0j9Xwin9gJ55uQ7e7Ftxq30iRorIlm9NOUD
         zjYCDeZIoRNQTXBYO8MejbWXFrZaSMHqj2zl0b9kGosnLV8UDRQEeDKaC+LdfOCAPRWv
         aPKBzDNDntOk9NM3aZ/gBnm0uimSAG8eKzmXdbX5smn0b/P0XVE4BIEAexJfNSFJMjp/
         C1E3iTXmFvgThlDH9m1oC03AhaAbuzGB4GZ8RGQmBLa7blsF8vtS4IeOg+zt12XBtcn0
         +qGb7NK7X1WochSsNtRr42siN539a5FsjYNEcrTWF2Zkodkfgy7hCTwT51Ow4mJip6+7
         vc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884045; x=1728488845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgQJYMAV1Cy6gzGL/u7HivKjPLbAqbqlxtOEix/JCBs=;
        b=iLoPY76e69Q0kH3leQa4wS+1hAlVaQWqfOvAlOfzc/UEMhpynmVo2rBNufm2UIT3wq
         +DVZ3Vnl+O1c5tGu5gsOY/DtNXfZbIo4oX1JafRUyYi/lclD7UpbY3xE5auoG6ekOXbZ
         TQyP3+dPL5gAmIcgsHmsUD0vbgLgrwTiJAOEOKKruSGR8cMO9OcDIx74piw+aKHNUkti
         2wQaNIi1+h558nGdnrhKKfm8cStdDCmEIQCJdccM/b/QHPZj4OCmrtGFR3FPl9wjaBWq
         yaCpDazp7YafaGfMyQVd/xUYIda19Dk+GgfRFO2bNEIquiEFBvAzOyYWO3bZPaVDzzMe
         ldhw==
X-Gm-Message-State: AOJu0Yzmho70uYqC37Q2II/hX2mrZTqsRQnSgy+UHNgQAZ7lYor1beq8
	TOfn2LzlhPCzGCLPM2NagNryt5Fe5arqT5Hr4UFgCIoGkeVhbDq9/1UheSdyyG6cxF7mS2znUSc
	/tB8=
X-Google-Smtp-Source: AGHT+IHyH0OlMNvhYt2s4BveTKX4zDHoJeN1T3jKMHSl1O4RvSx21Aas0uKc37BBwj7QAC6pF23TlA==
X-Received: by 2002:a92:cda8:0:b0:3a0:aa15:3497 with SMTP id e9e14a558f8ab-3a365931d4cmr35881795ab.1.1727884045324;
        Wed, 02 Oct 2024 08:47:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d9f7e6e003sm926593173.176.2024.10.02.08.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:47:24 -0700 (PDT)
Message-ID: <3182cb69-ea5d-4055-a883-a92f3a660a24@kernel.dk>
Date: Wed, 2 Oct 2024 09:47:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing 6.11-stable patch
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <4cdd1f7f-a753-40af-bde5-11bb584a052b@kernel.dk>
 <2024100208-tubby-reappoint-bf25@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024100208-tubby-reappoint-bf25@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 9:45 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 02, 2024 at 09:35:42AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Arguably the most important block stable patch I don't see in the
>> most recent review series sent out, which is odd because it's
>> certainly marked with fixes and a stable tag. It's this one:
>>
>> commit e3accac1a976e65491a9b9fba82ce8ddbd3d2389
>> Author: Damien Le Moal <dlemoal@kernel.org>
>> Date:   Tue Sep 17 22:32:31 2024 +0900
>>
>>     block: Fix elv_iosched_local_module handling of "none" scheduler
>>
>> and it really must go into -stable asap as it's fixing a real issue
>> that I've had multiple users email me about. Can we get this added
>> to the current 6.11-stable series so we don't miss another release?
>>
>> It's also quite possible that I'm blind and it is indeed in the queue
>> or already there, but for the life of me I can't see it.
> 
> Nope, not there yet, I have over 150 pending patches that I didn't get
> to for this round of releases.  I thought I gave a quick glance to see
> if I missed anything "major" as usually anything coming in for -rc1
> really isn't that important, but I missed this one.

OK good, then at least I'm not crazy, just didn't understand why it
wasn't there.

> I'll go queue it up now, thanks.

Thanks!

-- 
Jens Axboe

