Return-Path: <stable+bounces-209952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA32D28441
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A979230621E2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF1320385;
	Thu, 15 Jan 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="KJqVeEyW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876B2E0925
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507149; cv=pass; b=cvA+SGulzELgoRzKbKDAYsSyvqb+MWk3M0zSaU/d88vB/dgiCsifs0Slx8yWrwDSpmrEnKoSTcWI6Si29FYlczGYxd4VbkR3tUgsUQMLWJkoXI4tzou2Wk3FL/X6HVtUkhQHsQqdByCf1WbN9hZec68DMXF31IgLbHXu2gvIxDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507149; c=relaxed/simple;
	bh=HXGIPiUmMYQmAggMXf6TofPVJ08G0qCff1lEJIB0dYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrLwpMSgpseUfeH426ZVd5ZwhxMrmQPksrTMnoIldZ7ZLyIIxq6qmIBJxPh1vhmpfkW6fK4KAqxsqNfghUmwcaZpzymBECFDlxr861sOkNVpPZmVBRIgQOh6Pup6dz1XEA/ONdTjPw0VFhoOoP72mNcQGCKOEyPQAvC2zPzAupU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=KJqVeEyW; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-790992528f6so12729597b3.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768507146; cv=none;
        d=google.com; s=arc-20240605;
        b=CvMjxMu2m4uzu91xwYa+IkGJNKnV0mEeVhVVLfOu1b0ZOgUuxN82vaxRgCyz9rGW6m
         MqiiCBTTj2o70pBKYuyRQtPWjOnJn45qewqHCghpn6GGnQwg0gIzBv7Cpl6lwgReIORq
         efkeNy9xmyWkOmDCNn08/OPrjmtiA43HnIXDyEXKJ2naKxH2GSN2q6AoRgZM7SRIhOvj
         twC1x93mOMnGbuitZPZHasHq1fVzvSYAVJGdDgqaOZ5SQ8NAWrniWCn3tsu5nRIYJ1c6
         o953E/wdZuw1hbrTHaPwRCStDcyF7NZnwc302ZhPHucnXuwW7SqSju+S9nOerIPaWONV
         rNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yXy7cxDSk38KdQZVKqqCXFFDHkqTX+DHgbZccBbsdPI=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=Kr0NeO005mM+c0wJICwF3L4p0Y7akxGuBwO/0J61G73RBt00bAOt2PkXrnmdiizakw
         bC0E0usfnGXd3nBEqSMakOY4sNCi62CHe5BIQVG6p/slnWCq9z96fk2IwCEjNlyLcjb0
         E9MSsDtneylLUw2x5SiRz/PZCiIFd9K0oovEW2qmAu9jx2EtXZG1ZRJf3GYsQTv2wYIR
         kulL9OVJJz9uT1QkrwM5LAfUunO7LTi29G8QBeb9aMSzbpnx0ll9wYxMp0RweMfF/POJ
         4MT//JS7zmMFYBYUap4eXY79RtWxNxo1HMZDrFMaGkk7JNtKoDrk6mFMqKiqDqX0LATV
         VMnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768507146; x=1769111946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXy7cxDSk38KdQZVKqqCXFFDHkqTX+DHgbZccBbsdPI=;
        b=KJqVeEyWQ8xz3EgjkhxO6xh6iQAqSLGTv19jeJCtmZLJ/rFcaw5LxPztu4XuO193Ng
         7dEicakbKisOpF82UgAH/myIDO9zVHWDzmwDb/LyyU6vaJ0EnCuCkq69ZZwxVPP0FkEb
         uFuvZvEo2aEdxXeR8HKYqLhqcXF1jIW2d2/HqhWgmWaUqdNVYMxea/6MNXw6ESVlX38K
         4LVEeF7GiYehHPWQfxsmuXmv9QKa4/LOnkwrTUQiJAv+OQVE/lLoh0026axrqwKIsYoO
         K324zQsgSaB/sWqBNP/IPklVDum4hhYdK6xH1BTlu4lXA33PIqY3Tu+FEvCF6l4DQ68R
         u3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768507146; x=1769111946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXy7cxDSk38KdQZVKqqCXFFDHkqTX+DHgbZccBbsdPI=;
        b=fDhTzU5iOGGgwqGEsZ6X+Wz/VugIX4AkxawZZiWRIzzdzmyo8MiY5YcyRhU27/gFx4
         fUKsYZFUADhXTfro0su7v/GpPGREg5NuF5dAEUgoPRH40DUGF9TH98aS1DPxg2NsOx41
         fYuEEofAtWvIaF0qeT4GZc8maLkbamQkYZaxSRV9LzZ8v1GU2rL670mFcXd1626YohDN
         xIoR9MEu+irQWNPEj12z4P0hid8A8rAWdix004O4o7/CwOyh81p5DTqfpMMByMIeIoaQ
         gtpnRP3rceyXxNHkQTx+dP7O+BV/1B/wriG8dma1qp4MK6rdWsPQsiQ5AI2EFSka7mOR
         BquQ==
X-Gm-Message-State: AOJu0Ywv4fQU8ayxu6o1lUclF2sqyhiUM8MV220YKsorL4Pd4p6SBLDU
	qBwlnXYhOnX3wrnBbDxyn8jo1h/TZGgMhYKejWXLIZTk3HO4Jt0L2qeDdT36Ow3J7MucmodHj8g
	B7oMbJjw4meUqD5omhX6P8modSa2g4M6siM2PsjvoKBTIuVtmAuUrCTrMt2eLEIrDqmzL/TdUzc
	lHNEzDfYpEUOyMv1SGIu/w1kbDLWSuN96lrG/bg1zQ
X-Gm-Gg: AY/fxX7PHhZ03ApIp2AuGdPr+ayrYrOGwUlq8jKZb/RBYwTmWuBGITLBPVmgz1Un0SN
	qNZD72nFipAEIN6mbGK32qzYiZr0pIwhUn2Ww5jJQfjaNn3rOJbpOqBAmkqNKC57e6QHC41HeKN
	4o/Pp0jHDz/dy4gVEVDiJ7chsNYVHgiG/NincWDkvbEPQ1IQvDOJkQdGAiC6hVpGUPyoXS6Jemo
	AJQhMRLDYfaRONQH69bFbcpZpcmBUO0Fow2zrf90lQLsv1h1ArmniaNoZsEXbgSVAl34wI9PGWM
	FprnOhqBoRzQdj+UVTlUmDAcwvfM
X-Received: by 2002:a05:690e:1489:b0:644:28d2:a4a6 with SMTP id
 956f58d0204a3-649164f76dbmr755428d50.47.1768507145966; Thu, 15 Jan 2026
 11:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164151.948839306@linuxfoundation.org>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 14:58:53 -0500
X-Gm-Features: AZwV_Qj9p_zyq9fwWehuhzXC_D4wMSqt5CiBCMOCDBZLq5Uff2KxmGCqN5SVaug
Message-ID: <CAMC4fzLz4JxDMyD6Jc8BG_DXTKPeKQ0TXDY4vx646D1_UV_r9A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
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
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 12:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

6.12.66-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

