Return-Path: <stable+bounces-25320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC286A6D4
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 03:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EDB1F227E2
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA21CD0F;
	Wed, 28 Feb 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k4oydFxj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB61CD13
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088362; cv=none; b=Zsj/ZYq/4EdkMvL8uCq+Xva4hG37rOujaX30Bcsv6j6JOKGXYEZ3Vgt9BI7XS4nXgSrZ06cYUPcKXO1Hqf4u+tAkZt1qLXZkjt/g9zPMjejBcQDQN2A/GdvQczAqNKbYsyOSYl67RoCqkODreA8CSncWFtA6SHW6dmv6JY3yHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088362; c=relaxed/simple;
	bh=LV4NmiXNaGZ9KK8IYGWxqyPnJ0nw7pM40lzxC6A9w+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IXYdWVRAuw3I2OAhm4XQxpFzMIA6zNPFEFGz/02v2fXMFRD5I1TJTvSMbv+kU4iYW8E3aAb20Df8hcHwrp3aB6GQmaWMUpjHI183mAliwr1T+gfb8pWbVzpa7tm3OlHzb29RvTYwCk+lduZKWMX5W+pm6EzEyGs/l2BIg+/aYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k4oydFxj; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0680bc600so1216873eaf.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088358; x=1709693158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3dehr8Ho7ib3MGSSkhJ7f1dmLYZiqbaCJe9EpuzVRc=;
        b=k4oydFxjFUG0JiFaOmfCtp0b0859nzVCcCKGd3Mj6WxjOEl/OjfW8CVzVDKjy7Aqet
         dhbAuHMejqvQxnaOazVkrV/OpwOKFWmn7F42hm8kcyP0AuPHQSWeSby2yudrJkeRGAtW
         Ph3zI0N+2WO1NB+F69gI5RWQUu5aIRX7ln8DofCSh33HfqwXlFFa1dbsAICT1++N7VKj
         IhYLh3dp+BENQWvC5DDL70Q6bONIMDxlIk2YxqsaxUHO/2z3gvx9264CAfZQzGeVHx0v
         /Scqx1M4PwYq3dufseqzCJaLOZ0ocFkf8wL36/RC2Zg9iywyqgYH7S0p3EguJurgVT2Y
         zGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088358; x=1709693158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3dehr8Ho7ib3MGSSkhJ7f1dmLYZiqbaCJe9EpuzVRc=;
        b=cVEZWyyH43ZEp9u+8Sjjtf69i5o2UWWNG2tPAuZdEC78y61MUPeZoQJh7y2HuH3ClG
         gIx+g9+pT241ogO2Rpfsqkulzx4pBAvyai3p9D7YFiZ8K9zaXtxtCUEtFNZg/M9zMSTZ
         bUD4heZffTqxpI6Nlk2cfvTeKICE/5OJwYl8/Kdi9eQ50p3fr/s2Wdoh42u0qzFxxOJf
         LPmkp8pFqxmWV+qbHPoMnlokR6kqG1u9XnWsQbbqt6GeLg5NlbtJu2H0/dp5ei9OHcE+
         gP0ZcVKdbohDGDxLrJMTe+ZbTJkMVNgbAeqJl3AJdO+bgJv96sFghbE9jAaVxSaR69Kg
         OBkw==
X-Forwarded-Encrypted: i=1; AJvYcCWCXNxriyCRgtjsAOVPvOH3AYsuibhkhI3p0GW2JfsXYzlpz1nRBB9STvsvXIGlEiqpZARpivEX1VFSr3/G/EkEUzs2fBWQ
X-Gm-Message-State: AOJu0YwdUZEfnFycygbRQqtNPV78jhC6G1Ku+3NpOzkgb6cDrQ3yQBAR
	an7/QV43VqTLPib90b4kVUl8yzDSTBlTUXNqq7kmGaLd6LgZOF5VmKVyVhlR1Ss=
X-Google-Smtp-Source: AGHT+IF0cqOe/kAqIuBZWJWGEryFGpLCxIZSZR91T3CBC0PIc+508IRXeYTqKwYOwTzC3V3iqYVweg==
X-Received: by 2002:a05:6358:893:b0:17b:b023:6539 with SMTP id m19-20020a056358089300b0017bb0236539mr7634120rwj.25.1709088358106;
        Tue, 27 Feb 2024 18:45:58 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id 9-20020a631249000000b005dcbb699abfsm6489072pgs.34.2024.02.27.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:45:57 -0800 (PST)
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
Subject: [PATCH v2 0/3] Support intra-function call validation
Date: Wed, 28 Feb 2024 10:45:32 +0800
Message-Id: <20240228024535.79980-1-qirui.001@bytedance.com>
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

Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.2 (Apple Git-143)


