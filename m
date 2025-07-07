Return-Path: <stable+bounces-160410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4940AFBE54
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 00:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61B71AA60A8
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D028853D;
	Mon,  7 Jul 2025 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtVTerz7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEED1F17E8
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928221; cv=none; b=fZX/XvcDI1SypCvzbV1c1wjUGiZAJVPvg03U8QcYSUzqChWRbP0mw0y64MfzoyvJz2oJixbMJ3AMhCGboGH/tsNg4VmoEGE4wZU1g9YtN7vB6l2sjCBrbpjGehVAGEPudXTD4qpLw7yyp4+QUwMkUw22t14EEtYVTET0Rx1lFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928221; c=relaxed/simple;
	bh=mchbDOueZt5kf3JzpXSnVYLIzfNbDgDVg90YxdKUCx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i38CNFzPMI0/bBsojInJRQMKjXWuzpFFTYpBvyXQqDVdFwd2PDMdQSG1f9llCEtUkxCF/Ihu5EddfmsFkLRDEQWvu5IF+XoAmoF4MKqCSGAF/P/Bm2CNxjy8q0JAv5rx5uRM3XYZlkxyMFsk3RgcnHFlHAmzlOeA2UcYOsajh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtVTerz7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237e6963f63so24373105ad.2
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751928218; x=1752533018; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mchbDOueZt5kf3JzpXSnVYLIzfNbDgDVg90YxdKUCx0=;
        b=RtVTerz7MLNuSHnsARUU0BWmHCawqOPUpF6ESpKHnFZr0J1cnJdCXjPBNUbb1ANndu
         9wQKSD5hqHczDXPBqFAs3YdWL+0B6tZBRmCAl+9reSTKbd2t5L8ilVwTquNGTJWc9w3t
         0r0tjl8ZnomTNA1wMCKUaASIO8ljT+AWBMBVAYABdtWGCEzjHM4UQDlLIkfTIHw9CDxw
         hmqMbnRa7OYOSsQuMsyOsnRe+B4MO0y19ffRTZvPXRd18zSHfTw2jnkrdt3tJ+WgAO3C
         /ey1i24uF+FRY+whtvq1yVkUhUmwm1yVbU7LHS5YzhuivHH/fgFIyxgUF/8LcLU0NT01
         NDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751928218; x=1752533018;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mchbDOueZt5kf3JzpXSnVYLIzfNbDgDVg90YxdKUCx0=;
        b=cY1Ka7BZIDKPgv1nUgR1Y80OW3oEbl5jBeWRkV0TAuX1XbRx2gV7iJaCGYTbRE+v8m
         6V+chxgIw/3XBCPySPYj71jc7ZJwjYlosZK2hmaU5TR/psUYF+SaKMVGvBsoG6x3aQjA
         adRqTZQ25gi/lT2zFi0ZKlZDY9fGkVJGmXPoYSOlDVrxpkN+4T+WkfJH3j1qr0UW58dA
         eyv2CuohtpC9Jvt7vfeunC2bBdKi/samMMEKHb/pz7kw0ksfy71luCk68J29HMK4aTuW
         8AlvR8KylQyvprqhuWu5uK907R7P50Fp05Gv4kcLgRYrahOc5QSNnirH/1YTfEgAxcot
         Ktxw==
X-Gm-Message-State: AOJu0YwJ1GxjUXvRn39mt9Hsv4HUfZkZWNPOKVwUjmXZlOWe2RtskMly
	gGE5GyP6LHCAt2mCUmKZ3vaMKETXZQ9D6/RFJlpvZu5C1xb7xPBHpsishP/rUw==
X-Gm-Gg: ASbGncsvdpl1Ea/J+mXi1QP7wv0MYSwwb3EilUbXnKBKol+9N7A1XqSsgylDiok7H1v
	fYYRPhPCAiVEKYdvzswNzHdOQSuMMiphi2ddyGE6EU6ktVn056r+nN4it9GiP8FqT0peH5Rx/Ij
	mti8SKOoAn45c+RwHq8uMgrEdqFjLqPtDFn31RAX8q+eoAXZgOKW2dWtwhwSeLa3wq34tbgHgYp
	0ox6fhBGyPRgXiLfourXmFFYFfmehUooQ2eFA2ER8WNKp3vqWmSFc61/lib+MH8e5HHDpA+BxS4
	SxARYzN4VH8na+nqAHuFLWv9CRryojwU1PTPRMMw6ydJ7cGXGqwCAGbx4HgTbDqeH6Ajxn5R8uY
	=
