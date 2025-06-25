Return-Path: <stable+bounces-158559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19BAE84BD
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F457163CDB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3F262FC2;
	Wed, 25 Jun 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WN+eRMrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9F2609FA
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858174; cv=none; b=r6hIa1VceQiV9X88JEz3YDYTql42hDS3wghw7GE+9b+V33ZJ2t4IetO7PtOPkpq02G3PL+CuiMje75z2kiFmAdB4dyTfVC1QwAAEyolR4nF1uosjThZEeVigGI61E6DaZbJuaKcYQPTSoduzBsLGfQo0B1WZGVghALxUHlmtRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858174; c=relaxed/simple;
	bh=HI9la2QsxuOizkMwcoaS1bXXDpyUXSLfDzTpd/RFD+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHJVkaPvEmVnd6SWJp98/WPY2FNu67rst1Tfe3Q1hkpxzC3vK58kOW2Pn8r1sTDaZFxacafAum76OSXn3+N1CgLjVnQGBA/IXNpu+t2HCs/L2zzHkXMwst1JuJzT1tFQ3Fr8zRNHa8lCOyc1eU2znlI6kDbTfU6NN64TCNxHpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WN+eRMrG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-408d7e2ad03so4617344b6e.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1750858171; x=1751462971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeGY/v5lQOSYimAG1TJEUl7+krFvp4WYJspcjdIjkl8=;
        b=WN+eRMrGwwCcIAydMuFPIFjXEl9mkWdRzyB31DIdtiZNHiFVHS36+Z5Tx659Bz/Vaf
         qlOKXtU8O3U0sD0dMCBSGGVo9QdsB1B69PSGfvNB2G03f+A3aWnoyGJxzYd3q/MQEcmR
         hH3/QIB5ShkRQ81mA4ZSEXWcDxLXAOabee0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858171; x=1751462971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeGY/v5lQOSYimAG1TJEUl7+krFvp4WYJspcjdIjkl8=;
        b=pdniz/hGPvLxz/8YXi3QRC9zNHjn7NTV960t3kOInO/p5vGVROI3ceWaMVKu4Vh4W8
         A8mlKJxt8A/W+gZKaNsyjg9TGcU/koKvN54uSlgeStmYn3ZsZDbW7dJ4q5COCxlJadjb
         7HTd9E6HrDPXOG4GgWs7A0hXIlzF33A4nupWwSRLoWeXlN1FT3PsenClx52rjxl4rv3b
         oA7AWKHH3MYJBY56DV88KNzjSk5bQREtuW6juRXx/9OSfw58SZyeTaAnU+qBUglKT6oc
         45OaaxTFplzSWK9w08/pT9gQyK9GOAXd1g9IRDA+OGgZIaBO5Hu8deIU5PQTilWzg6VZ
         jFsw==
X-Gm-Message-State: AOJu0YytLrPfLolhEtiBq8eeAsIwr16S2s+wa2ghAsf4ysfHKOnYZaEz
	R4ZRka1FQA3TlyO2rWcT/SkaQ/24ILL8NP5nGAqJP0xMJ5TiXxSgn7OwofqNIj1jpQ==
X-Gm-Gg: ASbGncuQthjaoKj70Ml33/TEolctcvKqkR3vmTfu5p9c/Xmsh0PqBifOl0+NnAekH8k
	AgVAA1r+Ch+jUKO17ITc7u9dLc6MdUHO+tLEaAmrUxN3xz339Y6c58mvotrTkPtrNN5/Pkb6S3x
	iKqSmh9rM0zaaEcPe5DPVblXkHDu75CtPdjMf/M9kipmjO/Tbij8Yfj51jFB7LyEMKzugSFiK9o
	5MKAxOuQ0XHPfGlRNDjw72iPH05ovu0Jk6Omym2HfQBYjPrzcxgXlemetAGkk+Wcy93Ka2onzSS
	G5jloMT0xaaSb5H6H+9aR5gfgD4Jsk2e/w7o+axVObJNOGvdEvtYYo8cHO5TfFrTDPjXBh/8Asf
	bDgA=
X-Google-Smtp-Source: AGHT+IG2FI1jDRFQ8TbABRF9Bhv3qaEH5qecJjomLNpJZJ+9FLbz0XOtMMk41w+LNPolSsQ/Q935Kg==
X-Received: by 2002:a05:6808:640f:b0:401:e8b5:4e4a with SMTP id 5614622812f47-40b0572241cmr2882440b6e.1.1750858171060;
        Wed, 25 Jun 2025 06:29:31 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6c13330sm2150599b6e.4.2025.06.25.06.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:29:30 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 25 Jun 2025 07:29:28 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
Message-ID: <aFv5uPHCceTAbx9I@fedora64.linuxtx.org>
References: <20250624121449.136416081@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>

On Tue, Jun 24, 2025 at 01:30:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

