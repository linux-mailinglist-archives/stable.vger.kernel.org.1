Return-Path: <stable+bounces-69390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321859558B9
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBB62827E4
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376411547E9;
	Sat, 17 Aug 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIOCWr7n"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC978C7D
	for <stable@vger.kernel.org>; Sat, 17 Aug 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909140; cv=none; b=JFCq6l/HoqKE4BRG3bfgBNqXqP7VnqD94YABGvGf7IgQ197xO6GXz3RIivkAC10CgH907/joRIR6LSkrb4CxhVQn6meymI8SCFICL52I+jBI0XlwJw+2cpLWhkTBbVCESQXUbRSEyq8CP5H0L6MHZ9fyIK6ptUBWSTMtJ6sX9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909140; c=relaxed/simple;
	bh=wfAAaM0jmClhgcfNpIqUuc7ylHCMJJf9rVgMANon+bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e47GTCY4+CPMQIyWCGz/T3xAwTVuQ8s1LtLPMFW7Yw3SlrDyUIPV6gf45XieVgl1xA7jgwwMCAXxZ3pkZKVbK75IKa62kx9X8XwvxkfB4BQcyhPb0ZAdBWFlbXJkwRxIxLj2HlL74Wo2zZ6Bv9LBIWfEDDbgARxQm9meootwuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIOCWr7n; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d0dc869bso210109185a.2
        for <stable@vger.kernel.org>; Sat, 17 Aug 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723909136; x=1724513936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoUZ7+obYFa+U1vF9E6Yb2bjaEAB/EzTa0GZe5T7Ig8=;
        b=hIOCWr7nZvjp5X7lJkGln83l5Zl+EA5n+8O0TLsDwy28HIAMGnfMnAeTgeTp125A4V
         92kd+aGaLl/NSA+uD4I+Q1vOjvSghw76z7jJOCxO3kYL+YkRhdan4hn4DZjjhgWnZ1oz
         5YIs9FQBO/4BomnZfOGYhu4hEjPt3XgPNSQ174ddyQhih6rvZ+bwJ8T/rUslhD4HRv7N
         OCBg42pDUnV71LL3+EV5J1HJCW8gM39JSuHL/ZIUxIfFlBY3s3cy82HcqqdTjseDDgdT
         hwS2/T12x2YhvIBQd9Pg16ufkKxctlW7I5HQUptX82Jfk7MTWck9ijIgWdlCPBpkjINU
         LkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723909136; x=1724513936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoUZ7+obYFa+U1vF9E6Yb2bjaEAB/EzTa0GZe5T7Ig8=;
        b=aLAqQE/f/wZ2x+boTTQfd6kFOXqHt/FeNDIgVZDMqhyzHbkvjEypRgB4ijLP7Zaycm
         YciLwYH23DxDiEALnNmEvQMNXbODfet6Pg5h3VlEprlfLu6vtIOOIoJhF9xcmlxtAAe/
         WYYuTFmjAxG2Nu49ObVlZbAaXWrSFZ528RIV/11QppZ4+DAZk280AQL4Y2Bfv9mfING5
         vUXfDpTlHzK2lSTNe4M+XQovfypKcaHQ7IsXJjTERcv+UnNcBEoZmNbEehPYaCpAOLw+
         l5prFO7aDgZhxcoD/N/9jnsBN7NX5r7AoQQfJYnAxqW3Z6+ycRt2kpDIrdOtiv0itzLh
         VfqQ==
X-Gm-Message-State: AOJu0YwOjB3Oq0I1lB5GtTSCHyoB66FtJkFmbzPdbQkr2dEuKaUSGX6n
	oznWVZ4N2Lrp6CKdFMXbYohapA7ry+b4n3LE4Ix9OtdzuXzQihoWd4Ntt+X5VkvrKA57hRfK65P
	C4Jj1qwJxD9BvIT+ImlQj6aQo2ej+dbSjutlRkQ==
