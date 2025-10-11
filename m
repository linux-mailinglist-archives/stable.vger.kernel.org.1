Return-Path: <stable+bounces-184088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77225BCFC77
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 21:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADD034E3165
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 19:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3827F011;
	Sat, 11 Oct 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IDd3EwUn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E922B8A9
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212789; cv=none; b=mm7k/T9ZdTcwAHvf1TYGjc5wxys8hM66HxICxmhdfoGDIoRGoDFZa+lk792s8MwyipaaRMwzpXbIW4C/zTBOycRwBiVcfZX0GQhOpXOAgQIOg1ZL8A1xAtUXFrWSCnVAZTyr6XgAxPvTHfM1hgxMPr/8MeSAtwk9Uk2Fi99khJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212789; c=relaxed/simple;
	bh=2lHRYVWmcVWSysoBoWl9aOWZYULNsZ3wQbmkF5c/a1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LABiUmzkCWeK/+j6za5FxEylQSfWwxH7LFwWCn/w2MH3FlRUYjhQKLnKplw8guGIctgZjfYr+U0oSCiHZxk1SJACpisE2pC+Z/o3njGUuMC/7yNnfn1+WSeL0UNAWWmdQF/RhDRl+Ld7OQm6ET94qlF0M2hxhRnJbDMRy6gVkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IDd3EwUn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so30374875e9.2
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760212786; x=1760817586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2OqNKzJJPyV02v9bwdmUrRUvp/37eP/f4LyUk+OuKQ=;
        b=IDd3EwUn9PnZy0N0w83UmjYyD5oFj9/29s5NjFNLLOwGd6mbkKJJ9Z1bVV1y/uA6mb
         6VDGNbx7WmFMaXd4AulvCGlujbim2cwcty+i0n+AxzRQHxdckdqha2w9X3MxTfeKd3vo
         YoXk21bd7KZ1rYdbjZzW+f5AL3TmhMu6IUxUpXtdevGHPl4eBptMYlMGWhxH239HQ5zf
         wgKfsixw7x+TWRRMLPH0ODweY5waLEmz4uF1bz1L6ByRHQ/h1HkBpqhfVXlSikhpb7me
         pAanMmEzQHjNKOXz4HW4Ikusn7EuuRJX7CnmXShNLLeBw4zz+VU8muSMjF+JeE3wUhYH
         f1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760212786; x=1760817586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2OqNKzJJPyV02v9bwdmUrRUvp/37eP/f4LyUk+OuKQ=;
        b=KuZXXYg5nDB+NYm5AhNizQr7auJJ+rijX3LmO/jbrKwaeUuYPdE1AHBPukhbx/BtTw
         25k2hT+ZjqEsLYs6o92a2J65m1D/mNayjp8hdBUN5K3LApZwwOCW1iHo4VpgwR2gt6o0
         4hK5aCkALBH/O1OWo81OvWjH4HWntwqbi3nR0zBwzKpAT49KKCDABNDAV+VcGv09amW+
         bylYs93MsdJwYNTlPLRBITzrgmjnSzaBs+2gVA2SZW+L5sOIxKYcdJtyEw3cc2mDase9
         PXjJkv3cdgbeO4YWbR/748sfCWXotNp1qsTeixtXC0BrQaKz4WonkSyrx7FUrNugTGE2
         jCMA==
X-Forwarded-Encrypted: i=1; AJvYcCXZKEHgYq4KSzptfXcYTk11VKYMJzSORTVIWH4GcJnP1EiULc6Zpr8WzfSo9WLrUW9He8bn8P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibC7AcSqm52gt5SK9NnozFEvlekrL3PPqC7Fsjw2iwWtCH9Mz
	LZF199WiZzRfsmr2035agOTr8v6WRap/jmP1okMnX8ADyCCgULoap7M=
X-Gm-Gg: ASbGncs2mOxYH1g6dNlYTu2b1sYEswS/l54F9bUlvs9dEKnMMaK4Al0zsBuJIsjHbKs
	sTLoZUbR7NeYlDiHhC6MEix+SqL5pzuEX5il2xImmZNKMINOkpm58UhxCSi3cZbm6Ea6DgGikVW
	78xD9aXIOqP2uwcVYa6n0CKmS7j0HRbiEe+Tg34ZA9/HkUj9/zqDuwiLwi5qWa521HVKf7UdgLo
	tF2tysDtOLZbWEsyUA4Sqt3vI75NOQJWh351XQvsEWO0WFZQwNi326Q7tMwv4aDeEYwchvnxLIe
	FoPgrBVOfCHpRd4RcwsawhHc0NTyf3AAQBYIpbU1HI/Fw/XJBt0RCbAeAM61ZYTi6eKxgKRD5eY
	Ws9MU0tzXDq9DA5zrDmTvT+Acg2M/ZpzBwJFk3M8vHSptf9+fHeN1dj+eOg4ddYtVKUDsL9D7fu
	LjXOG2t2YbhYU82zZySg==
X-Google-Smtp-Source: AGHT+IHATtuXnAGJzKPrto5w7FXLH1pjsg8T5P+0eV6cqbcItIaIBiVsfIoq+NMulMphpPCEyhbgdQ==
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr119291375e9.34.1760212785726;
        Sat, 11 Oct 2025 12:59:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm9843873f8f.27.2025.10.11.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 12:59:45 -0700 (PDT)
Message-ID: <486e2f64-d522-4b63-a029-d72138207e93@googlemail.com>
Date: Sat, 11 Oct 2025 21:59:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131331.785281312@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:16 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

