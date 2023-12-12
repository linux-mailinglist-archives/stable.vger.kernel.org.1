Return-Path: <stable+bounces-6476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B13280F3E0
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EFE2813B6
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF447B3B7;
	Tue, 12 Dec 2023 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/+XMRf7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96D8F;
	Tue, 12 Dec 2023 09:00:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6da2e360861so185374a34.1;
        Tue, 12 Dec 2023 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400456; x=1703005256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8DPcbxgddFzyx98HpwcBqWBaG444HnxJOTuiHjDE8g=;
        b=M/+XMRf7TE7HtQ1pwb9Che19BGeFQ/UshnUEMKjOgKUfU1hGPZYlo4AIDeQ85rX1eo
         ohT8Z+6UbV0XFcRyVKIUo8mjEzNByU7nDy3usrQMh8ch1/wOzu6naUFXlLU+Gu3DCAYu
         Ndl0+tETAR4OV7uhrBkAk8FiZLdnwQzkgn8DIMj6BOKbVmm/QQeUiz3wi251lpPrvi81
         pVx/XVqJltQjjfAp+UU+mPgjstTyNls/OtgdSvbnLeRtcljnNTC96BXh9ZDoi3HOFes3
         bizp65aiQoUfKegywt1Iix1LcRtgovmEtZp96szz9YtYobey9FM07l5eVMFD09nlclQX
         S5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400456; x=1703005256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8DPcbxgddFzyx98HpwcBqWBaG444HnxJOTuiHjDE8g=;
        b=Q8e4CV0duY9sMriGpx+T/ZYBc9qg/bZ70NWNvbef0DGhxnfnM2Mqu+QCY5tnC/xkLy
         xuul+lZrRmRZJdAjD9+BS1UWXW+YMlbrirLat3+hinYNySagi2a7ZslwYSSqiS0j8tI8
         B7JhHKoJXBW8OIGbgn7Pi3ErIZKF27cjW038aZbsfdtTzwOm18dNTj8OwN+riZFX1l79
         +1XM4/aih5yDI+V6ZZdTEZq1Rwh5b+uF8kGE3EtaSN3L0JifPY5qL0i4J3bh7CcIy5OF
         RZ6z38D0dnZ6C2iDtKP9Of5o+ERHqCQjlUWToVu2rXeClf4W1AB4G82ZDexUEa+Uiap1
         iTtw==
X-Gm-Message-State: AOJu0YwqglDiIkuOjIH+7v7VFkeArem8HuFNt5O0lg6nTp33Hn0mRgIG
	ulTfbTYwYxKkeWD44SFRVTk=
X-Google-Smtp-Source: AGHT+IEnWzRUimBTu2VT9179iW9r74HE/QVAYtF1FST/1iY23TTgMz1NgfRUE9NbKfeMxUeRx5fbIw==
X-Received: by 2002:a05:6870:d185:b0:1fb:788:e8b4 with SMTP id a5-20020a056870d18500b001fb0788e8b4mr3311007oac.47.1702400455786;
        Tue, 12 Dec 2023 09:00:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mm3-20020a056871728300b001fb05cf9dfdsm3282252oac.19.2023.12.12.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:00:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Dec 2023 09:00:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
Message-ID: <4d4ebe9e-9187-451f-bc6c-c8e11a66dc7a@roeck-us.net>
References: <20231211182015.049134368@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>

On Mon, Dec 11, 2023 at 07:21:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

