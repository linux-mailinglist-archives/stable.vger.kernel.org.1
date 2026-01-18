Return-Path: <stable+bounces-210211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C03D397C6
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99D5130136C4
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4F23ABBD;
	Sun, 18 Jan 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="awqocaa5"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4E219E8D
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752990; cv=none; b=MRkPXEE562ZrHdBwVvhhiMS9aHiVU2+7avcBeSuVCJGHSrpD/Q9R84SNJ3RHRwEbpklGWKlSOsGkqlx8Eo4syYSnPwuYdyg5VZzrvjKlUSrC/lFx+dejbTkJsCDUX+qiChRk3Ws0ytDdVGgeuU4yAwvDZDNO7+paQpyiqCp7/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752990; c=relaxed/simple;
	bh=stuXfsC2R2WgtLp9fCfuUxiYdJI3HqQhBs6ki4A/LRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9ygjiMtQY5v/YdW2fVGNUSxExQo0ATga8IOBhJGOAVYe4T4qWN1iMVXogZk7K8EfBcwwet2AMAijUf0r4ols72I8YOs1O7xVBQnazzvTNd/ZCKSt+yvzJ0RNbBvVdjnbsOo68I/YgmRO8oe2Jfp28rGWazRlfBZo4A/ihMkVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=awqocaa5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768752977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rElvZdowGvl1nqp3YNSrESkv/wHlkAfhkif6BXnCRqc=;
	b=awqocaa5FEoKjJIenL0zwUUK5wEzvPg7+Fv36BIY6T/HNRA6b05QLghtMX9IbeNjS7bRdt
	9Arw+6FrTewOln1N0SQfYE45SC1Ew0Z1BIjUn3wrsTLIBmVwq4VkS2eslyILeObg5sTHyY
	kqKsNIozW+zdA7z6hd93ckQBwAkj8vY=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.6 0/3] net: Backlog NAPI threading for PREEMPT_RT
Date: Mon, 19 Jan 2026 00:15:43 +0800
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


