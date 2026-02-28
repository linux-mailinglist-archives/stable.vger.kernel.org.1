Return-Path: <stable+bounces-220137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ODRJ2sso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C921C53FD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C24730D4FEE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FD48A2C7;
	Sat, 28 Feb 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejiMAbtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6448A2BB;
	Sat, 28 Feb 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300046; cv=none; b=r21IyAYwtwa8018vAwxM5ES7Avt9HnZzBqo5cfqbyLcz80ZHnuNa+qijQQ00sCHGWAqjQS+Ci9G9OcFI72tLQT1Pq2d5oRl+sp7hsuPjxbmvQOAyRzD8fMMYQYN2I0j88K6Qb9n6nttXMgW2AVHHyYytF4lLecfJ9/CLl6DUDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300046; c=relaxed/simple;
	bh=Z4QxMGUMs+yL5pkf3AhedAWqGSrzajzhBO6RxS9IArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jncoO1zNRPmDP/iU7Mf4pScX1YAw5n45Xjukl5B5Uo0D0yhsM92fhR58j9R95F8DPpiyDqs+76n923tifAnPgw+N+DxmjXli9FNl44GO2sIymogaYhRYMAjma9ICYix9d+8P5MkSVZReRYjeNtHkyc3EtZ7m72aUeIccfwhIC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejiMAbtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD41C116D0;
	Sat, 28 Feb 2026 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300046;
	bh=Z4QxMGUMs+yL5pkf3AhedAWqGSrzajzhBO6RxS9IArk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejiMAbtEdmtoTY05xrfQuEaCe10SvdXbxScdN92stW0IpLUauglHA16jGAw5mkz4i
	 zoB6VV/YvR9/izODsMFFmMM5/zQPXiw6ic3L8Cxs/ujGaBMAor+HgF6iTKSruwzM61
	 pQ1AH1qDHXMrA2hbAOWdtUYXprDUNKtUvRqOdUy8n26aK0PbySCROGSyCCUtbwvaP4
	 vukR9yZqqqvgYh+XUrMU/T4z9FqOtc2PsRsiAt2974tLNJt910KqaBWnc40O+a4z5b
	 aFC+cuqleIuUHLfRAbIH37toSlWgUt7pMzNNjwrjLgLVBAk2EraGRP5rdAgNwi/9H0
	 xgxL7ORwt6tOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 059/844] s390/purgatory: Add -Wno-default-const-init-unsafe to KBUILD_CFLAGS
Date: Sat, 28 Feb 2026 12:19:32 -0500
Message-ID: <20260228173244.1509663-60-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220137-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1C921C53FD
X-Rspamd-Action: no action

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit b4780fe4ddf04b51127a33d705f4a2e224df00fa ]

Add -Wno-default-const-init-unsafe to purgatory KBUILD_CFLAGS, similar
to scripts/Makefile.extrawarn, since clang generates warnings for the
dummy variable in typecheck():

    CC      arch/s390/purgatory/purgatory.o
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
 arch/s390/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 0c196a5b194af..61d240a37633d 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -23,6 +23,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS += -D__DISABLE_EXPORTS
 
-- 
2.51.0


