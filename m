Return-Path: <stable+bounces-47515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB468D0FAC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 23:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21DFB21B9C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0B16191B;
	Mon, 27 May 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJLGt255"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D3179A8;
	Mon, 27 May 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847078; cv=none; b=XE73DQ4ftwAWfSGfu3Qq6blvHIB9+c/zGHtvF6riYeJpnf4M/s4+/1WNhhspreYxsXf3PhT2NNY3MNR7LV3691Nkrb6HEkAsEChpgZhITOsbAbWEbyKbaw/mRRZrJfGOQxReDq0TqWt/oUsZUP4qF5lkH0ckxUiVMdk2Ug/uYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847078; c=relaxed/simple;
	bh=tFpudmb7utFLtp1DrkxJwkGe4WVa+1FmsNU710JrlLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ol2aQRV4DAMttlcELRC15lCr9nCdJY55fU2K3WZw5PSpQc6tWwGGxDvtXKa5LwnvUWB86IREyOvsbsurQWzfdLKN4TamjoZaLN0gLqLGL21mU0AgRMi+VVVG4orXBumDxrWKaV9R3ft/GVN9WwOmXuaz4upWqkMcan4McmqzocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJLGt255; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so189383b3a.0;
        Mon, 27 May 2024 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716847077; x=1717451877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aEY/VZ0kOW3TO79bbaxiQdw+PPKgHYYJ4mnExDE3Dw=;
        b=dJLGt255ljxAq+2FwTxgGtZYFDiV9WE+r2qKq1wy686VH9pzYeglM91MKop/hz2WtA
         //KS2yKqkwoextAghk1hj0WMDCYbHHYFo8Uv+07kP5W1/gvknRBYzGoWnTSkzu1OlEQD
         9lpBlucComTyUmouD314ssoG4gk+nmzp8StB4znZv7YS2HkhUw7VJsXkDPPGnFcwmt6S
         Qd9BArNnSWyB3torwmE6nWx6idOKOUe4HaDE2dMjhSRmQcmbvWKx6Jnmu+fUuKXd0kda
         Vd6+Dg9ZV/7qFJNks7Cb+uehxsTfsb/1gs1Z2qcuuGo0wLVz6nfULpdMzpw8NPOGLdwm
         4d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716847077; x=1717451877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aEY/VZ0kOW3TO79bbaxiQdw+PPKgHYYJ4mnExDE3Dw=;
        b=DKbLoqpTfpxu6naZOp6W3b9EJhlN7ARgGOHs7p9UDu6beDaiX6SU8MTYzHQwJwlLvg
         vbttoX+wYuxyC2/DmBqJvkuFz0S6NXS7J+vmxDvWSMTY6Jemud/cRp+8391bboqLQslH
         AZj+ipejblaI0HzWKmHFhJqLOnWM4Kv0Tj1HzzVykFf55L2QDO80n6FCNXlE6J2QFvUs
         gA+AHGvkopie0AGFyL78w8vo2nkh/H1egMjxAP8l8mb3C+1CU4JN396j2wGFnMY8n0Wl
         BtA3fyk+638WIPu+P2d/y2/S0M8c/Vh2Y+axgqTLkSeaNDqi45bdUCjpl7HBR3rfuIls
         W0tA==
X-Forwarded-Encrypted: i=1; AJvYcCUeOKr6H/Y8BvXilg9c2VPR0OUAdsZKoWl4DcFWcjhGhZ0000J2ICeyUIyU0oHTjHv51edOsP3CKC3K95fosTuifYXN5XteW4QT7qe+90vM+iZxKLvb3PO+N4e8GBqFNxZGqH/x
X-Gm-Message-State: AOJu0Yz1hn7loPYi/DCtBOH/DJJ0D4zInSsuGNswe0Z8iqgZXyZfpbC7
	Ojb9EG2OmhQpn/LwlOyl7rI00EMsGo8ONL04o0S4SRpy++OQrelc
X-Google-Smtp-Source: AGHT+IHyyK9R+xE+MtpfI+UAMFtrboJJduXIZ818GnkIr7zOYph0pzCdXWMyUAy3gUzpvIq3+Gb5Dw==
X-Received: by 2002:a05:6a00:330d:b0:6f8:d499:2d41 with SMTP id d2e1a72fcca58-6f8f3f8ba84mr12440692b3a.24.1716847076494;
        Mon, 27 May 2024 14:57:56 -0700 (PDT)
Received: from [10.83.3.140] (177.204.11.224.dynamic.adsl.gvt.net.br. [177.204.11.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701b2219980sm508796b3a.46.2024.05.27.14.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 14:57:56 -0700 (PDT)
Message-ID: <bf02d65d-876f-4a90-84b5-595707659fb0@gmail.com>
Date: Mon, 27 May 2024 18:57:52 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Brondani Schenkel <gustavo.schenkel@gmail.com>
Subject: Issue with f2fs on kernel 6.9.x
To: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <2024052527-panama-playgroup-899a@gregkh>
Content-Language: en-US
In-Reply-To: <2024052527-panama-playgroup-899a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
since upgrade to Kernel 6.9 I am getting Issues when booting using f2fs.
If I am correct, I am receiving `fs error: invalid_blkaddr` in two 
distinct drives, one nvme, and other sata.
Each reboot the fsck runs to correct this suppose error.
If I downgrade to Kernel 6.6.29, on the first boot, fsck runs just once, 
than after reboot is normal.
I used 6.9.0, but in 6.9.1 it took my attention because I don't reboot 
often. One 6.9.2 the Issue persist.
Since I didn't find nothing about issues on kernel messages I am trying 
reach you.

I use Slackware Linux 15.0-current, and debug flags are disabled by 
default, but if you needed,
I can rebuilt the kernel with the flags you say are needed, to find what 
are happening.

PS: I didn't find any better way to report this issue, said that, sorry 
if this is the wrong way to do so.

-- 
Gustavo B. Schenkel
System Analyst
B.Sc(IT), MBA(Banking)


