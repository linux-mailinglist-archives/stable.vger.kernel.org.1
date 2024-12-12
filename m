Return-Path: <stable+bounces-103948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA19EFF6C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC691885A7A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADEE1DE3D8;
	Thu, 12 Dec 2024 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iSEPkRqj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267141DE2BB
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042839; cv=none; b=f0xtMA82FgvwLR4p4GNCg6v7tfNhC4et+izrLllm5N5FveioR+k7yhiNtIuy+Ko1j3UTpANPjhJOa+dejCsibPeNrmKLW3bvU+m+jD2tP2wmrwvgSYg6msUYHxgMbywIetMKklgdTaIuUEVw2qGxR1V59FmBrx5tgPcc5HFaWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042839; c=relaxed/simple;
	bh=36YAogMX7x24g0pQeoCE/qs8dnhjjhL1b9vSyDJOakM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqkButJ5IChmhMiZnha8bDddITpVyHTzfqAkDhCD3YprTM4JC0jaoV+70YRjWGhO/Mh0l+j9j6VyzFh62u3o/E7xlK4zZB0YOZIAyI6aPFsBD7NDDC+FIzehMUUZS/tqVVwO1m0K9S030z2sb32uST68OJxqToV+MRvFyDmvyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iSEPkRqj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163bd70069so11703785ad.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734042835; x=1734647635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeEPiUp6GO1fUUGBf6fhGJf1W+84fzvf845Jfc1nnYg=;
        b=iSEPkRqjkCjai7NuVAqqJPg1VMfqOO0fmtp1UL0F5/2e7fSXeRuypWuxh98G6VVHQM
         /mTkgsmnem29MtbP666a7GmhYWEI7ITnvhgRnw9PEpHBEcvvAjVAxSbB8AQxgkd6AvDO
         km5IfdxrBoItWCliWkE3Sk57pYAU0FmLjLmxZoNJBVeCUtqmnXFbcKZ2UCx/5OWLJPdK
         t1PodOEgx9+Ycijv5xHXhOF9zyYdIMd1YtBgI+p8eZNtHohhpkAZgUD0THs/n5fxUhPK
         H8Zb7jv2Ff7QskPsVxONT0HE5u0aYRK3O2byulOkLjpjSBBve/Gxe/qzTb8+bZEimjo2
         3sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042835; x=1734647635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeEPiUp6GO1fUUGBf6fhGJf1W+84fzvf845Jfc1nnYg=;
        b=PBooMmnXTNtYkSmxFLCgbfLOIlb//KcwESMMM/VY80x3/zWLNZKAWTZ1kBa+VqUjbt
         UpiEXG0Rzg2uZJL3WZvm+pCStqDBpW/v9QUiqh9FFJzj22hnCNHmuBJJfMYBeuaVo/J/
         FkDf2dv6QcWhExEwte7XGkzA66hW9N7ACx3Ff4zdfFnwTbM/AIsuogVh23Z6T1XPGaPY
         5NqCUskoorNTkkNeeIXkfVnIGEEGVMVE9a0jCgxCP4tZWZjls9uMPpYnTna+gOeuC/8+
         r5EXoxHp7AYbSwCEn1ZPXVFH6zHABrt4MjsqnkR5hr3y3bIMf4XsCcbNDJDM+KpQ9b56
         1e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBgCGKwwXiD0LHJORts6JfvopH1YQiRQFLBURB0LUlij/8r5QJXp0JajxvYlwvK+Yh2bJbAV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2m9yDotl3sAwAJf/M3dcO2+MX96hl7ghBrgTDMCU3Ye234mmT
	UXx/aosXu3RRS3Uzuhb69+VlYYMWaMDksEERG1ZXe3rRr1QhI5H5/ohGra6hed8=
X-Gm-Gg: ASbGncuUB2KDLspj6zo40c4zm6PjMLKzKPzDlz6FqGPbvKjG35gu7qraj94uE8XrsDc
	jtWs7jBko68blL325dJuEfDkDDqBFJUMefDBTTFh59MM1gLEHYqb9tMqeTBHJNrCaq8hjDAmtPA
	sft0DX7RKatraD9JznriB9D5YuwDhMPcDvGpTrKm18KNPKFOtvcJDuXx7DQiWEKev/J7vv/f1YM
	bZaYxQwulPZN4oYQxdrK+4qv5cnItjm4kTOIvEryOfthOAIEARJrg==
X-Google-Smtp-Source: AGHT+IHwq3TLu85j2IlaR2hxhwcRoLJzeDaudP3TQFjjBJdBHRIPPc4zxOXIXe6BnPJWLZY0mqqqkg==
X-Received: by 2002:a17:902:e752:b0:215:b01a:627f with SMTP id d9443c01a7336-2189298169cmr6022455ad.4.1734042835065;
        Thu, 12 Dec 2024 14:33:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21661c08b6esm66164195ad.80.2024.12.12.14.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 14:33:54 -0800 (PST)
Message-ID: <e2502307-6302-46f5-afd2-0cc5aa503b11@kernel.dk>
Date: Thu, 12 Dec 2024 15:33:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com,
 syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20241212222247.724674-1-edumazet@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oops, thanks for the fix:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

