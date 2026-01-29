Return-Path: <stable+bounces-212728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PcpNWTHemn5+QEAu9opvQ
	(envelope-from <stable+bounces-212728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:35:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67467AB29A
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DD973008C09
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB3344029;
	Thu, 29 Jan 2026 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="flqcJGWk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0763563CA
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769654113; cv=none; b=ZSRwqDR4HCzCLoAlkBc1OGooWAsJv71JB4S8NzofFSF3szbtC2w3I20tcskHj8zkl6VuowlgvvFsxnU0jBTbA8bdm7XQLpjJLIzHzQ9Ld+SQcjPvIvGnobZdcGGpupZf3fUOA+vVM7Up6E9vFyPj7YWIg0OAfdvP2jXMEUOQV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769654113; c=relaxed/simple;
	bh=cq0C40x8xqtlj6tVIRva7pIl6JIfrs8DSEIyTNNQXno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbs4m5qPIJipX0Y4NV/1mDsj4Mhvy8IRM++7om21bBZTMPwaWWavucgFVmP3G0IhVbhfUBqui4N9SrDuzUG4XdMaTdl81IsGiR/1bKI1n74Rk6fM+MyxLyWdcymFh2HjD/4T1uAcuoC7M5WnKNdixwYq4ug4Vx9sPc6VusuIpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=flqcJGWk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so3451805e9.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769654110; x=1770258910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug5QsrXZMAl0mYiTus8LnoHqNOGGvt+sQsGC1V10xGg=;
        b=flqcJGWkZv7nNMi+bv+zqPv0CStnPHfE4klIXWC41Qk/vra0vqz9wjLNwTF/9unhOa
         ONKWiCG7LFkjAIiJEiB+4cu75oKAvDU8K+FVkrRUmpfPffU72YczI5td5TH2r+Vxv+Z8
         GeEJKu/XIGWfOiziRCj8vlExbBA1mfSGlEf0IeYHMl1p7/j4XUFyaRz3npCVgR+Gvc5V
         plqCHDEGaeVxIWZmS020ro2cc66cWHgMVzfiklLOPfJTVsozRZK1skUx5ZyVSuQpfC43
         n1jJVKtzE+evW6bD9C8GE+cwsGzrhpGvs3xFdUZL+5jDSSdaQ9dxptS9tNwSqcavtzNv
         U1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769654110; x=1770258910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug5QsrXZMAl0mYiTus8LnoHqNOGGvt+sQsGC1V10xGg=;
        b=M1wGsTsZ3rKPHoCSG95f5tie8VQH3AQvDvJY1gU1+8Q8VfVIF+66m5mOJNGGa7pUX9
         VuiMfk9nH3t4kjKvf0wxMIIMoKCoWw5KVmsl/MkcZCB1VKtx5j6UubLvuDhAjbWoDVT+
         OzVGQ2sGwYE5S0kUYn4i2GO5rYOh4vl6Uq2kBxcPxFdiIZGkL61QHLQGq7lXchYlBEGE
         e8Y+kkKjVT9GcyvEQvAPGhgSqvhlEpEZombe4wQ14GV3JIqENDcnSGpT6r2N/wu/9POi
         KpV56zUDHPIktPaquJDCS1HXiI6pYiEiisTAptB9gT0hLirVgVH/NZzL2C3sV9vgS4qo
         pquw==
X-Gm-Message-State: AOJu0Yy4mKo1PHYV0G9dirtb7WkxEGu4afMgtsQ75+VSMNWCVcB1w1IZ
	JJBPfai4M2rR3o+r3ffbB1iEDl/awqRouPMpFJci48xMvq3Vwp5/MRV5UXWB4mumUWWlgs54h4h
	sNLbE
X-Gm-Gg: AZuq6aKrCDTpjnc9XIN235G6Hy9sDAvQXfop+w5Yd8GmsLNDmn3gtmcuIruoi931H1C
	BmRNRvI+X4k9DxQ4UTeT7Z5JQcCfMYOPtUr99xHg1U+tiVrwSaYzX88s5TeQBzeUnlbP6we9Cp4
	kdSYvIpTNxguQSkQrNoPCa757cvTSxFFyV0jUk5r+3ZxAfHNXo8v/lI4RcbmHi01Nz7UhSstsB7
	p40dynHMC6CUD/wf9/jOtR2oAF48dUEMePE3tgm2OzOh/kuKYZbKtbRNkjmVsBdyFuc3AHUmjgK
	KY8jBGF8nItqT4XEjjteB4XT9OzifORi4R0m8JOtXx8T4/O3kDTCpKvZ3mm7u2oAKtPceyluxiB
	RY5Sqcbzbx4SYGdtazNVU/9ZZKTP1V/jA1kNqMWuNodbKGLxDO4765eh2qKr0A6knAylAxLF6fV
	QzaSjZZy/8X57n
X-Received: by 2002:a05:600c:1c17:b0:480:462e:d640 with SMTP id 5b1f17b1804b1-48069c7f78cmr96225185e9.36.1769654110457;
        Wed, 28 Jan 2026 18:35:10 -0800 (PST)
Received: from localhost ([2401:e180:8dfc:3cc3:8fe9:e99:6cdf:244e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a70sm34555865ad.77.2026.01.28.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:35:09 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9=20=28eBPF=20Foundation=29?= <alexis.lothore@bootlin.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 1/1] bpf/selftests: test_select_reuseport_kern: Remove unused header
Date: Thu, 29 Jan 2026 10:35:02 +0800
Message-ID: <20260129023504.11686-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212728-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 67467AB29A
X-Rspamd-Action: no action

From: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

commit 93cf4e537ed0c5bd9ba6cbdb2c33864547c1442f upstream.

test_select_reuseport_kern.c is currently including <stdlib.h>, but it
does not use any definition from there.

Remove stdlib.h inclusion from test_select_reuseport_kern.c

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250227-remove_wrong_header-v1-1-bc94eb4e2f73@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: Fix compilation error mentioned in footer of Alexis'
patch with newer glibc header:

  [...]
    CLNG-BPF [test_progs-cpuv4] test_select_reuseport_kern.bpf.o
  In file included from progs/test_select_reuseport_kern.c:4:
  /usr/include/bits/floatn.h:83:52: error: unsupported machine mode
  '__TC__'
     83 | typedef _Complex float __cfloat128 __attribute__ ((__mode__
  (__TC__)));
        |                                                    ^
  /usr/include/bits/floatn.h:97:9: error: __float128 is not supported on
  this target
     97 | typedef __float128 _Float128;

I'm not certain when the problem starts to occur, but I'm quite sure
test_select_reuseport_kern.c were not meant to be using the C standard
library in the first place.]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Tested to apply in 6.12 and 6.6. Possibly applicable further back.
---
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index 5eb25c6ad75b..a5be3267dbb0 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018 Facebook */
 
-#include <stdlib.h>
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-- 
2.52.0


