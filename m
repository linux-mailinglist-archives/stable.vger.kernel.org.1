Return-Path: <stable+bounces-142860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4EAAFC2C
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558FA4E41DF
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFE22A4F6;
	Thu,  8 May 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YUpcFd9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB11E502;
	Thu,  8 May 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712680; cv=none; b=ejNkhQyQ+KdcIPL4VpmfLHg4w8E8DT0jiT8ZvseJF3wN+ufG2nkZSm8F3VL1jBDuK3aalm0h6pBxQAO2kojkhehMWh1to6bJLqp5ZTI0zLbycL0zjYAehBMhfpg/gDcGzIAsV0VbC7RUDMNmyRHtuBIPVZYpXh16jdPFhU2Wxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712680; c=relaxed/simple;
	bh=pnK7j3iLlDUxLcmldCg7AjEszg5umwAWmK3mTEYqYbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m61s9bin4BXtaEUMwnDb0Ln7aq70nOtC/HpT/kyDW4T61dFEqiuo3BzJ8xbHBJL1wfUfD5aGveq0h7VE7SDQe8QjMJQR5oN4n7pM/O9yHPPSVJjpNxCt6sAmk/Ls1ZHyEGjQTrhNlj+tq+Tw82eIgbbJEoEa08v1K0AbxHByXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YUpcFd9h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso4758675e9.3;
        Thu, 08 May 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746712676; x=1747317476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bc/Hb+NUmb+r3dEJSpV1YEeQoXiOiyGyh7KJhLgdWwA=;
        b=YUpcFd9h0pIhXl0d4YdqVoDECO42hKZKi0LFveA+FqhpNRdka5ud7vKkvdHotvJ4iG
         hIrhiMZbjIm+/dAyKjl7eMbiwy/esMRVd9zemk2ClAu1zqfcRFYzIvaFaWY7bh+XTaIi
         mYdrh82frT9SHaPVUNu0Z1+A/XIeYTV1zL28yGpXEXr7V0cSDCb/bzuMb4nSbMqPJhVN
         rdfFRjxDG1iAoCZY96wglFPA6C6+mMu1PKPo4qkkNGrO3dWcMDgWtj8dOk4TpjRhoSYV
         Dli/8+DbLsU3XRuPhiSymAHJr6ZTqTw1BsyZal17ULhad4Iq4e0fLIs5j0SA6V8K8yzi
         AUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746712676; x=1747317476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc/Hb+NUmb+r3dEJSpV1YEeQoXiOiyGyh7KJhLgdWwA=;
        b=WMl0DctHYbUOJzJ6G/1liGXavUtzlqcJO8v3CnBJGUJP7Koi5UNQ9ga1tCj9VxsYuL
         71+2kRS9+BZuKjAqgtN13nFfLTp45vYM+OHsQO34CbML20CtFb/xy314Dn2r+bpbAorw
         AJ6AtlMNmLB92EVrAHq/qPWNJacvsQsH2F6dwu5RAo5OCPXAXIQdRjDKBwjs8dWLGJO3
         XbSj6tkDF781eriGMBTCcoq3oDd1B52smA9mRhdZ/3nngt/AAqyfu/tgpc78JbQWzONW
         AS98ZRJ3bODxfJRmfaWXXYBA1SE4PkwpzAr70dyC5ZIDiBM003PbSYlQkyD2YD7EweNq
         PRnA==
X-Forwarded-Encrypted: i=1; AJvYcCUD/z4Dpz5lTgYpmsHGBZbScJicPTjBM+xHpH1WrnQVbWigwBt3gUNMvarURE19BztOAPp00bjo@vger.kernel.org, AJvYcCV+foeNrWytjXtC3vG5z8e2VEsO1fPfdOTeXMb2qkANOExb0Aa7QtPAjKFbldYXtu5shXHv2GM38yYRbSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUtEbAw+2ojbAyo7HR3eIdzN97iqawEET3AXC4Ik0l9zA23GK
	Yb09keLYpp9Xsk5NBc2aOtQaBwgI0jxW9rLYk2W+ZCHkVO57vFg=
X-Gm-Gg: ASbGnctVss35LbRRgQyjMMHt5Y+khYH7L/yGyVUykR9rSwRkbh/tVJoIozuFCxLe+ta
	S1uVmLvB5lMwOK6tUrmKKUp2XT9VVP/UBorJo+KAZWiCkaDwMfZWCCeRkIEIr7cYKlakpalylqb
	0cuU7czsYmJ7M0UyJWZKlrLkjbmAs/rbOGWXvzSofRZ27W5GwRdCJLwMYs0P8V09qLrHKPXyACR
	6r38VvKjXd1aQqE6mWaOGbrWZd8vmkEPZ9L9TNqnSSshkZdCrsn8qWaQxZeZrCUjLcFjzfAdHLF
	VC6+slqIRmcPuXWWRyo7lwFROAoYoPfblE4YCTnEZq44WQkUTIOa7oD1fi8hwC2TbZXC2GlUL0J
	zipEZy7rJH9oKtPjgVQ==
X-Google-Smtp-Source: AGHT+IFFwJcze1T7lgw6hr8b0Ua/t9GIVv5voSi0/3NVOHk7byZ6lTzScE2jwlR1wJYTPP5qB2k0sA==
X-Received: by 2002:a5d:5f96:0:b0:3a0:b565:f1ea with SMTP id ffacd0b85a97d-3a0ba0991a3mr2435294f8f.5.1746712676210;
        Thu, 08 May 2025 06:57:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b05727d.dip0.t-ipconnect.de. [91.5.114.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm59313f8f.32.2025.05.08.06.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:57:55 -0700 (PDT)
Message-ID: <afebad90-097a-4728-ac16-5081225f8cc7@googlemail.com>
Date: Thu, 8 May 2025 15:57:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/129] 6.6.90-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250508112618.875786933@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250508112618.875786933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.05.2025 um 13:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.90 release.
> There are 129 patches in this series, all will be posted as a response
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

