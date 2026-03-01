Return-Path: <stable+bounces-222136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNq0NgCeo2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B221CCA44
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D6D93015EE8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9932FF164;
	Sun,  1 Mar 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxRnl2kK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F45238150
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329991; cv=none; b=aAt3f8WQKSihSM3MR7EqQlSwzX93WWrKg0lxyLqtyb9MY9NTF6Q8vcLEUmchHUGYLkXGbivbyFZLtSjnEffGYrlpKNbcc+ZCKo1vdBUTLlBQHzvo1zcWZefAOLUgGN4W9I2l5iVQv5tur4XupPh/zcZrKxY7HL8MRR1nwbfQHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329991; c=relaxed/simple;
	bh=kxeBlUcPBFMnqFuMlYJuhCiq2X6vslJ1sOWPFc360pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pm5T0P4daTLRHoMfST02iPeWlw11CMQQr7R03zt13x1kFlTz2sCaFzeDYnN700sj319vZaVNvOS1RkV01q7euFFFvUDJctOgm+rsddPPcs1phtBAiaIOZ8VN6jwMFtJY6CLYVGIJM8a0sPxCFXWPAjy5lYrpdSYk6ZcBeeJd36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxRnl2kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E35C19421;
	Sun,  1 Mar 2026 01:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329991;
	bh=kxeBlUcPBFMnqFuMlYJuhCiq2X6vslJ1sOWPFc360pQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GxRnl2kKTvymFxK6SoxdCdntLcyBEnI3mjU4F8gpJZlPQCpsFu+5WUgJsoweRX5Q6
	 nofjBYwPe0gxfwojsvQW6YqzRtEI7S9sjDepvOOlPI0O2CoIZB4qhZ9oXYd/2zdQ8h
	 nGNOxE2gL33trs3DRq3HayTTdzSWnYF75X9kmfyeKKLNStAHot3lLRj3ijhCnnGY5q
	 C8ko7n3SvCf70bI8f8l2FlDRBDSeYE6Wj2wk8jq2/k5qjWv8XV2hOZZXMMprMUg56n
	 ntfWF4ust2tso3myXkvRRB+JyYwl72DGWuPZxjRPIkmH0GxJlLufptT5d0OkuYBeUS
	 k0G4Rz5hSXPxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	elver@google.com
Cc: Boqun Feng <boqun@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:09 -0500
Message-ID: <20260301015309.1719827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-222136-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9B221CCA44
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bb0c99e08ab9aa6d04b40cb63c72db9950d51749 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Fri, 30 Jan 2026 14:28:24 +0100
Subject: [PATCH] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y

The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
qualified the fallback "once" access for types larger than 8 bytes,
which are not atomic but should still happen "once" and suppress common
compiler optimizations.

The cast `volatile typeof(__x)` applied the volatile qualifier to the
pointer type itself rather than the pointee. This created a volatile
pointer to a non-volatile type, which violated __READ_ONCE() semantics.

Fix this by casting to `volatile typeof(*__x) *`.

With a defconfig + LTO + debug options build, we see the following
functions to be affected:

	xen_manage_runstate_time (884 -> 944 bytes)
	xen_steal_clock (248 -> 340 bytes)
	  ^-- use __READ_ONCE() to load vcpu_runstate_info structs

Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
Cc: stable@vger.kernel.org
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Tested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/rwonce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
index 78beceec10cda..fc0fb42b0b641 100644
--- a/arch/arm64/include/asm/rwonce.h
+++ b/arch/arm64/include/asm/rwonce.h
@@ -58,7 +58,7 @@
 	default:							\
 		atomic = 0;						\
 	}								\
-	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(*__x) *)__x);\
 })
 
 #endif	/* !BUILD_VDSO */
-- 
2.51.0





