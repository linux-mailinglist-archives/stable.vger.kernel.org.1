Return-Path: <stable+bounces-203471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6CCE62B6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBEB30053E5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC326A1B5;
	Mon, 29 Dec 2025 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qaR1iYCW"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9091A4F3C
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766994822; cv=none; b=gCtgFf1BZk1dHdet336cZa5HwKEPumNTD15OSh6C0ye9byHmOoINwwaTio7FIdvGKvueQLyDvR1IcL4gvulKxmRwihqNydULCo/TL9TULSTcnaRLfMCtkUOsCfdwKXeBMY2RVeSBMt1euRCFvTXdq2uEetZq4TlYXxkGDq+72e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766994822; c=relaxed/simple;
	bh=1VWzVXsgPj9vHaa4QreuNha982gkYmnazV/B2ritDHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN0I6hL9+k2ciSwIu0SwQR2lw42QHf6MO2pS/6Tahm5GH34zfa6HkdlP0zRgt9YRS3iK4cFLLFPulZCCa0bnoMLxhDlorRbRyKY5NrO+LMkkJV8QznvCcAZeI6RS6g59jxlM7oaBIM+E7IbzuphXkbAV1DGwtM5q6puypdE+o4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qaR1iYCW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766994818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2aEiYRTSi0JQw1+rh+RFBJta3Dp/hmtXQMqUQmhArsE=;
	b=qaR1iYCW1DHuAS667KhsF2oshRznCQtR6D4QC49cQ9DMRJdrrnpchgr8BYv99j+OWR5roq
	ia9abdRHsR2Awmx1ztzddgqfkgmaM+agvkckDtD78VrRvs3SEKM1aQmVoP3wPg7apQYXpZ
	Y/w9VERGR4dWbmKGztJBD5uIlrY8dfs=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.6 0/2] fix do_softirq_post_smp_call_flush warnings caused by NET_RX_SOFTIRQ
Date: Mon, 29 Dec 2025 15:53:15 +0800
Message-Id: <cover.1766987153.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with preempt disabled,
raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
longer preempt disabled sections.

RPS distributes network processing load across CPUs by enqueuing
packets on a remote CPU's backlog and raising NET_RX_SOFTIRQ to
process them.
    
The following patches fixes this issue.

Sebastian Andrzej Siewior (2):
  net: Remove conditional threaded-NAPI wakeup based on task state.
  net: Allow to use SMP threads for backlog NAPI.

 net/core/dev.c | 162 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 115 insertions(+), 47 deletions(-)

-- 
2.25.1


