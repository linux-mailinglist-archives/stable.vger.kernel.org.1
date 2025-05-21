Return-Path: <stable+bounces-145927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62147ABFC98
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 20:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83987A89E4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F71231833;
	Wed, 21 May 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N0hjILO5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643622CBF8;
	Wed, 21 May 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850435; cv=none; b=Z2PBwGeM1wm+JTx5t8dzWl4QIc5KND/qBP5X5auMLFNAqe333E97tpMWy7PNeebcg0AVueOE+VzWZFIikzdCryTUfViixUNOlWFFl2lB04Q7ilVmvxr+NzkKgXQbKFp/DR97dWPTWm0s8NY7bc5o2MTtslwsyZN3hj57omrKkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850435; c=relaxed/simple;
	bh=hSEhiDzqSaiyLOhzjpCcXuTR0mgkbVOtc0ok6q5hkyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etw7yyv1SmMwDRtmg5mWPQIp46sXxV0HYjlwpRoLeIh1+xqkQthlLwjmlqPZEvqmbkSIKUxbSYVk4Hm2iyhKWKm94X/ESy9FNweNNLc7i+c9A/d6CZ2gWx5vqsT8CKDaeHQ4MjNIDLT+EfahNEt20PD8CzgwwuSfp9Av/LcDrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N0hjILO5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375888297so2328017f8f.1;
        Wed, 21 May 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747850432; x=1748455232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8AA4IZsofQYOTdeu/xMopNAhMxBwcxpcA9eFx+l8xc=;
        b=N0hjILO5NjCW4J0r7fsAH6pizhm4l/Kt4Pr1O/ebp1KfIQeAazeECNtN+Z9FegsdL4
         M8kJn7V4U8KkfM8InXOEqU8em5n4t9rwOykmrMfKhZifdcs/Qj+tae2g/ED+/JrBVwcr
         VJYYORfjxYI3PBsUeETwelhz+8nD1MlJhunRW4XIt/qC/y+I62rH8m3FIKrVKMrry27C
         ivgdO1mbz2f0rowDyxMLo215Dr1Hv2Q2xr5cVZUsVAYlDaCXyH5PGObwyGLATONa+oRl
         WGL0eygcbYZCmK51DzEJFwFwZc+V/vafbiddL6akWYCPNR3SS8VYSCalYGU8YVRMi06S
         R0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747850432; x=1748455232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8AA4IZsofQYOTdeu/xMopNAhMxBwcxpcA9eFx+l8xc=;
        b=VkSudBczItkcpHGBJHxK/0H4YT4/MCL+PqU6cj+8K75ZEaownRIDnPe+S3Z2zsC82I
         f2Ba4uDHkHAnEo9VriIcSwVio1MqO6lEKy7tWL7pZ95XRJMfl82ApimBqpXBZ4Uj0l1X
         VNR1xqem02fQr1zVHosmP6XeAkfeUTucAn3p+wLxOE2SfN+URpYPFus9b88WHBOwJexG
         HfVzkF84wO6ibKZ0SA5ENo0lwlx5eAoJEhkEh7P8wxnjFYSmgtXEIQ7QRg5AyLLLr4XR
         OCkujAfqD7Y2lfXE/hwjy7a2W0uSzlbk9gEW8juyZy68YSPoBMSAdJ88iXH32d5HA5dE
         rwrA==
X-Forwarded-Encrypted: i=1; AJvYcCVJVrVqNjg+c/UMa3UoyzfrkukuDpCEzQQeInjEexfUCA0A3Q9DLCvJrVF1DU8MGZv4hCE6lIfb@vger.kernel.org, AJvYcCWgYDJCpmsyDV1rmni7sLm4DlvHuR3ruSRmmCHWE/3gZKT4NLEapkUgxPTpCUrev0KtyGPmtO5Q1NsceKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKAR96k4iwE+luh9HLCDkmfmwyhIbbS3NYQlmx+dYkl7wrfwe
	Wh5TcZCfKImc/cj53TUPvQ3LhJf2+QrfaelUuWoo3vCej7ClX/5K/hA=
X-Gm-Gg: ASbGnctsDvhDwLvFyRpyPQ7K5Uo+8/XHFsGmrAYPRWx7gpodaxOcl9tCpyyMu2/jdI8
	bYUvUMN/d8XeIjEc1ibw5FtCdYkWasvxYPeHHGLeiBNInj3+cYK4pK+WW8LuUh2knbc5qecJKGE
	18N5zx62WI5F8X2vl9LCJbcyWVX4uOyzv7ZY1H7mM9FECWGI6FbHNV66tnTv/0PN7MlyiEo2j3d
	t8riULlXSXfWIpmAMenI/dQ0fSzo5Q6W0KelEW+P29AJKvkT+6EraPcq9lCSstBXZF8UmpsYmbm
	cCSy1KKCeX098E8YEucjTMYf8h8oWG1EZZavDnJkF3UxGj0sQAJG8cI9MX9DSMqbe3QQBTZ0Q4U
	nA+z6x0/pLdGkHMVD0T+RNKnfVE0=
X-Google-Smtp-Source: AGHT+IFh2AGmng+VALdHnj2jbzj3BcBZ4blsY4cvN/b9ldp9O+4JHoVbg40HkfWme/bgODBOdOKQyg==
X-Received: by 2002:a05:6000:420d:b0:3a3:760c:81a4 with SMTP id ffacd0b85a97d-3a3760c835fmr9803335f8f.24.1747850431771;
        Wed, 21 May 2025 11:00:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac604.dip0.t-ipconnect.de. [91.42.198.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm79716415e9.22.2025.05.21.11.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 11:00:31 -0700 (PDT)
Message-ID: <66f9ad91-99b1-4791-8cab-22b01eefeeec@googlemail.com>
Date: Wed, 21 May 2025 20:00:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.535475500@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.05.2025 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
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

