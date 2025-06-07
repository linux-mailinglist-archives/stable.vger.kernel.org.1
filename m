Return-Path: <stable+bounces-151773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7AAD0C88
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DE5188FA39
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385120CCED;
	Sat,  7 Jun 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZD4uC4jx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA615D1;
	Sat,  7 Jun 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290961; cv=none; b=OgxviUMpIJtGNF33WV/wARaH3wASeAEea5XP54LeHsKP0LFXLmswKX0WZICLxbRp5HLkebuMfzKlWfL7miW7u/lYrl35DTEr8fhpjp3HtRG3HRTdPJli1+tA2+mx2woNz4vETrLCyr4A1sC0fp3qifWcGkUnwVPr2vfcRSp018k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290961; c=relaxed/simple;
	bh=xr0KBMw1ipd17qI/GJsZPa4WVHpPmUSM+5yCvWic6Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI1vPUxWesOQhcjNZ7Ta3ftkIEfl09c+D9zDI+ZMVwKzZ0Yx/VSBouBHJYDOWG0LEX+kU4JmNnh/D8JGnvWtyqDlIO4AgBQFMfKkZJQ6CBoHzi7W5gNpOexmgaTX3nHjUsg65n7Mx/KTb9jqJMHJJlgvuGIrPGdIx2KkUZsBCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZD4uC4jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A1C4CEE4;
	Sat,  7 Jun 2025 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290960;
	bh=xr0KBMw1ipd17qI/GJsZPa4WVHpPmUSM+5yCvWic6Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZD4uC4jxJQ0SeZb4PVQUqDlhnrEvnT6LoZ5Ao5JZXoAliPBAvDv/hca/6+VQvYsL7
	 oWgMy7ADFEJLOymRCpj6uJkiT3oMQCt8hfZLmxsVPuzvmxWUNcDszmf3GDFnRD+OfH
	 S9Nks+HvRnWEkawEjdAjMY+CB+ddhI4aZOV7LdeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Pan Taixi <pantaixi@huaweicloud.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.14 01/24] tracing: Fix compilation warning on arm32
Date: Sat,  7 Jun 2025 12:07:41 +0200
Message-ID: <20250607100717.765483257@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
References: <20250607100717.706871523@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6679,7 +6679,7 @@ static ssize_t tracing_splice_read_pipe(
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;



