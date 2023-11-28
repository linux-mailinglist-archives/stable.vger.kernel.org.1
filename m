Return-Path: <stable+bounces-2853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E07FB040
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 03:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A5281BF0
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67F5685;
	Tue, 28 Nov 2023 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLMOWWSL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A61A3;
	Mon, 27 Nov 2023 18:55:11 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b843fea0dfso2976213b6e.3;
        Mon, 27 Nov 2023 18:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140110; x=1701744910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp7jSBC47fByZPGqr9EnpWb3tiu6l+5NeCMTHc/fUb8=;
        b=hLMOWWSL4sx6w9uiCHj4Pk32/FNHY/ZM6ljtC3d8iNimROBb8aOaPI5yIHbaGkOJ7a
         boKyNJZWXBj9MUXwUJvpUcbg7Yi6BFGyx/Q2NQ2QhhAylvCZx9ugZyEnastwXQcnVRbV
         k8KKoteyD8CoZpOEFLyp0BPGFgCmz9aMPKr0DavgM2x6Z9n331F8C7iib1PhD6wSVV/B
         7kAmQ+JDzMK69/e2lUQ+CZii/QfGalp8860mR2xRpHIvnskdQ/JlWX5ew6RwVrLcTgwj
         4Ny3ZecEmtHgpSa9LXDZdW88Mxo88U71TeobXXbMLJaxyFtXP4nWaAMst/CVLowfWHnB
         45tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140110; x=1701744910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp7jSBC47fByZPGqr9EnpWb3tiu6l+5NeCMTHc/fUb8=;
        b=WINQZyP09OYOjJI7nCS3uqc9NGEktXude5a6ZzkpmkFYsjcg6ROBTMGcAseadpP4KB
         eFiphq4PdwFZ3eFqsMf/mTA3s//aGATU79qsbyg9qdAPghZ83qP7pxZ1C8eQbQMVwpVZ
         KaNwgCmmSKtw8TKt46J9z44K9ceLS1GVGdqMJvlPxsFiKeQf1GBAE8QCvxilUqWX0/Fm
         fYC0rVJ97EOyt6MVd6uSJi8szmF5XmWtMJxWbuD+8UiEETwlJ31yjlH7qMOvTljyq1fs
         +9JdWRysINDx7DMueHhZbrmvZreEz07XgF+8hx9G/u/tLZ0IKLeIl00rjeB9NDVu/UDS
         7csw==
X-Gm-Message-State: AOJu0YzqwFW0RrModhCg0zcy7boYF/by8+36crSgbRxNmfgG3dIpYtaC
	CfXr+sML5MrwVw2TjyKBaRg=
X-Google-Smtp-Source: AGHT+IHDA2R8rulOPMAOxsdEnIk3WJRN0edoR9iYypeCY58pkBvNjGmIFmkgLYaa30fHO9NPbr9gLg==
X-Received: by 2002:a05:6808:494:b0:3b8:4614:8b27 with SMTP id z20-20020a056808049400b003b846148b27mr15019973oid.50.1701140110712;
        Mon, 27 Nov 2023 18:55:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bx17-20020a0568081b1100b003ae165739bbsm1693498oib.7.2023.11.27.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:55:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 27 Nov 2023 18:55:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <5ce1915f-45f4-4191-8f3c-c58bed478beb@roeck-us.net>
References: <20231126154418.032283745@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v6.6.2-526-g0f3bc3a11114:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

