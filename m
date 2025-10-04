Return-Path: <stable+bounces-183356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5220BB887F
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010534ED020
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76293217F33;
	Sat,  4 Oct 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="aJesmHI8"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD620B7EE
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545662; cv=none; b=PbpLxCYjFxp0l/bPHb886bLNYMUOBlpIWxUVhhelg+ihQYe6y+kRI4ohsELjkuMqdrPRiHHcZdDORJyOqm5/u274GGts2JHct7YLqvUyWsqiCYijgcitsZzTU8A+kftZYEdTfMzIYVmJQZ0tfL+VoV0t1ydoiZTykDX5q1mjSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545662; c=relaxed/simple;
	bh=W47sKkfwYs2RK7IYeiEtev4+DLhj5IvN+P8eDuSZFjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVBrXzX2fcPHJgRGfcZ4nENqJtM+y9iB3drq0+cf5tOpx83bHbRqxMerLu09wKTFzKfPygo+OdlNE5RKUeyMW4VE0OYeBhjewnSGJZWlHs1pypfvMHkstAYUIgPi5SpPrmAckddNeYcLSsOI9eaAIQctx6ryjRoji4ZiWQS9mR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=aJesmHI8; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-938c85ccabcso123648039f.0
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759545658; x=1760150458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNDR8b2qncZl91XQkWHfWG4VDM9E/GJQEK5T5WnHqN4=;
        b=aJesmHI8tgVxwlhooTm8Jv/QSwbIXxCn5IOfE6LyRGKpMk+kfZpMs4XfB+JdHAP3wC
         pb0CdW8pL1mEV41OvHTataM7PLBu2SVmVQ291Dn51MoJKs8PmJ9WmtG4ZNb2/wBpGCG+
         DNcBBhh+z6+JAomE40/kHyGgD0jkaq6p3h88w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759545658; x=1760150458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNDR8b2qncZl91XQkWHfWG4VDM9E/GJQEK5T5WnHqN4=;
        b=igb1/GpEM3l2EJDhDqD8TzLJbTa+HD5yUuu5oH3GZPBndYpGaOw2WirIkBFEztN/dF
         sNWNQHNh7bU+5dQantmeg5mNPdTbv2LPUOfdySllWSM1LtFry7lSZ1S/Xc6ZaJbLDiW7
         5soTfSfbKfnCslwY67UfXfbcTMYUr/NGfcEJBGirM7QC5tuNW1eEU3UUlvoFefgZxe75
         nDQTO7uSlsfwdE1HsvzkpA8KbCqb/tcaV5Ic4zR4AUqT/nI4DLWg0VFzHoPxDL43OwBz
         skC6hK3knL6JPnEZH1mAlHgYghJB8dYpoExfwRt151190/TP/gqffIte7ZlE5mL0cZPS
         y+9g==
X-Gm-Message-State: AOJu0Yzje/Fi4mHmv3nzYgjI5EjoxfeyaNkniaxz+40swUP96vDIOgpp
	t7PXAdtNh8pALzu1TSYL71ZNbXKOBSYNguVPUPootInA0oVb5md+xd29K73xBiP1gA==
X-Gm-Gg: ASbGncvBlr9X7TKbcp8YgikQzh+nlprciGmdHbaiBed+hvREbjzCx0VzdMB4tI23Sph
	cZF6KKRhTYuAHqQtjG+3fK17v5vtMUmeFQyFcLN8Mwyi6rJwEfs7qn60aQUdzDtP2/HfF2OyHJM
	+7w/P7gPCdCLQNOokOhbsF2dyFYqo8pq6NIXSBg7XyNQnZdkpo8XroOYN8fovLavHMbwB1vvjc/
	pZhwO6hiIOF6VJvuqXGUlIU9h4b/jaeOHQNPC2HGTATNTUKjRKg91VYrd8nXXGA5ZPuKo3ZIK+B
	G3Ug598Ek/pZMYkCJYRLKAUL30CzSEVvNvsQiD2yBayuNf6XP57woyzVy6Hg2q7Err3qHKhE+UA
	5LNHcxwW/O+4GtNDOMYizcMVaFLcFlXJeEoAtp45lsx0JklcuAvw3GykMRxs75HCi7NGKHXZkRH
	+1q8E=
X-Google-Smtp-Source: AGHT+IFHbwBHFB4PEkKMKRHhUg29okZRl+OIlTXfFCdU/4WLStieBeO2P6W3jg9StbjK+Hp27/Vlwg==
X-Received: by 2002:a5d:81d4:0:b0:8a9:4e94:704 with SMTP id ca18e2360f4ac-93a666de022mr877468039f.3.1759545658318;
        Fri, 03 Oct 2025 19:40:58 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.126.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec07d04sm2516067173.54.2025.10.03.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 19:40:58 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 3 Oct 2025 20:40:55 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
Message-ID: <aOCJN3i65NH_C2T-@fedora64.linuxtx.org>
References: <20251003160359.831046052@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>

On Fri, Oct 03, 2025 at 06:05:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

