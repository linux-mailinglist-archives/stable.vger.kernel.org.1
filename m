Return-Path: <stable+bounces-143102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED53AB2AAE
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 22:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B63B710E
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AA18B47E;
	Sun, 11 May 2025 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBGDlyF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5A2AE9A;
	Sun, 11 May 2025 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746993892; cv=none; b=u2v3tbR/Ly+bbUc5s29h2hQ3VyacKs8/n1QtnQwO40eN71zs8+SlN5y9EKa3rMRTEla22wD8VMzus4oT6b3zjf23WKzrZj0gQungMEpPh+i7E2JDBxxoQ70h6t7t/i69nUyg9f8p3FBdl1xzXQ5z0dYCecgQP/aBo2jhQ+NBZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746993892; c=relaxed/simple;
	bh=a2vLC5e8w621vYFZFZ6T2uLOfqBXeMNXA1BIWr7Badc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS6wWr6WQKoNKKhaD1OLsYpJt+rAB+UxpprK9hf1QTWvWWt8d0Tp8k5+GJm1bIQliA0Xciayda/oYwraS+JsfsdD8Gtv2sS17zKXPiSvrEBgDw5merRI4GoYdAB4px8ZUfn9OXwhf84ryqPhMkdI73t4YdSIrp6JmK6fYoDA+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBGDlyF0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso23034765e9.1;
        Sun, 11 May 2025 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746993889; x=1747598689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYnfyvuko3DstVBj9VsnghcCFLtVoXIoYcgRptdifpw=;
        b=kBGDlyF0xsjuiu3UMx0D6GJS6qIzBvhnDFwJ8TE7HKqyLYwsOtHXIsRppr5lakpq5L
         MWNiPRY9FHwM7XejFttv+FISBJ1kV//iXYt93i3kBum/HakCkaLOyty3TmBk1dqAOmHT
         0EHjFus6XACvdsUgkHDpJPKAGhSEwOlpWoh60IFOojpp7msuWJgs1UTzWXfEg7K12K1D
         qzkrPP5+xuFeUgJG/Ubf3lvVbwlNcnRZy2fi2VRssAxtG7ZZ+OxDS05ZVd/ZM/UloA5s
         mOkmLEUZoy76oeJRN9y1y9y5I50KsykouBTn8tLZ0l4CuQcS1Y7qxBuaZQpV86wBt6Z5
         5K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746993889; x=1747598689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYnfyvuko3DstVBj9VsnghcCFLtVoXIoYcgRptdifpw=;
        b=cwL1gjeE+iCMSgpgHtPwG09ZwDRK5aoTOKD8UlZWpMqrfqoAo84/5uIg96j4RSulSP
         3vQw/U4brMdOpmMBYMSTeoZ37iLwqZuory6tw5dfvQkBapk8nE7WrmRLs0joqbhK6D63
         fI9FbO4GveUh/zGK+5/+IXUx9VgbRVgI+4hSKlrI8ktQlMKx5yDRA68J76/RrNRIJJUz
         sCLLn0CNYc9epd/srHbCWwvblJLsWClqzj+3TGmEt9uvF3OXGxiX6lCGctDbJcxxZ41O
         hbwwDDpzT6t4AzaC0U6ffNYzauy3C1nvv1+9HOj7RQgjcx9uy5Jk66effXgqofEtXRtx
         CDIA==
X-Forwarded-Encrypted: i=1; AJvYcCUz1NM2JPs4IyvcS5/pWKhME0VbyTbjZtL/auhSk8Y/8SHKXI6wnAcHgnv8055WOqFXF5EbkqkWdE2GsyA=@vger.kernel.org, AJvYcCWoXEQ7CH3DK2AJKTEokImSNoGGZqYM3SnTPRtZ9Q5wqfTkzH8B3cH6co7tTTAIvgnhFXoyimGx@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyP/snEgbRsKItvVRpCuR4wgooHhuCOD6K+92ql7K5/yeHHZQ
	qCtXrNsMOH+DAPjtUayMpNwKjjpENuYzu+edf9+eeq9XbPGYhw0y
X-Gm-Gg: ASbGncsc9cynpY6dgB2Nkbib8u2J2T/YFpUyy5DLl/qPwv1Cc1tM+JljlT9sH59ttw4
	tmj/887YqmKVKqKQU/uXYvNEf/ThZgQWbJgnPmmiIMuuKEkfATlQOFHZ6LTUCfogAw0GJUPLciK
	HgejqvIEF29q02/5g377qxImJklUcQSQaTUa6xwGisddkN6o72NJlM5PbIVdbTJRIzjj1uSQeee
	ijrGNDrHQ4hRp/J4ZMLegcQ0wapTpwSO0k9U5mw6ioX8cCDOBazoTp4Mj5nKQ+JgvAyGS4/S2nT
	J0liJO1GwFhW9x8MRbBgvybiPhAGY4uDRKJrHnMcFKJvkDPf2WM9Wu002xBPSsIMks17Z7JQInb
	DWpdQSKfKWxzZzkFIOgRmOwnQNrd4RcS3yEPpoPROQA206nVgm/IGtrk=
X-Google-Smtp-Source: AGHT+IFjIJ/PiWP0rc5Lu8A35rP2o8sedXKOTMh73Xgvm5S60olcSUYwZBrdtBhLKmBU/xrQcLLW+w==
X-Received: by 2002:a05:600c:45d1:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-442d6d18ab4mr87990995e9.5.1746993888671;
        Sun, 11 May 2025 13:04:48 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c35sm101844785e9.5.2025.05.11.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:04:47 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uECsL-00000000RYg-3Q9R;
	Sun, 11 May 2025 22:04:46 +0200
Message-ID: <9086a511-bd3e-4a88-ad86-8c51d5a385ac@gmail.com>
Date: Sun, 11 May 2025 22:04:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding in
 time-travel mode"
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at,
 stable@vger.kernel.org
References: <20250509095040.33355-1-chunkeey@gmail.com>
 <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/25 9:23 PM, Johannes Berg wrote:
> On Fri, 2025-05-09 at 11:50 +0200, Christian Lamparter wrote:
>>
>> What's interesting/very strange strange about this time-travel stuff:
>>> commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
>>
>>   $ git describe 0b8b2668f998
>> => v6.12-rc2-43-g0b8b2668f998
>>
> 
> Come to think of it, often you just want "git describe --contains":
> 
> $ git describe --contains --match=v* 0b8b2668f998
> v6.13-rc1~18^2~25

yeah, I'm wondering if this 'git describe vs git describe --contains' could be the
reason why the patch was AUTOSEL'd? I have no idea how Sasha's helper works though.

As for UML: Your work is greatly appreciated. I've ran into this because OpenWrt is
currently in the process of adapting to the 6.12 LTS:
https://github.com/openwrt/openwrt/pull/18666

Cheers,
Christian

