Return-Path: <stable+bounces-185469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3ABD55FF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EB13E7685
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3A279DB3;
	Mon, 13 Oct 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzyzXFKJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921C26F44C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373438; cv=none; b=LZou0R4HDdA0bzEMz4rJsXFp3DbxObBFI7hLJP3m8ff5mCY/6HRc9PmdMiZk/6V7EWcNuqS2By/rFK7kX7pLq9oUoMOJrGG97aC7VnmZTUUoMKDSRB5vsP6xHX7QP6EraeBr798belZK4Ar8+xPMKLUd2oudMvHduj1d754h8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373438; c=relaxed/simple;
	bh=b2r2ZnqDhlcE3hJzionks9xsPMpBi1PVSIuwbR3WWhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpJNXiET9Gv2JqDL/jL2b3tnlDRkX/xHPZdRYBiWZPB/hsmrq3u2PsUq5PcofpD7RfWz/NpgiKjYpvCdmTjT5mBIfaLGmu44DPmdY+ZIKfYgKExQq11jdJIC6tSzID1PeWDAKog3rczDUx57PkETSGeED1Mpi8CWoWnetR/II+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzyzXFKJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2051449a12.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760373437; x=1760978237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEa7pR/fO5GSfmUiWOWkXWJ8/pJjtXIzKlc2WrRjppw=;
        b=mzyzXFKJCQIIL9bbPK0giPHsCZXAuvf/SETa10SzgXnV2xs6apXMpmSFU49oGhd97+
         ikU2Qib07N2EZzQ9FmjZru4n+3XPFKWKtn/GCWVnfyQGap3sa+aG+9CGRcThYce5I3hd
         ACdmxTS5l3R69geQtVY2NedGjK+6dujl6suwe49qLupseBl93TgvCeX56GV+yNdxs0mt
         8aByqGfMWqf4rJxEhVdCFvtWw+rV+VWo9YK3eMysoSvepctMOMc9MT5FeNxF55b/wGS5
         IvtH/R8ETLfBcHyY2AtVNW4aXTWBJtErdBPwnwWtpaquDIX8I6wCg/x3n9Gn0JenPkXr
         iZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373437; x=1760978237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEa7pR/fO5GSfmUiWOWkXWJ8/pJjtXIzKlc2WrRjppw=;
        b=PMi9/DsmId4mf5aqzD/cBbzLi6mZP5lW/2zfJ1JxZLPrjIX1Qc6jRegz/wPzasMhPV
         vdSfbMVQEvkQa29EKsYtDFxH+pZX+DwwZMVg4gggEDBXWV1EZBI8WLRH0Y6wg65U7n79
         KlVhBnEwE8rrdYNK9ctjTalLn9mVBkcyCFI312GCW2j1ITacWpo9ETkfRj0ZcgJzTFEp
         gzNRLbxGELRM+UcMpOFdv2Gx478CK0QhNnyablscmOZ/bWFbd/vYkpDhn8krVhTbgxA/
         lQy0eX5CwoCn9+t9ytbZbfq49MUSQ1mEGRJL5sjT18KBLwfF4zKytxyOsheuVm+PoImC
         uuPw==
X-Forwarded-Encrypted: i=1; AJvYcCVwc8/NkBl29C/3aP81jqVMZoCVjI6xw2mr0w0uHXq1b4A9+agIsmni01QtKWlrED+5M0TyY/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1A3Lxkuf/EN6hlwwrG7Vk5DoleFgnKDq2c/6AIwu0DPs3tJI
	xAG0ea0JYo03bgUmTLxiBXvrtTxQ7YfiOdLjKHaVgiZ047j9wethhgYL
X-Gm-Gg: ASbGnctDMLkHit3/g23aea+91Ilc1xOXyIqN9npKJlqJE8ZE2fv56pBMKeDTwo/IC0V
	1LhyQY1vB/n+ISIJxmi56PRsDk2tUY8bBw6PD+5UrS4T1bWdhLsvsgY6O2u0DWJ2e/ZierFWXHR
	U7DMZYikzy95eyEArp4hJmlVM8NyRcCGcFxjXyJHcTSyojbdnuzxZE68hr8nu5TqN5kkAU4RR4H
	r19Sw/Th+TayLfEWvCPy7oPoY8blomNk0oh1AKevvNBe/BhfVs2OEGHFdumFFl6BTJCE8Fvold1
	xT7b8RSGXvazEsDzs/oommP5jsl5i/2JaEUJm1QUJCCK9M0BM6298WSrtdStT+a0rDJmYNUStvS
	lH4AYJRLBK1E/cyLUwVZsgXDjq1JdV/sMY98A2QH4UD+C4vTF+hHJG/7RHxWzmoilP14IwUAi0k
	fSMjw=
X-Google-Smtp-Source: AGHT+IH1KJHETTMsM9csfcmWcjkeu7/hQCwuY0V59wcP2JtmCwROl3hskQGQ1gm8DOn8sGQGlisYCQ==
X-Received: by 2002:a17:902:cf03:b0:273:daa6:cdf9 with SMTP id d9443c01a7336-2902723ba36mr241690505ad.22.1760373436572;
        Mon, 13 Oct 2025 09:37:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95bd3sm139048795ad.119.2025.10.13.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:37:15 -0700 (PDT)
Message-ID: <0b2ca7be-22aa-47d1-959a-a6aec4c3dc5c@gmail.com>
Date: Mon, 13 Oct 2025 09:37:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

