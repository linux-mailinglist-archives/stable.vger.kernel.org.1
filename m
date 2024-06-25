Return-Path: <stable+bounces-55813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FEF9174A0
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 01:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F405A285542
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A017F4F5;
	Tue, 25 Jun 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WkCxcBsq"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2D146A64
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357554; cv=none; b=PFDSWeQ51gsN/C0YdveieYlPbRsIcyX3boI4g/VYwSVnguzEb/tE0JpvNORaO8Hqll36zjEQ5VPARGcaMIQJMe683dU58sN3N1k7MSnzVcUjoq28ovwztavL4k30aIMo1hZgFU0Gxv1f9rYN3ah+n/JRsJIt3kvU06vakW4K1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357554; c=relaxed/simple;
	bh=3cLkEoQgP1YdwO0BfLrc2Nt9hXh8gTQtQS3drljKsUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0lnsJB0pMTJ70TeL4WzxL2InfMoQ0sDjgTlvvtwJRP7WSN2J8el41zenMDC7EnxJ68d43EEEJzviVn5uxxfPMi29OjX7T8qXL9Mf6RIsV0HqeMh6xmj5FLE2/o9THYx6K2z6coafFKxlttVO/rj8KnxaA+bNwsbBvCnn1/MNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WkCxcBsq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eb7a2f062cso243653339f.0
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1719357551; x=1719962351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1GHJHK8fYZOK8MQRqagipkH8Y/cWBs/Aado6nOWSJY=;
        b=WkCxcBsqNgiIe+3TCH7eiNHC40xBNI0jZupXolTlcmkVkVUQaD9QmVnW9NheN5GPfh
         j4D+5OpyAEn9IXAH3o0ny6lIXwEwGTpSA2qwfKkrwU80HRRQP5KZgYuDhq8b1U5Yfgnp
         7X1IdXkgJH+qbsFeo27pytyp/mhj5+Wh/vUIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719357551; x=1719962351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1GHJHK8fYZOK8MQRqagipkH8Y/cWBs/Aado6nOWSJY=;
        b=CeoA/xY/xpyf1eh0TNBuresl4NCXp4KziviaQVqeeVTS7If9JY6lZd583zvkBAya/n
         XlmifcjayWTqfAf5xIxJzdcpZxFpY5S9gW/XnHdJgB1e333MOfAkpxx3r56F/0aMJZs9
         V/sbudsf1EhxtJv9qwN3/HUY/wXOInzeDAjq8zhfUcqLrPAf0cd/aWkYaYIslF/y0WOS
         7oAvi0MWdvTeXRXbFYra7SgQJ0x/rz4znC3/sHPQd9j8IzyIZ5lnwdNoZfZ8CEmx+bW4
         E2jxiMmswkoCXpRRylEvvJjik7fUlGltvm8PTr6wsNTPTPpZYxuHQzc+yAWEit5m4YmG
         DHLQ==
X-Gm-Message-State: AOJu0Yw8RTqO16VpyOWDRYnYE5sd4QxpbxB+mdooElNuAX+IpwCmJPle
	4xqRfDPZtMF2SDczGTLSeL5cjXFMn1Ser8bs2ngIy1xSsL+8K3HWh9lM1p30kQ==
X-Google-Smtp-Source: AGHT+IF9PvWW+uGfCOxuE7/74/1AIT0M4Il4mBFOfwU/j90/kgt3HudyWaRkt4x9JkWeKxP9KFOJEg==
X-Received: by 2002:a05:6602:3fcc:b0:7de:a982:c4a5 with SMTP id ca18e2360f4ac-7f3a7532b56mr1053100839f.6.1719357551339;
        Tue, 25 Jun 2024 16:19:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d127b6f0sm2837019173.178.2024.06.25.16.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 16:19:11 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 25 Jun 2024 17:19:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
Message-ID: <ZntQbVyebJZZCbh_@fedora64.linuxtx.org>
References: <20240625085548.033507125@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>

On Tue, Jun 25, 2024 at 11:29:18AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

