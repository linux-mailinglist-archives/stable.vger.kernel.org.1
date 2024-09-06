Return-Path: <stable+bounces-73778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE296F4A5
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0121F28159
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0FD266AB;
	Fri,  6 Sep 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L6CEiLCq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD976C13C;
	Fri,  6 Sep 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627154; cv=none; b=bbDV4y95MQMeFZK+YIAS51rdWMbu0/yfEsDlCqiWiMLKZXHsLALvoP35aK3AFGeL/JgSUtIz5T+JVFmxdP1D4mByRinp97b9a/de8r7rK+PXXT6C378lCtbHA6UK7PDNKp4RfgreYEHh8o21l0oySRVLxyQCxGejRr1gLBc6kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627154; c=relaxed/simple;
	bh=LAe+SVFODFHG3JO85HxVC4wTLxHPy0xG1UGWXRGSfSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeo6r09yqar6sK5acIaDsNng7lPWQ40WSne4UKgp/oop5/xCGiwK2aGOM/3hkOOabMB6LHf6pA4iWJVi8snrQrhvuhDTMWvcNFkjRJzlOQPnAXoTFMBcH4J5yE4KuoV5QjvbDTDQ4t5OmqtJ4D20gU+0UMpoGVvFutpZM2HuBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L6CEiLCq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53345dcd377so2537035e87.2;
        Fri, 06 Sep 2024 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725627149; x=1726231949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7xpYl6U/W2CVmGwpeWmwDvxtZgNF6LNCUTyVT4QRdE=;
        b=L6CEiLCqdpj3ga5ePoS+WAQM4u6uqbItQPEqCpx57Rvo5OAaBgKREPrekpDYXq81uA
         FkB/223QYosmRmJBBupLNC3GT7yAXTOYQMoLHb48Xm/+gCKmckcLQIA5KWb4mJwfFCBk
         0+bWC6Izs4ppKK1Pa3HAgd5yL6rnxDGPb7pOgL1Hzs21d5PSHnzzu/ku+ozQyixRlbAL
         BAft8TMcTr9Vb0nNIQ2uvWUVHororXa43jH85t3rtTEHbET+4rFqyaaYkR7v9Vfp9KuJ
         7KNxtudHP2huXx7+EW+85GTmKVhMNe63fcMCj6P2X8TXBlnTRCyMJkaZF0nyofvaLx9K
         kDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627149; x=1726231949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7xpYl6U/W2CVmGwpeWmwDvxtZgNF6LNCUTyVT4QRdE=;
        b=ALY4d0PlL19d/SyLeETOqGlYZ6obtHvHDvouFlWaacjer+m5NddZmoMFR7a5GFHUnQ
         dS+2+ZLHoOuMfSp3TzndeBgh2CnlLSRk7kGBevnZOiNP8KlpGpTv+QgJceP88H7cFhEy
         aH1b+gVkZwN/jSIM4KcO0Yg1fTeKJ9boo8SWliM8fKAucWFjemT9dq1H6ghLQuttCZOZ
         5yGudLfeTZH+G4GD5DgNpLUHp0dK8fQOb/OI7b1x9dlK/1Bhw+ujz8a50LfW+Pzf0xVB
         8dpywzw9k14eB82ybKsJoI0s0KYlVvXYdMMumiTBuHARtDew7qefi75S5Z0Rdssd46ZU
         GUHg==
X-Forwarded-Encrypted: i=1; AJvYcCVLve939gW+7fT9mKX1jlIds5r/+Yyo5ubs3e49JHoYUAwcsazXkbRqaNd+ZQ22envokMxAS2CwA5Bwd6E=@vger.kernel.org, AJvYcCVR6PsxVKmEEdWoGQMwKhwGqIiZl3vh6uBqV+at5aeINFRRW++Lvuk3XedKY3/VLAbvn/AUwgFJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9XxLoYPdOLwM5uUR5sA74zMlohzz7J9ex8nPInHaPhcTz/ra
	hqahjQlmC4FlHgszCGDIzB2OCfX27mWd6emHVla6EHGU4cJd5jY=
X-Google-Smtp-Source: AGHT+IHWVUg6w0qXEXxCORO+fGAi77k1sUCAjc1o4hBTuyAu256CvscZNFz2PRcuSJLEh35/EphQNA==
X-Received: by 2002:a05:6512:3d89:b0:533:4676:c21c with SMTP id 2adb3069b0e04-536587fcdecmr1661821e87.44.1725627148397;
        Fri, 06 Sep 2024 05:52:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b40f2.dip0.t-ipconnect.de. [91.43.64.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a45b0sm279211566b.143.2024.09.06.05.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 05:52:27 -0700 (PDT)
Message-ID: <7e973e08-456f-44bc-b769-fb600b49274d@googlemail.com>
Date: Fri, 6 Sep 2024 14:52:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/131] 6.6.50-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905163540.863769972@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240905163540.863769972@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.2024 um 18:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 131 patches in this series, all will be posted as a response
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

