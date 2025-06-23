Return-Path: <stable+bounces-155374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4243AE41B9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CA617388A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23881254855;
	Mon, 23 Jun 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PC+zSgql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C02517A0;
	Mon, 23 Jun 2025 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684197; cv=none; b=Q2QMGxoPS+fMCByqPcipC5eWpq/DIWyPuckk0+ORAAXBI+mnh/a0Z17YMMOR98lHgpzuc/Vrk73zDkb3MrThq8JcfmQF/ifGzv1/sWxLPsp2oNviygAgcG9eS3fOCfYqLKBu01VjaGWgeQ3g8LViZ4yKV/j1QdI7Kdt1C1Eax/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684197; c=relaxed/simple;
	bh=5ipzSLr+PURbwgx2ZA/E+djWklaPOMI7KGmTJOMfsIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9TUFZH0kZTHRJ3bpFYQSyZsNEva1dddrJeqUSf35FYvclUXC3e9xrOLXaXFqii0lSD1aqb7MjWuiZrQWtSal4nAApjwSjEKL2lhXoIZ4EW+peMIBi/UALXbNXg/Q/CkDugWDnLq79hNtRrUYxuimMxlvCUbWZRZBPt26EJIL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PC+zSgql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44102C4CEEA;
	Mon, 23 Jun 2025 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684197;
	bh=5ipzSLr+PURbwgx2ZA/E+djWklaPOMI7KGmTJOMfsIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PC+zSgqlofRvbujaj0UAVkfTfZA8NkuU8rFWh36wUkSoGdTzHo+7mmlqcQj1jtxuv
	 z6MmCwvF6Cb+LDF3IlhTPPsjWi/GT4mAIINKgRxj+ynP6qRG8so29ceAGeuxW2jMir
	 1713tCUJG4pkTafuHgHR3hU4EVUrjiBVdauZg40M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Pan Taixi <pantaixi@huaweicloud.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 001/355] tracing: Fix compilation warning on arm32
Date: Mon, 23 Jun 2025 15:03:22 +0200
Message-ID: <20250623130626.765353096@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Taixi <pantaixi@huaweicloud.com>

commit 2fbdb6d8e03b70668c0876e635506540ae92ab05 upstream.

On arm32, size_t is defined to be unsigned int, while PAGE_SIZE is
unsigned long. This hence triggers a compilation warning as min()
asserts the type of two operands to be equal. Casting PAGE_SIZE to size_t
solves this issue and works on other target architectures as well.

Compilation warning details:

kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
./include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                            ^
./include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~

...

kernel/trace/trace.c:6771:8: note: in expansion of macro 'min'
        min((size_t)trace_seq_used(&iter->seq),
        ^~~

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250526013731.1198030-1-pantaixi@huaweicloud.com
Fixes: f5178c41bb43 ("tracing: Fix oob write in trace_seq_to_buffer()")
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Pan Taixi <pantaixi@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6686,7 +6686,7 @@ static ssize_t tracing_splice_read_pipe(
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;



