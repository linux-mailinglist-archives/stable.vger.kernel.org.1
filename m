Return-Path: <stable+bounces-189189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B45EC041E4
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 04:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D364EE111
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7914B06C;
	Fri, 24 Oct 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ExALIdZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8624E4C6
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273043; cv=none; b=fWEHQAoNGonXcQOI4cru8ZLWK2JDmXRaUtsjdQdGf9y9mhHR+3VwGjvSrdRt+TVRQJ/9/1omlATiVxft1dpOqvLepKGVOeq5dyS9IaDilpJ3bPBIywnkXwfni+0YmZ1QtN21CKej00FvFi92gmlVX+lCPSRK/v1FX0YI31wFjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273043; c=relaxed/simple;
	bh=szbmuMYt3jdpMXAfYeVf+V9lmtQjURi7oe5aHr7wM/c=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=S2Bus4GK8piH+bnEg/K52jJWxMkM4XM3MKG8iJZjSuO877prifi2T/kd8GuO7Z9MSYMrt90lUTM8ovo/y7b9JxX3WKwWS7OMtJwgXc9TnaCScStso/6/SeU/oY09LarHFAXzxUZwlCR8qPiZYk3y8n3uGtbxjubmu0w6LV35g7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ExALIdZK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so1517052a91.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761273042; x=1761877842; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi+F4ucKsrSujWRZ2QDX9jnGyIvHoHyd83ZHmQldU0E=;
        b=ExALIdZKIA6nFTy2JJNHDrAlhaC0PcnKAQxd9PSrvDyZVDwAS9qyBWj7TjKL7wjs5B
         wUS78LpvrEPW9MjLDlie2tpq31r0TPp8Gh2LU7SufgjxOnsuyJH/SjElzkwNCt7LctBv
         b1jvR5KUHj0fzrHSrfkZPwlSMnjSE4l1Bv5z+f8JDhKSESCIt9vw+d143C0SYbV/VMeB
         IOt0N5R7BqfrSWOQSsFDW3l4PxhuP5ksw8fw0OfVJp/F+FRyRy8fc+J82owgyYXvprVE
         5bW6wdC4OSuaNfb3t/y/4uk3XVGt2APdR28yuJpdM3a3z5DXuNmk2uXnCkOg7Rly4gRm
         bS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273042; x=1761877842;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yi+F4ucKsrSujWRZ2QDX9jnGyIvHoHyd83ZHmQldU0E=;
        b=f2HeqqkRJ/UIBM5RbrGrS+UdVFSLvDEvADlaYVNp4CgBfF0pjM/VUVNYBFg9PUYeRC
         r+szA5lI61W/YwLZzUUJwaUKmj2VteaTo/lZS154luj1n+vhjuIuHwl5Zp9TvNc+1l/k
         b+aSbI8KGjirxpaTFApxAj6rbAkGpQ24oqzsXyZSCf8jcBVi6cHM+xDsdQ2VEwxs+r7F
         COBrPaN+RcVgBL4vtbRwtHrma6f/azyQAxVKK51LoUTywHnG0bGsILbDvcOYRdOo2Tve
         lZIXHXunDkpW1rTfpap0gJgcE/jM1HmGe6/nEbPrZ+zW6nOAaB7VuQcFBOT+VFLkv5IY
         gWRQ==
X-Gm-Message-State: AOJu0YxkGnDHpbsoAzMcu1rCOCOR/jrFa0rNvOts5gyCqj5XVdWXuAFY
	EzWoh4RZrdaSCm/AuZcR2ZxIWRygjjphg1tzM2lNaz7x1l9PYvVHQ0n0JO4JBMqDKoPaqq6wT63
	SAitgSsg=
X-Gm-Gg: ASbGnct+F7SoFb1BWgowO7Gy6a4R5hmJNSv9a1SdSmClThxrz/F0x8KeAHBgdASNogC
	Xdwr1RMBuW1FlHjg8kkci1vo0jB/fsy4qPG72Aox0EJcnBssowKkAAyci4iDVvtbgS/a41Yk/fk
	oYtg3im/q5TRzrr3FhqBmqZpWGe3gXoIrtPW1g+oc6Kxb03AahmQAXbYKrPiW1J8991L7rOq4y7
	hIeU2G0+6wCTvpaWTMfgTOeHEM+CQGYcD94JSoUeXUK3rJT92X4fZCiMAiIarRB/yN1pm8r2mnP
	4oHSyBFIKecGPFHv7Mx0U0kTP2tiCOzO1iH4hUCBytWaor4mKh74A0IThSLJMHQG+WpSUG3lJIM
	WVOfSkQ5TeUJqJ4wMJmhkwr2NzaL7Ojcqt/ndYLgy+Cf4noEois4xoMkqY8r9pc0R2ANszQ==
X-Google-Smtp-Source: AGHT+IE88QRVeKtUy2XvVBccDhBcNB6tPti5DvxDwQs0apBBj2rTiUzYKdbalgW9MXLr9qpQWKgy7g==
X-Received: by 2002:a17:90b:1f89:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-33fafc8a0c9mr5498464a91.35.1761273041759;
        Thu, 23 Oct 2025 19:30:41 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a34esm7401019a91.15.2025.10.23.19.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:30:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 4fc43debf5047d2469bdef3b25c02121afa7ef3d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 24 Oct 2025 02:30:40 -0000
Message-ID: <176127304048.6187.7635196613052088404@15dd6324cc71>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/4fc43debf5047d2469bdef3b25c02121afa7ef3d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 4fc43debf5047d2469bdef3b25c02121afa7ef3d
origin: maestro
test start time: 2025-10-23 14:29:15.692000+00:00

Builds:	   37 ✅    0 ❌    0 ⚠️
Boots: 	  169 ✅    0 ❌    0 ⚠️
Tests: 	 9431 ✅ 5597 ❌ 2428 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: acer-chromebox-cxi4-puff
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-12
      - kselftest.cpufreq.hibernate
      last run: https://d.kernelci.org/test/maestro:68fa48db8a79c348aff82bf9
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.hibernate.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:68fa4b9c8a79c348aff83bce
      history:  > ✅  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-12
      - kselftest.device_error_logs
      last run: https://d.kernelci.org/test/maestro:68fa9d408a79c348aff8def7
      history:  > ✅  > ❌  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: dell-latitude-5400-8665U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-12
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:68fa48e58a79c348aff82c7d
      history:  > ❌  > ✅  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:68fa4c6c8a79c348aff8427e
      history:  > ❌  > ✅  
            
Hardware: hp-x360-14-G1-sona
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-12
      - kselftest.iommu
      last run: https://d.kernelci.org/test/maestro:68fa48fe8a79c348aff82d62
      history:  > ❌  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

