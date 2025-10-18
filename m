Return-Path: <stable+bounces-187830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D237BECC36
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E818E350498
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB004354AC2;
	Sat, 18 Oct 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVILu/O+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC5258ECF
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779109; cv=none; b=mhN8l2SPQmY4Hu8GRsCGEs39DuNK9oCk5qCWTwYY5nED/Pltizvmd5O6Xx5J+lgtlsO7THm336pDZM2mUsvfsaLS+7XvT67dyBvHZrDWi/t1mt3XsuLYXjLzabcqJvXNGx5cAAdRz91CkwcstECHnn6oEgPeqYwFRuPea/TOzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779109; c=relaxed/simple;
	bh=jU5teLVUCnWZH2TochB0gAv9g9e8BPv4GBxUs8VxtTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQzXqG+B3Led9owS33KUKJTAHaR2ms5w/dZ4K5i+jD12tEScAjfqGxbXRHGBwrZRo3PtLW+RePW/2nwlkJPg1oT2hybCYdMEmFHQwqD0Hrb0UfZwgha5j7j/iRTx4qU9dL2Yr6qPv3nTnwufUd3Hyqsgm/T+8NxuJITpG8PLOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVILu/O+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso3772260e87.2
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779106; x=1761383906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEx1UnLRAjNIB/wwt2DQvYTGt77QeDOtorXfzALGI74=;
        b=PVILu/O+FkgOyvp2qQaGz5Z5XQ4mayhhGnn7W6uTzL+fZxiL3/Ou7wcvt153kJmPKB
         Mdr9JpkYFXlwksae0RQIwJJHZQJJ6NcJs013snaSWD7V76FOYmO5E6ik+aYPjA3LeYZi
         tT5aLo+Zkwc9WsNaL54DPq8Ymmyb/AtSj8wAtRveNkRpq6gnKfI87+C/gPNHdAk9j72V
         nisPDWVAue3xxN8dW/vWWYbEEf+New0mO3SDrUfwgHhOMiPsVPklESNAKY7Mrd+N9jLR
         0a/iLuT6K+a51sQ+EYhtaoMuoYnL8asFJ3BdWDdQw8gSdTfnWYBlIdifRgDrIi+qwVVO
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779106; x=1761383906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEx1UnLRAjNIB/wwt2DQvYTGt77QeDOtorXfzALGI74=;
        b=RGx1oJrGuRpazaILWjyHQX3EDpJo093wViXbIi5mycHE76WWNVRU6UKVWkT46QSEul
         ehcrMzk/5faD6yvQ3WU/nTf0MGBsyGsGkVkPwDy89O0dgF5IaEps7Vt9FopVcNbYhaM1
         e41setDydJ1y5Y720HoxGGteayRaAMg2odCweFepV75Bao2xjCAVuhCC4oposJHr2Vae
         5/Mp6W/7026qpNf2+Xb+bNAqfiUty+b0078vAgb9F1x9lZqMxK6JsCU3CwL0D69PcIGS
         Lu1GmodoD6s3ly4/WgrZjMZCZrT3YJL7kSh5mM3btSPwZnuksIUE48gjm6ya1tY4kLEp
         khuQ==
X-Gm-Message-State: AOJu0Yz9xXuZUPzD0MbjMg/iNPDqGk4aRCQ9H5zcS/01zvOJHOhOFBoL
	2qDxbz03O7TNGFTthmeFSYdWd9bPBjADy6rGk9n8nYFdCRQBeMw/Pi0ms32F/04G5RZtLV2Br19
	nkZh5BHTJ0vUPaTGcuyHyWCXhDJxKPxU=
X-Gm-Gg: ASbGnctQQ4RtWMwqvd1c3ETBsSh/02TshVz9gd4UHgslbF6+JO3o81+9HE76EYAwBU+
	4z9yzwH5+wmXm2T3jeeDUhvsJMgaOyRGIU1LrGv7kgrEzfj3sjUwiEOa1YrFSxfkLN/CQTL5rhc
	EVJ+l7PpKUiunFUeIH/7XNxfmNzSog1gW6ZGPdqye5GKngIa1y3leBcGnG2MtAKvGxC0ZP+UV2l
	wtcbdYaIUXDNPj2X7tS0KOypeO/74LGU4oBj6FnMNHfiTnU6FJ0zUvCUPn4kCKGMLAst8Cu3dLX
	zMbDFQxtOcL/yy1vIPKKEVdkUPY=
X-Google-Smtp-Source: AGHT+IF5rfW/tAzFpoM3n1DSLD8tOde3TxisLUADp6oDUAe+BnbdUVhgS+yCWVTV35rJ7f2Er0OCoRl2bK7p/uL8KBw=
X-Received: by 2002:a2e:bd86:0:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-37797a09b5emr19614861fa.27.1760779105708; Sat, 18 Oct 2025
 02:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145201.780251198@linuxfoundation.org>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 18 Oct 2025 14:48:12 +0530
X-Gm-Features: AS18NWDXwx6Nj-xhbGPfTIeoZlZlaSXTImQNfcEKqQrGDv7K4Hexvzb5wBkwwfA
Message-ID: <CAC-m1rqGHU4fn+VaqGfpuy6EAGAKbhoSfpy=6_PsSbUijATioQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Greg

On Fri, Oct 17, 2025 at 9:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.17.4-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.4-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 396c6daa5f57fff4f0c5ab890c6bfe6ca31b3bba

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

