Return-Path: <stable+bounces-100916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503529EE7A9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10542282B2F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76352144A6;
	Thu, 12 Dec 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIFHlZAt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39831EEE6
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010108; cv=none; b=aBw4xQEpU39r/8lGJ6OV58zpqUI6dZT7wrUxaIBqt7IGgRXI2i8V13qIy29y8aAkgnbzwomq6jIoYIw/qV/tgB9oEagajsssrOlzj2BOqhQjQCnqYeVj1+S61xuCFvH3jy/YT+87SzWd7PZSaMj7wXESirJjMwqRp+LKUK6blDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010108; c=relaxed/simple;
	bh=qB5GHD+TAqQqOCOrGJw29gHTx2AMBPopU5z7hFbX+qQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I8vGwA7em2j2AXFzwXua8hkq9py9ZHWD+vdQdfacBzQ+2DM5+mGjrRWky4YOtBGdChgwRYsMk49pWBHO01V9onIEzWQ6jwTh4bxeyfp0HOO/FZSTtKld55qeDAG3vBYVzDVO4ww3+qjpbx3v1oDfEncHAx9OD/mVXsStfZFpD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KIFHlZAt; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85c61388e68so162562241.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734010104; x=1734614904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CcyvDeMz1OALANvAAZKMBg7sxjfX8hsRqx9cvQFOk1s=;
        b=KIFHlZAtBTTAgPuwBXm0sleUYoqYD/ZH+QRYSSfgb/fUbi3vngswUkk7fnUjT7b7Vx
         0YXuDT73H50vkwLfCu+r2yPR3/s+nB9maH8Ro9SMWEaATsVJrDUTxwjiCiwHrGFOWnHX
         DXw88cnE7XVgp2b9LcXGtS2NWL1lOBkXqW2ek3EfIVBW6dxyI8E7Bwqot8xFtPZ1nKne
         sIxtLprm7UdIXjDvbUpEOTSaR9z1gJBGUAcgWZJKU6g3rDg2QZdorkQ5F2U+DHwQaA3U
         yNkgamqHHvj3sJQodYLA5pdRAXqEEOOJwttwLuFZKeK4qrialMM5J4hblYx9+I0zpL1L
         yQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010104; x=1734614904;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcyvDeMz1OALANvAAZKMBg7sxjfX8hsRqx9cvQFOk1s=;
        b=WEd+YD6a4nSh47KwuAiJBaXg5wTNsN04eAYQK00cQYk5p5cCsHo38G/yhFuTJKXJzV
         bsXumBTM1pd9vonjUbkuvqQVTOqlBaIyqVDavE/SEMX3GFSpoHz86N3NC45r8NmxhJm2
         GEzpaq7dtUNiUeKqFlxD0GsJLukgWb4p55+e6S7v1i9qWIHV4b9WDPVEXiG3D1KBLKY0
         MfcDyTmYa5xHMP9zBFLSu7nQwxP7zXbwGRig6PB5tVgU/Efsl4A46nWcWngdxPqk9cIt
         Dff+s6u6eB2ljqm3fqTuXyMk5Ax3CYo6nXt0gCYdCePlk2nbUIYUWxzc3GHZLLGoBrL/
         IGxw==
X-Gm-Message-State: AOJu0Yz9UvkLGHRtGx9u2lCmIIdZdc5NM22DuaeuCww6OwvWS2zsWiQp
	5SEdZPA4PFW42Y8YrJnKrW5EFGM3uZKZHgiqJjn3yju7yAtm31W8v6hUOJKd0CmIEVlzhZyE6mz
	CAbujFS+AmAL/1pDJGh0zsYusLd/bN0bOeM5od5RoVa70qiiObIk=
X-Gm-Gg: ASbGncsoixuEk72kaFdrBhqtLpBKo+UmFOgRVJ8PTDxDKepO2mZH8vs1I/hCg1fbKHa
	fbWGKMNxv7gOZUCpcqkUokLbAhOVGfIIpP/EV
X-Google-Smtp-Source: AGHT+IGzEL4b6WkVdMy16flT3De7E7bEpOMJbkZMkNdDRIrjLYETlQYnJDqWIV3B8upOWlxVXBABZMEhoBQi0Yjzs5Q=
X-Received: by 2002:a05:6122:169b:b0:516:1bda:b364 with SMTP id
 71dfb90a1353d-518c5761f3dmr550305e0c.3.1734010104033; Thu, 12 Dec 2024
 05:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Dec 2024 18:58:12 +0530
Message-ID: <CA+G9fYvkiFZxYFV_jKYOgePNMJDjQHL+BVo8SUWNVS37=aR5ig@mail.gmail.com>
Subject: stable-rc: queue/6.6: drivers/ufs/host/ufs-qcom.c:1929:13: error:
 'host' undeclared (first use in this function)
To: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Benjamin Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 builds failed on Linux stable-rc queues/6.6 due to following build
warnings / errors.

arm64:
  * build/gcc-13-defconfig-lkftconfig

First seen on Linux stable-rc queues/6.6
  Good: v6.6.65
  Bad:  v6.6.65-348-g690f793e86f4

Build log:
-----------
drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
drivers/ufs/host/ufs-qcom.c:1929:13: error: 'host' undeclared (first
use in this function)
 1929 |         if (host->esi_enabled)
      |             ^~~~
drivers/ufs/host/ufs-qcom.c:1929:13: note: each undeclared identifier
is reported only once for each function it appears in
make[6]: *** [scripts/Makefile.build:243: drivers/ufs/host/ufs-qcom.o] Error 1

the commit that causes this build regression is,
   scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
   commit 64506b3d23a337e98a74b18dcb10c8619365f2bd upstream.

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.65-348-g690f793e86f4/testrun/26279249/suite/build/test/gcc-13-defconfig-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.65-348-g690f793e86f4/testrun/26279249/suite/build/test/gcc-13-defconfig-lkftconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.65-348-g690f793e86f4/testrun/26279249/suite/build/test/gcc-13-defconfig-lkftconfig/details/

Steps to reproduce:
------------
# tuxmake --runtime podman \
          --target-arch arm64 \
          --toolchain gcc-13 \
          --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7Ekivz3juYAyrxbUVAOGrVOAe/config

metadata:
----
  git describe: v6.6.65-348-g690f793e86f4
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 690f793e86f4efa31ddf26a48f4af8c28d2f8402
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7Ekivz3juYAyrxbUVAOGrVOAe/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7Ekivz3juYAyrxbUVAOGrVOAe/
  toolchain: gcc-13
  config: gcc-13-defconfig-lkftconfig
  arch: arm64


 --
Linaro LKFT
https://lkft.linaro.org

