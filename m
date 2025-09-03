Return-Path: <stable+bounces-177607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19AB41DC0
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ABD189E6AE
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31A2FF66C;
	Wed,  3 Sep 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aW6MF1NT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDC2FF66F;
	Wed,  3 Sep 2025 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900287; cv=none; b=VBG2o89vjm75bHRhKJ97mBaHxryk/1w73dyc2ffjgCLPmNX2wMDznB3Rhclb2AIB6DEsJi5Aa0btkw9jD5ZSENRXJmSItHZx7NtO4rO4MJxXw4+jL45lpwxngbUFDe6oLqAhovr85u8zrT1p3jjicksvBrrcdWgoY5Uv3Tgnn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900287; c=relaxed/simple;
	bh=nLBdBuaIf1/aVBs0fJxzcj9UY0fYGaAL/FzD81BuuFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPh0lzM5rNsTy2dIrPts9w+DW3L1KLioCHbtiyH6cj299PQVMCS5F9qwmK0N4+L4IjuYkLVewcmwa4yzRgYuHCbKbKnbQjE9UDlWO+8FThsp9HzDl3RCvCw2P7Ny49JCln5ufocOYuzjSJX9Vn4fB47ZRc87SD17nzejnctSI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aW6MF1NT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so20654675e9.2;
        Wed, 03 Sep 2025 04:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756900284; x=1757505084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+poAW3AComNrsNKMjhX2QMWKG3Ybru0jXQ935AA12eE=;
        b=aW6MF1NTjC9d1dWDldSIaPeoG2fOZSfoItwdlc5jbN317moKjJPeuhajktx8502DJw
         B6RN2OslntIeXV2LQjWx5+1z5w+0RKyfNu/ByKZks9c1BRplfQrR5dJ3g7UBtg9DHvT6
         +Wi4YC04O+eDjg4aMde1PlPi0eGWSqU1ojSkIx0jPwy0m/ArgTxONrro8K3ddkuhkpIS
         zufOnNyuNlT8oL6G6+OxJC2NczT2SflmoKk9/UdApTT+49TBssKtg7CJhbIii346JknV
         LtAjqpzqwzAGUBbkwTPUExDrlUGnM7RarstU3RIgghuCqCQsy8AUDt+/O7TlzcgByyP1
         DBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900284; x=1757505084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+poAW3AComNrsNKMjhX2QMWKG3Ybru0jXQ935AA12eE=;
        b=CYHan7Pq83pRAb1kguKxduYLkl4bjqTWDioNIxOyHcoEbZU/nry6Jn6rgHmftaMv9K
         nRfThOwI0oemQfTSDTlgdOFVUDEK0s4o4Mn+4PA6TW28JDHLVxEB4PQ8ZI82xiWLgzni
         lADGdosRnm/8PmaNG2g5wQLISjeIHIc+eRXPUm55QoxLmg8MpzM3gzbEtXABywfchhmd
         uwwuZ2pxK0A3PjQeHMtLZnjI3nPyizF1Gx4bfLrtuF/sjTTSX+jzLe6vxblENrGnKG2k
         TMFUswzkBHXwRAeqHbN2COd+k3Fx8Wa0Al8AteDJ7oox3u8XCo5JwxkF/O38IMKFf8od
         FXpg==
X-Forwarded-Encrypted: i=1; AJvYcCWXiksv54oJk3TQ5GvP0IVzsvOOcCuYAiuScoTjJKLjOYgXSzXDsM9JXqm0KKB8JYaZSjKjunUT@vger.kernel.org, AJvYcCXwMdJplX2ygP2RMSMy+8rJN2n0rqUUQUm2zG/q4TXnSg2sLJTURfikQJQAzu8xdRdrQi5W4AJgDlSy864=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7g6CfaTIigjpoVFRzoPv6TUyBMQ0zX0v2wUQIadDKr+Ow+Ezv
	ELRfM0prcYJLfmU+/5NC8zn+MD3RlcBAKKpBe7iz2O0txXOyEqPWfpk=
X-Gm-Gg: ASbGnctY3yqwvqOgMROnoY4305WS6EQcz6FZH9dOH9gv0lts6fnkXj8OXM5BbiSXxsg
	gwXxNR0ZCnRr7jaBVabd88z7kuijWyt/wYqlLwX78BPUpq8of8S9S1eICxqShsO5P0XVk6HHoWV
	XbVRi9X7o04cS6OspAXt3gkWVSCByrDcfFLshoVadYgP31rn12BQHc6iwR4KBmXHNdvl33rkByO
	GLQqHk/2MGfEOwuowADOqLJjArB6dUg5G6QkHEmm8CWP6NZGz++1xI4q16NMw01LTsAsw1PiggE
	8O9KDOT5vbDhT1GPwkPKwCVHwG2GnFghuC17VG60xoM9QuT8Qu2aXJmMM2iyQFy85/Tmbbx/XnZ
	nsLB6Bau2VYijNhejfpwX7tU1nOCqEMXkkscK3QLu+kwmo93Ae+k/O7iEJ8PKZXOsrfmOuU32UA
	==
X-Google-Smtp-Source: AGHT+IH8KQaV6Ll+X0GX7vVi1QC4bMGUrCiEpULUwaoVTVKkkRFfOk03P6Y5OSqOIWzXBzBujnsLCg==
X-Received: by 2002:a05:600c:1ca9:b0:45b:8c3f:7d5a with SMTP id 5b1f17b1804b1-45b8c3f7dc6mr90956135e9.4.1756900283871;
        Wed, 03 Sep 2025 04:51:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f3e.dip0.t-ipconnect.de. [91.43.79.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm30003685e9.0.2025.09.03.04.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:51:23 -0700 (PDT)
Message-ID: <170ff207-cba5-44ce-9d93-75f7b711bba6@googlemail.com>
Date: Wed, 3 Sep 2025 13:51:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/75] 6.6.104-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131935.107897242@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.09.2025 um 15:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.104 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

