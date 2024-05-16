Return-Path: <stable+bounces-45268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C868C74E3
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B501C21B65
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6414534F;
	Thu, 16 May 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE9hf5ya"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95164143C56
	for <stable@vger.kernel.org>; Thu, 16 May 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856978; cv=none; b=iI58OZe+9LJGnmyYw0muuUsZEmiPw3/x7Jgy/R7be29uMf+FSKadIwI2jG4R0n565RzLyimiSrgjgG41zRZjaaRKkzKKoDU6Jni55fxxWbxT4ATSW1S+9UcoB0JjxV8nHexWIbxt0WJumhebZyRJC2bN2tOUT+5itcI+8h7NsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856978; c=relaxed/simple;
	bh=aCXY487Vxu2tav49EYVB23ecLd3zrF9qRUTgLAbSiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4R1CgLGBDyG8tWR875KbXba5qWJ9Akp3nF6rzOf4rcUmheO23yX2owxIA8KIOvnxZlS98KbBtVCTKPpd9JoP4haG8i/BI1CQHngtR1BK7KaDWZhaFGFAAgnFJyjyyOtIrOEb6JRBaqyH/FiV1VQpsd1nJDl4n9flKbg4gkc1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE9hf5ya; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so2778724e0c.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715856975; x=1716461775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hvYdyfxE3IpE/vm58h7LJU7ngmgeqBpo8sHkqV4Ox4=;
        b=TE9hf5yaU8iDoNze1GUkhXXHYRmW/CsFo0KDlNOoaKgQLvkdu8+fp0VRZCEnrexS8M
         SqaKYSAAf+qUQGUCcU9Aftj2o5MF+qVIgMKZ7yb4rIKCVG9QvKYyG215U+7BHYCEAEId
         IET0za4d/eN09BoBz3pkqIw1CQD4m1W6MutiY1MOYa1udQ44KFFBF2X681WgWd6Wh/GR
         pAVxcSQdlU+BbNl8qnuYBSk4apX9qn63Z83dDRaVRFzvV0n5ZuOyw9CgFDA4jarOB4Bd
         rwv/aXTaaFFWow59+p0lrmtqkWaheERUTiD/VWY4k5f9fboiDQdulPoijHctpeFU761O
         cUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715856975; x=1716461775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hvYdyfxE3IpE/vm58h7LJU7ngmgeqBpo8sHkqV4Ox4=;
        b=lwxYZ/fRqdLtsmPYVSRvbosxbJ2n7TMVp6ICeGv87k09012dZozetyyP4bqZ9OELhs
         cilm/ER2skHTOKyO5Wx1BWYuruHHKwlqwEp+P+dyxpEPqyUU60yY2nwqxC+7kmDqgAHS
         b5FpV2eiiKnJV3UNerDJhVsL0fbKxFNGvxl9jMmD2lK5u6fKhr38hY5XrzDvPkw4Blu/
         tIXSEaOYLYID6nTZo8pdfB1l/7ISlfeKRqHxurSLl1j+JllBAhcSyg3ZdogoR38zaVGZ
         idz6PWtz9X4RY4uLzivRKQ/aVpoXc0wtASK2Zfy9GA4uTZEwEfRrVUUF/LW/WMijj5tY
         zhkA==
X-Gm-Message-State: AOJu0Yz9hGZMPSvO0Dz/TEkhLjeqfPPWsWVExQAihXIzCwhycTwdMteF
	ocWMTXKJLttz/ctyQnjzjCtBaPvDr/LVtcBCSdSR0E7jGFo6EHU718Nb7X+gXwDzK4uR/ECQWm9
	T9T21KG8IIX+Sez6sW2e/m2Hq9gz5KBJDMS8Gxw==
X-Google-Smtp-Source: AGHT+IHLfOcjHOyNax1qpFAJlUavmIK8GXsB4d5nnt42V8lPqyLhP6Ngp7Ge930ihPYf+AX/U/jPZnq78529h9Sa7uE=
X-Received: by 2002:a05:6122:4698:b0:4df:315a:adab with SMTP id
 71dfb90a1353d-4df882c2956mr17221080e0c.5.1715856975523; Thu, 16 May 2024
 03:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082517.910544858@linuxfoundation.org>
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 12:56:04 +0200
Message-ID: <CA+G9fYsZ7iTr8UGyaN-FB1R8=zLWnciB_10mzk8QCRhUMLSfFQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 10:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As Mark Brown reported and bisected.
LKFT also noticed this test regression on 6.8 and 6.6 branches.

kselftest-ftrace test case,
ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs
failed on all the boards.

Looks we need to add this patch,
  d57cf30c4c07837799edec949102b0adf58bae79
  eventfs: Have "events" directory get permissions from its parent

Let me try this patch and get back to you.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
---
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d/testrun/23938179/suite/kselftest-ftrace/test/ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs/history/

- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d/testrun/23929234/suite/kselftest-ftrace/test/ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs/details/

## Build
* kernel: 6.8.10-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: cfe824b75b3d9d13a891ad1c4a2d6fe0eceed1e9
* git describe: v6.8.9-341-gcfe824b75b3d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d

--
Linaro LKFT
https://lkft.linaro.org

