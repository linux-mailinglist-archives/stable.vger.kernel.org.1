Return-Path: <stable+bounces-28302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BFE87DA7D
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0D61F21612
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA49917C73;
	Sat, 16 Mar 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gZHPMoEL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153F217BA6
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710600214; cv=none; b=C2DEfElfRd0UJ3oZUBsf+quzMxW/OOvtY3mRMoDrA20VQAFCxT0iKM+UM329b7bTQ1HAzhtEzT1O4cIxWYH5/y68i4z5DNuxjg+yHMswovMth04/sG3F8DQgJuvywj0n9Kloa8JaJphXuBHCL1OQMT/djdV4fYOtuPuxp+iVR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710600214; c=relaxed/simple;
	bh=Yg0t2knyGuSsmle3EMiD+JWpq4lWE4qu+nXJkAcZaME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAu3VStm2AfGzvGPlSXsIQwXbxzL9CmmwoUyTFjAB3D4YFAHwl7xpKe10ZsBimSN5Nq/koAoH3XbMcMnyic/spK6rrSmnlvgB3Bh5cb8tPsHBFep79zQE0Q0ynezoF+ILJiihsMJytlQ6HEBIqQaQ/Uc5xAk4hmyBjiQ8Mxv06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gZHPMoEL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29d51cdde7eso952844a91.0
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710600212; x=1711205012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrYOP2DJg3p8RifZ+t6trogV/x5Z9myW8B5F8smKbAY=;
        b=gZHPMoELomyDWkNNi4JjVRNbTupRo7GuMzcH0xtoEnaKDTThCDHpUWB520OJ+j1yil
         5ZcXlG+ohAnY/GNDPT+I9NNnjNNyzkf6pRjS5ISlPAXaoCXGCjpAmT6EzBm9Zt7/v7lY
         Vxd4QZC7b33pI7l7HJQdhqu5Yn1SZEV7W1dhC8jGfMn8ZCx2oIbv2iKQk6XWmBA4fBg7
         P8b2PWYpx5Z34pPDJZgQabh3FOjkZ2SD/jiX6UXNXX+a2Y1zmBQZ1erJq3q7zdQSPFrJ
         AO0fOVYWQXB4luKb1DeRNW8slILAKsx3o7Yu3w3KhJ4AkRZc9lJksqs30zwhS/Vl1uO3
         G9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710600212; x=1711205012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrYOP2DJg3p8RifZ+t6trogV/x5Z9myW8B5F8smKbAY=;
        b=CSZsGJ5ZL+m1/iK+eRHQJu6+PtF+rNj/nmvOSfI/cSdeicGEuX6j68gMIfcA+deKKM
         t1YNQguwt3+qRHcn+9t4JdTer5cdu0nb0PN0yfZaGGO6AbCJk9ZflxGPDBsbOcI192Gn
         KtJT1G8gTeMdDeDECCOMqCinsF5NTKeAivARyE996duuurymayAFF9enT5AbgsVgJafl
         I3FvRER0Wmd0z4kZMV36tnv4xw9ddNuP2QuJH6TAgqVELJCTwWCk+JevbiLCTM7LurvO
         kQ6mquoO0gd1hJHFQv49v6AjE0z4bqHmy8USh4C1nMDtySB4Bu/04Dtmhu7rmIOZBhmQ
         ZXRg==
X-Forwarded-Encrypted: i=1; AJvYcCXaRzourUapHDyKZuAHq6K+dsH/euXoS6swwchcamTwr5qvvwzrU5ryR4k0RDZdSn8FEqBJmm7f7S9Bc2X4sJ22NBzeLY7o
X-Gm-Message-State: AOJu0YyGwweo2qyxkJzCpMDkqtv1ryOZkO/ZbvFah5ZZ6rc9/j/eSdx1
	TKiFDF0NhjM/9sqb7kVQvojYK0p1ZJSy5kzlA8TE/f0MJqqQVgDebPdvANCgLyE=
X-Google-Smtp-Source: AGHT+IHuxXPx5QXd1+2Gcthf//30oZH+nVtM/xK5fCw5b+GJDCFhZFIczs9iAuzMaBQ7iPMsYRLb+w==
X-Received: by 2002:a17:902:ce81:b0:1dc:e469:6f5d with SMTP id f1-20020a170902ce8100b001dce4696f5dmr9186342plg.4.1710600212333;
        Sat, 16 Mar 2024 07:43:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b001dcc158df20sm1453789plf.97.2024.03.16.07.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 07:43:31 -0700 (PDT)
Message-ID: <1bee5d0f-53a7-43c5-876b-4b1a57aea9ee@kernel.dk>
Date: Sat, 16 Mar 2024 08:43:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH 5.10/5.15] io_uring: fix registered files leak
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <3f17f1d9-9029-4d03-9b0a-9c500cce54e9@kernel.dk>
 <18c339f1-cd53-4939-aec1-04dbd50f7789@kernel.dk> <ZfV0jLKso1CF76sf@sashalap>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfV0jLKso1CF76sf@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/24 4:29 AM, Sasha Levin wrote:
> On Thu, Mar 14, 2024 at 10:15:18AM -0600, Jens Axboe wrote:
>> Hi Greg/stable,
>>
>> Can you queue these up? Two patches for each stable kernel, all named
>> appropriately.
> 
> I'll queue it up, thanks!

Thanks!

-- 
Jens Axboe



