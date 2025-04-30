Return-Path: <stable+bounces-139080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B83AA3FB0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9471C1893487
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B751A83EE;
	Wed, 30 Apr 2025 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IRTY2elZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1442A99;
	Wed, 30 Apr 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973476; cv=none; b=lAUGM3GXDQusEK91nKaINtzKhkibMbbItH5lbENJ9YMHQL78ef6zXGLPnYv1UcEkLGogzThsPDFrEC7wb1bw+rLXZnhCmfqbD6nCVUuJZvYpXHSobMoFnANDQ+Yunmi3meX5yATsQGpqAaXUJlqHmDIsZmDZKAXboXvPtr+eoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973476; c=relaxed/simple;
	bh=+aqnPA4r+iO0QbmkbcmL3npYlqLKb9+zjCliuHyxX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rbfm6dSb8UXm4UPM3mN1ZjuwVqdKucOelw2wsSF8MLhFy/SvDvQYtIbf4dT0t7T15p3x4aMxEo7iSCuWkN+zdXNVnVBewYIFxaTBc0uTfJKuYVdM+Mvx2RVc2HDEewVdeh3xj+x1OYskojmpovAtbmkOzZv0B21QdbPVMutL6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IRTY2elZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so49738915e9.1;
        Tue, 29 Apr 2025 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745973473; x=1746578273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36jpzvknKzrbqzrdJBObuGYioHZ4/CkD82SK+7pHs9I=;
        b=IRTY2elZffgeT4N7k+AlZ1naqygS/eQx+gVyRo6T+0Dod68ZzKquuWS1kQxOaVZ+Ss
         NgwsQAw2WC/kvmRnVddNsLCPs6aHS3ekAcfgO/i5mingETtuBUqxJcrbd3apFrNpSkEM
         sM+BfxtdMT9iORWaKYMLoKxe7y1gTTKhhYZLmc6dVGOHdLxjuVErbcUxz4p10h6sKgFf
         sc3cfy3pC+kFk56t1swEVJNTCThS1zQVgVJJAUgWZv/R8TetbpxRf+hjFYxjCY488Y5O
         Y27rwUOo7biyZzbwkIy8GMXHdc2Er7y+cn47803NnWsCf+iTp3EGaMZwDDEVl7IcdUvp
         C4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973473; x=1746578273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36jpzvknKzrbqzrdJBObuGYioHZ4/CkD82SK+7pHs9I=;
        b=iW0PPHikR3Fv+H7G01IIvwtB7jw8iizunnBGm8IvyV+lFv1nsmylFOs0CO+5qOgVT6
         Mb9zJtGsgSQe+upJ75NrkwK4EB55fNS3cuQoeaky6FYWBHsDcW2743pTvOS8Hg0ugdIh
         2e81iTYMoP5QxUtmkNKyYPeUA2Y/oMgznPiS2y5i98ZrmjzxgWYBYwF9uAMfR2+L1ug0
         I70hHRH0V+K2ph4mZtZmwuIJPQs5ih55pXPSgLk/luKM7tDwoAUuWoUSo/kg3cktRpBe
         63Je2hVzbNGSLZvAg0BOXM+dAvJ/kT0Oq2pYeLOTiyaY9+jQlMcz1FEJGFOJiXrtv6A7
         +X4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0RbQ3VEyJ4AE7C//v9qD2vSldGJaW9FE7Tx/bKSxwVV4EjhhGPz7C/4iootOdZXkkTTzRxtn5@vger.kernel.org, AJvYcCWiAZnffDaOz40I+xMDcMcq63WrV41zJHZ/4UsG653dpU3ARrbHLQ9TNRV8R7o2iPQIB8h84kxq26bxiJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6J1NUeJ3OiKdetbBOhedArBlzNvrCMXmTWFgbHYeDVbix3qfK
	lyG9NuPKVLDgB4Hz+cFpQtxi9jymq6NP+GUkXlEGBbgwP5iYSwV2bOgA
X-Gm-Gg: ASbGncvgv30TlFBgJ0YM9RTnrxnrQb4NAsnMhY2KrO5uVH+hN63vsAzjWWDLgNJwd0L
	1keDdIiTCEdEinCIYkF9R5lusiEltQC6YDxrikZiknIxWrvSxK+Wut2l5rs+bYNtuIT2y0vlRjQ
	vvxADl4qNF6hNP2iDvs7AJ6EcBouQbeLr3qOrx6acABdn/pph0SuQdDyEJN4hE3Nln+wW/aukJZ
	Q/08lGNkE8GViKx3HoELgR3qVsDVotqFrJK3P/rz2nXX0ZksDadttKKgCF2kOnnBVK5TIBBPgcM
	wzN4J/FLwZpWSYJUHnY21t1VcEd8G8652SCqTwHMOENqUl+jB/npomL9jcpNAr/wgmwWd2+AU2+
	ceYXWuuBvi7GFVile
X-Google-Smtp-Source: AGHT+IEKN5ZYb0V0mxVQ8VeWxSdDrKf1KJS1OxwBEsuSfvGVnc0TndID6ZTMb2SApHZjLTcV88Wixw==
X-Received: by 2002:a05:600c:540e:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-441b1f5c0c5mr9040945e9.25.1745973473092;
        Tue, 29 Apr 2025 17:37:53 -0700 (PDT)
Received: from [192.168.1.3] (p5b057647.dip0.t-ipconnect.de. [91.5.118.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20a65sm4942685e9.32.2025.04.29.17.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 17:37:52 -0700 (PDT)
Message-ID: <39b1a5e4-d8cf-482d-b603-d61f0ea3f51c@googlemail.com>
Date: Wed, 30 Apr 2025 02:37:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161051.743239894@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.04.2025 um 18:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 167 patches in this series, all will be posted as a response
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

