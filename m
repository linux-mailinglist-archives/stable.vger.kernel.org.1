Return-Path: <stable+bounces-220135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPO1A8sro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F11C52FE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 391DE3128686
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADD481FDA;
	Sat, 28 Feb 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsXssFFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5206481AA0;
	Sat, 28 Feb 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300044; cv=none; b=U8y92fwEScfrHPWyrS43Aw6PJkeX1/s69Zm5Lh2i2lTHXUMjXCpPQdq8e5R+vA8103XcFZtFNrZxvtN26kBBcq4Cek/sKzXDb8BeC3VE8MsHRpEN4/Q3xY6XcFhRB17I38Kf94z8IzUrzc9r3PW1leOy1Gtsst6W9+gR2cZEyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300044; c=relaxed/simple;
	bh=l//FoZgeTK71MhpWblD6GoSpBOiJdL79uAa8VL6fHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsVEE6j+16kOeVyq9cmRzbZYyfleBzMww12P0eMcXywk1LeNDLMo+abKrLBM45BtVGlxL5V6tY7mXgggmNZyn0WJ4yl85M2YA/MpgH5wdIuDFUtXKEvQaS4eZP1vzjYOF/EkLnftlga3MjSnNVxPda87WOX+vHvX/R+C+1dzDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsXssFFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0411AC19423;
	Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300044;
	bh=l//FoZgeTK71MhpWblD6GoSpBOiJdL79uAa8VL6fHKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsXssFFnSnBONs2g7P2yqO743SULqKM9fo0oNHGPLX3qBCXEmOGe/CBiyFNZa0T+S
	 aGkPEHov1CDHvVV8tN2tqPpOXxZdl0ZStSJ1XKR84YFRp+WkpxHFcAp0Dqq8ZmeCy1
	 IO18HtXB4qmSG6VTDoLHaobNW2PbqaBqsdIrovDHHrKklrYDxT2n4am/zW+LlAQS8g
	 2SBQYQ+LB7YdshudcjUt6oB3LPt2mfLfYJy18jAKCC1HKobTBy7/3wJNXkC9BleHxq
	 iuw+vSrqMPbI16DC7exiPuoCxBAQLV7lkh8YjNRN3T8aozbs3cRFFdHHealu8dz2Qr
	 o0omNFTxsUtYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 057/844] s390/boot: Add -Wno-default-const-init-unsafe to KBUILD_CFLAGS
Date: Sat, 28 Feb 2026 12:19:30 -0500
Message-ID: <20260228173244.1509663-58-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220135-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F2F11C52FE
X-Rspamd-Action: no action

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 5ba35a6c13fff0929c34aba6b7602dacbe68686c ]

Add -Wno-default-const-init-unsafe to boot KBUILD_CFLAGS, similar to
scripts/Makefile.extrawarn, since clang generates warnings for the dummy
variable in typecheck():

    CC      arch/s390/boot/version.o
      arch/s390/include/asm/ptrace.h:221:9: warning: default initialization of an object of type 'typeof (regs->psw)' (aka 'const psw_t') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
        221 |         return psw_bits(regs->psw).pstate;
            |                ^
      arch/s390/include/asm/ptrace.h:98:2: note: expanded from macro 'psw_bits'
         98 |         typecheck(psw_t, __psw);                \
            |         ^
      include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
         11 |         typeof(x) __dummy2; \
            |                   ^

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 490167faba7a4..a1e719a79d38c 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -21,6 +21,7 @@ KBUILD_AFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_AFLAGS_DECOMPRESSOR))
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_CFLAGS_DECOMPRESSOR))
 KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
-- 
2.51.0


