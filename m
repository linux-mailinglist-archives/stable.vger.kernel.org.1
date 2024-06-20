Return-Path: <stable+bounces-54691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB590FCC7
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 08:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8701C23D8D
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 06:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E33BBC9;
	Thu, 20 Jun 2024 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T/HLxz6k"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50152E620;
	Thu, 20 Jun 2024 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865293; cv=none; b=JPJz2pEK8HoVwvLoGycLiLXWzQpVZH46Mn4EuzPGMMgxgfNEBAO1wvKqlCi03aOCVDLTUDwjhTy4262RIcbwVL0Dvbp5RNPLjUTunTdgy5KufLJnbBbJLpS1afmXZp87MDwloAuTIFqXqM/hikt8JjoVmtYSlX2/zP50LAaP9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865293; c=relaxed/simple;
	bh=SrHVASrlu3Ppa9f14DtCPP4A2oJ+yIy9bAmDdRN3DF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQKAxUMEVQo7aUnqO/GMMNzfj2Zj3LQ1PBmTXOgmizXbck76NrRgdcQPJxqkfSXC/pzO0OHufFjjCJLqbZlbHvdb5oG4+Ocv7ZJRzyteVGEmXo2SJmQr5rez9hLojMTN4A2tWuFsbQJgFQh3bDop5LCA8IALq/sbra8hQJHiKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=T/HLxz6k; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fbe639a76so83807666b.1;
        Wed, 19 Jun 2024 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718865290; x=1719470090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7QKZPgQMRj4pucTx2/beNO5zVyd86YGn11PumdUlU4=;
        b=T/HLxz6kESlm8EqONueDrwTRBSMJ+7+d+rKZ1zclVYrbh5r1+K5M+73AFUlgcuT803
         KIXkmpOTvrbCvWooXZROASqVEWqWCIHHLtjtseDRkbN4hQl0oKimdK19G1nba76MxJ09
         nteN/lcg0LALI6hsYang1MFlpnC0DTAfwHH1qEayTXATYT5A2XLrVL7corsBl7VrRDlJ
         QKMBWk6CZHoXXbsjEpapx4KowcYmgq6Qv50Si66L55sfbcPvjCqtjZ6jF0jQpbV+HGLV
         LJhNuztEesPVG+2jVR7Zj/D/TZI4yFSBsyLjIVKYaiYsgdMAgY7kk2bWdpT0p4R3pT+9
         g7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865290; x=1719470090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7QKZPgQMRj4pucTx2/beNO5zVyd86YGn11PumdUlU4=;
        b=qbsmUv0PSS7fPkWij0f/Y0ONPIA/gbnarF29ZYvKakMsbAb1HMP+8DoUr4STao6EmP
         UnkpWL9m2BU4vd1qEADWxc8i+DU48uF2SROMvYeps8mqW/b590tsu3qvQqH6FUCQjKR/
         AM2I4LSOmArdQtvp49ZuKv4veXqF+4CA0YpoLuim26cUW+f2lxfo9RuzqE8YSroTttJ1
         lhGZR3MhB5NEVoJ9epgsdDOv04xIaBfGrpeVctXb6Ag2GCeEghyx/o0LYb5I8WTBd5W5
         iDkV55Mxkg7SAY0QXnBXY9Fo3yLQnO+hAVIwiDaiv5pS+RE7XxTMIhO7uOqTj2PMU15r
         UITQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDXe6wo/mG8FY2WdEAXhtylEbbYM/pz9g6CS78vRntmbJDV3AKIV6KBlAH8e7pq2lCEGuE8AKkTpBQVSkd/TIiDcGDKJdJ9O0WLwj6NK6LKSTGD5+eH7hjEbDeVDBld4dq13X/
X-Gm-Message-State: AOJu0YxC4PJJZ9C9ONmnJ1xJFhh+lO/rlDgAeTdY3MnnaodR0J6hubwb
	86eU7WlwM1ntpNxixgeb26JKAf/JkQy5+fBiiDFwGwBWdGGy1x4=
X-Google-Smtp-Source: AGHT+IG7OWw7lWn5SQ/ID1IIwKfRWUNNqhkxSK6c5AJaiuo89mo3Hkwe+HCpcggg9gxEagYRrEf8QA==
X-Received: by 2002:a17:907:c283:b0:a6f:506d:2cf6 with SMTP id a640c23a62f3a-a6fa438e013mr296201866b.26.1718865289693;
        Wed, 19 Jun 2024 23:34:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f33.dip0.t-ipconnect.de. [91.43.79.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdce5sm728062466b.108.2024.06.19.23.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:34:49 -0700 (PDT)
Message-ID: <57c50994-80e5-492b-99a4-97a7cd05bfbe@googlemail.com>
Date: Thu, 20 Jun 2024 08:34:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125609.836313103@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.06.2024 um 14:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.

Builds, boots and works fine w/o regressions on my 2-socket Ivy Bridge Xeon E5-2697 v2 server.

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

