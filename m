Return-Path: <stable+bounces-125715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E43A6B211
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6077189AF2E
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD542C182;
	Fri, 21 Mar 2025 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B0IW2RJr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19712B93;
	Fri, 21 Mar 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516133; cv=none; b=A1AkMnvoHxacwgWeroV9eqHi2ko2isUFsK/oMgDUuAX0hsdaiZ+x4JEbPBmIrROw4u1R1RgjqGFER3iI2c4jE2tHM2g8JkpEwrM4TmQ2JgU0LkEn2k7RI7gwQcxT6wOdei9upcSBKK7ux4V8u1zSHNlOdS+s2YowCOjIfqPovxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516133; c=relaxed/simple;
	bh=nX2wIduIG36+3fmPAhv+R+GtpwxOzMywhemt6G3PTms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3SB6wcunRgROLHliZ8P0oiJnt1PKL5rQjC+pVq3mP6OnuJ6CoGgacxYOTJqCoMlWiKgWqS8gA+7/MHPOz+EQ5w3kq7X+kvFbmkpeo9VBGRdS1Sjrd4Mh7n6qOMyU2iIGMchKThLimWoAq2gQLvDC/0cxfvPP+wSFWYjqLpAD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B0IW2RJr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso7931335e9.0;
        Thu, 20 Mar 2025 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742516129; x=1743120929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrTSJGZbf2PfYEvYnN2elEGB1o6Gj+ZashKptuKrxEI=;
        b=B0IW2RJr5NWm5zOjH2tmPcnJh/oqVZhW4ga/3IEY9IdaB84QR92FP6hf/qjHgge4kE
         YVYeaJFDuZ1jhuAKTGBm+kAnfej+l3hUaEbpDy+mWnYYnELCSnrxAl/hmtJVR7i19KUN
         J7I5drWmtTHPaFJDuopbHFIZAKhrdoZjEMhMOcapQdBAS/RLIR/l7K1k2Tg8J1nJR4Yj
         nGNDnWDtJebYAXzU+DgLdOtskHYmt92mgp5AZ6GZa8a+DtrVfCrJBe5GcazrsEC0iUqD
         6M2BOITIXLWTHUFzh7pJjZyxlJ1W1Nuad1XEgPiOs5uGI9QWuBs2JXLNeHNqQeqe9Cos
         j/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516129; x=1743120929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrTSJGZbf2PfYEvYnN2elEGB1o6Gj+ZashKptuKrxEI=;
        b=dZHhz2iWrpWTnG12uV2XmF8BtoAJw3oq+2uhRBQ/HDlwhKTuNV1t8IMCaKZPwKcEb8
         Go+7JDHw7fRG7jYvrLiV9GdxXe3goJbNIhS+UKWcj+C2M7TFGWGZWeGD8wS9i9XzTp4k
         Supi8PDzcRR2rS896h6VD8ylleYmOj2uQO5r0/O2iwEmYnLcoWrXEhJ6LMCsi6fCo6bm
         MbVYR0G3XkpYR+Cs7cOkeAN36ISDrAfucrqcZSRTnGpN/Megolvom6RHDgBzSCqY25Tx
         oe1Lnt0eLro2hNTsSHkQBUD0YvabbgfrKI+50rYH8pHqJ882dNhUI/TzDl7CXlJYaIx+
         HqWg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ugu2jRfWR7fUjbO6+RYjcL/uULoXY0Ay7LO5wLUWTFO2zX+iNtXTMAVBd5v/faVxoRVfMXKy@vger.kernel.org, AJvYcCXz6VVbD9pWq1UJL8ayuon4vBN3NJ8SQIr4+CTSpLVkV6XA8YsZ2D8NauTgAwl2ptaHHlHKUV5Dz9TqBis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgDOxCKf86xBo7ANLTuCt3Hf3H31FZ1BJhMErRaWLoQQ1hpSA
	W9aMDrNsRQ4MF8SjvS8CBvA9a96NsQ/zQECb4sE0pgJfCe9aiFM=
X-Gm-Gg: ASbGncv2zcv/FhniLBDCFS/wPIJt7Gpob4OySx1xC2yofVedwvbrU90TxCHfbEE0C+f
	zSMwPiCZ2jg36UMcx4hX+YHQvJI8X77+VLoUujv16dvxmdv5U//u3qm62ZqFHlMXphgpiuBzc0i
	k/TT87otSDqRgT3Qxo5aM42W5YN6e/SDsz+kcusH6073fRIFpp2OFJ75XPSRHpptdILiV6C6vlv
	9XKR5GNn6fclbWMgdyPiHQn+aN1FHHlBWii3eOHBg/2xLBfU394cAwAQBt0i/uRD0IwnjrDcGW0
	GGmKd2nTOrytLWeidx/eKlpIiyatcUXaLMmzRU+UAeCzKHMU2tuMqiDLyOjhfzFx+K9wLWu8Vtb
	iWcMxSN85ZeHm6kuJiOzHdsGa+jx42cBS
X-Google-Smtp-Source: AGHT+IGOiIISNaaXapzkv0zDSUG4moDEe5YccuymLOsnFtYvvMKZFsnv0AqzFgISjlEh4xFO/EyWuA==
X-Received: by 2002:a05:600c:4584:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-43d509f433amr9405935e9.14.1742516128489;
        Thu, 20 Mar 2025 17:15:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b0579be.dip0.t-ipconnect.de. [91.5.121.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea65fsm11740955e9.7.2025.03.20.17.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:15:27 -0700 (PDT)
Message-ID: <03cc622d-3a64-4e3d-baaf-8628f1bf9811@googlemail.com>
Date: Fri, 21 Mar 2025 01:15:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170447.729440535@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.03.2025 um 18:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
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

