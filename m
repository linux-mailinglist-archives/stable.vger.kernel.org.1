Return-Path: <stable+bounces-25323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6386A6E1
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 03:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B3FB2773A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5C20B00;
	Wed, 28 Feb 2024 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lpxQv5Wy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392F208D5
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088381; cv=none; b=EhxAaek7HhIu+VX3oPUxyT2JqKjPGVrR+3CLCqXgYxPhp6Thda+d79lBJp36uaOn7VcBpa19qA1cBs73027H7bwKNU2rsbj6IhUzEOFOktYCatNNszEE/6H8QaZFBNkJXHN3/1oyKUX2HMaFjRI28TC1irOxjWNqZ6kv/KPByNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088381; c=relaxed/simple;
	bh=mQFH/SJP37/K0A+bzRwDW5rArc1AI8HylzyhxGDcshA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D91JLMDQ2G5EtVzrp7XDJnwIa0OhvczCmStBZY6dUrUXuKw05a8XhJsfel070fmSEOu7+71m4tWHUJ8zry7OpVgwm5xL+ys7NUPYBBvvi2XYsSMSeMJCizqUwTrkppvvhqNaJX3a7MaUz8f0ojSN2jYo5iSpVEeWB0Dty6+vfBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lpxQv5Wy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e56787e691so21392b3a.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 18:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088379; x=1709693179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83r4EAUoTO5ZvgsfPp7swXodejXzXtH9eGtsARrhgv4=;
        b=lpxQv5WyDQS4nhy+Fa4qPpO5Y8GBEmL7icgkvkbgAPWKIzNAWss7vbfnY3yesoxNhb
         WHelhMQt6jI4Im7acXl4SQK41KMGMI6n0sWF4AfT0WiZkFmCAmzM34iK2qwDTTmcjSh0
         Kezt4wE65acTJ/yO2zQeX0You+kcO1wwny1ybvJdfmDhSuoPWqr5e5G7aD9nhS7CQMN7
         jUMyqmv1Sa4FeUc3QoUK0I5XaRROuQJCVOSZCvYNdnfwBKlAcYOhRtgFI60NsW9Gzk4T
         SyjR9X2gfpsgJ6TzVaj0pu+M2K3uGYQc7dp6jCDeKlWGrdJpeSslWDRWIVAMUbVmLcJQ
         fCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088379; x=1709693179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83r4EAUoTO5ZvgsfPp7swXodejXzXtH9eGtsARrhgv4=;
        b=QEijfHZtRZGYPFXuZ+cNVRgff/kpTNzi6g/suCJvHukUYFg0OumGKIYaxLo2SA6Ry/
         2PlVqW2L1LVlYp5W/GsIG38yhMjuyp/LRXvMNyKRmL0QTt+ld+TkV4yBZ+121ikYASni
         ywBOkuhHxWIzaY/cRsoTI/1ihIve8RNDSB6WoAi3V673RDYES/fbgJmE7Qrp1FnWNbBo
         fer6wVFLwNPSvJE3W/y6hq2llpT34Z4m6S10AZjcNOpI/AMzSRzwNLjsetGXSLxkJe74
         +twl4Cf4pcmSyc6jfI8QUTN8THuJRcsP05gNVDIN8crWh2uMvxbU7Eq2xXgYfk50PBQW
         6rBA==
X-Forwarded-Encrypted: i=1; AJvYcCXkWscBfE94XO3Cyw7tkt2y8hxMyJn4VdTWtqD9BOcgqmmc5qdyZSVu0Bwod1pXe/crw4dH+C3Yr0McnFiQtDuLazc2Vdeb
X-Gm-Message-State: AOJu0YzWYl3TzlR7vp+3tMeODociOwha+TdtA+4iKpFtKuEeI0T6hPqa
	+diZ8p4jX6fqKD70iwdmiDXwXgsdh5GHtt5A5kQRGhMsU+kCYGf4w3N4bLeO9yM=
X-Google-Smtp-Source: AGHT+IEy7061izEiARgGqc03Y4bU0MeVp4lQZod32fmca+lUIcc+h7BUudY1MtuW9QrEAQLNJql5ZA==
X-Received: by 2002:a05:6a20:93a7:b0:1a0:e6c6:fa with SMTP id x39-20020a056a2093a700b001a0e6c600famr1843559pzh.7.1709088378981;
        Tue, 27 Feb 2024 18:46:18 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id 9-20020a631249000000b005dcbb699abfsm6489072pgs.34.2024.02.27.18.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:46:18 -0800 (PST)
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
Subject: [PATCH v2 3/3] x86/speculation: Support intra-function call validation
Date: Wed, 28 Feb 2024 10:45:35 +0800
Message-Id: <20240228024535.79980-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240228024535.79980-1-qirui.001@bytedance.com>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
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
 1 file changed, 7 insertions(+)

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
-- 
2.39.2 (Apple Git-143)


