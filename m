Return-Path: <stable+bounces-118516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86506A3E60B
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6156F178BD8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFB1EB192;
	Thu, 20 Feb 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="FtU5Tkue";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="fXr1Oxe6"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84641C6FE9
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084340; cv=none; b=iasbaOVBgGUmWB38banTgCKOoHf84qwZCUxmyDuPTP5TWq0tmfU9RHmSi1H4wM4Bnnvs9CaU8DFIMP0VhZ6WrutcCjhXO15Wj9oC8mqhtgOzTB+xLAzDc1XOLZ90qFxkHM2a3y5h3CesXWcrls8FbmlIzQVXhcUUKsES2mdQtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084340; c=relaxed/simple;
	bh=3tbGpWfDHGaJ9/s2PSOb4z2HOm8MEgHRnPktyxUdylQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlMIvlxZyGigT2sKeNwZVPcdXeOjEc7VGH/BV7ftFigIiw8Clx4q9uOxKOYQu2UPDQB1MR94c8YqelNYsdLx9pp2siPayHDK30tJCeLGoKFFqgv3uhQd64XyGtuKmM5t/AMOAfgOKmQjeg/3eHdaAPz1pj8p52UlJ+fp92sAbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=FtU5Tkue; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=fXr1Oxe6; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
 b=FtU5TkueYHqB3rc1TJJ1MvkxqYx8ScbI1H44X8UACOztO7RGuBLUror2690lWyeq3paKvpxdHQw/F07cxsCSUYE3OcwRJ0w0B9TVZwVISQ711AMANNpWEpAJFx55BQtmAgDJ7Ha52DAoeBV18PeWUngfghr2xrx1kMz50yHNvyFGG5ANIa7DZIK6X31hPGXntAyBlyfHQtQGSbzBt0/xYs7ypX3CiCBHCVadOhvL7YD7JxgDunJFSEt6WSdUPYIe2Coua/vzh1epzhUqAzwdeyxTwqAVCsLqhLf8v2z21Tlp2Q41G0QUQ3wOmi/EjuaFbk6p3NKpbK5fsPk9TcGQRA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2C51EC400F3
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 20:45:36 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4721d9703ecso14819281cf.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 12:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740084335; x=1740689135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
        b=fXr1Oxe62nu08x2awskgd9HwG2ioYrmykVJRFPu/NkOOfjSaRV5ClxZxinW7guuhju
         g0ZLYwEEBI75R4ms5HmdT3dEaIQ8kECnltj9ixHYebKqbiPPOh+XANH1UU1Iz4AHdQFO
         9YyezYnN+fODPuHHdwoqLc1yLnrmmVKhD9nFqevyhZy28On4dhyN96lm/jwLFh6ZiN9B
         BwQmI9+IgkU2H2OnU4EOK2zzqhf0kLHfFJgmyE2833PTHW4uq/UjOXEs7nVVtVcfjmg3
         9O66Jdwbca0qS5fxiRzmaFRsOmcW4oSE7Rm5Qjyo33Mcuah8iDfhKtOA3jaxYVqg1SwV
         jorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084335; x=1740689135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FntsL4GwmN3SvMUBbKd+19xK7r8pdM9oyUm5MKitCPA=;
        b=a+cbpmgfzWwTUNcfJZYWuhjNnoHnLBSreeubFH5WSi7U6iJl0ASVlODW2s6cEaVBaR
         GS9CEqo85LBuBPdcxPNdKVqjXeANvA/NWCfAeyvtXVzcRxC8uqxGmLPD4NxrSC5wX2cw
         jkhw8PI+DeKxxv2ylGb3bbI+lfadpr/MJ+enQAIDiMUN0hLkkkJo6eOaHNKj+qtJvX2B
         TCTSvrJQOLBbia26J6b6n2fgoMtwis4on8eISI0PTPZzwq4b0oEMLAMrfgRcL1r6Z490
         JmozYUR2QpV1Tq1aiAffXnulewoHF7v38rUDOGQ/bSpoMFLJ6jiKEQ08RaKeQ/S5zqqS
         npjw==
X-Forwarded-Encrypted: i=1; AJvYcCXaZRpxU6N0HcOUJtFab2KX6tPqSrxZ8Vtz14RQGhAPEw4UCaAlGJHvz/B9hSvPEcA7Td3oZ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPHD1zBmAIV9x5n3nkXZOrZjP3EaZ9Xxh3OnaOnXHpKmaWaBp
	nW2Ia/RBeZ5TAFnZHDUu+Zl+Q79uSVglT94ePlssH327ubd16AJDR7G08SKLeMI/1+2NZrTghOM
	YXNp8fJeahl9sqNP7wMKtcEQ0jxeggQYgou4Z/PDZc1g48TR8eymCgtZVHBWZ8g0fymoMRTcObW
	s=
X-Gm-Gg: ASbGncs80tOaskSKl+gYYT741zCHLk/s5S+SiWB2uZJEuuSILWxZuOkJ+fItrGbrklv
	GPbPGfvoi0I468spprbOrlTyR7Z07OQE9oGlxrntLz/khxT9LZunCdfNczW4sdTNbV4cS/YaZ0F
	0ZOkHYRa6RXn4EdFTtryO/r/FdCGD6kswKP/8mEMIbo4oI5eMV4k7XpA0/VMB9Nd6VfzE3M1AkB
	72ouX68Z3rYmRDukQx7kAmkricqXrpaFHmZTAVUItCtgwKl137I+KDF7wl1RE3QdFRJT5cPy4nm
	g0y0H1PemsC1v1Khz8zOcqqkzwsF88lVw0gDbIbw2/u7J3dxMuUOc4kETvOf6BHaYhY2
X-Received: by 2002:ac8:5a48:0:b0:472:789:470d with SMTP id d75a77b69052e-47222944fe7mr10444031cf.36.1740084335002;
        Thu, 20 Feb 2025 12:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQosCl4HAObZR+gD2ypndpi1fkZxJJzZq4SMPEu28yg/MQCOKxm2JLseDQR8qw3CWe7vam+g==
X-Received: by 2002:ac8:5a48:0:b0:472:789:470d with SMTP id d75a77b69052e-47222944fe7mr10443621cf.36.1740084334496;
        Thu, 20 Feb 2025 12:45:34 -0800 (PST)
Received: from [192.168.86.34] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207919e27sm26434451cf.4.2025.02.20.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:45:34 -0800 (PST)
Message-ID: <942770a1-6b62-448f-8210-cc7fee79c6ce@sladewatkins.net>
Date: Thu, 20 Feb 2025 15:45:23 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104545.805660879@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740084336-z8qMpUANkqEd
X-MDID-O:
 us5;ut7;1740084336;z8qMpUANkqEd;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;



On 2/20/2025 5:57 AM, Greg Kroah-Hartman wrote:
> 
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
> 
Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

