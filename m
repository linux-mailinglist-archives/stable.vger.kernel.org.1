Return-Path: <stable+bounces-121132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D3A54039
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5316DDDE
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97117C208;
	Thu,  6 Mar 2025 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jemHX14d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACC2837B;
	Thu,  6 Mar 2025 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226635; cv=none; b=oYPFx9FTFTkxdrvcDOxKbsUqNWHdAuCjhoHkPWw0iZyoGw2ISh/5sXE9YlM9AdR4FF8p/Ur9kJJEIMImWHA7vF2UKyHclmwoIINhhFrDwaDGiXk7WjMqfEI04+dgRNmEkwUC0o0Z0t5d71Qur57zLohqNUHXvGpSUZvsNoyeSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226635; c=relaxed/simple;
	bh=MkJLPuKgr5v6ZlaUCOUYuEQCioPiSj2i/qCAETlW8O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMlENG0RrNiivqr6Obj2hGzwc+2O8T7wqi5GDPt44vxoBzTDl78mmxAdTHf6bCI33362z5AXGhs62el04lOTKbJUZUtkfYOL3TvB6kGROy8bzrwEFI6dcYqmIg0psr8dZCDth53KLOYknRg1YH9TOB8N0NxjLsqAhzXIsJ0ai/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jemHX14d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390f69f8083so138314f8f.0;
        Wed, 05 Mar 2025 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741226632; x=1741831432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr9fREGmxvfw4nIR4+MArOFiCvtJoUCsQdfY9QI8DmA=;
        b=jemHX14dCdWMunb86g47ntcByVd9mL+2nVKiqBsxmbRlYlYJ9tdi6bGoxdx1OljkJ/
         gaJW8PRFI6PuJcIRbblEWB0fuzJIwpWeHZuULcL3tsLEbHCa8l+79hkR7Or5wZlpLRRa
         0wCM1/95vFgB1aWkgr1kkGdHBzHZBW2lYp1MwbQUh1zjC00XPXdyruN4FS4z6y+5LOWf
         n7a75n9ApcVc6Mun4852+0MVXrZB24ij2/lXvoq8+4upUxjMcwiBaysNs9R8Zpspx/Kx
         boFFz9rjwVBzwRER66Zz9izZ+1VlqX1FXlbJp03TPY8PCS3WmYWeBKfRW97H+WFrA8CU
         4xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741226632; x=1741831432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr9fREGmxvfw4nIR4+MArOFiCvtJoUCsQdfY9QI8DmA=;
        b=AEFkRKhmwIX6X20cA8iQ1+w2Ko35AYOTI6YzhBkUgq16ZclcDh6Qcc2v/3sOH663Fe
         D4pORMhtxBNfx1E6goKN+uchoOZ8IiVm9bwlIV8Gs5lh+d4j6xCCKWRyHRtS3i5S3JKq
         Ur3rxGU3C5D9bUrhr4/BHj1czrXJce305faoNRrPxsnDDENg1aqE/HzxYMTCkfNyoAPr
         Y9fkejzBdRjI1ud4rqEp+JmhZTidDhAMu4kawBGhiZq6EIU+gwS3hQsGX6KO0q3nS9rW
         n4oHc1P/4Pt7iGuty2GcFPRwBGlJdBidZHi1A0UfvZEWa4FoWhwKQLZJQntA+gy0IKHR
         vhjw==
X-Forwarded-Encrypted: i=1; AJvYcCVPBCkgYvY1gIgMdFoL40/sKNg/Kf6gAuqF7kSGbwm6YGEkNH7u6VUWIANXFPwTzj381JMuRxyyAvgBUPc=@vger.kernel.org, AJvYcCX7jw7P0ZWcxdsyhMZTYw1HVfxsNPOQSZVLiDygYtHi3+qhCPAeIOIOMVNacxgzVSZTLHVKTcjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdHodFLzAIInoXf8+jLuK+yjizzMA2DAp8d93W9ERdw43D7bS
	VAHN1g7qpsZLSnXZySeWOaMtRh0ctFYFzuWojPNNMQeomyZSrpU=
X-Gm-Gg: ASbGncu4kGb1AdRWlgb402mP/EcePl2phD3kIZNfT6hbfxNl9GLIw76JsBGKbLG8col
	zjXNa6rJzwg70sNDjuhXdrHjlDVQnLFW5gVxg/hXOvkgJ55sLcenCKaFRJkewXJE+G7Nt5xGreD
	8yBU5URqsIDE4wH2Yp1UnTXo7W9JJ/wo89JZ9TziV46l1vM9vxYqmXFLi8Rkb3uCJL1L2KnUOfB
	i9mIzmufTznOd9YioQHp9qubGqS0Z5tzdKeF4bi+3SMg4ytlZp7NnQPAeWCNwbk5Y0CmSiGPCTK
	eXzLkVh+YRGBlVKep007H6mjxntNLYekKwyL/ymzyoZgvcE6ygPuc6lrMwMdhO8HSmYCrMoAsf1
	MDnMTte1ZBan36yUvYpwn
X-Google-Smtp-Source: AGHT+IGbL0ip0ayYFjdvtIKKzyBlCaBFpdHKVaMkM82Xlk2fjOfxl6v7fFLBx7EcQsk2xxYlEfEsng==
X-Received: by 2002:a5d:6d06:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-3911f736c29mr3759522f8f.17.1741226631494;
        Wed, 05 Mar 2025 18:03:51 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4217.dip0.t-ipconnect.de. [91.43.66.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm341988f8f.60.2025.03.05.18.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 18:03:49 -0800 (PST)
Message-ID: <aa98cd93-840c-4a32-a2e8-f9d4248e3a69@googlemail.com>
Date: Thu, 6 Mar 2025 03:03:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174500.327985489@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.03.2025 um 18:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

