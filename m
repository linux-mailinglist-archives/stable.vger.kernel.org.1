Return-Path: <stable+bounces-220186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHLVNdUto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB61C55E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C662731A782E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED04C0435;
	Sat, 28 Feb 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGAY53nJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA904C042E;
	Sat, 28 Feb 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300093; cv=none; b=E9hEiDsalss57+He3i7+xy1+MHKK+tQGnZsnWHEPDE/gV702FPOen7+PLncpP2bJ6hFo1gpriJqu7DC53nAGojWlOJwhCCh03puv9Pt0fyTRCQMk08y2alsCxNPL+IJxdAA7TXifQkdzk6SsiZEnhrlRPu89GT0Zyl8AEhQaHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300093; c=relaxed/simple;
	bh=Ix2tqAtDfLsARaykkaLnpch4kUaJMJ6GE7Rk6SrSrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYGMAtYyzEji5PXpoCdU4WDl3F7RNovIXCaueQEmKR/GvfFkwd8G3JKCXD90023SpynJokv7mR5FqeHMNSIr7+HnQME2FemW77389pW3qcRwkHlnDn40uNyN+SbcKRlXeqQzwxqUOoi8ZrrGAWP11bHzPlN2Ws29qonB6VD3Yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGAY53nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6933BC19423;
	Sat, 28 Feb 2026 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300093;
	bh=Ix2tqAtDfLsARaykkaLnpch4kUaJMJ6GE7Rk6SrSrnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGAY53nJKJZ+plk62JEKoWdbtIjfpDcGkAwSl6+0uWj7UyncoRveT2iTZqUCn6zvc
	 8lBl+jvhgZ/TiO7Cr23dbURI+txD5WOrbEXEluDd6rhtUUbyeAEMgDlPkBqXU+xHcx
	 IlzANQ26IGYgRBXBmUquaj6cFYAZbgzGgHa7pB8sh6StHl01efLgyJL8CwYjm9HRs+
	 ns+apv45jhYgYOSLbQHMG4IymqKBoxJ+3uwaqF+t2xJpNO3KNLDD3iPse/ZezikHXS
	 mIYPcDkNs/N4JHkzZCPUXSpi+5pT0TtyFO1BCLFwaOCLSChddfU3mxHCInh41viBL/
	 EINJ0Q/X0WC9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 108/844] crypto: hisilicon/qm - move the barrier before writing to the mailbox register
Date: Sat, 28 Feb 2026 12:20:21 -0500
Message-ID: <20260228173244.1509663-109-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220186-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: 49DB61C55E0
X-Rspamd-Action: no action

From: Chenghai Huang <huangchenghai2@huawei.com>

[ Upstream commit ebf35d8f9368816c930f5d70783a72716fab5e19 ]

Before sending the data via the mailbox to the hardware, to ensure
that the data accessed by the hardware is the most up-to-date,
a write barrier should be added before writing to the mailbox register.
The current memory barrier is placed after writing to the register,
the barrier order should be modified to be before writing to the register.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/qm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b8e59f99f7007..cf58d0d01b199 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -609,9 +609,13 @@ static void qm_mb_write(struct hisi_qm *qm, const void *src)
 	}
 
 #if IS_ENABLED(CONFIG_ARM64)
+	/*
+	 * The dmb oshst instruction ensures that the data in the
+	 * mailbox is written before it is sent to the hardware.
+	 */
 	asm volatile("ldp %0, %1, %3\n"
-		     "stp %0, %1, %2\n"
 		     "dmb oshst\n"
+		     "stp %0, %1, %2\n"
 		     : "=&r" (tmp0),
 		       "=&r" (tmp1),
 		       "+Q" (*((char __iomem *)fun_base))
-- 
2.51.0


