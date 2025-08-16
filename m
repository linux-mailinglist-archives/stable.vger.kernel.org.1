Return-Path: <stable+bounces-169839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66977B28A11
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 04:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA89D1C27196
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 02:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA9A927;
	Sat, 16 Aug 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="w5vuqeYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E86FC5
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311447; cv=none; b=YdCW8bjfvn7rksyxj6kbxwZoWJVay/dYV2OSsuoPkcufTKgMP1RON8fAkIvG+CEHRJMNd2xUcUvcduI/Unx6a3t6NAQ21Bz78POVSfgHh11PUuL/wGEWAgIeNJmqTGLVU+VFudhgyTI8uqCuquOVxuYUlaMmQfG9mVmNJJkx6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311447; c=relaxed/simple;
	bh=tVb5S5p1HDKC2XRc0d6iiNrUVl8TlvXghlpUZ3/aTNg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=a725u//mZrDQz2VJIl/XwKj5wiss8DnvoqSwcR0XOl142kGiJrnRf+QpdPvxDFwVmUSyuvK2YK1odd0CoIVSArnUpb9yUniKObWxRX6fUJitl5tyT+AoiXFOQoPhvc5hKfpUi8ceQ/ek1kT87N6iYJz/66kByn62toEHbJ26cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=w5vuqeYp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so2088987b3a.3
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755311446; x=1755916246; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owB5pGxmWpN7UqCPeSaaQjF/9eBOK0KZjBX/iEpLNcs=;
        b=w5vuqeYpe7SVdGuxbSfdvIbEM2IOMit4AmqIO7Y7/IOgujmpcnZhilAtoShRAyPTEK
         ew8YN8MG27ahrz8UYEIge6x/DxNiKJYqx9XR3+YtE4jyVHtboQpM5sh1IXVJby8M/AkJ
         mEgNSZmkN2aR/kGJfRvHzHlNcQz+X0AnxrJSgzKB7K9WRAk51UYr48jNkXzZemqevoME
         GXKtZ0qeYjY+AtqpFVKxzcOPMJeAiZbuCGulh0PIfexq35zqflTyHRYE/+5chR7Ze7bK
         WWjaGbCt0OfTmwDhjKOLt2u2rxFG/lnaamLijKRZ5kE6TvycnqPi0M5u1KLCO+HbYICH
         07UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311446; x=1755916246;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owB5pGxmWpN7UqCPeSaaQjF/9eBOK0KZjBX/iEpLNcs=;
        b=doEu0gK4hnaG+jTln54Hu+qj/U8Bx8sCeu+m/5OWt6CvGJjY/lRhk94LYBIErci5ZZ
         dlmPlBTQZ/oZjq0ixRgthtVngD4iG3GRJ+lMTD4zFXwxU2M8oDnM64g2vfr/MBz2MKkU
         +A5K/qzGmpSrp+WV7R1tlakHJwl63yqDE90a3IF4wE+pHR0hTenz76k65vDO9Sd1+0xM
         jekuFlSCZdosGiB/MEi1ypVPMLlDnXExJFErha8jlW8zrJ4UCKrAtc0RcGRjky1mD2jX
         DYj488PJBcu8nC2z0DTRLYDHjMy+sGmqL30C5x0VqoLuHZaDIXQVdQ9EF5lhpMv7yHfv
         qzyw==
X-Forwarded-Encrypted: i=1; AJvYcCUVyzQEh3EEtiHVhyZ58i7BFNQOS6ERrJG8xsS6D5vT3q4ZTZ5IyAFJ4DozDgfpKn6RM+yDIgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPKab3RhI6BqssUelhr1LKuFhGBf6x2lDiN0t6w3137iqxHdP
	fAtOu0RzQhfgDArGeY5LaAmOOFUj0rzfNMgX9ugG1KQvNdly8o+73+81QwWnWG/4mdDUvIA8g6G
	os+63
X-Gm-Gg: ASbGnctx4fu9BR+ERDJc7vRnmNbDgFsEvUhlJZrSVJ39zNKCR8kJyoedd36SvFP4ueh
	nhazEETZuqqx+bQv9cQEefyQ34hLUuKHSiJe4CvxI7hd6Ns0AIQgysL9ekzcArKHltCIr/SLm8z
	+V0vOD5b2lRNReVJsZQ81TPXbR16q6YjUZvyuMjQka8wLz2dmGwSvRtxWp2GKe7WO6ez5zA8jdj
	l2Q27ZrRg644xdRcZ1XvrXN9MNkV6IRsVBbgqW9C9vKIsUyPKRV5Va1EC1CuPWW0djy3WzNOKPt
	DGDAeE1b7Jn3+PdCtWog5sVXcoIXVUXeg3BfOo1/33CQVRWCmhv4z4zYMLyYvdV3nr+iz1TZsQ7
	eA+2OsrSAYMyTSB+u/SO11ueShzI=
X-Google-Smtp-Source: AGHT+IGmYeBpGa2WCd8P+YDdLOwOwF6EqSi5HYbwPrHe/ox0XjIQAHE1shmZ4KkxK8yXbXeCnCvlVw==
X-Received: by 2002:a05:6a00:1793:b0:76b:e561:9e1b with SMTP id d2e1a72fcca58-76e446c8803mr5268669b3a.1.1755311445584;
        Fri, 15 Aug 2025 19:30:45 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452663f0sm2113763b3a.21.2025.08.15.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:30:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 16 Aug 2025 02:30:26 -0000
Message-ID: <175531142617.276.15689034104295468004@16ad3c994827>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/880e4ff5d6c8dc6b660f163a0e9b68b898cc6310/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
origin: maestro
test start time: 2025-08-15 10:52:20.130000+00:00

Builds:	   44 ✅    0 ❌    1 ⚠️
Boots: 	  160 ✅    1 ❌   41 ⚠️
Tests: 	10405 ✅ 5245 ❌ 3110 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: acer-cb317-1h-c3z6-dedede
- kernelci_wifi_basic (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:689f1bf6233e484a3f98a8b1
  history:  > ⚠️  > ❌  
            
Hardware: acer-chromebox-cxi4-puff
- tast (cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f2110233e484a3f98ccb7
  history:  > ⚠️  > ❌  > ⚠️  > ⚠️  > ⚠️  
            
Hardware: bcm2711-rpi-4-b
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:689f1a23233e484a3f9880c8
  history:  > ✅  > ✅  > ⚠️  
            
Hardware: dell-latitude-3445-7520c-skyrim
- boot (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f17c2233e484a3f986a63
  history:  > ⚠️  > ⚠️  
            
Hardware: hp-14-db0003na-grunt
- tast (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f17d9233e484a3f986b39
  history:  > ⚠️  > ❌  > ⚠️  > ⚠️  > ⚠️  
            
Hardware: hp-x360-14a-cb0001xx-zork
- tast (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f17db233e484a3f986b42
  history:  > ⚠️  > ⚠️  > ⚠️  > ❌  > ⚠️  
            
Hardware: lenovo-TPad-C13-Yoga-zork
- tast (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f17db233e484a3f986b45
  history:  > ⚠️  > ⚠️  > ⚠️  > ⚠️  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

