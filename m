Return-Path: <stable+bounces-2851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4F7FB03A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 03:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75ED281C24
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2E5682;
	Tue, 28 Nov 2023 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSvwBhKd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2061AE;
	Mon, 27 Nov 2023 18:53:53 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fa1ec476f1so1836509fac.2;
        Mon, 27 Nov 2023 18:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140033; x=1701744833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLLWv5heZEhgKjwCSN7z2+gMmcOBqEVERQWxP5YYCuA=;
        b=cSvwBhKdPlGIhRpCPpLPI6CjnhJOQVxLjHCCJn/qFiLyOIHzjLuNLkBRji4sT14FL8
         4K3lG5PEgOUq3U5unmOwJ49uK5c/TNxR7siFelqFUw2bi/IDrQhXL1bNf+278nUBpchB
         l0LCTvLRbag9tQJlGBGMSo5Cm1UnprERrn+x5yxON+PWoNGOJSlmoyar628+VxRHyMMM
         lkOiHrC/VOtd7Sr5G14dbVKz5OPBU5KRSLFQQOQzoZ9eIEYvdd5aIJCRnPFGejwW+EZU
         ZeTabmBvAJszEDhU7PxC3DZ0jellyDL/bKdZ4UdE7oZfGAh+HCtyWnfYfcgpotJdl59p
         sslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140033; x=1701744833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLLWv5heZEhgKjwCSN7z2+gMmcOBqEVERQWxP5YYCuA=;
        b=jGxXPnwLC+EfaGI9bvbpMSj3Q10NHgju+zu1iS7YqFndYXZdE8UBvMfOETM2kgvvQ2
         nP7Ue5OtCE9odaFu4P7wFHOLQdvYWhGGc8OlAvY96DBe+QqvqcrbNM6kFB8nNnC+Nz/8
         zSr/Moy3Vltk11R/0dMWS7pzxA4H4JS/bydQTnXMH5dF7ZktbZO3qroma3HZo3wkh7g3
         4BpMvD4+Y+2/RzStZPNyhbU6Xu3KjZdPHQIeLA5KJcA8FwhPfBRlDIn4gIy8F4iaQc0G
         vNSlCGNXBwNPis4+wZ047MPoo/6m34mUZVXJB62M5ySSbZuXmhHa4QtBju6lXmT09KtT
         G0vw==
X-Gm-Message-State: AOJu0Yy/aDbcIG7hDew6bVjMbkfHKPvO94YZ1qKGWblD8ST6ip+fDWmP
	Jc8YkKX3Ld8fKc8viO1QxAs=
X-Google-Smtp-Source: AGHT+IF6jVKPFA8DG3pvBSHDGK4YiOzVX/zHwlGp7anDdmqYkUM8Gk1njhG5sEjns0CVgOWHm5cb7A==
X-Received: by 2002:a05:6871:438b:b0:1f9:8f72:4302 with SMTP id lv11-20020a056871438b00b001f98f724302mr18234988oab.59.1701140033150;
        Mon, 27 Nov 2023 18:53:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12-20020a056830438c00b006ce2f0818d3sm1559110otv.22.2023.11.27.18.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:53:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 27 Nov 2023 18:53:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <2956fbdf-8e58-44f0-893c-4c32b34b95ee@roeck-us.net>
References: <20231126154359.953633996@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:46:28PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.  There
> are 366 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.  Anything
> received after that time might be too late.
> 

For v6.1.63-367-g40fd07331b87:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

