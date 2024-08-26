Return-Path: <stable+bounces-70273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972195F807
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979C71F2365D
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436DD1991AB;
	Mon, 26 Aug 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXhPfBpP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kd3iHAtK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED61990B7;
	Mon, 26 Aug 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693129; cv=none; b=ZpfCgRywU3Z3xI56vjlCgZoIVgYKEQC6JC5nfts5QUZF2ltnDaqbIhSPBTIaliz40OR3AJ7QMPwzXWYQIKkfstJX/RC9EvbSrsRjuNG3InZ3gWJ1TZHnfVzEOQtCVFe/vaWM2hmI7Qn+gL+ggELDTEoGEruXUsxb/f3nBuHDKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693129; c=relaxed/simple;
	bh=bycceD6Sq3X8h7aj7Xz2NeR99SoTYzobcBZPvCA+e2o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Y89giwP/OguZIT6LqgKGXakQAXpq4LWMX8kYK+Mp9dVBFEmxyw0c0cEHk7anqc1y+85z1o4MzSdDd5YihxnnlEPhcMecgSjRgk408Z/45ZcU5uSC88QklOKb5d8wJ2gGVk+Vf9DUcaEIPVGXj4LQjseJnvIKWU0x+Qf3R3A5Qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXhPfBpP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kd3iHAtK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 17:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724693124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j5h0WpF7s0MWkaPvokJ1ZrffLzhCYljqkZkHQaGieFA=;
	b=iXhPfBpPTWjEp8vtUd9rBwFJ9vaFvey3smUe79xZsizCY4ZMnhWEtIWfMOAcKLJJoAxv1N
	9z80vDK641aZ2lkad4bQsRVlh9frKhkylufUzn0DLO5qC9eOUPthvm4a+aMfSh4avZ/N8N
	1c0EClzblT/39kYtnY4supP69uE0+9UMsKKfAuWqVbWGGAgsS0MQN3uG3u13gm+KqEU0FV
	2XFP3bMUZFdte25N973NdASLcjQV1YNuk4cousQtf7K71ydZmG41b/om/zsngBajGR1her
	KQiDf8twBO1tCaDf6IN8D+2uOjZuD+3MRe26j8evzkf+F67N7vNECSYQmqIeOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724693124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j5h0WpF7s0MWkaPvokJ1ZrffLzhCYljqkZkHQaGieFA=;
	b=kd3iHAtKdnloCrS7XQ5qlAvkO3onttdfYy0jS4pzbdcg4FBiqxVsX9yxpebD13XwZoGMDi
	u4MpT0Bd2moCVKBA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Fix data leak in mmio_read()
Cc: Sean Christopherson <seanjc@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172469312398.2215.16151331896868835414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     eb786ee1390b8fbba633c01a971709c6906fd8bf
Gitweb:        https://git.kernel.org/tip/eb786ee1390b8fbba633c01a971709c6906fd8bf
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 26 Aug 2024 15:53:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Aug 2024 07:04:09 -07:00

x86/tdx: Fix data leak in mmio_read()

The mmio_read() function makes a TDVMCALL to retrieve MMIO data for an
address from the VMM.

Sean noticed that mmio_read() unintentionally exposes the value of an
initialized variable on the stack to the VMM.

Do not send the original value of *val to the VMM.

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240826125304.1566719-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2ba..da8b66d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -389,7 +389,6 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r12 = size,
 		.r13 = EPT_READ,
 		.r14 = addr,
-		.r15 = *val,
 	};
 
 	if (__tdx_hypercall(&args))

