Return-Path: <stable+bounces-96149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E44419E0D03
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 21:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414F3B39EF8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D031DDC24;
	Mon,  2 Dec 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehdvq5HD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7B1DA0EB
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164261; cv=none; b=PbN+2P+1xmotifrK+cuXUKsS5hieOOxiVIaAFJ5bdWniY77WGjmlibOlKghjeZQ+NiIsINGCgJmKDMw/OcQRv2sD7p5lU0kDFQq5Zn45sDP84wDxhfiXDDOGpseUtWXVoX72LrWirviGGlQrTkwlELuoI2/uYGI4GQ1xo91TU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164261; c=relaxed/simple;
	bh=2iScdVCBMpmjjiCXk0OlK00wqChwDzGVlJmeztoW5S8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CNrLUSJ8oCmqRMzI/7hbo/7JbYk9Xr51eBRDBdstFVTnjGneCuzOVH2C8HN8VMuDwgJPhomZOsn9XQE+telD9pLqY8cFt68G007MhxGFqEa/qGMIP0wb92Av+EOWqREGwcSLy2SSHqo8g8X+CtShuhp0yxbjnmPXn+idfJBINw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehdvq5HD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d40fdde2fso1614585a34.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 10:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733164258; x=1733769058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hr3Gd/LiFtAjtQkwDJjm0PXxkVfJjoGp7ojBnwj5Gag=;
        b=ehdvq5HDhLpBkGeEKKXV+jn2YqsS2FPLGvxcZBYZG3bLRyjdVW4azQhHNi067shAS6
         xunefvMpi6WRKwRN+g1RUUjUPdPt4J3bLmuyKMDWkYj9bF03fF7CB41tPTdrEtXEEW46
         sCwRs3ip4pxZy0Rarq4+MLdtxm/oc/vZwIdj4KfrAtCRo0F8RKBDxFFA3qpMX0DPLQKZ
         QaSQMRG2bxQA1M+HH2TJ3lDFli+oOVKtocX9uoJzj7Uu4aCkEe+HGmxOFNxHLop2jqn5
         0fBIFODIBUdDdUY2meoNkg0aJ4iH92bHDM/X5LfugTVivMX0tAHxiY86mDMHLOwGjavu
         5rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164258; x=1733769058;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr3Gd/LiFtAjtQkwDJjm0PXxkVfJjoGp7ojBnwj5Gag=;
        b=bIPBDtk7Eq+krISebYKV2g3BUTg7JXmWqKy5/hdtX6Wic0w1cZsDVP6xuwZivNha0Q
         tUXhmeZEEPkUTCWlLMVSNUGXCraWOZddKLkNd4DLK+v0a/HFPKG6It+RvCdNfduxQBSn
         Uzw8zjWh/dxxNI/k0rMcTGRncNfsj1eVxt+qcMhcDBz///XUZuVbF9V3j0SX/EmFQ5rN
         O3Qx+OCM9MMN0NXKC31BEQtjbc/WIIEBP1M2Rh4xbdV+qwdEObluYJY6xLAcYXRy4S30
         SHlUsSjBBi9WhUdG5CpBJ5QAnrWyZ48OyrTsgpiO3XM7KMETSPctlIitNFRQro1aYb4t
         Lxkg==
X-Gm-Message-State: AOJu0YxIrN5dd65FtYTetuPH+G3Ykbpe53CgkyyXkwEfPzRdaxQHYOsc
	bHuz0IJbVogtD7t96Zy3JLJKdci4EY2H34YRes+SA00/bRLzdzDsUua516XqNHnyzQTTsflWS9f
	p2emseTCop7bL0qbmwuLXvgVVz9z2rL1xM6DFCIfBjvLOzNHwNiM=
X-Gm-Gg: ASbGncvGshKEUyCWod3/fCNScFHpnrDz9UWneP5RVqqrNqHkUnEw3b+12yc8u2RutDo
	Mm3lkxut6hbo9klztCluOKydfXJzJcHiy
X-Google-Smtp-Source: AGHT+IHlNZ0c3FgMSDeb4X1ilFXmlXpiLh2UyuryMRixGlP9qIERz81Jb/a0RHj6dZKqNN3qYCgeYR/htw4LOwHnoLA=
X-Received: by 2002:a05:6358:5d84:b0:1c3:75c6:599a with SMTP id
 e5c5f4694b2df-1cab16a573bmr895060655d.21.1733164257961; Mon, 02 Dec 2024
 10:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Dec 2024 00:00:46 +0530
Message-ID: <CA+G9fYu95a2Dy-R-duaieHVOM9E+zeKu1EF+YJydnaD7nxnhQg@mail.gmail.com>
Subject: stable-rc: queues: 5.15: arch/arm64/kvm/vgic/vgic-its.c:870:24:
 error: implicit declaration of function 'vgic_its_write_entry_lock' [-Werror=implicit-function-declaration]
To: linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, kvmarm@lists.linux.dev
Cc: Kunkun Jiang <jiangkunkun@huawei.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The arm64 queues build gcc-12 defconfig-lkftconfig failed on the
Linux stable-rc queue 5.15 for the arm64 architectures.

arm64
* arm64, build
 - build/gcc-12-defconfig-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------
arch/arm64/kvm/vgic/vgic-its.c:870:24: error: implicit declaration of
function 'vgic_its_write_entry_lock'
[-Werror=implicit-function-declaration]
  870 |                 return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Links:
---
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/history/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/details/

Steps to reproduce:
------------
- tuxmake \
        --runtime podman \
        --target-arch arm64 \
        --toolchain gcc-12 \
        --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/config

metadata:
----
  git describe: v5.15.173-312-gc83ccef4e8ee
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: c83ccef4e8ee73e988561f85f18d2d73c7626ad0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/
  toolchain: gcc-12
  config: gcc-12-defconfig-lkftconfig
  arch: arm64

--
Linaro LKFT
https://lkft.linaro.org

