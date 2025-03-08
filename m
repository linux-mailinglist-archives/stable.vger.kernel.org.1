Return-Path: <stable+bounces-121544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E820A57B7F
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC303B049E
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCD4BA49;
	Sat,  8 Mar 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep280HGq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE84D8CE;
	Sat,  8 Mar 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446937; cv=none; b=R8qPROPr+hSlUX4rvtJXj1+2wrFW8rT4SVJeVqFW6084BR0WCFN5WHSqW+tqWaYIaibSnP7SWn0CTvhmbYTg3dLxmqholoxASNvPDU8QLyrqeuNVlsMjDQmsLNNSLoH3GkCf2DYNucy+QgvdGMrjMni2GNpdPHyq1dfX+n2sZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446937; c=relaxed/simple;
	bh=AgKij9icPxUHdQ7wp2XVGsyE9+Y8y2YtloBCQAhf6fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDK+0MF8AxDUMJtS3TZvWHhWgK5Af9V4Ew/4NXZsuR3/0hKJKeHMX9/PV3Kpq4eTK8Bkts/Hfz5mNNM+DzP3GG8oN7FH84MwTBEcSYJ+c/zBs9Hh9D7bJXE7j7okiBRo2MxEf+Iz51wlevAXATKCrngsK7r9QDI727whrxr19p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep280HGq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22398e09e39so51573125ad.3;
        Sat, 08 Mar 2025 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741446935; x=1742051735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxE7kN91mnx/dnYRUE3PA94yocIq8DjPSrJ2/CcwosU=;
        b=Ep280HGqPCMfdUpTxW7YUu2Pm43//O9odw5v5zMVeLLm0VCpGFeKHmf+5WC78jpZ0o
         quGEjOWYyuiW6HkAN0XLDDgTT7G5whtMF7w7TZpnT6algBkT3WfeASfmXhc+3059k2/k
         5Dc0S6zdkYAImNScJtIcJ6vG7caHtUhSpYQa/TU32R9rgN2DclJDqEPX8yoY25vcZP6H
         w49C2ksZkAuif4I7SMgGlqdM5XF1eESUn5ppx2QsK4xM23fI68han9G9LjUhFxPqZqs5
         ydIBNnJ7FPz41+/SUa80hBmsVGHvHqcenpBApTkkCrExbmhaFoxHcGvSdHTBQIxmzOZC
         i2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446935; x=1742051735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxE7kN91mnx/dnYRUE3PA94yocIq8DjPSrJ2/CcwosU=;
        b=obnkZkdCqq4tCh3x2miM/ofvi8D0TITJEnSa4YPXYxC3ozBZ+VliqgthSCaHdQlTKe
         dK0EszAiPSsBnWD0TE6+ziWzzwNalXaVXDQwS8fZ4uHJ1iyQ0EiVMn3XIW+IbYpNRhZX
         BXdmXmmSqMkNJXnYKMVyTd6zBR7yCf1h1z1JiurXBHXzseT6TdrUK4sRwjJsceuIcAoh
         jSnpDdSiH5lC6qWuLR49AZTZ4YNgPfbUzT+sRPTuRbkfUedqcz5/W8Jzux/l/bgpzMir
         9NdfEUc+zfQ+IOE+HAianDYmeexcxF+IUOReUiBogGTtI5ZqjsZCya4oGU7BB/5cEwdr
         iULQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6kmJFgmvREGNxYuBqm8R3u2SP5QRjRzrcsgK4LxfBraxMRF7ZmQ9SEG+dSUsLZNJxlHl3UeN6H12AZlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6TXSKu9sOx5z2QKsFXp5FBLV7T8XkVTS+QXyEytGguPbLYZX
	lC7xZZW31TNS1pVzFyQ0R1yN95sEKKrjv/zsmSobT03EukM6sBeeZrTF4Q==
X-Gm-Gg: ASbGncsoWSpypP09B35d9VukazlY6OOV2EdHE8WLTzXgXXzSNkmRC+HymxJ/RTrd8vC
	6ICKagkXGS14fe1o+fX72EpxSXtO4M2Dp4R8h5EJKqsBIHLXyXfsPrk/ZErBDwUQrDqSy81rB1O
	T8BhBLZ2fxO7fpeo/AQsn6bmsiTeIBn0LBmRShGlhF/GwgHG85cwL7wUM1S/8gEVip39nTRcPiE
	MNij4EU97rvE4HO/qL74RlDafL2Gzs7Uw2lUyryr7Dbmi3bk8kng/4oPx9BH9MnvuyeyKS81vu6
	g4yQMAzi5bmL1NFWMGbLE45B3hZVpFz7PzQWXplKW9yXQBynm8tjevBWQg==
X-Google-Smtp-Source: AGHT+IGiXzCA206tUytfYMPn7EP+aqEfLAeC1T0h8hyqwwHJG1dER7GMyHIxzmAh9tnrtjt142Mbfg==
X-Received: by 2002:a17:903:1c1:b0:224:1001:6787 with SMTP id d9443c01a7336-2242888665fmr97038475ad.4.1741446935414;
        Sat, 08 Mar 2025 07:15:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfbcsm47942015ad.21.2025.03.08.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:15:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 8 Mar 2025 07:15:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
Message-ID: <1c813c9d-de04-487c-a350-13577dbdd881@roeck-us.net>
References: <20250306151415.047855127@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>

On Thu, Mar 06, 2025 at 04:20:53PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
v6.12.18:

Building loongarch:defconfig ... failed
--------------
Error log:
In file included from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/current.h:6,
                 from ./arch/loongarch/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from arch/loongarch/kernel/asm-offsets.c:8:
include/linux/thread_info.h: In function 'check_copy_size':
arch/loongarch/include/asm/bug.h:47:9: error: implicit declaration of function 'annotate_reachable'

This is not surprising:

$ git grep annotate_reachable
arch/loongarch/include/asm/bug.h:       annotate_reachable();

Caused by 2cfd0e5084e3 ("objtool: Remove annotate_{,un}reachable()").

Guenter

