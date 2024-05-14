Return-Path: <stable+bounces-43760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE78C4DC9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161231C214CA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD72182B5;
	Tue, 14 May 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7zQuAb5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430B1CABD
	for <stable@vger.kernel.org>; Tue, 14 May 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675975; cv=none; b=IzK+I98zgu9maFpgwoyfW16mtwXwXazAasi4dtx3jRPM6jQKx8/ne9i1a1kgJOrMIGXv7CfpgHp+s6PauSyoRt3qrIODppCYatlWCyny8v7EErL71KtPzOqrQuKBPYhF6bwq9oPWthQFm5PBASmOd2vssjDrex9nbYFKCBtwlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675975; c=relaxed/simple;
	bh=/qKAckkSIiFrpRIvGGkfqQ5SXkqsX83t/RMU22jS5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5d++U4W2yXe/19p0dhAjjDdgXhrJIbTycmsN56OPXfHqs/y3RDXKFslE7VNUCBAAG7XuBOsyKcsYE5A69bOnNOIsk/5w2uSwSQYhtFj47p1ePWBiHPhUmDPOaRH0bqWQ1GWgp4/JaFcmYG11GCY4yb1/WrcLH9HGOJVStoha0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7zQuAb5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d8d11a523so3349313f8f.2
        for <stable@vger.kernel.org>; Tue, 14 May 2024 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715675973; x=1716280773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LS0peL0MwvyMOdZgt++EgygrPaWPwT8KTIWTL9DYX6c=;
        b=R7zQuAb5AIK2KHe+S0ocEt0Va5DaqfJuMbJ/WDud8ZxAB6Mu9PbMxPmrRA34DpcuA4
         0Asqm8dXWhA+X2KC6XC3YmbGgHXFSkacz5BxOrSV7woAy4ti/oZmu1okS0+vtnqVWM3e
         JrImIWG2ri+PQ4QLog+RbsDbkshOnoSbrJMfc85MAGB+aCrV3exaSlNaFVKUFpc2Q6wV
         GkD1PD6BGvnhl+YhhFjEBIsp/qScrtHpwm0qPz+/h59dPh7kLkwT8f0wB+v9hOKDqvMB
         VmlCcMpgIJM700b420amoWh0tBd99j7CldiclSOEgjT/EzI/T3HvmzqhyrZazfMOT6k/
         o66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715675973; x=1716280773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LS0peL0MwvyMOdZgt++EgygrPaWPwT8KTIWTL9DYX6c=;
        b=msdEn3LfaZju+11vFq+ZD4LZa8XzMeoMpLINQBG3LijuIJekn+qorhR0LAeSv2dJR1
         OHsnrvU/4/MNblAUdSEK0cf0t5zGSm6ixV/f3T2O61dfLO6KC1m0++EytW72WAKO84Sv
         6DRvfwZ7Ijih85PScPAYIMxY3ALbZgGLgPJwCZIIy+Wmfpfa+myU2WoYTSkXAsQVo6yb
         TcWi2/IvL1mKvV4VksaZ4gItF3a2WJi3b1KfMCKaqnMM6ovd6i7Htbu61JJ5jL+r7e22
         qTrsNaghgEvLsytWMsrZCX/INj36L5zs0u1nd6i+vO1uMDAjVIVPcr4NbksCghL6HNid
         D1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtUAWM1oOnNrrdGdBvoVMuyW3LirHmSldKCaC2WHxHAW1Du96y4+aSnstszteOb6Cx4W6oB4mxizxGkDNWdEErq+XTrZDv
X-Gm-Message-State: AOJu0YysUgzVgK7Cpe4/GIN7InLS/Rl6plBnzcLlWeT4nkDwUekh0ita
	/L+Si8ICPYLh61n068gvswLgZ30JbS2BDonhMuIdYgRtfwNb23zC
X-Google-Smtp-Source: AGHT+IG+XBuPesGABN/DU+tou/THngVBqGizh2m2vmGjA1o+1uvBhmfyckrEfobGo05Gwci94M+ziQ==
X-Received: by 2002:adf:c049:0:b0:351:b56e:8bad with SMTP id ffacd0b85a97d-351b56e8c40mr4194712f8f.50.1715675972374;
        Tue, 14 May 2024 01:39:32 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502e5e0b0esm12890517f8f.26.2024.05.14.01.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 01:39:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: 
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Charlemagne Lasse <charlemagnelasse@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/percpu: Use __force to cast from __percpu address space
Date: Tue, 14 May 2024 10:39:18 +0200
Message-ID: <20240514083920.3369074-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a55c1fdad5f61b4bfe42319694b23671a758cb28 upstream.

Fix Sparse warning when casting from __percpu address space by using
__force in the cast. x86 named address spaces are not considered to
be subspaces of the generic (flat) address space, so explicit casts
are required to convert pointers between these address spaces and the
generic address space (the application should cast to uintptr_t and
apply the segment base offset). The cast to uintptr_t removes
__percpu address space tag and Sparse reports:

  warning: cast removes address space '__percpu' of expression

Use __force to inform Sparse that the cast is intentional.

The patch deviates from upstream commit due to the unification of
arch_raw_cpu_ptr() defines in the commit:

  4e5b0e8003df ("x86/percpu: Unify arch_raw_cpu_ptr() defines").

Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier")
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com/
Cc: stable@vger.kernel.org # v6.8
Link: https://lore.kernel.org/r/20240402175058.52649-1-ubizjak@gmail.com
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 44958ebaf626..66ed36b8cdb4 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -70,7 +70,7 @@
 	unsigned long tcp_ptr__;				\
 	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
 								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
+	tcp_ptr__ += (__force unsigned long)(ptr);		\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
@@ -85,7 +85,7 @@
 	     : "=r" (tcp_ptr__)					\
 	     : "m" (__my_cpu_var(this_cpu_off)));		\
 								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
+	tcp_ptr__ += (__force unsigned long)(ptr);		\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
@@ -102,8 +102,8 @@
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-- 
2.45.0


