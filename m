Return-Path: <stable+bounces-220372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDRvKsk4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E01C64CB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C29A0312BCC4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95535AC1B;
	Sat, 28 Feb 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbpZxkBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F435AC12;
	Sat, 28 Feb 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300267; cv=none; b=HLbY0DGb5HJQWFEU512FrvHJm3zfwL/6EUwtjti/KpDuVhucpXl4RCrKbcykhRzUoL/BcTkv4Mc52DsIMkHHWgDOxsbefs/9zMW0Xz4zDBRzjz5nqpd5MADMO3IKzKqTp0+MVTQqCbiQQ/RQtL9C47nxQiAv1CNRtHxwkMa7vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300267; c=relaxed/simple;
	bh=cSWzlnpqidfMV0fh8o4QeLP6rReA62/EY2yPIuusBFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOiA68J+bqgkFxZ0iSPCzOUYtrIfk2YZZqGUR6907MpQNjNw1ANK2173yKwW6j4GV1JN/R3VvhKB2obl9MLztegU/s36XwDKCQXUO7szT/yGdUSy4EYdeIkqwazymGWGVLuTcJLlN1Eoww0yypISjLI3phY0L22U5viDSGWuOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbpZxkBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F5EC19423;
	Sat, 28 Feb 2026 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300267;
	bh=cSWzlnpqidfMV0fh8o4QeLP6rReA62/EY2yPIuusBFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbpZxkBVdKKeNWqS+9ShxxaCAWG6r+2snkB83D3liHvNO1qulfl+WCDN+NnYpt1wP
	 xa7eGaenOk/TTymHbZM/mX1s/cDxa/iaQumHplt7eHV9qle7sQETr5B5KMPAshq99k
	 uBGnXgYiO/G8hEJvrGK6YmWjkRrA5wQqIrGCIvvJ5YFDbh2uyHUk+TgGNJYtzgkY1x
	 aF2ILVgNCoDo4rfUTS2Vo8C5Hk3Tc/8M3DmMlOL+3Jw4sMwwhwEuzYL6jJyQf1PyYr
	 JPP4wfd/na7Qe7crXvt0T0MNvwy5iUkOOEDAA/ECN27HRDPc1jF4EjQ2m0GBL3awq2
	 l4nvRO6kCWYVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Masney <bmasney@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Stafford Horne <shorne@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 293/844] openrisc: define arch-specific version of nop()
Date: Sat, 28 Feb 2026 12:23:26 -0500
Message-ID: <20260228173244.1509663-294-sashal@kernel.org>
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
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sin.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220372-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D40E01C64CB
X-Rspamd-Action: no action

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 0dfffa5479d6260d04d021f69203b1926f73d889 ]

When compiling a driver written for MIPS on OpenRISC that uses the nop()
function, it fails due to the following error:

    drivers/watchdog/pic32-wdt.c: Assembler messages:
    drivers/watchdog/pic32-wdt.c:125: Error: unrecognized instruction `nop'

The driver currently uses the generic version of nop() from
include/asm-generic/barrier.h:

    #ifndef nop
    #define nop()   asm volatile ("nop")
    #endif

Let's fix this on OpenRISC by defining an architecture-specific version
of nop().

This was tested by performing an allmodconfig openrisc cross compile on
an aarch64 host.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601180236.BVy480We-lkp@intel.com/
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/include/asm/barrier.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
index 7538294721bed..8e592c9909023 100644
--- a/arch/openrisc/include/asm/barrier.h
+++ b/arch/openrisc/include/asm/barrier.h
@@ -4,6 +4,8 @@
 
 #define mb() asm volatile ("l.msync" ::: "memory")
 
+#define nop() asm volatile ("l.nop")
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
2.51.0