X-Google-Smtp-Source: AGHT+IGWz/aKYGezzhbX6UXoOIF2JUqK+K21v1uQbtz1JesDM2Ox49UG4VMgItHLMr5GzA1WLluSrMoJtabTMk3wpwI=
X-Received: by 2002:a05:6214:469f:b0:6bf:7aa3:84ac with SMTP id
 6a1803df08f44-6bf7cd86401mr77277006d6.9.1723909136016; Sat, 17 Aug 2024
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817075228.220424500@linuxfoundation.org>
In-Reply-To: <20240817075228.220424500@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 17:38:44 +0200
Message-ID: <CADYN=9J-7HS62eKTgda-kU=JCz3ck=UXfaYk1XTK5jXuybpo7A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/479] 5.15.165-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 10:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 479 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 19 Aug 2024 07:51:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.165-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following S390 build failed on stable-rc 5.15.y with gcc-12 and clang due
to following warnings and errors [1].

s390:
  build:
    * gcc-8-defconfig-fe40093d
    * gcc-12-defconfig
    * clang-18-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisect points to 5af75585e330 ("s390/pci: Rework MSI descriptor walk")
as the problematic commit [ Upstream commit
2ca5e908d0f4cde61d9d3595e8314adca5d914a1 ].

Build log:
--------
/builds/linux/arch/s390/pci/pci_irq.c: In function 'arch_setup_msi_irqs':
/builds/linux/arch/s390/pci/pci_irq.c:328:9: error: implicit
declaration of function 'msi_for_each_desc'; did you mean
'bus_for_each_dev'? [-Werror=implicit-function-declaration]
  328 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |         ^~~~~~~~~~~~~~~~~
      |         bus_for_each_dev
/builds/linux/arch/s390/pci/pci_irq.c:328:44: error:
'MSI_DESC_NOTASSOCIATED' undeclared (first use in this function)
  328 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |                                            ^~~~~~~~~~~~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:328:44: note: each undeclared
identifier is reported only once for each function it appears in
/builds/linux/arch/s390/pci/pci_irq.c:328:67: error: expected ';'
before '{' token
  328 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
      |                                                                   ^~
      |                                                                   ;
/builds/linux/arch/s390/pci/pci_irq.c:301:17: warning: unused variable
'irq' [-Wunused-variable]
  301 |         int rc, irq;
      |                 ^~~
/builds/linux/arch/s390/pci/pci_irq.c:300:13: warning: unused variable
'cpu_addr' [-Wunused-variable]
  300 |         int cpu_addr;
      |             ^~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:298:24: warning: unused variable
'msg' [-Wunused-variable]
  298 |         struct msi_msg msg;
      |                        ^~~
/builds/linux/arch/s390/pci/pci_irq.c:295:56: warning: unused variable
'cpu' [-Wunused-variable]
  295 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                                        ^~~
/builds/linux/arch/s390/pci/pci_irq.c:295:53: warning: unused variable
'i' [-Wunused-variable]
  295 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                                     ^
/builds/linux/arch/s390/pci/pci_irq.c:295:39: warning: unused variable
'irqs_per_msi' [-Wunused-variable]
  295 |         unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
      |                                       ^~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c: In function 'arch_teardown_msi_irqs':
/builds/linux/arch/s390/pci/pci_irq.c:395:44: error:
'MSI_DESC_ASSOCIATED' undeclared (first use in this function)
  395 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
      |                                            ^~~~~~~~~~~~~~~~~~~
/builds/linux/arch/s390/pci/pci_irq.c:395:64: error: expected ';'
before '{' token
  395 |         msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
      |                                                                ^~
      |                                                                ;
/builds/linux/arch/s390/pci/pci_irq.c:386:22: warning: unused variable
'i' [-Wunused-variable]
  386 |         unsigned int i;
      |                      ^
cc1: some warnings being treated as errors


Build log link:
--------
[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-480-g2a66d0cb3772/testrun/24903946/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.15.165-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 2a66d0cb377282f04abd41b09fbbbdebdf39e5ea
* git describe: v5.15.164-480-g2a66d0cb3772
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-480-g2a66d0cb3772
* arch: s390
* toolchain: gcc-12, clang
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kmLyVVnghC9nRUIBEQn4Vg2fzy/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2kmLyVVnghC9nRUIBEQn4Vg2fzy/

--
Linaro LKFT
https://lkft.linaro.org

