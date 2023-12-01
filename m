Return-Path: <stable+bounces-3678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041BE801477
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 21:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8851F20FE2
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F4D135;
	Fri,  1 Dec 2023 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRo/W9Mu"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77892F1;
	Fri,  1 Dec 2023 12:30:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b85dcecc62so642365b6e.2;
        Fri, 01 Dec 2023 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701462639; x=1702067439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSNkEbO59JbGnp/vwzQCHoFhC4gr49WpvluGhevEYM4=;
        b=RRo/W9MuKU3MrUhmRpFWT5odIrP+9jMRoe+Y0+V5gQTcPoNZrOJ3lKIItlZ1slkUEe
         Uh9PHShzVBagxnn3xrzkk0TC2eeNQc2edOHcYXIl0s0N4MUzG2YTYnoE/nuecn6hgBGs
         ReKlzuWyZIukwhpmAHAMgMYD8V9eya5iHgqcWsw9SMupkCBg2BClyJzs/hKEhKRS3OUA
         a2a/4IrrI++RutLtiEIH0W/aqt339JDLx1OMpuN4um8+zS+BGen1ihuiKZr17rYOhHGC
         oYvzJShiNu1sPh08D3TmiG8WibMapGLrl4BvnZObP4m6J8wu8zwMlVjEF2tOEWG1usa1
         R3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462639; x=1702067439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSNkEbO59JbGnp/vwzQCHoFhC4gr49WpvluGhevEYM4=;
        b=Vjr+rbsuvEM4V3LwXsaklRreX5hkFn1iUhfuQdigDGN3KShLNgbAdYRTkl18HB2zPe
         nc2pjRDyalNz/9I3okBXtF39pq2/UyWsodh5DIRfvHHgiZrDSog7dlsH3roETrgimCNX
         xBkHbhL7i0ZrGvjRH+LMCD07RbVKV/DIsdwlh2OJTbEOgtGp1cPdSU2ZAL4BcmU9OWxn
         +AxV4iUYNng0VsTU+G+DejYJDAlaRoQm1QBaqrDCttkrJJHTMYQeZ+sw3rn2Zh2izctQ
         +l3tdHXlrMbt3XlTL3+3tBdleG3ZrkrOqrsutoTiHsJjzo9LJsSWm7Q1Z2XjRR/d9ucu
         PmxA==
X-Gm-Message-State: AOJu0YzER0KXw70ITDsJc3sRtm1CSRRve+M8NM/H5d+GNXCB2ATT4D0G
	S7g1cX8G1yZtM8QkEqgeOkQ=
X-Google-Smtp-Source: AGHT+IGijPbQuKFYuomb5cF+98CpQViKpIWZTL5F4i3MfDxOqbbkRIpyZRT9uKkGDWvEIDxDAlNHaA==
X-Received: by 2002:a05:6871:878a:b0:1fa:bd0d:34a9 with SMTP id td10-20020a056871878a00b001fabd0d34a9mr126893oab.44.1701462638722;
        Fri, 01 Dec 2023 12:30:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu18-20020a0568705d9200b001fa8b2d3212sm987258oab.1.2023.12.01.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:30:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Dec 2023 12:30:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
Message-ID: <915b6a33-77e7-493d-ba91-0c93a0e7bcf6@roeck-us.net>
References: <20231130162135.977485944@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>

On Thu, Nov 30, 2023 at 04:21:31PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

