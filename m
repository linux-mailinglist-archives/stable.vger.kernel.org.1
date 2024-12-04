Return-Path: <stable+bounces-98467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554839E41B4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DAA167A61
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14022B8C4;
	Wed,  4 Dec 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRj/lHdA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AF218DC6;
	Wed,  4 Dec 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331826; cv=none; b=OD01RDaduPWTjpUgUziGUJICwbe/mzod3Egqw8PMmhpJ3Dfud7IIUXy2bf5mgkQJ7Mi8n/6xQrCnLQ1KV1XI2om0oJ6/S/kqGgMuc+ab91nsPjAhAXYtJ+5ZRiWcd4N+m5S7VPgDXsyfOCr2NUEWl0NH6GdREEPJ5q0NCZrb8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331826; c=relaxed/simple;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaaggmyoM3s675xrcC9hPvhpHMMXIto/IDJ8lQOltjM8HkOzpxlPwgN5xMyfwfIeGGxL/f7r7Q+fOVqE2ZGS0auuU+o9ShZETjkcYoSSaBPX2IZZqjPWAx4XWHZdSl+DGHLJI2XSM/1NmNHv2UN4BBzBxZrpxt3EM9COaLTs7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRj/lHdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D441C4CECD;
	Wed,  4 Dec 2024 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331826;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:From;
	b=kRj/lHdA1mrREEWGHbI0GZDPO3A8k9yqDVUHHc9w5n1X+8p/f0M4mlblEyU9wy1zB
	 LIG5UOzaN6o/RWHvY1dxrrhZwFAG3PNIiUNIMe6Q67QvLsT+goF+BCmLmsgF08Axst
	 OzCopt4Z6YIaKLkNmps/7UBj4Qt9i+BozxIHDZ/RDSKbJWcIDJl+zyoAOwCA8JX3Zx
	 3TDzasH7rDdc17FEyHhwS0Hk3vvOLxHOdnuwJk7BGlUalWlZppBgOzHc1zFtDKiUtg
	 XCgma1icATPiZqgTGzbwVoaW6aqqCz4n4QLg8ihMmD866EZ8pM2Ci0+A+oxemRWVyu
	 GrsPxaJWSv2Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/6] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Wed,  4 Dec 2024 10:52:20 -0500
Message-ID: <20241204155226.2215336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit eb887c4567d1b0e7684c026fe7df44afa96589e6 ]

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241007085651.48544-1-ubizjak@gmail.com
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 4702efb00ff21..4cb2ebc439be6 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -154,5 +154,5 @@ static atomic64_t trace_counter;
  */
 u64 notrace trace_clock_counter(void)
 {
-	return atomic64_add_return(1, &trace_counter);
+	return atomic64_inc_return(&trace_counter);
 }
-- 
2.43.0


