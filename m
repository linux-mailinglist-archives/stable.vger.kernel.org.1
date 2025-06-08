Return-Path: <stable+bounces-151952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E324AD139A
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 19:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461A21886B25
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE63FC2;
	Sun,  8 Jun 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S2m1kAyM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507D54673;
	Sun,  8 Jun 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749404460; cv=none; b=ozrITUPAdLHxCmt+47dN080Y8nKeyIhqVEJnDU1SzU7tN61gLhd+0vR82f4oZUHDxLKGMDH2ki5tXt7aHyoqfYGsX6aKH4VEfw3DzJ8Z3N2oQniq5mNG8UKRCV7O1GG4jeJimNE5L2ipfVL30nkzXRqi0aXxOGnULQN4AEr8qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749404460; c=relaxed/simple;
	bh=tNa7t++GLpb5XVp7b/gfkdm8zfOa/b9SJSrTVO5CBW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxQARyjuBKwSEAGefo7gOvSSB1PzmZ51DL9QzLtQ20UqJHhykbXN8Py8rC1TLv6QC2Qe8cb5H4oaAv0QUiTYUCrjmpQrF8Ns6MUT09jsPTXp40auEQohCBQLRTXiPR27HnlnQz4PB0T/Ii0tzChsoU6tAVWS9j/jRK2/wAME+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S2m1kAyM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so346551f8f.0;
        Sun, 08 Jun 2025 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749404457; x=1750009257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V298GByS0UihQqnZbWCQzM9pjzFH0uvqjj1S1drsO9Y=;
        b=S2m1kAyMi7TEQNxt14rX7zNjeT5SKz05ivyS86hay/sZt8nJ3sfV3F56l4sWkcuDOu
         NCy57P//D40ijs27cJ+n5TDvnjjiHOmAMhWQc0SRxc0lo0QPN1NxAjfvcgrwwUM3wzjX
         X0LTfiCAIFzeUinziibUabEzx2WFpqia22vNgnMZuW87G/lmgtH1Jq0FSkJiNgiwXFrU
         C/koXrcZRTFLz26OZSVGS5smLcWhUg78VNwzx3Nqr2K2o7z0EceCmknidVfoWMroHE0P
         7sDAB/2Lq+TL7rRkx5kzEYvDMisKAUw/U1qastsduISRvH5sHmqqrl+pBXCH4sNp35pU
         Odzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749404457; x=1750009257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V298GByS0UihQqnZbWCQzM9pjzFH0uvqjj1S1drsO9Y=;
        b=FQVDWwe0hgCrilC28KkPAM5tNIdjTYwn6YYJbq59vOeu/nWBCFyQgaAw0kaFOasoDW
         S8ICzNldqx90gHplO58oTgmR3HZcgGVyrRT5eL4mzefKE3FVqMhwYYDgxxZzpbDWM+dK
         g4PPrlbb3yhE+Xf8rdVkG6YSHbR6tf6Rjmbt68qZRmZDTJf/IF7pfdPEPAkJO/uF0wTw
         LWfN+6NYpR3kaOFuWEjuJ1h5AO/WPdPXWCV5jZTnlRPcTm/ZOkjetOC/QtZxxfKUmVeC
         NeQUWDXlFaomSNvjXdcZpAEqiAIefjxruoQ1XU7V3+C3l78Dy0JFY8KDKNlcbF8g7Dln
         EazQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7k51UYGwEX9s352XvUstI6sv4JgYedolMavj1cIhrYp2TxaONVhyEgV1Darg9BjF/ZpM6O2JOTLUL4qw=@vger.kernel.org, AJvYcCWllNXfoudTQV7fgV73W46EifiKq6WLfhgvMs2VlUR6gfuBiGxGjXR1F33+SdFVyQqbVZ37Mnz9@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNOkbu8/OcqaQfUJ4MLKEFTFI7FNlU6sak8r1xTmsDJc3/oQG
	PxNfBvuQn5l+kUtfIysWG37NStvnBkdfkrlgmumApYNacAokRtSrsRs=
X-Gm-Gg: ASbGncsFUNgWRRKxtmn/y4/WH4hpLvpHYgzfMjzXyEshm/8oVnqvhEDmqAO1V68ARjJ
	MpWuSc2dWTsjNo6j8zHL7gcCPhK+mzKr5Six66+sE88tt26Xxbh3Xlusg74DEiudykR06DYxvEX
	s73p3dqqrjhGm1Lh7FO7G6Psiel/PBTSHyc0d6PrPToRu6AlswPJ7SQWrvSusFjQFxoTQPmzinl
	I8Mq5rNaYHwLGOiDsHK/fZeoGQm4XjZgUWdOCG1ZCEv9YX/YAqkfrDflDMylyZFwUow7oSDeeKU
	T+EIhJ/RfF491+asdQVzFNv5AM4ZZYrJ5B5R8/nHh5cAVHnx3Tk0yo7n3zJQAsoZ7MLZVm65WSu
	+Snv1+duFIGlcgOYH72KXU2mVfUc=
X-Google-Smtp-Source: AGHT+IHnN4ArvaernVN0i2Q3r5CdugEYMRzyU+aoqQurZJvd+6mjnN24e9YgyDP9K/6+UPyhBfAazw==
X-Received: by 2002:a05:6000:2585:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-3a53188da55mr8344003f8f.11.1749404456378;
        Sun, 08 Jun 2025 10:40:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace02.dip0.t-ipconnect.de. [91.42.206.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323ae18esm7821035f8f.33.2025.06.08.10.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 10:40:55 -0700 (PDT)
Message-ID: <79767ec6-14cd-4fdc-975d-e303d3d2fd78@googlemail.com>
Date: Sun, 8 Jun 2025 19:40:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100719.711372213@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.06.2025 um 12:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
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

