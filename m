Return-Path: <stable+bounces-194527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B9C4FB3A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258C4189FA8A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDB33D6E8;
	Tue, 11 Nov 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hOyDctzW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBB33D6E2
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892953; cv=none; b=Yn2FpPqYjmpHF+ShID1lGEuHESyzEApLE4+Ffu4EIkbTANbn4L2L+trCXCg/ftbFcbS/bR7BNLf8/S7FnNlP9mYGLwa50kz93Aa+U4RAyJ/XDTpGN+T/5ytvBNsN2sEzZYBkNowhvAeZmKVHQgMyilApyr3hl/pHk9U2L2df9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892953; c=relaxed/simple;
	bh=92npXFVKjrhpisCLYsnug9Rxp1dITx02Uvrz+rVkX3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTL8SBVYFg6nfRDEIXJBVn6elEmBdcEL3TZjBoSoXbdO4WvZqFXCO68Dz8ds9lRqEIUapWmQ+iBy9qIj6sC6u6KABiDK+/IrgCF7abMExfjud14SGJ6/O+pw6i0zYobj0hWk6c1roU1nHlhQ66i68r7xQnwikLnXqELpM4Q12tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hOyDctzW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297f35be2ffso1002355ad.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762892950; x=1763497750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lm0cyy6GpKPtLwlPwfKtxbxoiOSXYguyMaReC5kh3A=;
        b=hOyDctzWMiHvsab4Pyl7zPenUOlvPSoM6Uv1j93BiHep4oTEgKXEknCOqYqnKncVxX
         7Ghmr9lvHTHKZ6TCXviEdQtuCQPUxx4NXPhnMX5xNfOu20RGO00HStsmGieRtR8pR1G2
         jtxQjwaHqV6YHVksC86xOKuEkPYB/FGIp+3Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762892950; x=1763497750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Lm0cyy6GpKPtLwlPwfKtxbxoiOSXYguyMaReC5kh3A=;
        b=JQmewkLEKmn32cDzvxmMSD4Nd1QgQifg/cazwjusfNgBx2GJceofob8akNT08JsFC4
         DZm8o9fzsNYnlTduf54Q/yBeM++ZXebXimBaEURntNAq7UUZTBqPCrr3vxTv6QCT1Xj7
         /qlIx8v7e97tinyfnJiqyvGYpM9BDdAXKlja1ZNXofxE1DUTkpRhJZB8t+xThSaYW1A+
         ejjGMVxVyfvCMVQbKLkrZamrkVO/J6pCfB1VIx6l8/TzZGHWqIq4o7n9p4GzMy8+Nn2s
         ce3mfY6+G6lhkfXQKdNP3QfSR1GgIxe2ao5eCQ3XsSIxTvplOacGOdDBXIAjMaYkT+Ra
         8uVA==
X-Gm-Message-State: AOJu0YywXmhMLK19T9+9C8qF2McgqlQp8Dh6lNkS/F67PH4YQtTUUBK/
	Qn+PkGxljt8/U3GV4pQFzuI+3XiA1dAKkH7j72ghBtd1YCTxU5piwNcD94ziTxyHaQ==
X-Gm-Gg: ASbGncu15sUuSrhZkWAk6XuboU2gF22XtsH7HMGHE2u4cwh6dykcIb8NPvCildoUDXd
	n2oAEEVHMOEdE44nOgVK9DMhfLUZEfM3oOf649JEJ5FI7SckmZoabJxzdtfu3GFAZ2xBBwDyT2t
	m/5U3QSBE+zt29vnBs5jQdp6ewdjhwrLev9SFSEjBMGdByBe+FVZwbl/4wj6dW9rcbxRowjfH0Y
	dASwMf/JdD+LuD89pOgdWb+0T06h6TDgjRImX0FoPASb6V3wjTIdYOfRjKspg9nSNBZwlrRpIhQ
	VWNiXULJ4NujxBOtc5iSOM+bJPJL/XQnA+MrAoF8UkWgcXuEffJzHPGRHZlHw+5vef9SFEW6hlk
	x14S5eLGc1QLf45H2Fi/6D+DPX/ZQFRD+MONYzTXgocqtaha56unSPvhTTj8+yiQUIHH9KEBL8F
	oUl4XiT8WVusJACBl/S76SV88gQ4UG1EVo
X-Google-Smtp-Source: AGHT+IFgpJ7ieLN3D+n9X4Ct/IqCjfaNVQEHkLLAGtviQqbMsn3doADs7khGezuYpaPY6qofXBLTlw==
X-Received: by 2002:a17:903:2ac3:b0:295:39d9:8971 with SMTP id d9443c01a7336-2984ed3410fmr8163715ad.1.1762892950309;
        Tue, 11 Nov 2025 12:29:10 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcc9f6csm6044815ad.75.2025.11.11.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:29:09 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 11 Nov 2025 13:29:07 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
Message-ID: <aROckxa8DMdqBx0b@fedora64.linuxtx.org>
References: <20251111004536.460310036@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>

On Tue, Nov 11, 2025 at 09:32:50AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Verified if you drop
[PATCH 6.17 145/849] bpftool: Add CET-aware symbol matching for x86_64 architectures
or add 70f32a10ad423fd19e22e71d05d0968e61316278 everything builds and
runs.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

