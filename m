Return-Path: <stable+bounces-183715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76BDBC9BD6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70D919E7A69
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84C1E1DF0;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMFh8OGG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C81DEFE0;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023460; cv=none; b=RmOdRA8KUDSWD4DVMZLJNEGR3oFyiIG5o2Xsqq33qzRsSlndjR6W81l1YURrSW8KDNQT/ntIxH3icN6hvu2zRXl8C+DJxJO30xlI1zNM/ql6klaknTU6GpalAk5RwulWZLf/cu9HqIWC18tPXuySyfy2mD9sECMuwVGT0acErjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023460; c=relaxed/simple;
	bh=ydc3U0Yxoi93G2YKlPO0EC9UcDZ0KIdY56hZeXd0Pm8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zg+OL+wapOMLK+UZdYRuyxAVR+o4DbXrBJrWMsY7ShjyDHIVkXs88rlBBBMSWyxvaDE8f9KNGxijIl5V4P3wSFun76A+5QNo65UDUHFXdFhenfWmS5Nw7GjgAZP3G1Uc4wLk8avcRjB8z08KhIQGxSBWM+DdZoeWM9DiE7xdXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMFh8OGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91496C116C6;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023460;
	bh=ydc3U0Yxoi93G2YKlPO0EC9UcDZ0KIdY56hZeXd0Pm8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WMFh8OGGUggIzabxpoKbQFcnLhNsmC0vG/4SnYl+6nO2GPNU3VEJUI7m/N+1tw7iS
	 unw0AyNh+yFJtwV55IkUYFe6NDGBZj4iFepGWSh16THayRTd2kN4yUSRX/IQIv+Jeq
	 //PMr6Ls4j3OJU1TvFfo5U26Yya+vx5S63vD6vvKV39fzBaG2BUltDRwvadjPplIeC
	 DyBX+LuU6qdHrz+APaSso+ZoiQDAMVLVbdYBcdOiaZnCgax1b5fUTX+AAstIJdxIOv
	 Wlgb+DUnj/36uzb29a4rLIjhpMCxk9hGBJw+EFsEvG5Dj5N6+H9t+CmmiI8JOX9aS9
	 hYHVYD0z2sIOQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVB-00000000Bdy-0xdD;
	Thu, 09 Oct 2025 11:24:21 -0400
Message-ID: <20251009152421.086241586@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:24:03 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com,
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [for-linus][PATCH 4/5] ring buffer: Propagate __rb_map_vma return value to caller
References: <20251009152359.604267051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

The return value from `__rb_map_vma()`, which rejects writable or
executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
ignored. As a result the caller of `__rb_map_vma` always returned 0
even when the mapping had actually failed, allowing it to proceed
with an invalid VMA.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20251008172516.20697-1-ankitkhushwaha.linux@gmail.com
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..1244d2c5c384 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7273,7 +7273,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-	return 0;
+	return err;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
-- 
2.51.0



