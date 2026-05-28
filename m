Return-Path: <stable+bounces-256440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFK+HG/MGGrrnQgAu9opvQ
	(envelope-from <stable+bounces-256440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:14:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF85FB467
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F3833170189
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25833D4E2;
	Thu, 28 May 2026 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6uB1knX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7C367F36
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009849; cv=none; b=WioavtIHjszqFgD6bBmJCoG61wdc1TQjzywjtKjE90hJqSVnRPZhryJFQZfc2J8mvgr7TIedFfuTeIsGEp7GJS5zxUoRAxtdJ49NjkPNio59j0+RzhjgTvqf1i1eF/wUgDMgxCSh2PBQ646aXO1V/EWNFoVGy/Ns3EFO9kdFYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009849; c=relaxed/simple;
	bh=fhdDODqpR4chdblBJU8fdAmz1DLGOrwpgf0lUaM2PoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEmhg3HXV6mXvfW/E2LPunP2BmleFRjSBqpX6xHWYhxU7cEbM8UiSiZc34gFZ8BZ3fMZA6jplfQv/9FBGYhwCpE9SiDKDhSfck8DehERzU6VsKSi6LbbN0bFWpoZejxlluXlw6ozrEzzacMrxDjj14KueuTOqIRsTntfh8K2iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6uB1knX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7c0de780bf1so120191057b3.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009847; x=1780614647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9S3g84A5WnXh4iXXrEMsVPJdFWPARrWB1WQLZWJngA=;
        b=s6uB1knX29QnqkLhm8Fz32YH6HqwHQU0VyFZsjGSvbfJcvjlW/ABX0DlUATj1RmXWk
         rN0dxmgZJWDMrIe4fwKxgZyopijeDreRWbOdVSIK8bepkLo3RyyS34euy/2VUCKUHOTX
         6w92nc+FglHq6wPf/RH66bl2tv/4vCxnvIjsqQ4ac2srDRncE0V+VY1UIUwcbacIOWBO
         U2qUvibWUxaJ8tj1AA+vK6FGt67kIF+Vz88SD9Nxvb15owHsTaLBYg7YYTkkZgghc1sM
         Czm6+6BUFy5IUJFKpgnK06T8Gthfj49HrU8lUjHsDKZXVg07V2BwWgSuJf5fugr3DWMr
         mkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009847; x=1780614647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9S3g84A5WnXh4iXXrEMsVPJdFWPARrWB1WQLZWJngA=;
        b=W4lDobJj/pYEFOaTctnKCElu0lFsNKHWa4Al4AFJK8jKNVrJL4oxi6EB6HSafpJDsh
         zDUI2e53Qqx6FXtvnsmGsDCB5EdCmBWg0bf9pFUY/i1dPm8QefDRxGbZu0ICBNfj3Rcs
         SDH8R0P6T4i8QRQfdy2RF3Mo4Le1CdFfYUqSEIvXiOSzAQzg5ClqVdJiOvNi4k7U9xkJ
         VCs21lLs5sXyZWHqzyMc6uoZxw0eJrRKUia6CTBaPQwbKwja4bRWVQQ+6EydGq3BCoip
         I86Rrahw/lnYvUeW4qxTxDVrN/1NPWdzZ32J5SiVCPCcMvW7jPfe6o81sUl910/4zYdf
         raag==
X-Forwarded-Encrypted: i=1; AFNElJ8twIx1uk3d75xuFTMZ2r2x3frQa9SlcC79qGr69LmuJe+GHEJEmQvZ6orkVvXCRUiQiCWe1LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykn1gZGzqRVMn6NCtP2kBkPxDlzxUFKyGQIXBASvk7iOWfC9qq
	r2H2yrx+joxN0y5HG+TRuq2UdreiZQqaMOWq0iesqmjaeY2zVNbWjupK
X-Gm-Gg: Acq92OFmzJv/1NnTdu2Va73E9cRGv+uDIVSu7ZnF0k78YsK/eyPAYufUioviP1R283O
	tJQJbJaboJXz48eB7z5vauvsdFRc6/yBOcK3gETh/WXH3JRCXvvhSJT5C3kE7bAOcI4QZ9tvIeR
	zwSNVBM1rVVLWE4rRg++bKDDX0lIF3kJTp14uiRsiCkLF1QZSLwO6iqooMt5MFoysabt9lHR3kR
	2V1XiI/yKsZUSqhBrgWwlSD+ngW99wdLholhp3ZV1A4PdmRkgXV6y3/T8yKaNe6FhPV5mz7CuzB
	d/JvE1mJMlgVbD/iEMxVNWIhc/m/v8O4ARBXohuckyEj7KvsCXfmMC34XsKuR6g75W0yXv5pftE
	w89b7Ol9VqJDnIPfxuy4tavcTjW+WcLO9RXGkMdLYZ6cT/B+kDVXEaSCcOJd49Lgg47kRqPLUKP
	csihtXcnXD+JeqagnIbkNuPljzlwil3Ky9QPX8TI/IvZu6OHuAsEbH6cMzpyrPrF/tkpRSXIKXz
	IqOFuMnc88O1CP0FIoXfO92
X-Received: by 2002:a05:690e:1904:b0:65c:5b88:84a2 with SMTP id 956f58d0204a3-66052cb1fb4mr144652d50.4.1780009847107;
        Thu, 28 May 2026 16:10:47 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6604e6a5b44sm261601d50.10.2026.05.28.16.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:10:46 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] alpha: Fix SMP shutdown hang due to missing memory barriers
Date: Thu, 28 May 2026 19:10:43 -0400
Message-ID: <20260528231043.1842326-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256440-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattst88@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCEF85FB467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alpha has a very weak memory model. halt() makes no guarantee that
pending stores have drained from the store buffer. If set_cpu_present()
stores are still buffered when a secondary CPU halts, they are lost,
and the boot CPU spins forever in the cpu_present_mask wait loop.

Add mb() before halt() on secondary CPUs to flush the store buffer,
and use smp_mb() in the boot CPU's poll loop instead of the
compiler-only barrier() to ensure it observes secondary CPUs' stores.

This avoids a deadlock on shutdown on EV7/Marvel platforms.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git ./arch/alpha/kernel/process.c ./arch/alpha/kernel/process.c
index 06522451f018..d50f9cfd8333 100644
--- ./arch/alpha/kernel/process.c
+++ ./arch/alpha/kernel/process.c
@@ -99,6 +99,7 @@ common_shutdown_1(void *generic_ptr)
 		*pflags = flags;
 		set_cpu_present(cpuid, false);
 		set_cpu_possible(cpuid, false);
+		mb();
 		halt();
 	}
 #endif
@@ -127,7 +128,7 @@ common_shutdown_1(void *generic_ptr)
 	set_cpu_present(boot_cpuid, false);
 	set_cpu_possible(boot_cpuid, false);
 	while (!cpumask_empty(cpu_present_mask))
-		barrier();
+		smp_mb();
 #endif
 
 	/* If booted from SRM, reset some of the original environment. */
-- 
2.53.0


