Return-Path: <stable+bounces-189992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC8C0E3FB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 602584F59F7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316619EEC2;
	Mon, 27 Oct 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nldwDBug"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5E25C838
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573551; cv=none; b=FsE/2j74sjMWbOeafgY9apMibAkQDG+1YGiG4hIRtRFTrVHIMulyrB4EV8iITmkH94OOY3/+DbAvBAX00Gyj8rdvAwnAdigYMz/3tC4FnNKFiJADhyo0D+a683e0j4lPHRK8y5gGMhF7j4h5FQ63xhIXZ9E4+beEMMOi+o7GVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573551; c=relaxed/simple;
	bh=NZEP6mrwICAFC9jSIVpWUdxWgboJaGICbNnHkaDqwdY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LXTuP+fG4aabp8uXM5PKbomEDLkLXXDqcldVRcmqzFUngLd1iQ/Gg31Xqqs0M3M3r0XQ4RKYbjtlaniajohW5xakXfcwN7bAWk/D3yyVYXAG/NQdm/cWar18LW8pnTR+wOYvRpk5nBn9Cv2MzW+IK068wlStfhzQAyww7jG2zms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nldwDBug; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27c369f898fso76999075ad.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761573547; x=1762178347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIXH5fMTmUN/OgXHjg0ubdyR/0iwILkJTK0MF44t47A=;
        b=nldwDBug0gGDqQJ9RS10I7Y1BJxX9CT5J3HU20E2fRk8FkrlM/IG437NUG+Zq8WbVc
         hnyo3rsgQxv50ZUliTdY1aCju1D1zaOhT1XIkTUF5PMuqnxUQiyeYc1JUd/prHPlBSxD
         TO4LPMVGqUoOllyOlhggXEHIcbCKsa+dFcAq0UAu7/S3s6ajCTd5QbtUgcRIRS0XEXRe
         yeq1fVFPGlXvOp5evbAAqrRAwtkY1AkmpOyVpxKEJDDOkl0zxayGn9CD+feHPX5q49Zn
         xdi02fICUS8mejTJl1geHj2BsO4xizRfDw+BmwbWNLEEOdR4W0/b95u347lmhoq3RtK6
         Tj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573547; x=1762178347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jIXH5fMTmUN/OgXHjg0ubdyR/0iwILkJTK0MF44t47A=;
        b=u/d8QUj1Sz3hj3TfB4DopL4ig1Fn1SOAbpLv3h4UalaahqmMDG4ZiBossRc4vU8ayU
         T/Bc8nseN4jXUBBFkRTRTvuBxBIYnzuNly2czeyC5mAyWRZgfU2uIsB1XXesokfQzpRW
         Y6WyIGzgrP5BpZ/6/z6pGKNrvn/LO/QjuY14C/jdDxEBRJJ3U7U63AuHhnXLNlR0vj/M
         ibCMHRl6xoQ2dd5KhsopIrE5NNZxWusiYNYRrCU8+z3d7eR3HAyP6eL1bElf9Mvq+dLh
         dLqgkHxNTOqiHydHt8tcCMkvp7oE9Y3xRreTYpz+NG7yKt7hvkchq6oHws64hu+ag1j7
         Uoqg==
X-Forwarded-Encrypted: i=1; AJvYcCV2qu22vsM2hQsHIDAx866vC+HKAo2z3xvsl0GVI9YUl3hXcPqrCW4ICi8kmwXFi/NQltVrxyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LgxArLmIDB9VtsoLUCHGc0lmZ9fhJwlhobNkDcKKd9hdziS6
	BMDfosvJjPX57X/1ap8PVrW16u0vTkcN5C7xP5kWDsA6uldseCzkk/3cFwtDO4Qw3R4=
X-Gm-Gg: ASbGncvuoo8IL/zbASfoiWN/De5AfSPhq1HbMJm/fc7qrHWcg9LtmFl0FNXUGb/amO6
	nY726NLyCBMQYgbUQdFt4rbxtTce87XzfE1pYLiLc96cRQFoI0iYgaSyFETVY0iqQm8vCrvQXev
	743R/A93vJEzNtbHva0qslq4kkHcjLrN/ZTnf3ZZWCWb/VSTBxxLneWegWq941oblQ0QPTzhgm3
	G8c3fXDyKgAgm7TQs7e+n78ATYcoVXWKVTFGtIKQbSMs4Q7+Ld0CmWuEeaw9riI56maUrdDamuL
	wCXIFpU3ZsFQJ1GkBct2fJwX4A5prRLLv1bVmLKG5WA9o1/44cR3BP1D5s0jeM1LMIn47jVytLf
	BhYg1Mcn33b9RJ7daStjBqLe6LeuelNZjwuh/a9sO6bWXJxqkA+c+vhgvn/ris6ZHBmJzydWW/u
	3QryQv
X-Google-Smtp-Source: AGHT+IGazc36AcH3JFwpPspBJaeZOlWd35EriSvaTz8P7nyStY6b1dmQr1CpyZfUSsNlH3k4bH9L7Q==
X-Received: by 2002:a17:902:f548:b0:26a:8171:dafa with SMTP id d9443c01a7336-294cb39dae9mr365955ad.21.1761573547349;
        Mon, 27 Oct 2025 06:59:07 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm82653355ad.100.2025.10.27.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkgaW1w?=
 =?utf-8?b?bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYb2ZfZ2V0X2NwdV9od2lk?=
 =?utf-8?b?4oCZOyBkaWQgeW91IG1lYW4g4oCYLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 27 Oct 2025 13:59:06 -0000
Message-ID: <176157354594.7785.10539824076665749790@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 implicit declaration of function ‘of_get_cpu_hwid’; did you mean ‘of_get_cpu_node’? [-Werror=implicit-function-declaration] in arch/riscv/kernel/cpu.o (arch/riscv/kernel/cpu.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:aa2fc1f4fdbcaf13e029f04263806fde636d74fd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7288ed51fe2777d083b6cb13bd2d18f368fa425d



Log excerpt:
=====================================================
arch/riscv/kernel/cpu.c:24:33: error: implicit declaration of function ‘of_get_cpu_hwid’; did you mean ‘of_get_cpu_node’? [-Werror=implicit-function-declaration]
   24 |         *hart = (unsigned long) of_get_cpu_hwid(node, 0);
      |                                 ^~~~~~~~~~~~~~~
      |                                 of_get_cpu_node
  AR      init/built-in.a
  CC      kernel/locking/mutex.o
  CC      arch/riscv/mm/fault.o
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-riscv-68ff66e51198e7d4c92ca056/.config
- dashboard: https://d.kernelci.org/build/maestro:68ff66e51198e7d4c92ca056


#kernelci issue maestro:aa2fc1f4fdbcaf13e029f04263806fde636d74fd

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

