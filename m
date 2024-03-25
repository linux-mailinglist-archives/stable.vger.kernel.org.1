Return-Path: <stable+bounces-32255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4A88B0D6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578BD1C62514
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2C3DB9B;
	Mon, 25 Mar 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Qstw1Oc6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D011BC46
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397159; cv=none; b=X09hG6nTYXreU/aAVAvRgeYJrk1o8qyMZg0kVOL+wg3b2fGU2M4Ju3yOZUxl3ZC4DbpUVMy0iBJD6iw0u6uzQsqBwP80ykui+9ogGBd/7qxv/4OcwXP/iCpPBeQaeIvjre6//ej8FcQbCo8xSeQG9dbT5gvl8VwUtVLvAb7W3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397159; c=relaxed/simple;
	bh=UjrUvFUa0XDyVul18UUTRk6viKLJkQaQh7vx2mOVQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu3EwMGGrBIsDDCLqyaLoBeF0+NcOA0v9bcB2HfwxNOTCqIHT3T1+nIpSE5Z2rKj2PN8dY3+Ud7JvCUCKawJH7efEqcX5NYFgzoygAZIp4GE3tvxlEN5nZ5pYtU68ZP2oDTqvSmc+wQUWDs0vHM/Vsje0wagMFK/MFhrgaPkHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Qstw1Oc6; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21e45ece781so3142879fac.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1711397156; x=1712001956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s4wc3i/rfC3/kxPVkBRBN3/JL52yC7W1Cjubckw3aI=;
        b=Qstw1Oc6PeGe7QTXrkhKhbfHA/q8M3FNDYbOEOPwiwUBvwAgOdHeljJUGVkgeor2YD
         TGf6MEaDWhhhpZgLVaOYrieSDF2c6qjDKdhsVYO27aMZzmAYaRLEO/OKc5o/7WbIhnfr
         iT0quJTZ9rPRKyxDVZCPEsqork5YDfAtVT60Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397156; x=1712001956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s4wc3i/rfC3/kxPVkBRBN3/JL52yC7W1Cjubckw3aI=;
        b=hnSs7nxrK5zlZgznK1Zgt7nO64cemwhtN6QHfwpRFTPmHhmVVKnCAyGRZzN0kDtuDT
         WuWJQQdDlTMUqAE9etJYRZ/ohj8dDJbdUEDE0NgP5+HpEuU6xYKQOocNRJWieuBWQQCY
         GvMylxzf0Zzi4mmb4dN85pV9L9Cj7zlxhQD48jF6Yc+ySPLPmQxl/aw0ZnZSyXBvIrQI
         5DBMjhyle8d50dY3a/QZYh/LTUPyuIUkSH/P83GEflFtmGXChylRkKw1XGMfuMAcItOo
         jIIj6qczCn33jUAprhqD5aBmyBfRHKtymjvfU7vscQCu4HLFyAUQ5yujqDOef8FwQ+cr
         ixCg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQVECzR5wXTxSEX/UlMuBquQd6KO/ZdSMi2rXEve8jYmBs8lK9FjUa4Y/LsKeHia97ByN3F87PqW0iLmZDrIrQMXbLobU
X-Gm-Message-State: AOJu0YwTSYV3ZNPFyNfsrKkcjSOaMn+dhNCUSgVME++EGuNBKqZlU9yy
	ARh2sbmxxZ+cgWBGl9ENOPXyopYz5xiuQL5QalsE2I6BJOhquQuE/u9kYXLXIg==
X-Google-Smtp-Source: AGHT+IEz2C6ZNyFMQGJcw/HWcHLsyuzCTD2CcJ7kx+2L35Lrd7WJVLF0L9DJWnDMbuCXNFX6SJqKrw==
X-Received: by 2002:a05:6870:55cd:b0:229:fd96:1e40 with SMTP id qk13-20020a05687055cd00b00229fd961e40mr9859382oac.44.1711397156561;
        Mon, 25 Mar 2024 13:05:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id pn17-20020a0568704d1100b0022a56a9dc6csm246922oab.10.2024.03.25.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:05:56 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 25 Mar 2024 15:05:54 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <ZgHZIpmQ5pWcrG-h@fedora64.linuxtx.org>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>

On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

