Return-Path: <stable+bounces-176441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1799DB374BD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4F814E1E4D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683127D786;
	Tue, 26 Aug 2025 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aQVo7IkW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7A23ABA9;
	Tue, 26 Aug 2025 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245969; cv=none; b=Lt1MW9w4f7aiZwxVMeYUFvwPeSssRmztGdCcjZc/VhVtWTDh7dkTND2FDUlBjd6X1WoxgywI2Fj3FO7HR4yXAbRw8E0Qs98vrIykEogHDFcWTprWjQdAOJc6PlXtZklivfWvV92OdfvzEB5rCpUTyOHYY2KOyFAoimnN/RaxzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245969; c=relaxed/simple;
	bh=u/TTX0STx4snkL3BTx2vIxvUR5cZT8dsiz7IKeIyq2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKbTKyVptnp6U6/nP+jo0p3Q37/T5XsJUseiHcpcSY3xkXq1YKqw+htZFomi2hfIB4vCG4xjyomhQakutWz0eVbt8U5vYQqhEWHkdep8FHSxMYuBVC3cNz17kwkMAdYd8CKeLAHMILCOpA2tfyyZJxJsGQ2iNfZFlkMaTCFAhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aQVo7IkW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c84925055aso2321895f8f.2;
        Tue, 26 Aug 2025 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756245966; x=1756850766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8e9dM5QsAQ9dzNMnHHlU+Y7vBsWhn8pMu81yfhmakKs=;
        b=aQVo7IkWpMETSYr6eDdCGaR35KqH9MJdWUxmpoFMHBqptaOKJp2EOpc8kHh02sMDBq
         GGyE1dL2rpRee2dPwDKIs/vhJafvzez/EeP2/9l/towRUVJF3RTlV76iVw4yaz+ZzSQD
         gPFz5+BaXZJ5WwS9S+D0kiGuwMtZNv0vqsRhI0iQ//Us6hx1RlNNdQyOjqNTaS0NamG0
         RzxPB04X6tnllYR5fnD/mvxT7cNYlFM01ioKxd4HR4gibman5/cl2g/fac3/m2ZVdQNF
         VbMin7tvGRrV0RPUKtK4OJwKVnWSuU7oPu6dJ1+HqNR8hmTToyuV/KX+OzpGLEkXZQOz
         ehYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756245966; x=1756850766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e9dM5QsAQ9dzNMnHHlU+Y7vBsWhn8pMu81yfhmakKs=;
        b=dG70xkW6nWm/xF7T6y+dwihBlsdDiy5sASRBPMhMQRCHxi09S+/4/VHuzUxw0mxUhE
         TTgJNoad607ZCp82eTk/On4uLb/v11t9YQahUcqN2f3ej3XqGhjIL6o0a9lqmoDGkvta
         pn8F1Byouj5S0EB/f5J6pRpdwWlYpsYeup7pyVWd2LICcgvSsCqR9hafL3FebjInDo1a
         +8WXRO06HTvR19TdMrqqVXhMBOoNc5MY0a8NETILkd+I5xPxE1FXqHXvzOJbnfwRqZaF
         +fXx3c4ZstKTKu+5yp01TNxSyDg0oYX3JoLvilan3DdTLqPlvCX3ReWHVMeEwYzOLzsH
         Yi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj4zhrspKXBx5uqebnWXPXH5urZ92w5VlIR6QNz4mlfYrZgImX+p+ciqZHQFfnmH3GtVXhDu0q@vger.kernel.org, AJvYcCXwtITMExQcCVbPUCXvwBWSJ479q2AWSbE5+OVw/U0GDbcKYeWjuGm5lHR2yJN51UKrq1nS2m/pBUdG/gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYzMPi0r9qRgvnDgXcme7khU25dWAxjJCHO4UjL+YqhilPnu9
	bed7DUg3cnHeEKDS9WmANx12aRy0zVYFq9A1bAtsY6T1ZkbVRixmQDM=
X-Gm-Gg: ASbGnctmg4y/3Z8LCwAbWHEXHJnW3k+t7EIU968G+3mf7CriSoBlrL9oP4e+L7blhCd
	/MtqDSRZOzULCMkzIqP4JlKLLpiX+Oo4Kbov4lBridPzTBnSFc9BI6SjebE2z18VTpKqxIo4P0N
	7qW6Jl+SbdQxGCCix2LM5lRHlfTBuDQTR61Zy2c9FsPLz82PCmB6RjTYrNlvv5NEC8ldM4ZXcFb
	ixZ1Xzg/ewPuUgwn7iNS0H3uWUOQ5W3+xam1pKxUee1Aiq3jBmexcot/uGEBK/UL5OV8Oa3GBek
	QtIZhEx0gvcIiBXkFFXm601kEeimh1QGI4nxudHifDKXv0/qXRSfaaYvXbdi5hw7isx4c73Tzkr
	BptLchTCz2kClsmXE8iyzI7Rqr68Wfah77yXxfbEHaQP/yE3o4JDTN7J93KFzzSq5WEG4r4cJXo
	c+xQdwlofBqbaNAP5CsGY=
X-Google-Smtp-Source: AGHT+IHMTfuxDf1Htew8ys3jQRNDbyDBKRa9bTKr6dLtQleGws59MBJtQywxLD466SH2lWL9ySo9xA==
X-Received: by 2002:a05:6000:4205:b0:3c8:e436:a5b6 with SMTP id ffacd0b85a97d-3c8e436a7cemr8505302f8f.63.1756245966065;
        Tue, 26 Aug 2025 15:06:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b057219.dip0.t-ipconnect.de. [91.5.114.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc66a45c09sm1007087f8f.47.2025.08.26.15.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 15:06:05 -0700 (PDT)
Message-ID: <3269b6b2-d079-4e62-8948-95a53fc07e3d@googlemail.com>
Date: Wed, 27 Aug 2025 00:06:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110915.169062587@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.08.2025 um 13:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
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

