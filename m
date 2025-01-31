Return-Path: <stable+bounces-111790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF1A23C60
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05C1885B4F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC11B414B;
	Fri, 31 Jan 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="sdQu1rAt"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462D1ADC6E;
	Fri, 31 Jan 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320105; cv=none; b=L87tdYOmGQ5XO6CkcgZENPpVfJMbf9bzdBdjOHZF3K1+YqjbEToTCoHihDASah5IsM7ZOjJxyHDVgBi17j7n/zV55g3OST+IAjvmflYFzw5ydxg6LoBEpeObUZQZfgNKPjAbg/h8u4dVD0W6otu0BMqeqDPiMh+zGhV2WLwQ/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320105; c=relaxed/simple;
	bh=/3GSmpoCAJhdUHcsH0C4nkKAgmCmf7SvRKRvXj901CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUMjYBCa1PQ6RqzkiGilgOLU7vOuxYWPvFJRVlPNndWOVJRXdFsQzHZVpDOgARb/qLGcQtCbP5Ff4dwSIaz1z2SMiMRIJzChCGkE1rZQ+YQEW+qgNMNSdwhx4r3Du1p5HR1d3CWHHJqwJqIiP/72L05KE6STu4tlwnIX/p7VqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=sdQu1rAt; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MAGc3C782RcuVPqtgCHWbk9Msj4KMIw5qLn2RNcmO7Q=; b=sdQu1rAtDXIA23nZh/MXfGQVH2
	iebOwnwEv1eUX+oiO5uKHUoTMJjtnLDcvYlwH9CzhYQYoeoPjTNktLc7wk3pKjC7ehCdtO9e69rTY
	Hu6zV/LVhjbCZUsUkSHjvLs/1MAQ6X4q8s+IUGic8F1ZPLYWVPVRWgIPAPZtRINURkW/gpLlNHHt/
	BSKEe6vvCMJM44GZLvn6VPn3tNpocnMR+JcL7G5C3rM4pdN3dn3O0CfDIEEnfGTB8F2Qn15SLDz65
	ReBkAqp3JTVfIrHEXvx8qN+aEocYh4mijmmqKKfMCmVXkxFVkg+D0/VjrT0ad4BH1ElpIEoESAYZj
	8/tiKwKw==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tdoSo-0002sc-0k;
	Fri, 31 Jan 2025 11:41:30 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] alpha: make stack 16-byte aligned (most cases)
Date: Fri, 31 Jan 2025 11:41:28 +0100
Message-Id: <20250131104129.11052-4-ink@unseen.parts>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250131104129.11052-1-ink@unseen.parts>
References: <20250131104129.11052-1-ink@unseen.parts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add padding between the PAL-saved and kernel-saved registers
so that 'struct pt_regs' have an even number of 64-bit words.
This makes the stack properly aligned for most of the kernel
code, except two handlers which need special threatment.

Cc: stable@vger.kernel.org
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
---
 arch/alpha/include/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 693d4c5b4dc7..694b82ca62f3 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -41,6 +41,8 @@ struct pt_regs {
 	unsigned long trap_a0;
 	unsigned long trap_a1;
 	unsigned long trap_a2;
+/* This makes the stack 16-byte aligned as GCC expects */
+	unsigned long __pad0;
 /* These are saved by PAL-code: */
 	unsigned long ps;
 	unsigned long pc;
-- 
2.39.5


