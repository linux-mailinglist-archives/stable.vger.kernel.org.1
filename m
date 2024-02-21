Return-Path: <stable+bounces-23226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B085E678
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA031C24E44
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD88565E;
	Wed, 21 Feb 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="bZ9zJLPK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD83C068
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540754; cv=none; b=IKEM2Qr+ckRQ/x+YdR8ZZLC3NiYwXtHhAJXdwS17c7XDpTs0/TxO/9KmofDrPyccoalzLWz8mE/Ra/9VgjJBuDi4W8Z3d0ai1NFhEStlZUjjLVUHYg/pTD0I5wUiiaCSwn+F0ZE5W2tyuLHjV8VgLGuiP7uw2lK9rbfbt7z29i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540754; c=relaxed/simple;
	bh=wORu2VHuAnw935+Cv0QQr5ove+ncqd8zeKB3hAAfA0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeUwgLkVnthnuwqqguw1/AvgZDyVp1o305brw8Rq9a7hksPfcyE8PFYjP9Q2lPPunKkodRwb3eeJIPpzTLv+2Z36h64fpaCINTRxfiP0RcTYENSPEKm8xyo3ZWj0RhG4HXSsqCRzBZHqIzsqmlHXOMUK7sC56gb/xl+8R8E9tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=bZ9zJLPK; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4351ce57aso423977a34.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1708540751; x=1709145551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epfXkFMvEj+O6RQTqhcuu/VpNn7r6C+NR5UDG63CzB0=;
        b=bZ9zJLPK/zaAwU86KSYjgaEsZviABB7myyofQoNoWbJr12nf3YzvOjv69oxpTXIhST
         OZfXRmCuc03a+v5al5f5aZt4oYJggwA87XBAiduvbmeEUul9E7z42MeEfew8IddtWcA/
         uEvapzfJQgCbl3nMNILLyTpCMNdWHSQr7jZ78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540751; x=1709145551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epfXkFMvEj+O6RQTqhcuu/VpNn7r6C+NR5UDG63CzB0=;
        b=w8Bksaq7ICFV7Rv+QCtsOI6aay0gcagQBuCdbT/HjYKIaligkyj1P9GPzJKc6bLKiM
         7UGNs1Ghdzlr/mJFH1/QCobe8B2A1/bTEzDDSKosU3cLTrzrbIGBWRqfRkepBhNDaqot
         5u4pwtYzmfRyONlOA4aFdfLOFObPmpA5Fsoqn6+7m3v9Jmh9UjelUmOCeoTOLh1YSvyW
         UILH+8llLa3DlOq1IVFRunt3CQIr2FTUJ0mWYOFxtjmON6QU3QSnMRVmpoO/ou+e5PNe
         PzapIj1yW7uepopoUQimkMXdYRoJCg9lrRDkDzvzKCfslBQ9rUBznf+PvaIwi3omH4Pk
         9qOw==
X-Gm-Message-State: AOJu0YwnAAfiVzZvkALtxiW1awgcNZaV4BDwJcgrvvbd9siv/bbleifX
	tUvInkAv33M3ihE3mOj1IxbLEoyqY55w6SxIGVkpKgy4BvoagcGZn+1XdoI6GA==
X-Google-Smtp-Source: AGHT+IE6vQu9Ee36mA2Xebhws5M+r7A1PWQ4d3zqpqI9AXKlri0chGThzivmD6usVGdGBqrmBaAwIw==
X-Received: by 2002:a05:6830:454:b0:6e2:e526:b0d9 with SMTP id d20-20020a056830045400b006e2e526b0d9mr17898788otc.16.1708540751121;
        Wed, 21 Feb 2024 10:39:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d4717000000b006e43c2c4381sm1673596otf.74.2024.02.21.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:39:10 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 21 Feb 2024 12:39:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Message-ID: <ZdZDTZQDspSCagGj@fedora64.linuxtx.org>
References: <20240221125951.434262489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>

On Wed, Feb 21, 2024 at 02:01:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

