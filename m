Return-Path: <stable+bounces-119527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F343A44439
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26EC3A8732
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705E25D546;
	Tue, 25 Feb 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="I3RbItsI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEF268689;
	Tue, 25 Feb 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496865; cv=none; b=EyvJc7R8w+1AyupRBt2sX5gaq8zwCFOyznpsrbilTOn3XTUfQiyGg8Cj7j4z28jULLPT1T2GaGoaw7G1p/v+uUXaF21VHvN0vduo45Vmq2w9jdYVsv3g6biTGEIE8QPxaTodU4ZawvVjpOKf+VHRzybpdFiY3qstJsECYcOLCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496865; c=relaxed/simple;
	bh=LEYExAvOlZQZSspB1c18HV8RXpGDdV5MPj6WidEcY3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgHHb4FZ4oXd00q1xc+yZjNbmZNY71/6ZEX31tU+Feufm/HGEgfts5EwyB/lyhQfxSV9A0kZMqb5mXnO8P5dervFi6+O6aUtLueux1sKZ7mJSfMIpPgBupLidCZI6qofsAD/svvbVNAIlNmtXudwkzH2meyhXe6b3UNpno6Gg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=I3RbItsI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4397dff185fso50299335e9.2;
        Tue, 25 Feb 2025 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740496862; x=1741101662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R00iFC92M1deh98zQEz+YC258SvnhDWpARo05Vlc3R0=;
        b=I3RbItsI5VpSLVLDK38fCL2OUZS7w8QFSYfIPmBJgU2szZ7+nF2R8jK9ZVKuTokCAl
         mBQyd2y2+azzHzU/6k3tuHo95R5Zo1wxh10/3IADx9QDOtDVeFd7I3dr+vOVIrtBGkfW
         leEEMlbcTe9YxIy6HpeNKgNSU7jKuIqtQIg683r4fc+HTtydETwSFeC5Gtn99HQoeztL
         D76rVB1pDqJoCFi//ivOBX116pbzYV7sirsenvAXHV/dNJhUUyducnu51w29Ho9W1DkW
         PwKrl0uGCM13NMqc6oLexolkPyCthLQ2c4Em2IVCV5ss/Da/EyUuvcOoQD02N7fQvnw9
         2lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496862; x=1741101662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R00iFC92M1deh98zQEz+YC258SvnhDWpARo05Vlc3R0=;
        b=pT75gJIDni9SITCvglXEkpOBd1tEFyGpc55TOpdxSPyQgpfI67WbPJfDhEfH+LUxAN
         oQ0vf2oNG1X2tewYvJfIUrVKEibHaIL8Beyyivc+185qr/V/FChzwIKIKblzrrq97TqE
         zrLalLCoMNUebQNLDVpT338Yb7qhf4j9nZtaRLZHf7e9KYxu87Odjobe/qSENPbyJ7cG
         xyIs0flnY82+ygBkFr66mlxn1yqZG2ryqv2spmnMhBLrQ0P81wfJh7t1gIKkI/ZfoMyb
         1NWeGC6d9KNTU2Zjh3xRskao8jwJPK2zimuI1+R3rvosLZ3kihc54k5YqE/fAwmmNevT
         RlcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlx/dKsohIKBGXKvzOKHKRXbb9fBixl8HNKYyDEI0b/DtUHL8WOKfmeI65HxTwd3g5V2dtZgZ@vger.kernel.org, AJvYcCW/ZSs2FoE7sDtbhEPUogQwaVGWYcLtdmQqHNmYeICXN+2KWLp/sFttD6h5+7DB6MSewbiYGq0T716JSic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77pXcx4hRbxRqJlGsaLBMcZpoo3QJsZlxg/1bHsScLlLb43ze
	H9bcGkgmjbUo3AKbmyYHRnejWucMjHMbNeyZf+UjywVDY4DpdpE=
X-Gm-Gg: ASbGncsi7Y7z9rNoqL2jJjVBJNapG8NSDsd3zFMMkD6DX2XC54xf3PCg6HaI3TVyvFI
	8aC2HOQBQoPax8ol5IJCByB+FllLqpGEgU13BkQqWQZjjQUgXjBBYeqItBqAmeVlAXAnpHRR+Aa
	40hxM+SNf4mk515zUEfG525/nIFRTMBjIVnrFaJtYbOXih7H2zr59VQx+yTaazTB+a+WFfCZTcC
	Oa/Sr4tB0PphM3VWnliZOeNpL+IRFOPVX5L7ir5rXFl0Rx+t+9wPSX+NW1W6rI1C6FWNAzAPA0u
	rVDDAAxIBeu8n8ra1RCEnxEu6JNGJ/EF3tjMrjLMk0DCghBMe+DNc2MatP9j8jN+FM1AO9BpIJ7
	zHiVD
X-Google-Smtp-Source: AGHT+IFTmPOZNMUYbjq0xktjOwR/hrjcj7eKjTft/BEOywT7Z0vceEUrKjh0CqgKZ053FHdrLSzW4w==
X-Received: by 2002:a05:6000:1788:b0:38d:d9bd:1897 with SMTP id ffacd0b85a97d-38f6e95ef5bmr14241054f8f.22.1740496861848;
        Tue, 25 Feb 2025 07:21:01 -0800 (PST)
Received: from [192.168.1.3] (p5b2aca7c.dip0.t-ipconnect.de. [91.42.202.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d60c0sm143189335e9.12.2025.02.25.07.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 07:21:01 -0800 (PST)
Message-ID: <066123b3-127d-4200-946f-61b118de1a45@googlemail.com>
Date: Tue, 25 Feb 2025 16:21:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064750.953124108@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.02.2025 um 07:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Like -rc1, no problems with -rc2 here. Builds, boots and works on my 2-socket Ivy Bridge 
Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

