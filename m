Return-Path: <stable+bounces-183028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA5CBB342B
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71E6468477
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CC2F9982;
	Thu,  2 Oct 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coLETaei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9qQbg4e3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B792F6569;
	Thu,  2 Oct 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393409; cv=none; b=Nw1fAi8WRVf4jLIKqEspnxP074qyozNoufES5dlkr6iOnvkBquP5c1+EHlwkQqFpF2YCDuLCXa5x+7ulsj4N5Bok+hvp8TjgAbwB45AvSZhxc3bUP4WfJ3jq8ck9DDlwJq8wu4YYpjaSoa1euILt8ZvQXe+Ij4eortjCefrwtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393409; c=relaxed/simple;
	bh=UqlGLleMkXpq+Xno0Q1AJU7J41Tk+8nEgleIZqqVhjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty6OpbC+TcWD90JyurZuX6yh3ugFPbhpElptgIPOgGxlBxcip9SP4BfvfhRN34p0gbTtNYK69F91AgV16DxRNQJqgmiz+z2i9Xph+YyY04bZUkn/0gRa9eN+xJ/Sym+onpjfwhgDkg9ydYW1nLitMjbMuwaruCuZeoiBHsPgu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coLETaei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9qQbg4e3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759393404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j7PsuRrjkeVYwWZ9ja15zwm8l8USychG99WEiutMiLA=;
	b=coLETaei03rwnGWtgFTZkhAw9qkBwd153+zuDmhUTmZkmycp7V0iE83VJp0uSRE4aEZFoI
	cDEzfazpJwjsGDAZanfZhTea8YV2TDH0zJsvB7JyWSJkuugSM8FunwpAwX14yahGobDsj7
	VVLoySvEYGqYcQLhoMC4dnVHGIsV9vK80mfe5DxJ5QyuRa0jOOHfIeZqRus/fc+D+/PhU8
	2ZRxRBO2Y1+A1DCltaJUYKz5nqd6jejHL7hVzzEE7E34yaxd06lUPHjHiEO1JJ1W/RmwG+
	NDk0VPtXAq8Zoajg1ZZfmo1KILdaaVBqVnMgk8Q7+2GwEp2KhYCujLTBO424aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759393404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j7PsuRrjkeVYwWZ9ja15zwm8l8USychG99WEiutMiLA=;
	b=9qQbg4e39E9kN4EL3/b/jsO6DJEg11tPRMSFmjBdIHtCwqFcv3BhdTubgDGwf14V4nd0ah
	ZXbbvQNeoNfmQOAg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] rv: Make rtapp/pagefault monitor depends on CONFIG_MMU
Date: Thu,  2 Oct 2025 08:23:17 +0000
Message-ID: <20251002082317.973839-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no page fault without MMU. Compiling the rtapp/pagefault monitor
without CONFIG_MMU fails as page fault tracepoints' definitions are not
available.

Make rtapp/pagefault monitor depends on CONFIG_MMU.

Fixes: 9162620eb604 ("rv: Add rtapp_pagefault monitor")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509260455.6Z9Vkty4-lkp@int=
el.com/
Cc: stable@vger.kernel.org
---
 kernel/trace/rv/monitors/pagefault/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig b/kernel/trace/rv/m=
onitors/pagefault/Kconfig
index 5e16625f1653..0e013f00c33b 100644
--- a/kernel/trace/rv/monitors/pagefault/Kconfig
+++ b/kernel/trace/rv/monitors/pagefault/Kconfig
@@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
 	select RV_LTL_MONITOR
 	depends on RV_MON_RTAPP
 	depends on X86 || RISCV
+	depends on MMU
 	default y
 	select LTL_MON_EVENTS_ID
 	bool "pagefault monitor"
--=20
2.51.0


