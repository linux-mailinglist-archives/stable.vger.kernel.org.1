Return-Path: <stable+bounces-104376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135C9F35B2
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFF7188D997
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696661B2194;
	Mon, 16 Dec 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="iE5TE+vJ"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAE136331;
	Mon, 16 Dec 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365763; cv=none; b=XgPbWIC5doyMo4Hoy2Qrc2NuHkDcMAHDUrFb0El821Njz1GJ5lOJPzbFdqbiLSdcuVENGZMiAQGcmi6athPNBLd+r+Sr8gb5QQA8Ee9ySx4EffzaY3O3/Uyl9nqlH+UtP58fymTdOVQ31Z1lLLYVN8/euuSTY7dsubcX6zlm3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365763; c=relaxed/simple;
	bh=ljPpzBbW0EQBfPznOnrP/UV2AkI6l5nD9XWxPeMsXKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=on6yqrX0YWmSgw24CvEpAXv9lVW9Q0TNYS3UdlvowPKaKU+66xP6l0+VSSqueskmrHMowqzU9Wm3WOBe538JZzxz76Nu7Lw3Eg8qSr2YUz4BRiV19E0e3KyGaJ6kyuhtxP3CivTbh1fqBmaS+QjNvNKbJFA71x9HdE2QUU9f2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=iE5TE+vJ; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:292a:0:640:622b:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 46C4F60B5F;
	Mon, 16 Dec 2024 19:13:40 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b593::1:0])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ODS8oF0IWa60-ewFAs5xp;
	Mon, 16 Dec 2024 19:13:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1734365619;
	bh=jFstk9TW5c9LIxd58pbiRWX8MKODoBllIfH8a/j8/Ak=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=iE5TE+vJaGii9BUs5ikg3C5NmRvo3oLaSrD3HCiBYdDBj2IATjS6RJlj6LocUYbun
	 LogQrViOg5AlgSgwYaIOfCp6WpsMVakqD4cR7Y7div4bVJ2MdsYZ0aGGC4d0IfFcBk
	 Xcr7ZwAbKJi2Z/9Mq+lqhJdEo71Pmp/neS0uqSKc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH v3] tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()
Date: Mon, 16 Dec 2024 19:11:45 +0300
Message-Id: <20241216161145.2584246-1-kniv@yandex-team.ru>
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

No bug in mainline and 6.12 as those contain more general fix
commit 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")

Link: https://lore.kernel.org/linux-trace-kernel/20240705161030.b3ddb33a8167013b9b1da202@kernel.org
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
v1 -> v2:
 * Reword commit title and message
 * Send for stable instead of mainline
v2 -> v3:
 * Specify first good LTS version in commit message
 * Remove explicit versions from the subject since 6.1 and 5.10 need fix too

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


