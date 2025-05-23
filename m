Return-Path: <stable+bounces-146193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCAAC2239
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 13:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EBE50393D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14B22D7B7;
	Fri, 23 May 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjyKu3kZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9A1A5BBD
	for <stable@vger.kernel.org>; Fri, 23 May 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001281; cv=none; b=XsJVxJgjGkJ06JSQJ4yhh8CfTK6GHEev95VVZfaCuJxkC7pb/yDxKd3qQHk7R7xzk1ykhwL9s/knrpCUPBnrhHKphATLAAeXqyrj/a3E3QfWNEXqw7es7oLkxprTAL/vzy89uKSOARzlokJksbFxCNjo9UJ3fbcwB9ZEbMF1EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001281; c=relaxed/simple;
	bh=m/jXhWjPbXgZQwGy0f8fhS55jQy6CofxHxvTn+xFvY0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=erlvpT+Q168F4wCqde4sbXoAVjgkZ1fTQfI/TimgQ8Dh1ik5v/SjZSXdoM/90ayag4arEpoQPoBH45Y7oHLdgqwW25d1ytF6EzCD+giMJD+MzKoUTS8hDioPCVkdshew68DeP4N52H0gvOUL+j3K9duOvHylA1spkAkwoQQitjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjyKu3kZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso81759371fa.0
        for <stable@vger.kernel.org>; Fri, 23 May 2025 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748001277; x=1748606077; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVqlsb2hiMkJTIbluIUJdhL/f6JCE8Eu1lI77odS8jw=;
        b=WjyKu3kZmdNP8EAdk+mFdGuAUtIRgYZ8WY7MU1ktcHbHz4w6Z5smeMduuBd19uSxik
         4uOKDPeFCFU65Txdb4hBapBdE5kLfmf7SURuhuXX+5YmbfwtxYMLbgS+3HsCRV/jqqyW
         BrvUfa4fCrV2iVyviB6M0EiWHaFrXsj7l+HScGYCgOGzLbnGfKFcW+4V+HLYZ5hgJaXL
         md4D3V46ES6UbGjQu7KMvz+FUClqVBIP/D/XwXxrVcBY5dzP+Y/b23u412hbRdiQoPtt
         t/tlXK+PE+/Q3UkTegoTtscjXccPsWOh/zQQGwxOHV+V8aE+zIEVUocKmg34IahOYLYh
         uoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748001277; x=1748606077;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zVqlsb2hiMkJTIbluIUJdhL/f6JCE8Eu1lI77odS8jw=;
        b=cPtgnCmzLwzLiP5k0o8Y+Ex0s/GpqqdmYsn8xBz5x43UPqMYOB0hes6C1s5pY7GuY/
         1qIQ2WlRkduZtFQARG0phOJ8xmlMqAo0H98UvWH0kgvpqcSafrMc9JPQNA0NEOMfhPcc
         Zy5+856enY4cNULlG5k69aGSqkuSE6lreN0eJIQTb1wcft8+bOWKIbgsYfvc+ropqh++
         zoH/Cj06bBtYs1Ztbb0jr25OHWuT+YyJoGyFIoHZidLEcbwCcE3Y9ybqZSWnEY+IjuM9
         JfDTQxsO9tNTnA2U9NrhwEjSKFJXKE0GbvLu1evL00a1Z/ba2qCQxZpS9YxD/WEqxZqq
         6AKQ==
X-Gm-Message-State: AOJu0YwKvhKRIOZ+PUZfx/MscOcXD6Fwje7yIwKievj6iL9QEFhZmYP5
	IgxAXgJdL56M3e4qIfDsoVLSw9neURsxdPpPPnsNEYaU/LRPOacjFgL5jLmrLQ==
X-Gm-Gg: ASbGncudtTxQPcb4Z1JfEGXF1B0ANMcqqJbUzq8Nfr74q04y37f1OUwnw7TDOzz/5rG
	afObfthcGEOldFhGeDQ7V+dzoAuDibUjXXEsZ2y8W6LmeYqYkzECrt8nc3lOzqUTFBf3+aK1Ip4
	d6ThZ/d5/V3BR2ZAElph2kDKXycC9BrsY9dW6S5JX9crD8gxrd+WKxb9eSjsNJohtdWNTZmpVW6
	EXuFoJXQEmwrgbD3twSzDMsUw4NvROqsssxKKXfxuf6urYdZAVTBlellmagg+frrWJ+dDvgwNqF
	XESMcxyv5JC1okoxdbydAmMvKGcthvYamnana70y7sVwNHOLdN5jQNSEn2sL2vjXx7DJG0cguYZ
	E/7o2kgN5bN5PmbaDDwMtUbRo
X-Google-Smtp-Source: AGHT+IH7KU3vZj3Q5hE4AY8bu8C8klFBr1ZuXvk8NVcka5eIsm9dHTU888PzCZhg3sIss08RUVuw1w==
X-Received: by 2002:a05:651c:503:b0:326:e80a:46c6 with SMTP id 38308e7fff4ca-32950c86217mr8748511fa.34.1748001277154;
        Fri, 23 May 2025 04:54:37 -0700 (PDT)
Received: from [192.168.0.134] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328084b38f6sm37031821fa.9.2025.05.23.04.54.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 04:54:36 -0700 (PDT)
Message-ID: <30d4c161-1367-4013-9603-3ee3081a1ebf@gmail.com>
Date: Fri, 23 May 2025 14:54:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Subject: About patch "remoteproc: qcom_wcnss: Handle platforms with only
 single power domain" in stable queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Patch "remoteproc: qcom_wcnss: Handle platforms with only single power 
domain" was added to stable queue for 6.14, 6.12, 6.6, 6.1 and 5.15 but 
the patch has an issue which was fixed in upstream commit 
4ca45af0a56d00b86285d6fdd720dca3215059a7 
(https://lore.kernel.org/linux-arm-msm/20250511234026.94735-1-matti.lehtimaki@gmail.com/). 
Either the patch"remoteproc: qcom_wcnss: Handle platforms with only 
single power domain" should not be included in stable releases or the 
fix should be included as well.

Adding "remoteproc: qcom_wcnss: Handle platforms with only single power 
domain" to stable releases is probably not really necessary anyway.

Thanks,
Matti

