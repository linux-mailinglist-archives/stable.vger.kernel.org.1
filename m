Return-Path: <stable+bounces-232534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMEYIwcJzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E136F58C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6308B31450C7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0B3168FB;
	Tue, 31 Mar 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdZ/iM0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2A315D50;
	Tue, 31 Mar 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976991; cv=none; b=CqhIIH7zI2pZeJF6NV6wvXMmBx9CQFbAUnqUVE4zGLYg2HS2F3S/doZwU6/d/ocenIeLe5LV73PEdcHT6TJhkVx+BRlfE9iGsfwBNHU42vtH8hJmxSBopFKuyKz+HaQPRl7IH8U6fK5AoRfXeOYe4ogMP3hITM/6difhBRLzBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976991; c=relaxed/simple;
	bh=W9WkA/yifFZGKNwgUvsG3Yn2hAvkQtL3nS5lBfOWXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE5UTaTnNDUryhJowExHWmbCPxh8TLQ+fTH5oNJX1REraMhwA/VI0KiHTE4jevhz3jXu+/ukVGkoztHQL35B0KFB0xHUWpjcpddRcnbWZQuNHKjC0A0jI2Dgmd6yvkfzmFV4arWqOwgvWOyTO1UhkZZNtoAqFlfF+GT4/piOAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdZ/iM0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE282C2BCB3;
	Tue, 31 Mar 2026 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976991;
	bh=W9WkA/yifFZGKNwgUvsG3Yn2hAvkQtL3nS5lBfOWXPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdZ/iM0tLvZRRAOfJe366iHoEhojMAjoLuxcwj/eaXjKg+ioOUL2XxigdROwvXsom
	 G6Ip+72MFIQKeAMZ6nTxd97XLWVh7tOUyMlTVLgQQ2n+QrZFsHIi208Ei1Yp2FXOk/
	 1TuehOH7pr5zH4jU97o/2hYpS2j9x/HlBFN1c0mM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.18 274/309] unwind_user/x86: Fix arch=um build
Date: Tue, 31 Mar 2026 18:22:57 +0200
Message-ID: <20260331161803.646394395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232534-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,infradead.org:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 123E136F58C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit aa7387e79a5cff0585cd1b9091944142a06872b6 upstream.

Add CONFIG_HAVE_UNWIND_USER_FP guards to make sure this code
doesn't break arch=um builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202510291919.FFGyU7nq-lkp@intel.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/unwind_user.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
@@ -34,4 +36,6 @@ static inline bool unwind_user_at_functi
 	return is_uprobe_at_func_entry(regs);
 }
 
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
+
 #endif /* _ASM_X86_UNWIND_USER_H */



