Return-Path: <stable+bounces-19012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1684BF10
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A011F21EC8
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649C1B94A;
	Tue,  6 Feb 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGdtD8WO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A611B94B;
	Tue,  6 Feb 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253893; cv=none; b=EqRr9jntHMMYAixOGDfmGOBNW2F2CnlhZ+njLNAuWavjPN6CEeo+xpmKrqmSTquQq65oOmz9C1RmvD+hD5Fn+3SOipyaLip6uqUAf8eN0UNgLbi40RZ2ifBfT+x/+kfl2gp6qutUUgedkyh0mOK7dDm6G97w+X3IL9FVyN3Fa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253893; c=relaxed/simple;
	bh=GV/eJUKwb2OYMCovPWnrR+Niw7eLeAUICtYDESUG/0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cMBl27s1sukskjnTygvifL32LSVI+e4gNed4q3hEPZMRE4Y0f7Ys164IIl9zYVusqCvtdiSqOLsVr8SxG2P7k2PmqbkUjAv5GqiqLbWmmbUpYrxt+D1J/+/ARW1k2UAZ5Widqw4EOymbQzHu/99y/c20LcE0KyM4ujoTP3Y4YrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGdtD8WO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d76671e5a4so49383205ad.0;
        Tue, 06 Feb 2024 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253890; x=1707858690; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VAjBSRX04ka0kvKjRppyin94pEa8/DDkMvhfnjtKPtk=;
        b=NGdtD8WOOHCbkJqDVRZVMTA6agNt0pu17Q3DTbkAZTTvThxtYYXe6igIK36YjNwtSz
         dJnGtoMaTpmKf7zXzWI++pVfvgokr92DOmOD6qB2cDEHqkqw7hI1nE9PSbICFMo9NcL2
         5294L0Hj3vEq6779C5lOcHhhN/1/YZ3CZkH7p+yimGUvMQ+/omD7h2tTMVtb+hwaWYIn
         ZN0g/ThBQdtWJ+3w9+EpUq+Xuyd17crNgvJsegAWb6j+w5qx2MVdhvTjEn2IZHzvEdM+
         z4lkfUkivSlWaWiqNABUUaZj3w7f4vZAO23ply+VMWoFDc6YnykX2FxcRaWetFukevJO
         OrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253890; x=1707858690;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAjBSRX04ka0kvKjRppyin94pEa8/DDkMvhfnjtKPtk=;
        b=ftJb2jxe+qklZcxm068u3nn/8yw5xnniydMkpzkavHnX+QF86qMZS7TOvp6K4te944
         d9o/yy7D2zFS08RgkeXs90AXvEjX2r5CglS4LCY5PqN3yQKAx2L+z/SwrUEubbP98duM
         6Zsw0svBlcBrUSLc4XUr79/xhWrCRqFOx1JKClE59pxqIZauJSOXf44QSA3XlGQ4TTho
         uGHvNh9M7EZvFFedWuAqO6TE3WRtGta9psHs+VEdSXIzPkpe/ub/4hMr94c4Hv6kqLRB
         HNei+zhrbffZT483NSxRcPJ1dEx1IqA9R1j+YREF5bKYlsq8S6X11TDSVn4AzfE3TyDB
         3JVw==
X-Forwarded-Encrypted: i=1; AJvYcCUz1ml7X3Rwu60+spVY8MnpR5oRw45GhmU8u6g6d1ShK8/U8SFB0mQkJzrf+kIoDkeJEnl1zOVskkkL1mAuDQv5Vr0Y2vo4
X-Gm-Message-State: AOJu0YzJvh2yfpSPWLOUpFJ8zerTwoaikdDbrGkS1+tndecs0QwSZXx6
	FGuEbx0sim8eNxcASlmokWmtE0B92NnrmzAajkpOmryyy0pz7vaW
X-Google-Smtp-Source: AGHT+IGD4DFF7IRxHMdmWQ/isr67lQtHBLzguLofsVYh4mFdPkxv3getkWoLeSQ+zJ83NHZfFKOljw==
X-Received: by 2002:a17:902:e74b:b0:1d9:5ce0:224 with SMTP id p11-20020a170902e74b00b001d95ce00224mr3196233plf.0.1707253890179;
        Tue, 06 Feb 2024 13:11:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLWh+OT5ZTXAmtUlHxbpR43+IjLniUkaB6E4WAOsVnRHDI8T9AChs2S6upLNnGq1xtf4g5CQPhi+EeTkHV8TLFkjKEAHw7o0JLVpH7Bn5VF4z8TNni96wzmOr8aJgv43LDphT9hy5h5XMF0BZz6rRjSYeQdgUdbDbM2dV0tDB5fs0FvX+5KsrPhD7zfSd1LdHH/3oTlnSB5CmsjUhn9Qz7S9wIEP+x65oVxrPwgT5ANZs=
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id le11-20020a170902fb0b00b001d8f251c8b2sm2315243plb.221.2024.02.06.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:28 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 0A6A9360457; Wed,  7 Feb 2024 10:11:25 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 8/8] m68k: Move signal frame following exception on 68020/030
Date: Wed,  7 Feb 2024 10:11:04 +1300
Message-Id: <20240206211104.26421-9-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Finn Thain <fthain@linux-m68k.org>

commit b845b574f86dcb6a70dfa698aa87a237b0878d2a upstream.

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


