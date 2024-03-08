Return-Path: <stable+bounces-27126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F4875C69
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 03:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905DC1C21020
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70728DCA;
	Fri,  8 Mar 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dDbSCWkV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94722F1E
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865946; cv=none; b=GKf+QADzaQH9S44fwd9IYi8trqS0MYVz4m7AjDwf7qSv5RsHvJXAfJjkSKfQs0Gw4qJ1nsRGlTmECyaBba/Gz5HnSq942b7BNTatUQeGLsXwpmAsZPCSrniDznT6unt9dkEwGAJ3HXKs80/l2zwrAUl3jMc1WqDQuc86dbL2JIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865946; c=relaxed/simple;
	bh=A9JJZAf4f0qBrIUH970XEhb6Gx3TLdc7GMVQz+Xz/gA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k49Hl0iay9MXjqiAZ2gYoTQoArLbeP4OmhRvEsKvK46C3JtvmbyFuluQ1gyFK6TQ/J0nOlJF8haVhuSjnutGMzQirSGV8PlyyRSr05+0bRowt8RmpGOEzqY07+3cYgwOAS3Mb/nK53SzKnh7VbgKnzTjmCV4BaG2vaTuZUpEio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dDbSCWkV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc49b00bdbso2634565ad.3
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709865944; x=1710470744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBTcuM34vazcQ8FUxJ81MwY9Go5tsnqrD1TprkB4i6c=;
        b=dDbSCWkVLpaQjGRAcqadwYyZtMODURCP43NcFG+ooH+yBz/jDnRmPzvDHpLLxDTYvW
         L/EVz9fU8V1YY9KGOmqe7fuI8DzCNYu0vcKef13Kqg/QmOm8l92V1BiR9IDY+tsEhyk6
         S4OvlgU1ElEoUVdL8MR7l63IkZxBHpZQbhDWwcXruIaGPH5Nz4jP9i3ySuova5fKl5so
         BMO1rzD/6zJqmW2aDuNST4EQGWDrBgWxEjNXmQ7t60eniAU0Su9ObFTeWzclelkLn2mD
         8Ukfjx6ri9brDTp/NVCgWprgmgOjim1ZWEJGNid5atcmaSzBspUA6PwNVaEU9pgOmo3M
         4yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865944; x=1710470744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBTcuM34vazcQ8FUxJ81MwY9Go5tsnqrD1TprkB4i6c=;
        b=GFK+MDToZ4e/nUJIo2P3N9p8cgMOzPvRWiyKKre/8enlzvZFVNUaZVtyXNCfcw0oLm
         5hm6Wz7bZixktuUxI17hltOi2ahFWvcB9joWCT3zOGGabwGsPdxUj554hP1nONo5Dtl7
         pur9M7qnK1EXKp5qBzUwoNjFAFn0HAzc8W6AQTetHZzOAqA33CWqkvgetUU0ZWfGj2aQ
         A8Wur4oZGR/K4NYag9XaNgdRnhw3TibWZLU9+k+f6m8sqbwMYkvLNd5V5Ie8CwXwA3V2
         DtuABy+ibihNyfLD7GCnGjwPnqecWhg5A8j4oTgbgikJGRE/K8ndaCxMumOeW3B7To00
         Q25w==
X-Forwarded-Encrypted: i=1; AJvYcCXiqCXMSN7bl41xoNXsk+3o5IJqD2zSV/VE5GGOPZV0KMrRC3Yg2IV2JOHisMlf1HYaPrU+kWoMs8/C21jRG/iXHVlqL5In
X-Gm-Message-State: AOJu0Yx+CJqKQD+nvI6P+67Co+xnQrmU6jpPYjE6e80CD3sK6SbY3ryf
	/RZbrmYHgnjM7F6bVupA837xPA/HsCgHCivGKmhAK1hxF+O0Jnx2wq1UBAygP9A=
X-Google-Smtp-Source: AGHT+IEvIAI8sq/1OcNEGlOk2q3petZc1tRcphID3Cuq03oBgO9LU/5Qyoqw+BszQpjMEbkERqXMzw==
X-Received: by 2002:a17:902:7847:b0:1dd:6174:c63e with SMTP id e7-20020a170902784700b001dd6174c63emr1880622pln.54.1709865943683;
        Thu, 07 Mar 2024 18:45:43 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001d8a93fa5b1sm15244360plr.131.2024.03.07.18.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:45:43 -0800 (PST)
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
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v3 0/3] Support intra-function call validation
Date: Fri,  8 Mar 2024 10:45:15 +0800
Message-Id: <20240308024518.19294-1-qirui.001@bytedance.com>
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

Based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269), This patchset adds stack validation support for intra-function calls, 
allowing the kernel live patching feature to work correctly.

v3 - v2
 - fix the compile error in arch/x86/kvm/svm.c, the error message is../arch/x86/include/asm/nospec-branch.h: 313: Error: no such instruction: 'unwind_hint_empty'

v2 - v1
 - add the tag "Cc: stable@vger.kernel.org" in the sign-off area for patch x86/speculation: Support intra-function call
 - add my own Signed-off to all patches



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


