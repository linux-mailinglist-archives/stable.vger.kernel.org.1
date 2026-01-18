Return-Path: <stable+bounces-210217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E48D397F5
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 651B330443F1
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4167231A21;
	Sun, 18 Jan 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXXAliuT"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA8239099
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753747; cv=none; b=BeQl24Giu7NoiHERDJiIHcOyWfRcus/C3svimDgdRZSpVDiykuNXuQDBB8E0P81odayKC2inetTNqW7IFQiFO9RR1MrZm998m2ScME0CH1bxIOrRvfn5gChj3n7uy/T5CiQcaUMjnXqjDPLzSQayzuStCEPoGC0P2+18R+nxYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753747; c=relaxed/simple;
	bh=stuXfsC2R2WgtLp9fCfuUxiYdJI3HqQhBs6ki4A/LRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EWWffMzYi8i6H9Wplw9TKMfRyC2gmFhiKk9Hh1US2c2s4ZYn/fO4TM0rX/4PaQ1h4RGjcHZ+poQzZK49Itw/nMLR6wxS8k2ZojflY8zlXP8gbpOKHEVg+UF3IEQ/tuj3OiKXL2GtWzp2BpEQoKcTsKCDpUS/b7ItkmUQ3T+Eyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXXAliuT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768753731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rElvZdowGvl1nqp3YNSrESkv/wHlkAfhkif6BXnCRqc=;
	b=xXXAliuTuv5whv48IhVnPc73boyYeO4fKWj9UPfgGkx7SMZk5dCB0RlqnjxKt21q6Nhfi7
	nT4z7WnRjDmFY+8PuRVg6wmjrYNKkoC6HUWPuOcis+o8rjYyHcavbkmqXI/4QXevmyYGDn
	clSfYb0ygeJgXrie+Fs+4yBI1FPnQ7E=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 0/3] net: Backlog NAPI threading for PREEMPT_RT
Date: Mon, 19 Jan 2026 00:28:21 +0800
Message-Id: <cover.1768751557.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Backport three upstream commits to fix a warning on PREEMPT_RT kernels
where raising SOFTIRQ from smp_call_functio triggers WARN_ON_ONCE()
in do_softirq_post_smp_call_flush().

The issue occurs when RPS sends IPIs for backlog NAPI, causing softirqs
from irq context on PREEMPT_RT. The solution implements backlog
NAPI threads to avoid IPI-triggered softirqs, which is required for
PREEMPT_RT kernels.

commit 8fcb76b934da ("net: napi_schedule_rps() cleanup") and 
commit 56364c910691 ("net: Remove conditional threaded-NAPI wakeup based on task state.")
are prerequisites.

The remaining dependencies have not been backported, as they modify
structure definitions in header files and represent optimizations
rather than bug fixes, including:
c59647c0dc67 net: add softnet_data.in_net_rx_action
a1aaee7f8f79 net: make napi_threaded_poll() aware of sd->defer_list
87eff2ec57b6 net: optimize napi_threaded_poll() vs RPS/RFS
2b0cfa6e4956 net: add generic percpu page_pool allocator
...

Eric Dumazet (1):
  net: napi_schedule_rps() cleanup

Sebastian Andrzej Siewior (2):
  net: Remove conditional threaded-NAPI wakeup based on task state.
  net: Allow to use SMP threads for backlog NAPI.

 net/core/dev.c | 162 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 118 insertions(+), 44 deletions(-)

-- 
2.25.1


