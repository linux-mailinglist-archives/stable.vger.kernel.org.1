Return-Path: <stable+bounces-104327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29249F2F07
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD78167127
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B94204568;
	Mon, 16 Dec 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="dLEThSlc"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72D2040BC;
	Mon, 16 Dec 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348192; cv=none; b=LwfD2KhglmZvtlkrb/k0AFSbGJ1kfZpgpwl6JATy+kxiMVETaaQvnxRvK40wPM39N0OnzqSMvCn6hmPy8WWXb1TyyR1bQB0N7+llVusUJa0XGoaVTOdnzoB1ABsZbr/zOZPoYAIiMcpCPUUMxZIFIC7VvYdOzS1wcVG0G7kC5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348192; c=relaxed/simple;
	bh=v9MlYDCK36PZWcjvhUzQxWG/G5vDOUuxFMmWx9TYNdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y4TC3bNEg/acm9TgLGuIs1Ct8fCYiRSFOTa7V5TFV/HqpTzQqfObQm7Ik6LvNgN/Iy2bf9X3Y/yv4koCtpMOxxMsu4aOY9s3NgcP5wgRZzVuH2VFM4PgKrcCvlHzKKMX5Wj15gsolaPRTovFwDwuMAbpCiEb9G051XtHVd2Rzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=dLEThSlc; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a1f:0:640:ba2e:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A762960C03;
	Mon, 16 Dec 2024 14:20:56 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b593::1:0])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IKN1R70IdeA0-8ZrX9k8l;
	Mon, 16 Dec 2024 14:20:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1734348055;
	bh=/nS9+hHfVlqu+TKOoeIEOJA+wyrVifg4eoRYjE3EpB0=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=dLEThSlcgquloVYaUJqdgxw+4QGWBkC9ro/fzH2XiXPxkN7sWWeKC5z4LrfuSb0I1
	 mLQh9adZ2AUKyG8yNXK35vUBeoqyhtMVGdAVyVjSaC0efOoQ23p2qbtt2LiRo5aeKa
	 arIhA4vFyu5A7s9QFZ2g0xazBcEHPCGPIDgTdIeA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH v2 5.4 5.15 6.6] tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()
Date: Mon, 16 Dec 2024 14:19:23 +0300
Message-Id: <20241216111923.2547104-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
avoids checking number_of_same_symbols() for module symbol in
__trace_kprobe_create(), but create_local_trace_kprobe() should avoid this
check too. Doing this check leads to ENOENT for module_name:symbol_name
constructions passed over perf_event_open.

No bug in newer kernels as it was fixed more generally by
commit 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")

Link: https://lore.kernel.org/linux-trace-kernel/20240705161030.b3ddb33a8167013b9b1da202@kernel.org
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
v1 -> v2:
 * Reword commit title and message
 * Send for stable instead of mainline

 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 12d997bb3e78..94cb09d44115 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1814,7 +1814,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
-	if (func) {
+	if (func && !strchr(func, ':')) {
 		unsigned int count;
 
 		count = number_of_same_symbols(func);
-- 
2.34.1


