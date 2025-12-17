Return-Path: <stable+bounces-202875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA1CC8971
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB123004CC9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD337D13D;
	Wed, 17 Dec 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="MYKeWfCf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A538257C
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985357; cv=none; b=HAcifYyxMfxFbRAIcIsdKriUrLC/N5FDyB11jeJWpW6M1aSYWEtk+fKKZ0bIlngbvOD18yktKubFXKrCb6orxoe8Inxzyl18aI7Qi1Mb2d2y0XoC4ZCAzY5C8ROsYOiOQpEEw9RriqShH82Kw3+2lCdPbcyeSLgTug7w+iSz/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985357; c=relaxed/simple;
	bh=tELgiPFUr7EKhpczx0utp4JjfB5cbUqERxMtj+15m8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGYE2bo85E3mhwPA7mP0GQgZVrS2WMJz3io56VCx5EmBwMlJcS2uiYxJTe/lnKyA7M9u+RIhMmJybyphMUyKYCPG0gGiJoOtzNWOqhOAkhf8cA5MwmkA22xDT37NkWiwFkK64BcM3Y6hX7u0mv0sATtAYE3tkOgmgo6HEe4TcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=MYKeWfCf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso8964116d6.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 07:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1765985354; x=1766590154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7X6PVsXMUSqSNI5/s5CVcqmMOVizvbh7cL73ZOmZ7k=;
        b=MYKeWfCfsTVoxLrz7X0mW3FymSMVMnppodOTzvagsoRD0CFrBTwgjsCSGsyuLVJFz0
         4nK7SbwrSj2Zp+hj0CfY5PUpDUNqtaAKPh76M/tfQNh+4FKO1HKksxMgdtvxekqyvvHL
         hjD2Tcstd0ev9rbo0bLlN2vo44do0eApWot2PQ8JnxkYyoiQZuEEur+xJXV82wt9FXcv
         PityfWlbbJGrfPr2oBEJD2rrQECJpHXUhtqgg1Yra7EDMvOtv0gO7C6cLFQU+W3B7e1n
         64DjmUTuLIyv4iG8NuQVtCw4mk2e14F47HBMBjwq1XVFYX+/dHElzwYQFEGpSyB15TIg
         g/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765985354; x=1766590154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7X6PVsXMUSqSNI5/s5CVcqmMOVizvbh7cL73ZOmZ7k=;
        b=Nd3/l5eN95U1bkW3mZyIzjh/4Ufq09A7cbUxIP4oGBUmEgZJ6Ec0gzKKcd9SmoWH1C
         xH1U4YDTppphUzse8dw+qqc62BI8HiMx2hhwfCq/L3P7WNdD814iVicU4czh+wYeg5lX
         kUsnnSMj6nWg9BWeuIQ1TF0yBAMA6tSdiwXXSzFxhCH2Le72kw2oVkBHKs/cOp110oZ6
         HRkzcrBP19l3EVh7SQ/Ggf96Cyx3PXYngaWuamuTzMftXm4EOGNTDw3CngsmGIpsPR4L
         yh/e03psscifvVplwHXNJwd6PEvs4/CLzXi+5RilFuhHYktaS4QXrZMANwBZajxrPvPz
         QHJQ==
X-Gm-Message-State: AOJu0Yz+UuDZkoMGWomAM1Jou4907qw1/19OilzrtICtV4ElrxvujXxl
	gHKADT12bjlskh6cWwxBk3Ydn5/tlF3iBWWGAjCY8AGSL+wgGMniHFfTGF9GNIkWAeLvSMYbi83
	qijnws3yz5R6Ty1ETyfVvVHiNXp+8E8oTDF8xqJebWQ==
X-Gm-Gg: AY/fxX4c8Srl/YQ5GndM8WeNb/FpWG5mp0WCaUcvK876VCYC0i2UbG9w8acrHC2I37p
	RPy5zTGXqnsTlOlgEDeP4Kv7kxkiHkIBKkAO1fBHxLIu1KBKHDM8EOZwDIEtSfv6ur+9693c39H
	qdkzFUPoQadxWDFjhNHcRYGHcnOOR0v/eIfP4mHpuCG/5ZwMI63jviR4SoXxOajeqxDeMy5HU4c
	KVpiNSvKKqa6rCm1QCVJ6cw24qBgP3RCEer6SxbnLeDTyxuNTqSBnB8vf9l/0ZBlZuubRmV
X-Google-Smtp-Source: AGHT+IGMlM80JHHmEZKn0/ZepTrbMYUWWGVgnvyInQZ9HfxUP0BsVl2Hull3yJ5jz7mvq40YAEcuXWLZqjZJdNZ1fVg=
X-Received: by 2002:ad4:5d4e:0:b0:888:7b01:2839 with SMTP id
 6a1803df08f44-8887f241108mr283244046d6.16.1765985354309; Wed, 17 Dec 2025
 07:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111320.896758933@linuxfoundation.org>
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 17 Dec 2025 10:29:03 -0500
X-Gm-Features: AQt7F2o43WldDPgtwceYT2msiy8JqwvgErFzIzdQTa9ZMBPHuiN1N4vAb_f0Dwk
Message-ID: <CAOBMUvjkKTCcrE8hKkGvcX0AbGg2Sz3EzAeAtOW0VOx_2HUs0g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 6:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.63 release.
> There are 354 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.63-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

