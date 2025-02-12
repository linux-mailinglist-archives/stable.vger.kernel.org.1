Return-Path: <stable+bounces-115046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC30A3257D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 12:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642A4188A8D8
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E520A5C8;
	Wed, 12 Feb 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgRx75Ry"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B552063E5
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361493; cv=none; b=cjasgyiR3FkORvVjjg/yW5njvguCXzcNpWXLIRMti/n90mIuxayzXenQ7vE4mrqGNsNVBj5XLDrzpilBznG3xHrXm+e6Bd/Q8//WIK44EYZduKUUYb4PsbAsnutHsq/KkBUpiZd/ch1EVTfJwbqwk3mTawwQ92FZ5jmk6+jXKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361493; c=relaxed/simple;
	bh=rc34wL6IEE/M9j5gwoShAyDv8iy+96G01+EJ0MKv0+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5dB5j9MK9rf5o31wKDWhTePx/8Zr6m92n4ZAtRe5otobTHcPlz/ETfxEwFMYIkq9JthZZb6HbUdurpz1bhTSSaiizfz2c9g+Jdp44/96aMxh+mclSgMiug9fOew+pPBwsabt0CLcby24YE6cXef404hl6Nsp32WpiMNyS2Wp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgRx75Ry; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso511486f8f.0
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739361489; x=1739966289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJyVBnUmJhsFxZYrQ4bvvLuz93aO/6H64OYPdLBe4l4=;
        b=WgRx75RyqRYEEiAlCyAVMR9TydCnXQtQczq6x9x/nRm8iovsiPK3IU7MnkmouTyiqy
         l9vfyqxTDtIMOZKop+v4kiq4EoQCGId9cAfiDlEybb7IJeAlfKi9iXjyvmBqFZt8p/gX
         WC0g3KV2g9uRnzntOvX6tmQV48fP6F3Lhr0jyZ+23epqSoVDknlXE+8a9U+Y+0OQCmuM
         rM8SROhAzVClW+Y+0sPqlN4ez9jLl+0+S9kkYtUOtX/9eHUdx6Mo7mv55C1hjk8tCYlB
         QPf0ygC7CRUwDt3gNWu+bWaIJQkpCU2L1RWgE4WZgtYAXrWZxfGKj6owKynDQnLG7ISL
         83iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361489; x=1739966289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJyVBnUmJhsFxZYrQ4bvvLuz93aO/6H64OYPdLBe4l4=;
        b=JY+7z9PlGVHrjcufeyOLqBXHThDFfPolT3Rj4vsisOYRkk/tkFzkT6jURvoCn5XB3k
         L1Z0g+PdjoQzbvvcuE1uTKQzT3GDjgzxrOjKZ3QzA6asZvzUGMVz+oxfDm0S1X0nEuoV
         sJlSZx0xIFpsTiSDp9BxPQhM7XGFJnw3ep+piwd07WvP1bjLxl/0GzgkYKSlUzpqjul2
         R0kFeZCJ0gZCezgEHLJZO+96e0KwJTzOPkjLJDNNxFRp6ZECkHNrcjE1hg1VofhVDoUN
         eUQ+ksFIFLYWwsUk38AlpfpsiS27UT9zCCGKM3SFHC1wzdf7Fcs53sFS78NGJ9SmrTdE
         C49Q==
X-Gm-Message-State: AOJu0YyB0D9vzhrP84spVR9HxG9gWSV5ATTLMholvVflex5KcFLRnm5H
	mhQz4m/4BgrDyFR9G1qv4Xf/CT26XUIblJ0QOxqH2J3pTvI8WPBm
X-Gm-Gg: ASbGncuklW8yHhROPo3a9CCsb2X9zNGFMkd3T1ys0bIACdN5LvxUgmtu9MxrLwSVqjB
	r0lMHU9xsW7JDfSz5f9Rl2kDw0g6cK6KNIbI68xCt3Li147rx15RqyUcXxbftmUAHGv/7ZcxJYB
	pw2LeOz09qIxX576S6i96XU82WdiNpL60tN31D6xkWN5fFP3Ms77HUfKwJ3w0CdwtJ/hPq/j1Fd
	ptx2otG/wj9mRmFKuqfgscpujSxnWgBabrhVwthO6PJazTihvF2f8P+CZf8PGVjGTMrSKon4PuG
	zJubSam71p0kBdosAAsDbxGs
X-Google-Smtp-Source: AGHT+IEQJD1at2vgKoD0SZAiKFCXWWdHdfRNp9Sy1NyjZpGiBc3LO8hFQb7P6JVAO2/auMd1p6QxgA==
X-Received: by 2002:a5d:6d82:0:b0:38d:d773:2df1 with SMTP id ffacd0b85a97d-38de43e90f4mr5998048f8f.25.1739361489167;
        Wed, 12 Feb 2025 03:58:09 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a053e42sm17685325e9.15.2025.02.12.03.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:58:08 -0800 (PST)
Message-ID: <adac9661-cc98-4c0e-8445-3a83a250bf51@gmail.com>
Date: Wed, 12 Feb 2025 11:59:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-6.6 0/3] provided buffer recycling fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Muhammad Ramdhan <ramdhan@starlabs.sg>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, Jacob Soo
 <jacob.soo@starlabs.sg>, Jens Axboe <axboe@kernel.dk>
References: <cover.1738772087.git.asml.silence@gmail.com>
 <2025021100-demote-graph-fdeb@gregkh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2025021100-demote-graph-fdeb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 10:18, Greg KH wrote:
> On Mon, Feb 10, 2025 at 03:21:35PM +0000, Pavel Begunkov wrote:
>> Fixes for the provided buffers for not allowing kbufs to cross a single
>> execution section. Upstream had most of it already fixed by chance,
>> which is why all 3 patches refer to a single upstream commit.
> 
> Ah.  Ok, that makes more sense, nevermind, I should have read patch 0/X
> first...
> 
> I'll drop the upstream commit reference here as it's just confusing.

Got it, thanks

-- 
Pavel Begunkov


