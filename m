Return-Path: <stable+bounces-61875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79DA93D306
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA51F1C21871
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2A17B409;
	Fri, 26 Jul 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="W8xXGrRk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AF178CF2
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997147; cv=none; b=fM1rWxdsG6FPnzu9XlMBLUPIxiF2E3L5vsZV4YCKCKK3hRLDPtHENISKNW0M6dH6ZUyRYbHtIgJo0YT8n8qLpaaq6YaeIfD52mltbhQZACzQ86vsgueZECfPlsJI5R68XdlygUsbuj+UdaUpt3twsX22By4tvaoI776Kze6fEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997147; c=relaxed/simple;
	bh=Ow0lF4PR1W4zPn5dnOxQWbvpWyIhvhfyYRUku7Phcrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/QFdojBNhHRSLcyYUnXgjJZGNjtcwr0eXjoi7gTa1b7jgUZGbPqjbmK8HW+u5B74GLo0oBOvgHNybigTc5iy52pcCi+SYEj4UH8+7ue2ZLqZ+LDcKqJQpqWvHCeyX5nu2BYbe1r6RhgONWxcV4t8eHBfOxiNSPsMn51fPvhqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=W8xXGrRk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso674418a12.0
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1721997145; x=1722601945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2CXarSgTnQy4ZvMHuo03qNRpFcxWzwsegdi47MF0qg=;
        b=W8xXGrRkDpidzv4aJEcx3FgioSldwL0GlbBZS83Mz+uZ5AyaU74v1H/8MNmWTaZIn3
         xGCF961mDx5Bd/g7+jZSnZYYiYKyIRXaaG2yvks1pcRQ9OPNsd+1b+RqkWO1AtCWuuWb
         MoLt/HMVtzO720zgm874dXDb4mLkdmSnXS64H2z7EHNgmPA1U+4V+MzKPW7o5BIgz72U
         J8iHZwNMCBW96XqnkizjSG+268kOgvMxp7YILsvRMrEB54xiIUxykNZkc0fJ5I+qwZ93
         tr2pgkmRd+3E5Kdu0j5yCzd7XcXef7w2rF7wQRRYa3OtUxJBQpMpufIme6r38bhgoozR
         5nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997145; x=1722601945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2CXarSgTnQy4ZvMHuo03qNRpFcxWzwsegdi47MF0qg=;
        b=rbm2V8O/a469LQxPGMdS9X/LYZv4sbKiCftBnLgsMZ12eQR8kgm0QnWCa67qcKc9+Y
         OB+UZ3mWpX/wL/41M7Uid/zTaqOmmBIQSXOKRUtwFRDT9uoxkyXItMevwCsSToKCJ5+H
         Qb3FW8STfQFtFZYI29ra0nOchJAgEvd/6WYdgKD/g4IPvuK3kyBNbCyo6chX1bn7BTkQ
         m57kWvP8sP+2Igelut98Ybh+uMXR56WdzgKBI0sKed4rwy9DkMt6BXiIHTi2RdMNpVL3
         OPLJzn3vS58prMN+TMKMqH34mNhsUd9RDlYWsIS+wjQ66e3YjkhR1o+qYoTjbTJi3rtT
         kW8Q==
X-Gm-Message-State: AOJu0YzErdLchbTzcv7GlRIKjCjjmsNn+czaRwXAX0aMOclhmsSZl9Ls
	gVbAJCs3l3NEh2Sgc/GoSSUZOrko/PuQEYTgAq28ho7xJqgIHbp9eMeTnRVgCR+vK7PZ9ela6Sh
	lVCg+t6YHiVHewPDdNzYzY993cUIpTz3UXn/XIQ==
X-Google-Smtp-Source: AGHT+IECb8woF2lIKmHKOjmufAD4JhhxypYA+icIANC3xTm1uDphLcOwr+ij+DGnOuZ/K/cor76RApG76j1tmrVHkmQ=
X-Received: by 2002:a17:90b:164d:b0:2c8:f3b4:a3df with SMTP id
 98e67ed59e1d1-2cf2395832dmr6365849a91.42.1721997144677; Fri, 26 Jul 2024
 05:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.905379352@linuxfoundation.org>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 26 Jul 2024 21:32:13 +0900
Message-ID: <CAKL4bV46vNSzkJQXBH8xOOSY70Q2PCoKoyJpmFBHPQzs4cdL0Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Jul 25, 2024 at 11:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.43-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.43-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240720, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri Jul 26 20:55:25 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

