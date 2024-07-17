Return-Path: <stable+bounces-60433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6E933C7A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F7DB2286B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E017F51C;
	Wed, 17 Jul 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kCsvB+wI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959417F505;
	Wed, 17 Jul 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216775; cv=none; b=IybXJ1iFSJ2NHxIiQdCr+d7KP+zKoqyukzDRZ8osxxaXIlac8eMg+SI4MR4nGYh1dP+FgLYgx6zqC7pjqLwzaQlmUgb/fzSRvWTjYHbNFNdaVwnzLgozLC9iHqPB8KjcG6oNlQSMPA8xfZSRTWP9dz64c9UVQ4ivJutJDVyzT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216775; c=relaxed/simple;
	bh=mPNNJXb9JtXOSrYhH09YI2E6ecROU8kEPA0TLFzJtFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ycyi9/rPt876DU1fgDVvD9TO30qKrrAcASTW6anTGiE5ba/usFzdyVKaqP/V/rPrGr64uST8TxPK/WDSyKrbcpoJevtfkrpjrcB8dsIgW04WrmGKLPMGibDW4czxbA2T2TMRcsEmUGSY57eaiqOpc0JvAVv33vxmv420FxfKYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kCsvB+wI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77bf336171so128767066b.1;
        Wed, 17 Jul 2024 04:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721216773; x=1721821573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FH2P+UODR03FUkhmyN08iuWgXrF+03JkmoesFJR614Q=;
        b=kCsvB+wINrWwlGaSEKWWuur1zo/ualpf4EMF7Zxru8Ki7Y2mL6GUwAVkwk24Di16dG
         W9/9iay48sJDSGjGrJ4KIhUbjxlaTylFOdjMjeMk3X2tqLQ4QGWDeeb5Co/hiWq4sfbj
         g2Sks4VFkuT8ydNIB1auA/yVFl7qgEBcZwOgOif4sk1g4cSuDSc/7n6jvrVqTz397v9F
         U3kzuhRATSVZ1dTZj9ujOw7p5p9ZEfJXHCONhm/1BJ8x+jSA6PmpODz6PbWW6ZrDR3KS
         MtX1HvMBgKGflMGaL44V2qte7+5nVKU7Rn5kwUk2UYS3dSuCeaPz+SFmidHXLfLolDBd
         Cl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216773; x=1721821573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FH2P+UODR03FUkhmyN08iuWgXrF+03JkmoesFJR614Q=;
        b=Jqxa+sKQjEpOIHmt5Er5KX0627ooyH7MXL/Yp9A5FtHsiLwXq/ijYXffQAX+FdmRcc
         Si5yPpnn8s2CrEu8i+Tw+9fpbjLL99pzw0EqYTNI1f81MphunIRyHTp9LLoeqDnBVtm6
         UcPPPAfTvyobhQBgZvCycS04NVGk7gtcsEOhwiF5lhIBoYbDbPvPxtBBYq9kbLlISnUo
         LTb5+lNN9Vrg4IQK5HyVG5LpqvXlpM18g/BYLwXjXaQS4yKuOg3s5fsRehLvPEGnU4+C
         RuPU7ko/Kk19DkprTxd+k+N1EOq4lmQsz/uGQlxCLmo1E7maYwflxs197ZiYyuGAPQAq
         Gn1w==
X-Forwarded-Encrypted: i=1; AJvYcCXGTMLVyKrSMTgFU3WElYjbt4wtt6a8zcDxt5NP3pEqwyi98wX3LRD8vQ3nn+6XJelAN/pJjP++/PWLznuVVGQeetICq9GsQHA9aBq6/6K4NjqfYfji4+k3Mlh+onWc2a7n+iuE
X-Gm-Message-State: AOJu0YzdhA6dpWwihgb57PBrRy49+ThiCeuag9seNZ3mkrQwzOn8RqSA
	orvLPk3KaRsDAAibk0Thc6SlP3d210F5+MxUkcitAILGa73F0wZVYfMxxJ8=
X-Google-Smtp-Source: AGHT+IHY9UhZrcLqZUJEDjrrkScBQVarkTtANqFffDu6b0DNpiM/F0ukbPo2IDtdU96Z3B6jY5Z51w==
X-Received: by 2002:a17:906:5a93:b0:a77:dc58:d30b with SMTP id a640c23a62f3a-a7a00915bc0mr153976366b.31.1721216771808;
        Wed, 17 Jul 2024 04:46:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b0576fa.dip0.t-ipconnect.de. [91.5.118.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a359asm444939366b.19.2024.07.17.04.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:46:11 -0700 (PDT)
Message-ID: <56ba7dc3-bbcf-4d62-946e-a234c74dbd0a@googlemail.com>
Date: Wed, 17 Jul 2024 13:46:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063806.741977243@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2024 um 08:40 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

