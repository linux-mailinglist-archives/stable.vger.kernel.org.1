Return-Path: <stable+bounces-32459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B188DA79
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95807B22492
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661523B18D;
	Wed, 27 Mar 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JqBwZm7U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7E4AECA
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532718; cv=none; b=ZVQ73IDRPbJteU0hkc/nbV8OLaKFdHJNkPfH3knDnDG26isYXTc0/Phzg+iz8LESaSKQ2CIsy3LQs68FMT3zJYM60qSC/O7Qti7BdMda7gzHLjBja+KFe+60COLirlkA1iOYEwD6XnpC33TW0iVSoX8xe71pBeYtOaB/oPHDSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532718; c=relaxed/simple;
	bh=mBf6wZN0cIO/N0wB3JaiYh3xHh0wn1kXf+UEavA0MRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBaK5THQs8AmgwA/m1ZW22s0a049NJJGr+zkmF+ZNovxfWFC1j8mVbeGGnYQwmlFqSiqPQ2B+0nUJAsgOV+FaziqH7cvn5Po+YGht29XzTdpHL12mdtLwyibZl1HVhbsW6Tq5xfdrDcAbRBB26gHHHMmWdPgqBOMuVLaXylJ5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JqBwZm7U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso47398845ad.1
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711532716; x=1712137516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ptT0otTY0d8yLPVMZk8S5EDz2pvO8mJ9CtUPG2vMjQ=;
        b=JqBwZm7Uh21Z122aHPpU64U2hTBcdSUeGej19I2AsVTphXMn1l6e4ICR8d/gX+DoHO
         bhiBG89FxCWjce2nFd4sy7KZZuD3lHuPRDymmzhpGewOGqKmZuxPUcse59mrGnz3wfY5
         877a1CVB/4/eMOphosi1tmmoTxiiVbYWokMZpiAGWUmbKRtZVrNVNwjqfA1aH18lVrat
         66FOVKpIglGQOiQlSKIDI4KvsBEH2CTKT81OqSbIR//6d6Vot4Oba8zVUcvGB9IOk2kI
         4+r5wpmmqeQ35sJUQapPsYPJT1ZqnrGxR35xYiL8cqfrPi3Ab1ERgdNj3n/2dy4l7nWN
         VZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532716; x=1712137516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ptT0otTY0d8yLPVMZk8S5EDz2pvO8mJ9CtUPG2vMjQ=;
        b=L9WtZi9sBhV3X6zPTzdCcjocUnsAvfs0vJ0hmykmkWkv6O8VuQZYMFNZ6gcvj6S4Mr
         30klSsCiYKrbBT/MVb6JfWqfJZCdH0c9pDB4SqiOW4YXMQfpql19CPcAoqEhUJMrTkrr
         DkwOGNBUb202I03CEoeyMMPQSSIKuUfcGtyqjY+sCW1HYK0HAMHJSsGXjo1KH/2Xnn2f
         xrTZu0lbsvf9DTPBiZbKM2cvxgJzES2Uo7DivCJLdWY9pxuWNC8Rlfjx5jkDxd5Vi08A
         RhJ75QC1NWvcP95HaQcVPHCLO88x7eBM+AUl6Ec7vSA032TxW0mIe9tiSQHXzHRoE3KM
         Cklg==
X-Forwarded-Encrypted: i=1; AJvYcCXHFlDkS8y3W8lpJhNHD2P1mPsPCY2AVbtP6DNyBuR0maGjADfbFvwG5UAEVzSoYR46sU76QleRCL6XKzYvFqQ/6cZV9o0A
X-Gm-Message-State: AOJu0YwzCt2Jd7mejy/UoIygwolM2dZPnABQI3gpYKfLJJx0XFCxfyom
	ok+mz036utmwdszwaNSHNxETVZY2VUCqytLsqlQnmwWDVO/HC2lCfUZ2up7ii1E=
X-Google-Smtp-Source: AGHT+IFjFnJBRihujye+oVYrOczmV8gAbnCg1VNzHZYgH3CquqStysAK6Hmybu83Wrb83RcqMPIU9A==
X-Received: by 2002:a17:902:c94f:b0:1dd:6263:62d4 with SMTP id i15-20020a170902c94f00b001dd626362d4mr4669647pla.3.1711532716241;
        Wed, 27 Mar 2024 02:45:16 -0700 (PDT)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902e30300b001e002673fddsm8500474plc.194.2024.03.27.02.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:45:15 -0700 (PDT)
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
Subject: [PATCH V3 RESEND 3/3] x86/speculation: Support intra-function call validation
Date: Wed, 27 Mar 2024 17:44:47 +0800
Message-Id: <20240327094447.47375-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240327094447.47375-1-qirui.001@bytedance.com>
References: <20240327094447.47375-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER
 to work with objtool") does not support intra-function call
 stack validation, which causes kernel live patching to fail.
This commit adds support for this, and after testing, the kernel
 live patching feature is restored to normal.

Fixes: 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool")
Cc: <stable@vger.kernel.org> # v5.4.250+
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/x86/include/asm/nospec-branch.h | 7 +++++++
 arch/x86/include/asm/unwind_hints.h  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c8819358a332..a88135c358c0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -13,6 +13,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
 
+#include <linux/frame.h>
+#include <asm/unwind_hints.h>
 /*
  * This should be used immediately before a retpoline alternative. It tells
  * objtool where the retpolines are so that it can make sense of the control
@@ -51,14 +53,18 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	772f;				\
 773:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;		\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	774f;				\
 775:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;                      \
 	pause;					\
 	lfence;					\
 	jmp	775b;				\
@@ -152,6 +158,7 @@
 .endm
 
 .macro ISSUE_UNBALANCED_RET_GUARD
+	ANNOTATE_INTRA_FUNCTION_CALL;
 	call .Lunbalanced_ret_guard_\@
 	int3
 .Lunbalanced_ret_guard_\@:
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 0bcdb1279361..0fd9a22b2eca 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -101,7 +101,7 @@
 	".popsection\n\t"
 
 #define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
+#define UNWIND_HINT_EMPTY
 #define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
 
 #endif /* __ASSEMBLY__ */
-- 
2.20.1


