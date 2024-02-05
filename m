Return-Path: <stable+bounces-18804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8E849268
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB066283119
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B372F25;
	Mon,  5 Feb 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSA85bBL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAF8F51;
	Mon,  5 Feb 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100370; cv=none; b=dn58N8tcA25p/IJiz/rFcVcvuMBVqA5xvybKHac6AahpHX9s8j8P7Ax2hQIEs6F7EKoAKQnMlCmo3QZ7mwveKusiRxuLRzTqvsdqD+OjlFe/pB39TK1yAo/CzBI31p6M4zmdxyztLOr3E2UpEScFXSSopsG2GkWZkpyeC70XqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100370; c=relaxed/simple;
	bh=gEMjQcZtRi/+8XKkrggSOKWdHpkxx9sAEC+ja8pr0r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=itV3yRHRRDe8g9rnWTCAt3NE6J8YDaAXIYFuwFju6KeO3Sr+7/A1a1ew7fZs65OGZqJaO+N/EbE628mzbiKFwrC7Ilck9BvF74RXoGL/+avDEHXl3OPFCSjfhnpcV4s7xbZ1TKbpNSMX/HD25U1sdcxwhv6EXc6FvELKEx+Mpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSA85bBL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e03ab56e75so293529b3a.2;
        Sun, 04 Feb 2024 18:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707100368; x=1707705168; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AHP3bpnrDrmcH0nJC+WbODRZ2J1Taa/l9rz69PC7XxM=;
        b=iSA85bBLEBLUYdUsxQi51YiJHH6M4iX9Xb+qYIri2//xMqoRn4vj62h6glpWnPqeGA
         5FC/k1Q4uJ8AlMawu2myr5EALxZ6fOWw8WTAR95c6RItcaN0bgOtSOM4HHbyV0Zk1yHC
         muRopguAVYq6tdRaKy8NVEx8dH1Qvb67O2J+wXQn/rZGeZwKT+u2Y0He8THZ4P/xaiJe
         OcMx6636tHDow5nlRfJHXy6agqBqw+owqqbYVFfwBLe68eYbP/ax4bTuTZ5AMEP1UX5j
         5fqNMBsmAt66GEymp6GvjNDM5ZiEtmixYcVw/4EsI053DK8BzxB/fx/2BTyoA4O5hLdB
         KQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707100368; x=1707705168;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHP3bpnrDrmcH0nJC+WbODRZ2J1Taa/l9rz69PC7XxM=;
        b=hJcBjPZF40X1es67Ol/cIKOX572/g96yTkFP4tGDvXu3lfEp2lhibPmpR4mhNj8rQF
         mvKlcMGZdp5YtjvrGCeqnVNNTvWx/vX23KbW2S9gc4lAUBq8Ta8iaWnpt+/9QLjWC3TR
         Ypw1NSd7dac5kW1aHb4KruZnAwLUyAmEkd0RFMPGyuoWTfAo/zgkFvmmZ7EWUx9VapBy
         2ObAbZVkl0XNHXil+8EqNe9ag7ePtE1yNKxXNYIOj7dyjzt3Nj+td9djIi9KYDGTiZb5
         6aQ1n+y/aGDNbjt+4xhbSQx33F0YdjpctsyeJwkU5qTaBBnqLtME/2igXnFrtVpgM/Gx
         51Iw==
X-Gm-Message-State: AOJu0YxGoLDu0fRwD5++cvAyw47/viNob04VZqlQMiwS8IgvtawrDoqX
	vohAfSD+fXBf7vMc0Czpm6hh/JJWGl47KlyAl9Mn+Rj1T4RF1ASG
X-Google-Smtp-Source: AGHT+IEc7XKX0NKQkKGoHzBtBofWOM0OIau3VNyrfnCT9Ts0PHH2zTQOhNLm2jwa58jN2GhwdmbWtQ==
X-Received: by 2002:aa7:9817:0:b0:6e0:3cfd:501e with SMTP id e23-20020aa79817000000b006e03cfd501emr1582502pfl.3.1707100368178;
        Sun, 04 Feb 2024 18:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJ1wl23UYPABeuCmOrY8t5d1BlUT5eoHYlrVnVypYCGm8MF4YnPUg+4/QDpE6cH631fSHX0/BpEwtsvWqYKlSpetER1n5zQ5zT1wLb1no58wj0gGWAEPZzgs2paXwPtwPzdGTxo49OZ6d/T4/TDUZoJLSVwjd7Evy4sS5yOFrzRZRF94nMICh29LV++Ci0Zv3/CKRtcyZBWIzCu8asfGUoBVhwqkekbhOpf4IYeHYmizI=
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id q18-20020aa79832000000b006d0a29ad0aasm5392960pfl.5.2024.02.04.18.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:32:46 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id DE54236031F; Mon,  5 Feb 2024 15:32:42 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	stable@vger.kernel.org
Subject: [PATCH RFC v2 8/8] m68k: Move signal frame following exception on 68020/030
Date: Mon,  5 Feb 2024 15:32:36 +1300
Message-Id: <20240205023236.9325-9-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205023236.9325-1-schmitzmic@gmail.com>
References: <20240205023236.9325-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Finn Thain <fthain@linux-m68k.org>

On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
a stack page fault during instruction execution (i.e. not at an
instruction boundary) and produce a format 0xB exception frame.

In this situation, the value of USP will be unreliable.  If a signal is
to be delivered following the exception, this USP value is used to
calculate the location for a signal frame.  This can result in a
corrupted user stack.

The corruption was detected in dash (actually in glibc) where it showed
up as an intermittent "stack smashing detected" message and crash
following signal delivery for SIGCHLD.

It was hard to reproduce that failure because delivery of the signal
raced with the page fault and because the kernel places an unpredictable
gap of up to 7 bytes between the USP and the signal frame.

A format 0xB exception frame can be produced by a bus error or an
address error.  The 68030 Users Manual says that address errors occur
immediately upon detection during instruction prefetch.  The instruction
pipeline allows prefetch to overlap with other instructions, which means
an address error can arise during the execution of a different
instruction.  So it seems likely that this patch may help in the address
error case also.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: stable@vger.kernel.org
Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/signal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 8fb8ee804b3a..de7c1bde62bc 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -808,11 +808,17 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
 }
 
 static inline void __user *
-get_sigframe(struct ksignal *ksig, size_t frame_size)
+get_sigframe(struct ksignal *ksig, struct pt_regs *tregs, size_t frame_size)
 {
 	unsigned long usp = sigsp(rdusp(), ksig);
+	unsigned long gap = 0;
 
-	return (void __user *)((usp - frame_size) & -8UL);
+	if (CPU_IS_020_OR_030 && tregs->format == 0xb) {
+		/* USP is unreliable so use worst-case value */
+		gap = 256;
+	}
+
+	return (void __user *)((usp - gap - frame_size) & -8UL);
 }
 
 static int setup_frame(struct ksignal *ksig, sigset_t *set,
@@ -830,7 +836,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -903,7 +909,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
-- 
2.17.1


