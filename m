Return-Path: <stable+bounces-56283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C250491EA5B
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDE31F254C4
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6C16D327;
	Mon,  1 Jul 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFjg96fv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E5168D0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869457; cv=none; b=H7Z8HKOIIvuxNEc/BAGW5Wg+1vBhzA5bF/VjaIs69avOEU4Jzbb8hulm2HZOE9kABPlzREXkHGXVeU38qyXf1e38o+ItPvBPgRWg6vRXwaIeOK53r3kBvjpyo5m8eduWQcudQZDXVYwObZFxwvVougPohkc012to6Bhifw5UBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869457; c=relaxed/simple;
	bh=AgoDV3aHTCVvfNqTFIeFZARwfO+gDnBvj44sFGQiKv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwxHzcXvnd4EFzlESXYSP0tbbRYlNPo7xh+jHoqdmj1mz5afEGckgQKzKT6IYG0P5b/pJfHVoF4A1du/iEa3yRIuvmO/QQJM2R+n+G1KTsTVaxo5v3jpm3qjZbonRr7ucOW/V+Ba4sAoMoeoxdWsQqDLob0whIqFEVy48PTya1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFjg96fv; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3d37d6bfdso103166139f.1
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869455; x=1720474255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VGCGfoVTxQdhqBa8mQPvhZG0jc6M2s5q2tjWGfDOSs=;
        b=HFjg96fvXvMfopr4VxyHg9Fusp/uVtwABPAlNrWxPOX+ejmFm6UdoUC741xlfzdKIC
         wdfx6XOSHyayLBJmstFmA1kzrsWDGEmDt/1c5+G+hiYHc0WNacfA9N6OxfsIeoag9+Dw
         tANOZ7VrDnTiW6NxvhHVVUJ2eYdlSC9OpOuYHROcUAZfNWYPXdiGNK1+g4lE/iBZUz6f
         8iXru9nIJReqsfEyx03AWXa4g+KscWOXugBaIf33mITOACI3h2XrrBLkvf7dYw0qq52+
         NX02Z9D8k996kR2Q9rol3GGrnNTFcUIW6AtzkYYyhltCpBm+OowujjCNmcwni+QDgVEL
         SBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869455; x=1720474255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VGCGfoVTxQdhqBa8mQPvhZG0jc6M2s5q2tjWGfDOSs=;
        b=EfI4N3g9vtoElV2tTL0qenrG6RnX4iKJAo/kdCrw/0FOcJOxBhPGjM+DMcpRpjX9GA
         NqFD6jdr5p4kAIf90iydD3WNx/BsOAuZpVlCR71umF2CQ3Ek3eqBjuov1RMF/yFPCdRe
         7Vv9D47CEWft3SmKv4qaV5pUSKmMjC52XWmnOvVmuL1c5CpZPloHhBnW7QIlti8HpVOI
         68JHPwOW3WEE84qEKNGsxtxYkCYmQMJqMSPslDlMjm25WrWopctMN2WGRlsjYLrPaXgE
         DSRcO15Cm/qCkMH+7RvS7ZLn2yhFiM2l0Hlk+yThDg+7MqWBTASKG6YHQmsoxRrLjh6o
         iByA==
X-Forwarded-Encrypted: i=1; AJvYcCWFlC3/4V2dH/MDU06TjKW4mgFeFXh+EjEbf+CubrBJ/Xg1cqZRerqfv9kWkpxN2wWo2tOjLSQe+Gs8uRwUUvrukvqdIK0u
X-Gm-Message-State: AOJu0YxlCNauf8O1FJqIRk3GJthi1VeoM8vz83UtHffaLj0652hwiZOq
	NUdNsntIX7cmvDRRrjLENxhw7IpCDsnZAfr6UjyQYSnx1+7JFphg
X-Google-Smtp-Source: AGHT+IGRg1fqfBs65UKZcm8fWoezsuVZNEQ2NzZyoO4b6Qoupd62q6AvZ1jn0K5DGninDpJhfx4gDA==
X-Received: by 2002:a5e:940c:0:b0:7f3:b211:973d with SMTP id ca18e2360f4ac-7f62ee9d5f5mr336935739f.7.1719869455431;
        Mon, 01 Jul 2024 14:30:55 -0700 (PDT)
Received: from [172.26.252.3] (c-75-71-174-102.hsd1.co.comcast.net. [75.71.174.102])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb37f3sm2441373173.25.2024.07.01.14.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 14:30:55 -0700 (PDT)
Message-ID: <1c68b9b2-24b9-4bbb-852f-cbc5c267443b@gmail.com>
Date: Mon, 1 Jul 2024 15:30:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.96] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rpeterso@redhat.com, agruenba@redhat.com, stable@vger.kernel.org,
 gfs2@lists.linux.dev
References: <54398cb8-92e0-4ed2-8691-38f6d48efc9a@gmail.com>
 <2024062953-problem-truth-ce3c@gregkh>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <2024062953-problem-truth-ce3c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/29/24 2:10 AM, Greg KH wrote:
> On Fri, Jun 28, 2024 at 12:07:52PM -0600, Clayton Casciato wrote:
>> [ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]
>>
>> In gfs2_put_super(), whether withdrawn or not, the quota should
>> be cleaned up by gfs2_quota_cleanup().
>>
>> Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
>> callback) has run for all gfs2_quota_data objects, resulting in
>> use-after-free.
>>
>> Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
>> by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
>> gfs2_make_fs_ro(), there is no need to call them again.
>>
>> The origin of a cherry-pick conflict is the (relevant) code block added in
>> commit f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")
>>
>> There are no references to gfs2_withdrawn() nor gfs2_destroy_threads() in
>> gfs2_put_super(), so we can simply call gfs2_quota_cleanup() in a new else
>> block as bdcb8aa434c6 achieves.
>>
>> Else braces were used for consistency with the if block.
>>
>> Sponsor: 21SoftWare LLC
> 
> That's not a valid tag for kernel commits, sorry.
> 

The documentation mentions "some people also put extra tags at the end.
They’ll just be ignored for now [...]"

I don't imagine this would be appropriate on a line *after* the sign-off?

>> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> 
> What happened to the original authorship information, and all of the
> other signed-off-by that were on the original commit?  YOu can not just
> delete them, would you want someone doing that to a patch you
> contributed?
> 

I didn't understand this and was concerned along the lines of "it is very
impolite to change one submitter’s code and make him endorse your bugs"

> as-is, we can't take this, please fix up.

I've submitted v2

> 
> thanks,
> 
> greg k-h

Thank you for the feedback!

Clayton Casciato

