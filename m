Return-Path: <stable+bounces-147769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E70AC5919
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51C28A2039
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA127FB10;
	Tue, 27 May 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xuwHZK2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD7194A45;
	Tue, 27 May 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368372; cv=none; b=l3S3FsmJDr6m0bvSdR5hEL7fPvWG3pQijqwc4OSgFi7jR92yQ1oHG+zAebeei6x0vPNRHuK5S3JOTGZwRHees1Gn/8fR26UUzwKYy3RfRWzkDvzP9QPCP6zRY9IwkVNye+XgxFrbQPCkcoDscVDPYySv9R/E1T3Neg0cXccYbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368372; c=relaxed/simple;
	bh=2SqDwaMyM76LZDG+oCe2mCMLi0Ccrjyy3tgY5lhjqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghWj0Pmcf7lr+q9SMMHmkTJscYwf1/LeZgxwIm7D7SbxR07JY0n73RvmNz2yBWMmHh4CESzaka3Vuh62MAUgwAdG8WRh3ZqYxjanMiiuNZDAoJjXSJgXLiq1xD1+KsIbd38DcJFGInawKlmyMqSGKfJCzek7QLnzVgcRRdUY/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xuwHZK2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F47C4CEE9;
	Tue, 27 May 2025 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368372;
	bh=2SqDwaMyM76LZDG+oCe2mCMLi0Ccrjyy3tgY5lhjqWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xuwHZK2C65zB7aRp7XL+Nid6Wor3qNeHRWnpyd4FmQ9UaCFE3ndja5N+yr6jxdIjv
	 joxh2XKtPaq8a2Ux4T5uaQsGTojJ1JGuFOc3NaJENwBKlZCtZPddnh4HRQk8jdnE2L
	 hwdCh/P/kuFcg4JMOpbgAGFqUqzjsIo8q/n17gSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seongman Lee <augustus92@kaist.ac.kr>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 686/783] x86/sev: Fix operator precedence in GHCB_MSR_VMPL_REQ_LEVEL macro
Date: Tue, 27 May 2025 18:28:03 +0200
Message-ID: <20250527162541.065501750@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seongman Lee <augustus92@kaist.ac.kr>

[ Upstream commit f7387eff4bad33d12719c66c43541c095556ae4e ]

The GHCB_MSR_VMPL_REQ_LEVEL macro lacked parentheses around the bitmask
expression, causing the shift operation to bind too early. As a result,
when requesting VMPL1 (e.g., GHCB_MSR_VMPL_REQ_LEVEL(1)), incorrect
values such as 0x000000016 were generated instead of the intended
0x100000016 (the requested VMPL level is specified in GHCBData[39:32]).

Fix the precedence issue by grouping the masked value before applying
the shift.

  [ bp: Massage commit message. ]

Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
Signed-off-by: Seongman Lee <augustus92@kaist.ac.kr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250511092329.12680-1-cloudlee1719@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/sev-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index dcbccdb280f9e..1385227125ab4 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -116,7 +116,7 @@ enum psc_op {
 #define GHCB_MSR_VMPL_REQ		0x016
 #define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
 	/* GHCBData[39:32] */				\
-	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
+	((((u64)(v) & GENMASK_ULL(7, 0)) << 32) |	\
 	/* GHCBDdata[11:0] */				\
 	GHCB_MSR_VMPL_REQ)
 
-- 
2.39.5




