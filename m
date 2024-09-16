Return-Path: <stable+bounces-76520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C197A726
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104511C2598F
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CF15B141;
	Mon, 16 Sep 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PD5HjywU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44AA95E;
	Mon, 16 Sep 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510348; cv=none; b=JXd5ZPCCB/h5DRz17HOEuwsMm/uIrFJHIq1EzRO3ORHJ1kxsqVFtJCICMMgcB02ZkYrZ4pUf5OYmrcrhk79dzXkAXozZpvst82WPW6VQdMf9jshyut86YBMGHpE6K7t/biWfYUUjpWG+nDBWSSZt7A+2FE56k5LOwcuBVAKbsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510348; c=relaxed/simple;
	bh=/OfRyNqrb0rhZXvUasI7+TDBt2vnFU2uO2phanTYMSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWIuBoRrdaBZ4jfnnSZIlVUuXvh4YKsceBKdOQc1NEzw35xQ07hGkz9z2QoZGll3xPvgwwqr8JtxHkEGCMK4GEMbOaytJb59p4rxu3lkmb/b1G0R0Cbxd6zJ/1jFS4OlZrXo4KbyoaI3gAEw082rTVYBdRRhrk/YrME5g8OPHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PD5HjywU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso47186715e9.2;
        Mon, 16 Sep 2024 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726510345; x=1727115145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZW97+TG1bHC3qGZeiAaZOhq8lixoj+g1nC65K/8l3Q=;
        b=PD5HjywUxoHwRYjcYI3xFeWdWwjhufd1cc+IdQkXPqSfo8k8XLjhq0vgrFxWAjxQGA
         dbs3XYl/vjVoz8nALLI8XXtp75pZ2ZZXqeEG+RrjV8mb1uYjzjkuQltz6/uDDc/ccsXi
         9/cd5GjRKkd4RAtQh9iiBBOIK/sU9dft47b4soOxXvg5CkhUl52+7q1XLExR+w9uGvTu
         exCK7h9GQqWvZ4cf24Tym/I0RFpRW2tvU3fD25+KTZku15KX7hXXscPxHyxVwCY8PKMF
         3hZ1JB3mtdc4QCEkxZGOar58QA6ScmmLeWpaKZHt0u7G5yYThEvu2JX2BRiyG47ka6Vj
         5i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726510345; x=1727115145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZW97+TG1bHC3qGZeiAaZOhq8lixoj+g1nC65K/8l3Q=;
        b=nPfhu1SLglhXqjNmnixNryhsmvJ7w+SIw4uawR9DFq4jthd4FqYTtrlhovc53fUWc0
         flfVbAOxzFJiSK8K7F0pcTnB6g2KO+eIsG3S+XLJ42C2c0AXRMR1IoThY5aOL8OEozpl
         Sf66yjJ7/xjn+YFKESxV0IK/y1Kq9dIHJnz6O3iHZAgbP1SYzpLOnnTROzh/KvafY/F5
         V4NUYFkoDHxNmEngpZifVC5d5c0UGM5R4Z1L2ReK4FKSb2oSq45h0hfgiiokVsD3gQp8
         EQDvI46N3tNd4AAshYWCMed6KZ9cGvG3PMMlXeI110Ognt9dF0Q0JNytEXqeqfVCZh8M
         KjLg==
X-Forwarded-Encrypted: i=1; AJvYcCUUFUbVs0xQrJufN9WcLokJe/zw0mB2lraKBhWuMYdUXA8+PRWIQaeinme9nTv7K9RB2hrh40GEFDTYteU=@vger.kernel.org, AJvYcCXiEwEU/bHbDZ1+ikw2iBHgaQNrDnA0SBPYnn1M2ayKjq+1YHzXI/LxEM3nPErvtAmBXEKMOCJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJOEI4VHRGpU5MsxvQi/R40mXo3cPf9anjFINXrapnLRDGdZA
	8EyLBsiQFSVzh4jUoccKDsgCEGBhEJp4d5HRN5Xm1j6y6ivSy4U=
X-Google-Smtp-Source: AGHT+IGQbKp0JgJMcbk//NhE7JFF/Sc+z/Un8HvbYJn5CqgdSrSP+LnKzeoQpzxpl4BwO3NAoE20Ww==
X-Received: by 2002:a05:600c:46c9:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42d908267d1mr131297855e9.15.1726510344858;
        Mon, 16 Sep 2024 11:12:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acc3a.dip0.t-ipconnect.de. [91.42.204.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78051c1sm7864645f8f.99.2024.09.16.11.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 11:12:24 -0700 (PDT)
Message-ID: <0b3ad565-1d66-4dcb-9a6d-64c356d50e2f@googlemail.com>
Date: Mon, 16 Sep 2024 20:12:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/91] 6.6.52-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114224.509743970@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.09.2024 um 13:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.52 release.
> There are 91 patches in this series, all will be posted as a response
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

