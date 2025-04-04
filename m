Return-Path: <stable+bounces-128351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933B8A7C59E
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 23:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C85A3B97EE
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812021859F;
	Fri,  4 Apr 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="A5WYs1qO"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B571F12E7
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802721; cv=none; b=EwqMCqyI3GSne8pW1FoPoBeKBCyjfXTV63RMrf752cpeAAzr4jeNGSLQskFeJasQmj7aELuwvwCJoTPh/E/uoIENHbtEAlcPFTJEEtm7O4csdUazhkeE/zHh/8ELRgjnaKH1Ila5TW3uqtAak8kuzQwc0UtG1L58s5xB1OCDoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802721; c=relaxed/simple;
	bh=oeXi/OWda2xxmVGM4W74nFEsM/hWSjUkr3LPxXiu/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in0XqrUSyLoekCV0xH/3yB5LapqBxU2Sb+sGYG/EX2AiLuFBYFEENBZRSwK59YqEuSnlsa2bQun5tbs+mzc7kP+Woo7A5wBH11d0YpW9Ku8I17Q65qSkYsC8+ELVCg8RsqHiPTRdmyeor5P8X1tq4DYj2Ce6cl3qYRkMJ+lpfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=A5WYs1qO; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d6e11cd7e2so12782665ab.3
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1743802719; x=1744407519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MvC/cEhqDtGi3cYQt3IC4fUmaaxTciOdN9PYiIFKME=;
        b=A5WYs1qO4tQzOHX3i/eZCHPv1GpEYRC4IMVDMIq/CjczPOtJ9OP2vg1m+5P+8U5hKh
         0ggVWWNih63b6KTH82TLLg/1Kp+elQmaK48+iQhwAKAhzo2PASL48AFSB0mX1d67Djxk
         ZvSxmB1gLLHtlloA0+OqyDFb6h3EzhfgXZvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743802719; x=1744407519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MvC/cEhqDtGi3cYQt3IC4fUmaaxTciOdN9PYiIFKME=;
        b=M0adD17U/SErEQk+b/JiRjS9I+Apj0MQlngW4iUTmIl+Yqn4L8sS0AV7R5sWdMYJSq
         78dQUNf+oJxzYM4hsYQkkifur/STBZQjwJi5uYBrULtDlKyKtZ6wsygk1UpVvy67Z24e
         TKFmhN6SmspIOFsYHn6TcxR4OkBcVjIIEJ2V/JCCQ6beQGSgXd6zEFN1K6aax9O03b/A
         OwJn+OhwbLVs4uw7d36vVCF0J7XkKWpmFDnj9W+L/Z/G5bIoB7J6aMu8xWcT8spnbOTp
         DkaKoP0+pB8mzUtlTZVBIoPvDuk3szZykZ/oKH+1kFGL/Y5yRopy/DMv4hZBHs0Ag1i9
         p+FA==
X-Gm-Message-State: AOJu0YyOV/RMuHaeIl70+BNjOzxht1DahxAtF5YzqcdPRm3ze50wfpAy
	Y2KsX9JZw7esKCI41OJ6YgKGy96mwGKWfo+4j2BmatVuK20DtAXGIWVyPOnegA==
X-Gm-Gg: ASbGncsHBGus1z2YrJ/YoZGhpI4RpgF2l1nkK+Zu6R+FKGDieoLRulmJP8ZryL97fwC
	ijzajdn3iBVYmyQjN4QKG6Mo7UxFeW/5qZxvodEONlgpA3S9yUrqiyd9ptAll5Tk4S0Xm23dWvY
	IOtsMDnew/UMshiZBzNERgLTe30WXzpbQHRn05vqGUBcr2ze5/72akH1k3esVByobcYsGCUObwZ
	i0p1uiIEEwzLCmoYM7YRDVaelx2MwMHXUZhQYqEgTH1rlJ/cQWZ4qKe7q3KXLsnHz8ExE2MPDrv
	wo58s4ZaCxew8RbUwFm8HFRFKc1FAekupiXS9vqRU++0bCAgZRPGKK0BdFEc+Q==
X-Google-Smtp-Source: AGHT+IGB/Y1HSkOpJ2q0nvYfvc7mtN57agU2hn090g/NK0jiNIWgsZVZqVAQkC06/3IHoq7MmS2hCA==
X-Received: by 2002:a05:6e02:3389:b0:3d3:d4f0:271d with SMTP id e9e14a558f8ab-3d6ec5446bamr13709135ab.12.1743802719037;
        Fri, 04 Apr 2025 14:38:39 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de7b8828sm9984355ab.18.2025.04.04.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 14:38:38 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 4 Apr 2025 15:38:36 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
Message-ID: <Z_BRXGxg6McB2M_c@fedora64.linuxtx.org>
References: <20250403151621.130541515@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>

On Thu, Apr 03, 2025 at 04:20:04PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

