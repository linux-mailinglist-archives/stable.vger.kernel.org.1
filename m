Return-Path: <stable+bounces-6601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295828114A3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D137282799
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFD28E2C;
	Wed, 13 Dec 2023 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQSPpJtA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110AF4;
	Wed, 13 Dec 2023 06:30:40 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso4433027b3a.0;
        Wed, 13 Dec 2023 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477839; x=1703082639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLer1SF7EpDgV5wwruLn7G1R9ug5hXuliPpWU0a6AFE=;
        b=hQSPpJtAxJVgZv/Q4K8pY8A6QMTzA0IvjsjDTvssvoRBczIrIYCFntpxUKd7dUhqrr
         F6v58lbSvfbcDKQ+XRPEEIMLKMdAxl2/Zj4CJriiuDuBY1INnTJA8gH6xdErAnFpwZqZ
         QUKgj+KAjDvZkJK0jmpLo0i352XKx1f4U53Azx0+TJkR3UomQycQZy0EB8xkCSb9Pbqc
         D/qOwZJm3nucyIl2RWhxVdSb/hztSubuXFNXLJE3Bb+DhpF5njO0v1ZIQoS4WYPlMflo
         PnxuDNMNSMQOsNQCn/0dHu6xQADQwjgLXf38ZSnnbtDLZF2id3YSc8vZBxATW4eQgGmb
         F+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477839; x=1703082639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLer1SF7EpDgV5wwruLn7G1R9ug5hXuliPpWU0a6AFE=;
        b=A4+A3+LjDsQtGj00HcuTJqaFG997pj26MmY/rTq4MDZkEb6h0yGY05mRsBCIEaZeAY
         XTlsMvlV/LKyMosLvARlGIQLpArvd5yxIM/7gJIU1DwVFWyvlunxTuXsR2gMycmEwXKN
         UNQm93hbJh9FL0zlxNzObz45DD9Mra5SR12X916SOussZw4UUi72XIVI2TQr3qAs7cka
         Nk4iMPE9yLM008OMDL1Q3/HMyFqa8M6Dyy+dlHR2SyU5t/nFNqUPsqcoMbyHexzoKiYL
         0ZP6oref7DxAkqIZcyvZ+km4TmR47z7JfmBs2TMDhCFQl4wei+ACOyB2kuGRCdTz+tYc
         ctEw==
X-Gm-Message-State: AOJu0YzsIiq7FhcLsn9pbAshAjDDpEqFYjcvGXhfjKuE2iJgpxMbTWY+
	mCD/QF9OpJvR3UAtXcwgyOVncMIS+YmhKQ==
X-Google-Smtp-Source: AGHT+IFLSrUkVbTFTgvCJSNuu8ML3O5t98F48xqf1rkoyPc0reME2OknOSdN7K8VoNkJsq5+v0a6ow==
X-Received: by 2002:a05:6a00:3305:b0:6ce:6007:9bb with SMTP id cq5-20020a056a00330500b006ce600709bbmr4451522pfb.60.1702477838995;
        Wed, 13 Dec 2023 06:30:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b006ce5bb61a5fsm10102920pfn.3.2023.12.13.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:30:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 13 Dec 2023 06:30:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/53] 4.19.302-rc2 review
Message-ID: <9137cfe5-83b1-4307-9943-77e8367ecc64@roeck-us.net>
References: <20231212120154.063773918@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212120154.063773918@linuxfoundation.org>

On Tue, Dec 12, 2023 at 01:05:09PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

