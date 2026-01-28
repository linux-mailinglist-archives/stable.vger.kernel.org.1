Return-Path: <stable+bounces-212483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNVBFf0xemlo4gEAu9opvQ
	(envelope-from <stable+bounces-212483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:57:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD167A4CF8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 243AD300E0C0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166C2E2DF4;
	Wed, 28 Jan 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyJ82/y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFA2857CD;
	Wed, 28 Jan 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615669; cv=none; b=b2Y3EXPCMsv6B1yJm6nVxKc2dFdGkeoRU0tHR0pi7noyf0u2/6VUiKj1Vc4tMPo+/ySqvYO7ope9OTGjJ4U+rhhvCTOtl0sXOOeIz90sCyPF2spohWV5LUz7plP9ODnxhMzYfJ85+Nx0MXhiShNDJVvCTHsJc7IqPfp0odA1FQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615669; c=relaxed/simple;
	bh=xBsjEFUc0YafeOUsXH/z1vK7003dYvI+Jm/8IWH2VLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6QUFn5FJZjGxvFW690V0NlgmklcOH0ZjzHdBwMyDrP+mr0cVkzrbG41Qf+ehAC3XTz6+bRGkRXxOzTK4/Un42nx3siK+bsNwr9Tmvgz1xZFLpzoCHeAClAW/lBXoYp6LCNGTX5Qbnsrax36ODqP863COIQypygN72gjmJVj7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyJ82/y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81F8C4CEF1;
	Wed, 28 Jan 2026 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615669;
	bh=xBsjEFUc0YafeOUsXH/z1vK7003dYvI+Jm/8IWH2VLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyJ82/y4gid/fEE46b5KmwoBTE3JF/HsNI/txEYiWMm7FnzPOQggDa6teQsp7oOjw
	 R8zawjTS06sJp9bIScq/m03hgZZWv7GAzGZFyi+ua2nAhDygaXSQg/3dcZTi3gcLVy
	 KpUHSzPj0MxbCE2rjcq0zTNrpE+WOpwLcGR8N4/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.18 079/227] timekeeping: Adjust the leap state for the correct auxiliary timekeeper
Date: Wed, 28 Jan 2026 16:22:04 +0100
Message-ID: <20260128145347.186698418@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212483-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: DD167A4CF8
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit e806f7dde8ba28bc72a7a0898589cac79f6362ac upstream.

When __do_ajdtimex() was introduced to handle adjtimex for any
timekeeper, this reference to tk_core was not updated. When called on an
auxiliary timekeeper, the core timekeeper would be updated incorrectly.

This gets caught by the lock debugging diagnostics because the
timekeepers sequence lock gets written to without holding its
associated spinlock:

WARNING: include/linux/seqlock.h:226 at __do_adjtimex+0x394/0x3b0, CPU#2: test/125
aux_clock_adj (kernel/time/timekeeping.c:2979)
__do_sys_clock_adjtime (kernel/time/posix-timers.c:1161 kernel/time/posix-timers.c:1173)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)

Update the correct auxiliary timekeeper.

Fixes: 775f71ebedd3 ("timekeeping: Make do_adjtimex() reusable")
Fixes: ecf3e7030491 ("timekeeping: Provide adjtimex() for auxiliary clocks")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260120-timekeeper-auxclock-leapstate-v1-1-5b358c6b3cfd@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2721,7 +2721,7 @@ static int __do_adjtimex(struct tk_data
 		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
 		result->clock_set = true;
 	} else {
-		tk_update_leap_state_all(&tk_core);
+		tk_update_leap_state_all(tkd);
 	}
 
 	/* Update the multiplier immediately if frequency was set directly */



