Return-Path: <stable+bounces-41388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A768B1622
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 00:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5951B247FB
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168DE16DEDA;
	Wed, 24 Apr 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cZeM7DAR"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3C165FC3;
	Wed, 24 Apr 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997303; cv=none; b=G6e5w86vEw695RHo6dfymHRhhrvp56rr4lRRTl2sYt2TdRY+Jn9545RYks1Ox33aU9YedNZmwijIGa8RZn3IeIIz0ojiVTQZHsm0HjvCF4NvN/J/Vt9XHcptXv4pKOstdrSBvRj06SH4vdcw/VZcvpYpP7hXs4EsdAvgdr963cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997303; c=relaxed/simple;
	bh=/z5RRkVDqdf7sA61OqTk8XQkatIAaRcC64RYk3Da4c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmBZpLBNv9zm1syJj8DDOw+8zfUNjM/7npAXcOBjnSgYs+gEofU8+Nyw3Q3m9UtmS9yVrZTCAP4XQgEPVCI9XtKd7ZtlCon9uw5bzId218JtlNb+ScxKA3zgoQBt3guw0mxm7NofF+HWtw+jIjt2aSqfTJy7JCyzUAMiXpnNNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cZeM7DAR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5cP9V35l2VBhQyt1Fz9qhDTs6dZbB/S/UM5KxZ4gYGw=; b=cZeM7DARD4ncy4MHXajVLMAANq
	MavsEtjtaAq6kTV6Y3ORQFXrduoW8+Ksi04wKGvyLs+PryxIdkrneUVnhTt7Xb1hP5AldTpbOtFbX
	mEosz+VOOt8yLGleIc1WrNUCRDP3SVxvQWuOawIqV4kiYlPVIPyUSy4p+ChM0ZwP5yk69dV4zx3JG
	Fj/dyGxrqetmu7wC8MCwN64VIe8D6P4ukE7JlXZVrP6XXrtSgvjEJfZPV6yAFypNBnLTsvwhiKYgk
	KSAnr1lpD9LqlgBd5Zf1R2sQluKMWi5XI4H6vkg86zZPJ7KZJhBWWYh0+8lZFtYKwIDcVkEsmbao8
	pjU4qAjg==;
Received: from 179-125-71-233-dinamico.pombonet.net.br ([179.125.71.233] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rzkzi-008LGq-GN; Thu, 25 Apr 2024 00:21:39 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5.15,5.10,5.4,4.19 1/2] tracing: Show size of requested perf buffer
Date: Wed, 24 Apr 2024 19:20:08 -0300
Message-Id: <20240424222010.2547286-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424222010.2547286-1-cascardo@igalia.com>
References: <20240424222010.2547286-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Robin H. Johnson" <robbat2@gentoo.org>

commit a90afe8d020da9298c98fddb19b7a6372e2feb45 upstream.

If the perf buffer isn't large enough, provide a hint about how large it
needs to be for whatever is running.

Link: https://lkml.kernel.org/r/20210831043723.13481-1-robbat2@gentoo.org

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/trace/trace_event_perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 083f648e3265..61e3a2620fa3 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -401,7 +401,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
 	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
 
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
-		      "perf buffer not large enough"))
+		      "perf buffer not large enough, wanted %d, have %d",
+		      size, PERF_MAX_TRACE_SIZE))
 		return NULL;
 
 	*rctxp = rctx = perf_swevent_get_recursion_context();
-- 
2.34.1


