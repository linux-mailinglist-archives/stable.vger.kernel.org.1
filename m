Return-Path: <stable+bounces-124089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD8A5CF0D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054B03A64AC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869CD263F3D;
	Tue, 11 Mar 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd4PtL+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561E149C55;
	Tue, 11 Mar 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720305; cv=none; b=G1at5V4WX2PX3143ZFAMQhCDgjn3Yxn6J/ql2zLc8cCygJA5BFku3i5CRm9nL5gvdWhyldIYpLe8iRUthpcgjNn2AXwWBexjW6QULCoinOmXYx17uPd4GQV8qcsN21zuOrgpJOye/ApfzEs+0b7k92qUP/DOYyVDuCugUfDhSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720305; c=relaxed/simple;
	bh=9Cenk0RJF+NXyoIucvW1nCyLgk0A8k7LysRs0Ukvy3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvRYcv0BbWFPShA3gGgdkA3m9MH09VXB49u9GxPhk++5dhKUYYaD0j35X4fkT1I8nEQlmu4oMwUkzWaKW1nC8n1/Um+YL5LAz3wsJPHbCGRb3zORi+O55fktX+a21/OfAUMN3JNuw80cF0R7S5/2TQcznDEhz5nnnUSKnrGs+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd4PtL+U; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72726025fa5so1202341a34.0;
        Tue, 11 Mar 2025 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741720303; x=1742325103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dmF1yNUo+ggsbU/6nKz3KCl2C/94nft3iJGJcrNcTT4=;
        b=Qd4PtL+UpUFTU7Kwxa4Dt3LP+keyyM16ANNzFT4BWbL1GhAaoCfEzfxkXKaf+H3sgU
         LA0iTg4vrTVCdiEZ8cneFmyQBUo8iycU/337mTppVH6YVmfHfkuISo+6VxkjnmfdjF59
         x/TvvuLP3U+EDwoe8tAiTs1M9htEbzZE7qrSBCHXMJZj1zxjti5urquc5xbfjr0q5gDy
         Yzr7iLQr3rCF46JgSfymjdHSObOyrXNMPEK94Ryvu8MMjfUhm5dqBVXirL4Y++Al4sk0
         AUjJWL7QynrRPZYroLIJZNDTno3A6KNGEHG8IrgRj+Rk6jLr5ptDDw94rdvwozu20dF7
         VTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720303; x=1742325103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmF1yNUo+ggsbU/6nKz3KCl2C/94nft3iJGJcrNcTT4=;
        b=EcIg3uyvhlBTxuI1iaGfMKCEssPsFnaW49MQUhQfTCec6smlAUe/om4vMXsXsoVh3/
         WAGKtkusnJnp5vhBHCF1qSaVQw6Sl6jQG05dHU9y4aUs6ZBXf6H7NrCH3QmaCYG/MVNs
         CaFf1F2PlAIeiTY//yblyL4L8thspQQs8qd+bonxWk8A8OjODjdfHGJ09D9HN1ipSDv9
         /TuUKwHY1I3tt/LvGVuJK9o3meWrUdOhZQx1RF8FFUrHZFOiHENPYuRMNKMNlBMnKT6t
         kFmPLPshCKd4+LW7oaf6SKM8Zn2FTcLbH1wRolRb8th9g47cUEtFGRySMdeerBuUnrOe
         fssg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uBgLZExPFkYusdlrfcgGzbhRjLqbClkWtwP0gIw+02ZxpY7U4X3/sAuMoAqiA/eexoYaXlUz@vger.kernel.org, AJvYcCVFyibOlk3mTZasJAsdNNNUlMboVC8QQWCQmI8r/1/Oltf2n9FnNkJ/NqJ8AI3jZhoY20VqLFdoLroRAEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmWFi92B4vkb2NkVbMe7AaDQv9CcngXa5ah9V1hlLv6i4aIZU
	Svmi+TI0LVP6VTNyCs3LBzWz9JxONM+qlWkPE2GCihwQqEuLDrLg
X-Gm-Gg: ASbGncvpVyHNFNxoulmUn0jp5m9zlx33ZhGLRwdg5uErgrp7uCpoty3h3edlUbEqAbb
	0s9XVBCwuOXuYkh0AMqYi0hMsLHfAzwVspV5GSNpiQKE3xuUAq8dbg2dR8H51+HVh5yzQ0Qsmc3
	QkJvkkYEszcNTEidRwjEmG+TIsb6me+x33L02ZGz08qsUD8Dr/HUb7QaAsIyCK0jKog931IQHDA
	aKU4WUSHcRcWU8jH/T0wsXVgzGhpvrSqYPoFDvcQofWz+CQpj/QhUxrduGC5MoKmoa/cJGpPrnO
	IOw0s0HogiV2h/5OJUD8F1TM+7XRE91n1VUT/RQH4ZXBEc0MjIuzoLe1AA1TPwjL6kN8uTZxsle
	R+gmlu2g=
X-Google-Smtp-Source: AGHT+IGO8BCRXctWglwCc571t0NVoaIZgvaZaD7VL0BHwXnJh3s8NSQE2hXByipqSycd4grqrCS2Gg==
X-Received: by 2002:a05:6830:348f:b0:72b:9d2d:809 with SMTP id 46e09a7af769-72b9d2d0f64mr1847884a34.27.1741720302759;
        Tue, 11 Mar 2025 12:11:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2db9f92asm2517059a34.46.2025.03.11.12.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:11:41 -0700 (PDT)
Message-ID: <1532136a-19c4-4647-bf43-5ad3d22e89aa@gmail.com>
Date: Tue, 11 Mar 2025 12:11:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/144] 6.6.83-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311135648.989667520@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250311135648.989667520@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 07:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 13:56:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