X-Google-Smtp-Source: AGHT+IHwbFcvhSyngqrx9i0VSDUrzm8rgV8R8ERU2Z4N19EOAAtD7yAii2lrbmu2QvGUNM8QgGGxUA==
X-Received: by 2002:a17:902:d48e:b0:236:7165:6ecf with SMTP id d9443c01a7336-23c8758cbaemr209640495ad.38.1751928218521;
        Mon, 07 Jul 2025 15:43:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845836a3sm93810005ad.184.2025.07.07.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:43:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Jul 2025 15:43:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Please apply commit 93bd4a80efeb to v6.6.y and v6.12.y
Message-ID: <3fb5d5b7-8c1d-414d-953f-b883a6e188d5@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

v6.6.y and v6.12.y fail to build corenet64_smp_defconfig.

powerpc64-linux-ld: arch/powerpc/kernel/irq_64.o: in function `__replay_soft_interrupts':
/opt/buildbot/slave/qemu-ppc64/build/arch/powerpc/kernel/irq_64.c:119:(.text+0x50): undefined reference to `ppc_save_regs'

This is caused by the backport of upstream commit 497b7794aef0 ("powerpc:
do not build ppc_save_regs.o always"). That commit made some wrong
assumptions and causes the build failure.

Please apply commit 93bd4a80efeb ("powerpc/kernel: Fix ppc_save_regs
inclusion in build") to both branches to fix the problem.

Thanks,
Guenter

---
bisect:

# bad: [a5df3a702b2cba82bcfb066fa9f5e4a349c33924] Linux 6.6.96
# good: [c2603c511feb427b2b09f74b57816a81272932a1] Linux 6.6.93
git bisect start 'HEAD' 'c2603c511feb'
# bad: [36318ff3d6bf94ea01b2caa0967f2b366c7daea6] media: venus: Fix probe error handling
git bisect bad 36318ff3d6bf94ea01b2caa0967f2b366c7daea6
# bad: [c64a16344c5258dcaaa6caf2bbe2298e6e3e469c] randstruct: gcc-plugin: Remove bogus void member
git bisect bad c64a16344c5258dcaaa6caf2bbe2298e6e3e469c
# bad: [cb4b9369463eb6f6d0f4bdeaf35d183a935c2573] Use thread-safe function pointer in libbpf_print
git bisect bad cb4b9369463eb6f6d0f4bdeaf35d183a935c2573
# bad: [aa7b90057bc3f8d9ddf50e7397facdd613de5610] x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()
git bisect bad aa7b90057bc3f8d9ddf50e7397facdd613de5610
# good: [cb1e26f53e598a3946dd9b3014d6bcddd8609a47] crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions
git bisect good cb1e26f53e598a3946dd9b3014d6bcddd8609a47
# bad: [5810e9d402c43a63c16ce949f9d9ff59fe6832e7] crypto: sun8i-ce - move fallback ahash_request to the end of the struct
git bisect bad 5810e9d402c43a63c16ce949f9d9ff59fe6832e7
# bad: [3cf4d9cae4356c2a0610d82c13c957e4a88d6d94] crypto: marvell/cesa - Avoid empty transfer descriptor
git bisect bad 3cf4d9cae4356c2a0610d82c13c957e4a88d6d94
# bad: [ce167ff4cd172bb85b834d671f37151b0f7f734a] x86/microcode/AMD: Do not return error when microcode update is not necessary
git bisect bad ce167ff4cd172bb85b834d671f37151b0f7f734a
# bad: [4fb22310892c9bba3a170d0873e95886fbadf064] powerpc/crash: Fix non-smp kexec preparation
git bisect bad 4fb22310892c9bba3a170d0873e95886fbadf064
# bad: [fdc39b3ad8a7791792408212507683bfae9f2dc5] powerpc: do not build ppc_save_regs.o always
git bisect bad fdc39b3ad8a7791792408212507683bfae9f2dc5
# first bad commit: [fdc39b3ad8a7791792408212507683bfae9f2dc5] powerpc: do not build ppc_save_regs.o always

