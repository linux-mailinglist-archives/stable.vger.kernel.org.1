Return-Path: <stable+bounces-179080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EAB4FB8E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C694E380A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29B3375DC;
	Tue,  9 Sep 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RCCGq/pB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF93375D9;
	Tue,  9 Sep 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421878; cv=none; b=useDjtDEfRWLP2tcfvJVJxFCWM8UcfXAvEXTakMDDIRDtBNENo0uN0EycZnZwWK5tqy5yzaH1P/tZAVqhPm8SMFvJTB++WRerDlytaZeYEdLf8/kmVQiKGEznk+/0Q62Sz0Ouesnc6mMpjU1OWI7SrAq7eiiG3qkKyDkdjZJKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421878; c=relaxed/simple;
	bh=GOhkJEeymfMf6qrtgq5+BS/JhhLjKijUfD83vqgz2mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grDsDSOgGE6sMTKMumBy2FJWCJo3ddI1yBl8oGSMgcCb7o56/+sXpso8OIq2RBaXHF9QvvY+fwu4HwSOI8neJHcf4gMQybi04AVnccJILDDHerCCJxbORnM6uWSX3ygfOh5Roa31OU5oRsb/Voa+487ZEMmQdTyPkB3SqZQ7bPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RCCGq/pB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so13675115e9.1;
        Tue, 09 Sep 2025 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757421875; x=1758026675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQaDHF+OqdVZFz6Y2By3JYrIbz3IYU9PimfS5JdBTVU=;
        b=RCCGq/pB6/2nODF5dcb+wfASw0I7vVCUecAJuiPZw9ckgrldtsep8LjsXap9oocGyN
         s6v4tkHOIJR07sZxBnfrZpleQmYvHi1/dXUqwY8cvdS2MuJccsqcknHdC+phLQG7sXH4
         KpD879Ripqn00uqgQ8pA4R7AD2y1M79WDj5TrdYQHJ1TfdebGgLQlK1gSwHh2xo2SuaZ
         acU30OUV2pbieP1WKu+QpjOT2WukJ/3nr28BCQer3GBtQISUq8Kf42WzWJK36KNJQNFq
         wVSABp2MBt5J38UdhWLRH/0BrEnA2ivH1JkdP9v4SHVvia3/petFopv/kRCQzKsdh7en
         Y7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421875; x=1758026675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQaDHF+OqdVZFz6Y2By3JYrIbz3IYU9PimfS5JdBTVU=;
        b=LBSzVpZRcyMeLYtXh3WPAZJiA5q5wQQFhGDKE9aaSbC0Zcv7J9zU5kHtnF1ZtcZyYy
         tXHS6SLTiDhmVMDSf2jltHBataj0GmU8LO4opU0hEibHWkJ0Lxb7mvPdh006IvJgo1WK
         sjL8CStEhJGmLKlU7Tm5X+NInmhD/ukot+mjJV08wlwHn+xNh5ugJqJF2wEw1bP1jPuG
         0vHC/B9fFIYiTQUraY2vRwG6pIh6WKSVfEyotH3qB6GLP7tQM56UOJ1ECi4cSthnNEGE
         nm6TNG9pDFUhfVXWL7CkbG7XAA5qoM4FCmQIBrEVVnDNGhKRppqle+yGXjoawttMjrgV
         Ewlw==
X-Forwarded-Encrypted: i=1; AJvYcCUXCU6bT1DEp8/i3El0t/T+f333LdvfU7bszkDIn5Rg4FVo+gfZeOHWpW64Oi/nE198XPCzzA20xG7l1Mo=@vger.kernel.org, AJvYcCVHYi3CcRtFmbsv8KINQrLpUmUqGG74bH4a/ATyjDkFbqffsVmFY9vnbPreQ/+8nR/11yddvPqi@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTDBdZNc9Gsumca7ntXOuBAOoLmqfS534rZZ8vCgclxeGuof3
	t6D+XyQT2ByF7DQ2fJrwVJvms0M6kw2rztuMahnicOFkfrqmMG+wadI=
X-Gm-Gg: ASbGnctnF/fxvSYYlSts2uYSbcbcHBoRA0lw1Lm/cZ4Pg7VPqRpjUY5zjXHLOQNOVLv
	S36obMZJma+/27ACzAklyxQBFmItb3FdU0Bqm1J/lr5RkuMgH9bwX0pGVPpZ+/7QcJ4tCBJKMQA
	AhjwFMsyBtAzjZUxTDgsB7AlQyzjds+1nyt5Nsk5ZQ0noMkJWMWFZzDPxKtjmU/WLGvs9XTMz+r
	AcpN3RlihwShD6gSD3CEXNoKaLBEZ/4klwXxtaW2Kqn/5tlNkhTEu+U9jPLO/lzy3I5E2bnaCVW
	5AJLg+NdxwNz0CFqCSbFLQmKEhq/Y9RnyO7b2SDPFZfVNYS/BF+a/xF2qbFe4ZwuVHrs203uu4Y
	JIUNQxz9fVXbwAH75zzyTKqHQyt1rOEhXzGp88toVjjNabTHPG6xC1mRaH+ez8IfhAi1ySi847x
	0l2uDoUZb3
X-Google-Smtp-Source: AGHT+IEsx7Xxj+2lRlWFeshLEPV/hPgQbvNUMtQMttEiRIzCxZzOP6ON/5bvIiUPG2wAblUV+ecYAw==
X-Received: by 2002:a05:600c:4f47:b0:45d:d903:beea with SMTP id 5b1f17b1804b1-45dec7992demr37367755e9.30.1757421874469;
        Tue, 09 Sep 2025 05:44:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b057250.dip0.t-ipconnect.de. [91.5.114.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm490545475e9.24.2025.09.09.05.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:44:33 -0700 (PDT)
Message-ID: <5a3ee5de-0b95-40e2-9bd1-f0b544b70530@googlemail.com>
Date: Tue, 9 Sep 2025 14:44:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/101] 6.1.151-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250908151840.509077218@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250908151840.509077218@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.09.2025 um 18:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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

