Return-Path: <stable+bounces-145682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A3ABDEC7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B44E7A64A8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0C25E828;
	Tue, 20 May 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m9dxw+Aq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157625D1F1
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754586; cv=none; b=Owa/tbGxwnbOTvlhZInlVZjySoDD4YGoYbtp6GkRztZuuyVlYZVhGPtcK+6qAQFQgMitoA8V1uHVGVhhmkVKR4mBgfBQMyZ3mfwbwK+ig8jx/sjIFZa7uhcU+M2eu8ohJ77BPqImgFPk9nbhpzfTy0prqMnOFyphMCmYA2oVVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754586; c=relaxed/simple;
	bh=vEbcuXQwEDRa0vNR50YOWWWtdFUeo4T8qpaWJJxDqHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NonZNREV+9pqinoGBWYyePtCltTon6p9ZUEE8LuNzyw9qPBA4q7RFF7QlCs0pYe69Tke0cmBM4ps+qT9YAp38bwhFAJ5evmUg6jwdZTLYPhsVz/jphL+RT/vhd8GM+hDT/uPOElReZWo/mjAxgLRmXI+khVf+LX68/EXm2uCRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m9dxw+Aq; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so42770725ab.1
        for <stable@vger.kernel.org>; Tue, 20 May 2025 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754583; x=1748359383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=m9dxw+AqDQ+1rWgodAGFWnhuFaKSCIgi5ZydGaW52KKeWbLHBVKN5J79xHekkhN5uO
         WJei/NE5ldeBweYaP+bnT5llbDOj7a+pQPJTi+IgEbQ5Od+1/K2Dkmhm9dLz+HI/G7d2
         rkH/Fhzb/48Sh/2r5tFFoJo63I7Y9fV5z/y6gRXClhC1VZj4dLYYc96o9jduLxDM0D4c
         ZjxXt8Ty/oei0KrLVfQHFSEuZljFE7vrHD6gwkPc23UyLRZ9MWk9Vac67r7oQIn+x121
         TUi9xpLdBihCEhB2r3RJyfsQzO7U3wAw9EGRijgGbbnG5M6IYD5TOz53jUUymEflYwNu
         9nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754583; x=1748359383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=AaYi2EHM89wkKO42/s5SAS4KhSXa4mjrvG6s4QlsH0MVikEnC1PKe7ZM2tMR5lpdUi
         hRh7GmlMgat5llu06GvRm3NnWvvFpq+6cwrYLh+xi+O6y0bBfWk2YKXOXHRU1aeAKk5n
         /+LmjNZKRX7JNup7H2O4u0QTsNKoGEW1MTkCiEAh7LGvcc3N15n/EKccE+fSPxAbsJri
         0FL6km9U1gdU7+mPw3ziNfrLHb0ulW5xpXza7tJUJcuCy7ZY5yKYx2vahF7O42Y7LcdG
         yzO4xqZ2Qi5/lrHKxxxnRYvCQpd6Efw4YfGoTRENcMs/W2LGxAoodUkWMIz+ULYSO1Fy
         8IUA==
X-Forwarded-Encrypted: i=1; AJvYcCX1xWa44Ubn+hJioLbmGmYDQvmtv4qbHt1xe3ZxkDAGX1HFM/4ivbI7u153DLsu5poJVpdurBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3W4CNEoKE/5dbHBfOTgYFEJo8nliZHsVEo8VH7oxXzruKitf
	3NLkI2MPnTg0tvM3Ppd2xzuFxT1Dr/c5Nac0sSi5fR9ev2DntF7K1u6TwMLhulRopVE=
X-Gm-Gg: ASbGncsYYbXeZqNpiApyReJQ1O3D4gAurhggUML5iiBy704wkn2/HUW+ITTS5e1wN2d
	w9e8sRdB/tqCy2Fr6yziBAmDPydzTYFR77OaBOv6zR9abnoLKvEd9ZBOWz0iAjxt62+uOEyZRJz
	zvOx2tp+04smAyHJToVKHgi84T+DyP0vZAnJGqiNNhT9yyr+SdkZoStwr580ey3B6Fxkn0W53DX
	Qok0ctgBJHtU0NfQUuTJCBvKTHhs5hKLrtKbQ8+BV8pW5afQH3NoKJ+9I8x038qn/ybY6kjAY26
	kWLEVgHmlRrM2+9p/kcKsW6zsiVb0abuiq8voypNhrPKe2rkn+fjK9EJ6Q==
X-Google-Smtp-Source: AGHT+IH5FiH5hdeBYNYfGJRWZ52DOo6I2S1qMZg7FuTAuJBXr6A1ts8mPNDcFL0CI9GiyXU3YCIgRA==
X-Received: by 2002:a05:6e02:12cf:b0:3da:7cb7:79c with SMTP id e9e14a558f8ab-3db842dea53mr165651365ab.13.1747754583546;
        Tue, 20 May 2025 08:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a556sm2268664173.3.2025.05.20.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:23:02 -0700 (PDT)
Message-ID: <72139ccf-892d-40e3-8870-2dff0e30ecd9@kernel.dk>
Date: Tue, 20 May 2025 09:23:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
To: Salvatore Bonaccorso <carnil@debian.org>,
 Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
 Christoph Hellwig <hch@lst.de>
Cc: 1106070@bugs.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
 <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixed here:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.15&id=355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0

and will land upstream this week.

-- 
Jens Axboe


