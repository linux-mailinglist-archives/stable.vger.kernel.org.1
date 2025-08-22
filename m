Return-Path: <stable+bounces-172347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23ABB313AE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE29E16FD3E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E062F28E3;
	Fri, 22 Aug 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNFc+wEr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1B2F3C03
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855077; cv=none; b=G5X790ydwk8hydOKtU6rgZ7FJ9g0SOusn1bw5t01LNMDybJgrLe/C7ZW7Vf0n1mju5Dq2okqsBCOoot7ggAyP9mv4vI6qF89LRje9DWrYxfxV9HidWqlPgdzPBssYLTGwKXuGgALA56vnkzfP8usgoTYOK2BtAlTjwIVWCdpWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855077; c=relaxed/simple;
	bh=0208ISyKu10cUE7W9YgFPUpUsfgz36ubVskvnrbBoYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocnYbk/KB1dQo0ar0+2UGQGTZprjxRkICImntF53vP0VXc/F1i/dVL3FZxH/CRhAKrVZ4zMRiDzvTHedEbaQHBiKIUWWEF/DTZYI/xqFlHih/omxHbvmBwnoGFUjrNHG8ynrx3Zo0viQmslpthvZwAXP9hxPOdLl7bCfYvjudSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNFc+wEr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e4193083so1469300f8f.3
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855065; x=1756459865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=rNFc+wEr/fsbRkz67OsdEajGw6jjOXw3VflRwkTLgv6k/n5SIIjfOwyTaphWDuM+5a
         lbdtpXzIZflwbqnFv5bj5dx2lsIukjcdAaGIjJsC9k0ItbHhD7qS1zgif+0ZOSZoG98d
         wTncx7mtA2GuuvmG3roiJW0/quoI0P66YeuS97CPAPkzYPyY/Mo/3tywcztd/dSDEUaK
         z5AbbP3gjmk2y3AjLLc+jJx+v8bYJOllxbgHGmZYAFZ/CJJUWpVXemUaktux5AVeqt1D
         HySCfOPBDVyj4hXf1F9ogBjKTsKZyOKzQAREk5ImrFS53hFpli/4MNLRyfZfdIQUbwGk
         kO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855065; x=1756459865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=a5XUGPDBnmH9bZMGd4/drlEuBeTSVdrREIbm71hQ54yEI8Pv15wo9H9Y+C6rJB/Zvg
         gwlMcZu1Ytp0ve/grAiZ8Ru6urOoJ9yUxFfC1GfPWxq4BzFtLA88PxxAxNORGXJ8Yxmj
         dK5iHSW5dH0oZIfqinIAqpoSN3mfQOS9ABcZ+K3qKnT8PJ74mFy0ri9CpC1lp0YEGdMk
         V+U4qhDUyr0vHli06pOgbXagV+osPh8lypFaiv9vtwM1bk34ezFunBiX2xkOTgS5vOdA
         QSpO6zK2XfYCX+O/w8KIvUFU6NfIVa18pyNfRd2fDth2etbV5b24qk33L1Ro1fErBrNU
         zgtw==
X-Gm-Message-State: AOJu0Yw6/Z6CECd5BPWHRIk5NKNLOi1+AHHEHaX/bkJI5nvQf5mMoc+5
	+o42CGP6ovpJ7roMLS2NXtxdphbJbMqyuvY8YecG2FPJBXbgzlckclt07dmKg7X/B2k=
X-Gm-Gg: ASbGnctlZ/jtl3GtpZweN8xhghrbsfHPIUCvSsg4D4Db6nogC74DBYrEDT7zrr/+/v+
	zjucGVi5fpDsvVVBGsAUXaO/RlQGIszKOWn3Ut7dRbdxvN/yy2/d+zq1X4Ji1IzjNhBxB+28FoV
	oRJVmpCgL9np3IPUe548vXLqIyqg2FVCLcJZdHL4rGEbdXs8CUqtrOLzWumOfXsqDaqynmtcbQ6
	deNXRA8wnPE7q5vNvonXFkm88wmYICw5MqIP9l0AufWxWHMsnp4j+6W9UAWw3WwSlA+dmwWvnr6
	WIyYcMbsiPmfvb7U4CunzdZAdVMTSOiMQMqhQz0pltFqYQrf5CdAxxmj9qATKFUcUcPUr2ZdHr2
	w2Oh0fw5OzqVSyMyJNgG/mwusLsM=
X-Google-Smtp-Source: AGHT+IETQifX60xNpED57w605gzuRtVMT1h5myncjmf4CiJxMRcoa/HpI34Al4mQ3T46Kr36eWGX/Q==
X-Received: by 2002:a05:6000:18ad:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3c5dc6385e1mr1345579f8f.34.1755855065462;
        Fri, 22 Aug 2025 02:31:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c598e067b1sm3192314f8f.59.2025.08.22.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:31:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:31:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <aKg41GMffk9t1p56@stanley.mountain>
References: <20250819122844.483737955@linuxfoundation.org>
 <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 08:06:01PM +0530, Naresh Kamboju wrote:
> On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.16.2 release.
> > There are 564 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> As I have reported last week on 6.16.1-rc1 as regression is
> still noticed on 6.16.2-rc2.
> 
> WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334 start_this_handle
> 
> Full test log:
> ------------[ cut here ]------------
> [  153.965287] WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334
> start_this_handle+0x4df/0x500

The problem is that we only applied the last two patches in:
https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/

Naresh is on vacation until Monday, but he tested the patchset on
linux-next and it fixed the issues.  So we need to cherry-pick the
following commits.

1bfe6354e097 ext4: process folios writeback in bytes
f922c8c2461b ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
ded2d726a304 ext4: fix stale data if it bail out of the extents mapping loop
2bddafea3d0d ext4: refactor the block allocation process of ext4_page_mkwrite()
e2c4c49dee64 ext4: restart handle if credits are insufficient during allocating blocks
6b132759b0fe ext4: enhance tracepoints during the folios writeback
95ad8ee45cdb ext4: correct the reserved credits for extent conversion
bbbf150f3f85 ext4: reserved credits for one extent during the folio writeback
57661f28756c ext4: replace ext4_writepage_trans_blocks()

They all apply cleanly to 6.16.3-rc1.

regards,
dan carpenter



