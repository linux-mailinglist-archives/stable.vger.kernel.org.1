Return-Path: <stable+bounces-19775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0391853610
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671101F23599
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B93BB65E;
	Tue, 13 Feb 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EprhpgoG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A67491
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841975; cv=none; b=J0gJ75na3HzlbQ3hO2Oe+fDKmDhQMhDcmuJnRs3gwJPBsX+yvu2ItL/86LgFW0/rW0R+DRPxTBmceeklNaIzKf0/iv7c9GAL7q1Y73pYLXbghwzP8XmbsCL2ctrIgsEJxuBO6qrfa8koiFaqC9BrY4LjAFTDvBQVNnZmvOv0J88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841975; c=relaxed/simple;
	bh=Y9shuY/oXvtK/ayqbXusJNvVlm3fnwnfcsA/5ILbGOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upES8n/BC2vJ2wVzyrtIRLfWMcXG7lSwaDsYsy2zFXYJaflRtqWTlib5zvq/1yIjJ8psnRGt2YT6FMoBS2r1fCA4FxyB6QsKLb5Q1YZd33sBK5jsHZxjyxJ7qIvA6UbgUmVYIIgne/nBwnJkugxQMw0UWeqKShgvPxicnaWh4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EprhpgoG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso41003539f.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707841971; x=1708446771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAEpuBxkyD8za2QohwHr52wpVRb2KJER3Yir9SQIVeE=;
        b=EprhpgoGEznuVpLg3H1Bqdb3bzFSRiIJyqBCe2luaJmy0LIzzE4NZyJfIzJUqQDoBL
         UbHPBL3pUYAKjGxwVmcIwn5+y5q9FvMq0TXZzReZigSFo3Zc9R1VkXZVkSwReF3v8Xqs
         gDPBzpNkbhlZk+7ELwAsbCkUEK8SjZLAIlMCI+Rynytl0QCaZWEL1qSr7dnpfmAcJsHx
         x+QO54Eil6Lj6K3sJmgaoGT/XnXL57TFJH93O6xTEI5Dd+DAqMsFISuJChhejvnQuiHA
         nZr2Vz7PcSOffJxSZQiy2Po5Kpaf8WCssWgXDCjsz+NMgUpnATDe8Bv8D4+dQpZxT6ly
         kbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707841971; x=1708446771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAEpuBxkyD8za2QohwHr52wpVRb2KJER3Yir9SQIVeE=;
        b=sLSGZt8HVslpjuHU63mm5ZDJ47bQyYxx7FZJAqRkRCdClSoWThrNX8x87VthbvM7ib
         nL1GraYYyPMWeJxji1cH63837yuhPuc55Yp4ypEUStR9DIOkR0VGPGCyzAsvorbPaEfi
         zOt8hToL9EBvCUA36ECj9sL6h2S3zARLMxneso7O+O0+pflFoqu7c8yTZBD4GDZOt8a+
         LYyShbYei4PBNG+soOh7iOlEcsGMaBUJrBKlYrzL6GHoji6nOg1BBjoGDVNTqj/5nVbR
         nRHRQu5Ll2cX82YO/la5ppm/iLLjdmOaF8+EceKsLwLdJEuKj/LzAbZSpS0+ZEiqGfhG
         p26A==
X-Gm-Message-State: AOJu0YwLA3yHnOWaiu5aF7nh+DtPYPsmx8b31VLR+u4xFwdE7q+73X3p
	xJVcfj2Xl7/113GGkxA0CHdI0DMpN8lWR/GKSarf3+5Vu27KvdKu/JmS9s4JqgM=
X-Google-Smtp-Source: AGHT+IHXUx+OGzWc2jSIuz3qpaTH7BrkpU0wb2gUCabQglz0ysfMe7e30keZcsDsXUGKONIw6JKipQ==
X-Received: by 2002:a6b:e315:0:b0:7c4:1966:63e3 with SMTP id u21-20020a6be315000000b007c4196663e3mr166580ioc.2.1707841971605;
        Tue, 13 Feb 2024 08:32:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d9711000000b007bf0e4b4c63sm2098759iol.31.2024.02.13.08.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 08:32:51 -0800 (PST)
Message-ID: <bb9c3950-23ec-4897-b5a5-afb0df5a7ed6@kernel.dk>
Date: Tue, 13 Feb 2024 09:32:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.6-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <2024021330-twice-pacify-2be5@gregkh>
 <57ad4fde-f1f4-405b-a1cb-8a1af9471da4@kernel.dk>
 <2024021304-flypaper-oat-7707@gregkh>
 <7181edf5-864d-48e3-98dd-93e4726c16f6@kernel.dk>
 <2024021349-doable-glandular-934b@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024021349-doable-glandular-934b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 9:27 AM, Greg KH wrote:
> On Tue, Feb 13, 2024 at 09:18:43AM -0700, Jens Axboe wrote:
>>> This first patch fails to apply to the 6.6.y tree, are you sure you made
>>> it against the correct one?  These functions do not look like this to
>>> me.
>>
>> Sorry my bad, refreshing them for 6.1-stable and I guess I did that
>> before I sent them out. Hence the mua used the new copy...
>>
>> Here are the ones I have in my local tree, from testing.
> 
> Now queued up, but to confirm, 6.1.y did NOT need these, right?

Correct, it's not required. Would be nice to have, but I'd need to
backport more things. So I think it's better if we leave 6.1-stable
as-is for now.

-- 
Jens Axboe


