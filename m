Return-Path: <stable+bounces-32456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262A88DA73
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 10:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC94F1F28D85
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8038DD9;
	Wed, 27 Mar 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fMH+qMCu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F4381AB
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532703; cv=none; b=FHbgFk8o1lMCzna9Xh7FTxAJniWEd4v7Q/43u25zBKkckHPChnmmRdyr4njae/rmSm0pBmYOg7purPGdK2J0CTrqASKGQfi04NOhNwLfOt17rlpgbAkNeVPGNEGcJ+q+QdYntIMo32f4Fp28U8ekCwjJ0utlrzOtWPr8zwsKdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532703; c=relaxed/simple;
	bh=5zTEJoGPB+tgay4nvfgbQK4EeEdhwCMFFHER4asBSQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D2ceVZB0iZdjwV/bDvXcoSeLufspbEu0CfRMtSm9fQzSkIApEpDgQTTsxpCCXbyyNrABeGv/0HU92bVWne+ZzDOnmVQ9ZZSYEDgzobpr0BrrvOjlQtGWV46k+423D+Z1zj633yjHi4abuPXR/1LBWZ62iJZ0psMKI1JskF+OqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fMH+qMCu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0ae065d24so29240035ad.1
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711532700; x=1712137500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0s2/2nt92fOMZjCKazAsy5Mowx4acP5f/CX6uku2zg=;
        b=fMH+qMCu78f+H76DQlMprxo/7KgHq7gJ8MFzfTaoOy3yckwOMY+c5sITLa6LAEFUeT
         Pk3j4AN99zYJd+tM1WHz0+64nx0UnsqIsO/VbIY3lfcj5BtGJsoyQ8I/zmGpaQVD0KdS
         hQfKZATQ1vEuAlrs7w9iJ9rqLo8fJGx72f/fiBQh6BDt08nlgQgMe+gVUJuQsPtkupoY
         Hkc1jFRJXJBv2l51fTon3tnI5dzJ+eMeAxUx3sQ+UxudG7mp7qwO+sM/ZHslSd/lLXRq
         sa24mVvoCooLkO85ejqLbipy3dbpIWodgGmCDJ8X0eqQDwMM9JxpA+F1Heu8EWJzlyDE
         /Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532700; x=1712137500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0s2/2nt92fOMZjCKazAsy5Mowx4acP5f/CX6uku2zg=;
        b=fgP7fKg1vj8YdZ4X8c89E2MjnohP/Mmx3hC1WOz86iPVYyAEVquks7rZ9VYN2NV0QF
         4a3WzzV63kWBGtIxANXtb6ccw/iQDG95YQNKaI4Prp4USHr/KCLJ3p5x8qO+dOQkPw5z
         iezuyhGk7xZAl9Yxo4rb/4D0TdyavqThUZJJrukYGAwaFeP6XkV6lpi/qQSyxfrgHlwD
         CJzIgZ4CZH57xFDMcG3dIBj7cZqgGCQJU8fAb02XjKpstqom/7EGCwQwg1YVNRPAZ53J
         Z5Sf8e/zsK7eXyp868mJY0gir2sFMVG2XR0TOqA67OobG4QnupjOIx3L+PKit8fwPYaf
         Mcrw==
X-Forwarded-Encrypted: i=1; AJvYcCULPo5+HRBO/UYgV7nxfZzp84i3/DAWWhUUbLrQphqGiyzziNUsSOQgjMOmv/dXCAXBWXIRmKDhwu2Dg49ktuganyFsM6QW
X-Gm-Message-State: AOJu0YwMSULUbTWDMAK8TXsIGuK9aLi809gYp/UFOX67zdZztJI5odMC
	fbFmTzsS/ameaBcWTCA7EOqApV07vcM8r4Yoc77vvvy/dYcJADDutSyyv6LroRM=
X-Google-Smtp-Source: AGHT+IESl6EbiprGQ7fdcjtdxHL/0CNtsLJmj2bp7YqhGwHMzCmgr3tnJfDwqDhyhQtmEsddUxcJ1A==
X-Received: by 2002:a17:903:110c:b0:1e0:e9d7:83de with SMTP id n12-20020a170903110c00b001e0e9d783demr672164plh.12.1711532699925;
        Wed, 27 Mar 2024 02:44:59 -0700 (PDT)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902e30300b001e002673fddsm8500474plc.194.2024.03.27.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:44:59 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	sashal@kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH V3 RESEND 0/3] Support intra-function call validation
Date: Wed, 27 Mar 2024 17:44:44 +0800
Message-Id: <20240327094447.47375-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since kernel version 5.4.217 LTS, there has been an issue with the kernel live patching feature becoming unavailable. 
When compiling the sample code for kernel live patching, the following message is displayed when enabled:

livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack

Reproduction steps:
1.git checkout v5.4.269 -b v5.4.269
2.make defconfig
3. Set CONFIG_LIVEPATCH=y、CONFIG_SAMPLE_LIVEPATCH=m
4. make -j bzImage
5. make samples/livepatch/livepatch-sample.ko
6. qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage -nographic -append "console=ttyS0" -initrd initrd.img -m 1024M
7. insmod livepatch-sample.ko

Kernel live patch cannot complete successfully.

After some debugging, the immediate cause of the patch failure is an error in stack checking. The logs are as follows:
[ 340.974853] livepatch: klp_check_stack: kworker/u256:0:23486 has an unreliable stack
[ 340.974858] livepatch: klp_check_stack: kworker/u256:1:23487 has an unreliable stack
[ 340.974863] livepatch: klp_check_stack: kworker/u256:2:23488 has an unreliable stack
[ 340.974868] livepatch: klp_check_stack: kworker/u256:5:23489 has an unreliable stack
[ 340.974872] livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
......

BTW,if you use the v5.4.217 tag for testing, make sure to set CONFIG_RETPOLINE = y and CONFIG_LIVEPATCH = y, and other steps are consistent with v5.4.269

After investigation, The problem is strongly related to the commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"),
which would cause incorrect ORC entries to be generated, and the v5.4.217 version can undo this commit to make kernel livepatch work normally. 
It is a back-ported upstream patch with some code adjustments,from the git log, the author also mentioned no intra-function call validation support.

Based on commit 24489321d0cd5339f9c2da01eb8bf2bccbac7956 (Linux 5.4.273), This patchset adds stack validation support for intra-function calls, 
allowing the kernel live patching feature to work correctly.

v3 - v2
 - fix the compile error in arch/x86/kvm/svm.c, the error message is../arch/x86/include/asm/nospec-branch.h: 313: Error: no such instruction: 'unwind_hint_empty'

v2 - v1
 - add the tag "Cc: stable@vger.kernel.org" in the sign-off area for patch x86/speculation: Support intra-function call
 - add my own Signed-off to all patches
s
Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 arch/x86/include/asm/unwind_hints.h           |  2 +-
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.20.1


