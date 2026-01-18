Return-Path: <stable+bounces-210215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D3D397CE
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0453020C66
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCC1E0B86;
	Sun, 18 Jan 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iH1SvSu9"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A719309C
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753089; cv=none; b=Z6N7y0jONx6N3O5DFTl7ERmiTula27GbV2eO4rVb5evTUQaZeqkmG0d5pizgKwoP0ytRZTfLI9P57EwU0ixXYifF+0kDyIw2XhW1WKHNjddQubiWbT4oJ/cWad7pgQiSYv4T0xWG+0o8h/wcDI19P6Ay0u5mDrinVtzyuwHRppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753089; c=relaxed/simple;
	bh=stuXfsC2R2WgtLp9fCfuUxiYdJI3HqQhBs6ki4A/LRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXsEUDJhITqnhKh36gmWk7tyLkQ8KErkYZLOv9HJJ3pEJFTmKk2wBykw4HOOkHjRED3+AlPvgP3+AcAHNy8Q/jGFPuojGtrBmg3pRy3+ng0fVlyCDe+yGVFAsZMcp9kHRslrKxfyUnFrjtZp0JUGElKTAvlmy2dpCkB3udKMkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iH1SvSu9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768753073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rElvZdowGvl1nqp3YNSrESkv/wHlkAfhkif6BXnCRqc=;
	b=iH1SvSu9EMe8X3liCa7BFnNPazt7hliZKRkvwixVaCU/oQzBPz2gx1PrbPHSzBuagX9JIn
	L8Zyd0vgwIejuK6OXPfNlwjS0l2yRi3rKN9jipAdJWNR72dbCffeJZSiZ/kgjRtZY6fGku
	hC3v/jvOAwjWFL8nDs8SOSShj1VIMUs=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 0/3] net: Backlog NAPI threading for PREEMPT_RT
Date: Mon, 19 Jan 2026 00:17:38 +0800
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


